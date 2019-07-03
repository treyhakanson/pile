using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Factory;
using TheGameBreakers.Collider;
using TheGameBreakers.State.Enemy;

namespace TheGameBreakers.Entity.Enemy
{
    class BulletBillEnemyEntity : EnemyEntity
    {
        public BulletBillEnemyEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var stateMachine = (EnemyStateMachine) StateMachine;
            var factory = new BulletBillSpriteFactory();
            factory.LoadTextures(content);
            AddSpriteMapping(stateMachine.LeftFacingAliveState, factory.CreateBulletBillSprite());
            AddSpriteMapping(stateMachine.RightFacingAliveState, factory.CreateBulletBillSprite());
            AddSpriteMapping(stateMachine.DeadState, factory.CreateBulletBillSprite());
            DamageMultiplier = 2.5f;
            // No gravity
            AccelerationY = 0;

            // Make bullet bill get faster
            // AccelerationX = -.01f;

            // Collision mappings
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario }, Collision.Top, BulletDie);
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Left, DoNothing);
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Right, DoNothing);
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Bottom, DoNothing);
        }

        public override BaseEntity Clone()
        {
            return (BaseEntity)new BulletBillEnemyEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);
        }

        public void DoNothing(CollidableEntity entity)
        {
        }

        public void BulletDie(CollidableEntity entity)
        {
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Top, DoNothing);
            AccelerationY = 1f;
        }
        public int PointValue => 1000;
    }
}
