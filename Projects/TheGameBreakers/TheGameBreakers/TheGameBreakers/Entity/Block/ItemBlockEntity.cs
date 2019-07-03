using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Collider;
using TheGameBreakers.Entity.Item;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Entity.Block
{
    abstract class ItemBlockEntity: BlockEntity, ISpawnerEntity
    {
        protected Spawner ItemSpawner;
        protected AudioPlayer AudioPlayer;
        protected SoundFactory SoundFactory;

        protected ItemBlockEntity(ContentManager content, SpriteBatch spriteBatch, AudioPlayer audioPlayer, SoundFactory soundFactory, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
          AddCollisionMapping(new [] {CollidableType.Mario, CollidableType.HeavyMario}, Collision.Bottom, _bumpAndSpawnItem);
          AudioPlayer = audioPlayer;
          SoundFactory = soundFactory;
        }

        public virtual void InitializeSpawner(List<CollidableEntity> spawnLocation)
        {
            ItemSpawner = new Spawner();
            ItemSpawner.RegisterSpawnLocation(spawnLocation);
        }

        public void AddSpawnable(CollidableEntity spawnable)
        {
            ItemSpawner.QueueSpawnable(spawnable);
        }

        private void _bumpAndSpawnItem(CollidableEntity entity)
        {
            Bump(entity);
            if (ItemSpawner.Count > 0 && ItemSpawner.SpawnOne() is ItemEntity itemEntity)
            {
                // Wait for bump animation to complete, then reveal the item
                Task.Factory.StartNew(() =>
                {
                    while (IsBumping)
                    {
                    }
                    itemEntity.Reveal(itemEntity.PositionX);
                    AudioPlayer.PlaySoundIfNotPlaying(SoundFactory.CreatePowerUpAppearsSound());
                });
            }
        }
    }
}
