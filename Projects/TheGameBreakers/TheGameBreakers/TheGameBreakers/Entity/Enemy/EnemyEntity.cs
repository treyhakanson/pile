using System.Collections.Generic;
using System;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Collider;
using TheGameBreakers.Sprites;
using TheGameBreakers.State.Enemy;
using TheGameBreakers.Factory;
using TheGameBreakers.State.Enemy.EnemyStates;

namespace TheGameBreakers.Entity.Enemy
{
   abstract class EnemyEntity : CollidableEntity
   {
       protected IEnemyStateMachine StateMachine { get; set; }
       private readonly Dictionary<EnemyState, ISprite> _spriteMappings = new Dictionary<EnemyState, ISprite>();
       public float DamageMultiplier { get; protected set; } = 1.0f;

       protected EnemyEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(
           content, spriteBatch, positionX, positionY)
       {
           _boundScale = 0.6f;
           StateMachine = new EnemyStateMachine();
           VelocityX = -1; // enemies initially move to the left

           // Gravity
           AccelerationY = 1f;

           // Collision mappings
           AddCollisionMapping(new [] {CollidableType.Mario, CollidableType.HeavyMario}, Collision.Top, Die);
           AddCollisionMapping(new [] {CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock}, Collision.Left, TurnRight);
           AddCollisionMapping(new [] {CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Right, TurnLeft);
           AddCollisionMapping(new [] {CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Bottom, Land);
       }

        // Addes a mapping from state -> sprite to the sprite dictionary
        protected void AddSpriteMapping(EnemyState state, ISprite sprite)
       {
           _spriteMappings.Add(state, sprite);
       }

       // BaseEntity overrides
       protected override ISprite GetSprite()
       {
           return _spriteMappings[StateMachine.State];
       }

       // CollidableEntity overrides
       public override CollidableType GetCollidableType()
       {
           return CollidableType.Enemy;
       }

        public void Orient(MarioEntity mario)
        {
            VelocityX = (mario.PositionX < PositionX) ? -1 : 1; 
        }

       public virtual void Die(CollidableEntity entity)
       {
           Collidable = false;
           VelocityX = 0;
           VelocityY = 0;
           StateMachine.Die();
       }

       public void Land(CollidableEntity entity)
       {
           VelocityY = 0;
       }

      public void TurnLeft(CollidableEntity entity)
      {
          VelocityX = -1 * Math.Abs(VelocityX);
          StateMachine.TurnLeft();
      }

      public void TurnRight(CollidableEntity entity)
      {
          VelocityX = Math.Abs(VelocityX);
          StateMachine.TurnRight();
      }
    }
}
