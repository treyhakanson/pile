using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Collider;
using TheGameBreakers.Factory;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Entity.Block
{
   class BrickBlockEntity : ItemBlockEntity
   {
       private Spawner _shatterSpawner;
        private BlockEntityFactory _factory;

       private static readonly List<Tuple<int, int>> _spawnableVelocities = new List<Tuple<int, int>>()
       {
           Tuple.Create(-2, -10),
           Tuple.Create(-2, 0),
           Tuple.Create(2, -10),
           Tuple.Create(2, 0)
       };

       public BrickBlockEntity(ContentManager content, SpriteBatch spriteBatch, BlockEntityFactory factory, AudioPlayer audioPlayer, SoundFactory soundFactory, int positionX, int positionY) : base(content, spriteBatch, audioPlayer, soundFactory, positionX, positionY)
       {
            _factory = factory;

           // Add sprite mappings
           AddSpriteMapping(StateMachine.BrickBlockState, BlockFactory.CreateBrickBlock());
           AddSpriteMapping(StateMachine.BrickBlockBreakState, BlockFactory.CreateNullSprite());
           AddSpriteMapping(StateMachine.BrickBlockBumpState, BlockFactory.CreateBrickBlockBump());
           AddSpriteMapping(StateMachine.NullBlockState, BlockFactory.CreateNullSprite());

           // Initialize spawner (for on shatter)
           var spawnables = new List<CollidableEntity>();
           foreach (var tuple in BrickBlockEntity._spawnableVelocities)
           {
               var spawnable = factory.CreateBrickBlockFragmentEntity(positionX, positionY);
               // Console.WriteLine("Creating velocity "+ tuple.Item1 + ", " + tuple.Item2);
               spawnable.VelocityX = tuple.Item1;
               spawnable.VelocityY = tuple.Item2;
               spawnables.Add(spawnable);
           }
           _shatterSpawner = new Spawner(spawnables);
           // Console.WriteLine("Spawnables: " + _shatterSpawner.Count);

           // Add collision mappings
           AddCollisionMapping(CollidableType.HeavyMario, Collision.Bottom, _shatter);
        }

        public override BaseEntity Clone()
        {
            BrickBlockEntity e = new BrickBlockEntity(this.Content, this.SpriteBatch, this._factory, AudioPlayer, SoundFactory, this.PositionX, this.PositionY);
            e.StateMachine.SetState(this.StateMachine.State);
            e._shatterSpawner = this._shatterSpawner;
            return (BaseEntity) e;
        }

        public override void InitializeSpawner(List<CollidableEntity> spawnLocation)
        {
            _shatterSpawner.RegisterSpawnLocation(spawnLocation);
            base.InitializeSpawner(spawnLocation);
        }

        private void _shatter(CollidableEntity entity)
       {
           HeavyBump(entity);
           _shatterSpawner.SpawnAll();
        }
   }
}
