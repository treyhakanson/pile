using System;
using System.Collections.Generic;
using TheGameBreakers.State.Block;
using TheGameBreakers.Factory;
using TheGameBreakers.Sprites;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Collider;

// NOTE: currently, all entities use the same state machine. This will be changed later to avoid storage of unneeded parameters

namespace TheGameBreakers.Entity.Block
{
    abstract class BlockEntity : CollidableEntity
    {
        protected BlockStateMachine StateMachine { get; set; }

        //Block factory to return block sprites
        protected BlockSpriteFactory BlockFactory;

        //Dictionary for sprites
        private readonly Dictionary<BlockState, ISprite> _spriteMappings = new Dictionary<BlockState, ISprite>();

        //Max offset and velocity used for bumping
        private int _initialPositionY;
        private int _bumpMaxOffset = 20;

        public bool IsBumping => StateMachine.GetIsBumpState();

        protected BlockEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            //State Machine
            StateMachine = new BlockStateMachine();
            StateMachine.BrickBlockBreakState.SettleTime = TimeSpan.FromMilliseconds(833);

            //Block Factory
            BlockFactory = new BlockSpriteFactory();
            BlockFactory.LoadTextures(content);

            // Bump logi
            _initialPositionY = PositionY;

            // Add collision mappings
            AddCollisionMapping(CollidableType.Mario, Collision.Bottom, Bump);
            AddCollisionMapping(CollidableType.HeavyMario, Collision.Bottom, HeavyBump);
        }

        // BaseEntity Overrides
        protected override ISprite GetSprite()
        {
            return _spriteMappings[StateMachine.State];
        }

        // CollidableEntity overrides
        public override CollidableType GetCollidableType()
        {
            return CollidableType.Block;
        }

        public override void Update()
        {
            if (StateMachine.GetIsBumpState()) {
                if (VelocityY == 0) VelocityY = -2;
                if (_initialPositionY - PositionY > _bumpMaxOffset) {
                    VelocityY *= -1;
                }
                if (PositionY > _initialPositionY) { 
                    StateMachine.Settle();
                    PositionY = _initialPositionY;
                    VelocityY = 0;
                }
            }
            base.Update();
        }

        // Adds a mapping from state -> sprite to the sprite dictionary
        protected void AddSpriteMapping(BlockState state, ISprite sprite)
        {
           _spriteMappings.Add(state, sprite);
        }

        // Entity actions (incur state changes)
        public void Bump(CollidableEntity entity)
        {
            StateMachine.Bump();
        }

        public void HeavyBump(CollidableEntity entity)
        {
            StateMachine.HeavyBump();
        }
    }
}
