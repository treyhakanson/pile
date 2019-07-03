using System;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Factory;
using TheGameBreakers.Collider;
using TheGameBreakers.State.Mario.Action;
using TheGameBreakers.Level;
using System.Collections.Generic;
using TheGameBreakers.Entity.Item;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Entity.Block
{
    class PipeBlockEntity : StatelessEntity, ISpawnerEntity
    {
        public Motion warpDestination { get; set; }
        public LevelManager levelManager { get; set; }
        public Spawner ObjSpawner;
        private AudioPlayer _audioPlayer;
        private SoundFactory _soundFactory;

        public PipeBlockEntity(ContentManager content, SpriteBatch spriteBatch, AudioPlayer audioPlayer, SoundFactory soundFactory,int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var blockFactory = new BlockSpriteFactory();
            blockFactory.LoadTextures(content);
            Sprite = blockFactory.CreatePipeBlock();
            _audioPlayer = audioPlayer;
            _soundFactory = soundFactory;

            AddCollisionMapping(CollidableType.Mario, Collision.Top, PossibleWarp);
            AddCollisionMapping(CollidableType.HeavyMario, Collision.Top, PossibleWarp);
        }

        public override BaseEntity Clone()
        {
            PipeBlockEntity e = new PipeBlockEntity(this.Content, this.SpriteBatch, _audioPlayer, _soundFactory, this.PositionX, this.PositionY);
            e.warpDestination = this.warpDestination;
            e.levelManager = this.levelManager;
            return e;
        }

        public virtual void InitializeSpawner(List<CollidableEntity> spawnLocation)
        {
            ObjSpawner = new Spawner();
            ObjSpawner.RegisterSpawnLocation(spawnLocation);
        }

        public void AddSpawnable(CollidableEntity spawnable)
        {
            ObjSpawner.QueueSpawnable(spawnable);
        }

        // CollidableEntity overrides
        public override CollidableType GetCollidableType()
        {
            return CollidableType.Block;
        }

        public void PossibleWarp(CollidableEntity entity)
        {
            if (((MarioEntity) entity).ActionStateMachine.State is MarioCrouchLeftState || ((MarioEntity) entity).ActionStateMachine.State is MarioCrouchRightState)
            {
                BoundingBox marioBB = entity.GetBoundingBox();
                BoundingBox pipeBB = this.GetBoundingBox();
                if (pipeBB.MinX < marioBB.MinX && pipeBB.MaxX > marioBB.MaxX && this.warpDestination != null)
                {
                    levelManager.WarpTo(warpDestination, true);
                }
            } 
        }

        public void Spawn()
        {
            if (ObjSpawner.Count > 0)
            {
                CollidableEntity e = ObjSpawner.SpawnOne();
                if (e is ItemEntity)
                {
                    ((ItemEntity) e).Reveal(e.PositionX);
                    _audioPlayer.PlaySoundIfNotPlaying(_soundFactory.CreatePowerUpAppearsSound());
                }
                else
                {
                    Console.WriteLine("Spawning a non-item");
                    e.Visible = true;
                    e.Collidable = true;
                }
            }
        }
    }
}
