using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Factory;
using TheGameBreakers.Collider;
using TheGameBreakers.State.Enemy;

namespace TheGameBreakers.Entity.Enemy
{
    class PirhanaEnemyEntity : EnemyEntity
    {
        private int _startingPositionY;

        public PirhanaEnemyEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var factory = new PirhanaSpriteFactory();
            var stateMachine = (EnemyStateMachine)StateMachine;
            factory.LoadTextures(content);
            AddSpriteMapping(stateMachine.LeftFacingAliveState, factory.CreatePirhanaSprite());
            AddSpriteMapping(stateMachine.RightFacingAliveState, factory.CreatePirhanaSprite());
            AddSpriteMapping(stateMachine.DeadState, factory.CreatePirhanaSprite());

            // No gravity
            AccelerationY = 0;
            VelocityX = 0; 
            VelocityY = -1;

            _startingPositionY = positionY;
            DamageMultiplier = 2f;

            // Collision mappings
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario }, Collision.Top, DoNothing);
            AddCollisionMapping(new[] { CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Left, DoNothing);
            AddCollisionMapping(new[] { CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Right, DoNothing);
            AddCollisionMapping(new[] { CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Bottom, DoNothing);
        }


        public override BaseEntity Clone()
        {
            return (BaseEntity) new PirhanaEnemyEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);
        }

        public void DoNothing(CollidableEntity entity)
        {
        }

        public override void Update()
        {
            if (PositionY < _startingPositionY - (GetBoundingBox().MaxY - GetBoundingBox().MinY)) 
            {
                VelocityY = 1;
            }
            else if (PositionY > _startingPositionY)
            {
                Collidable = false;
                Visible = false; 
                VelocityY = 0;
            }
            base.Update();
        }
    }
}
