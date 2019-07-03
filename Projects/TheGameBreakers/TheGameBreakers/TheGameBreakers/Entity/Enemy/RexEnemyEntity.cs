using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Factory;
using TheGameBreakers.State.Enemy;

namespace TheGameBreakers.Entity.Enemy
{
    class RexEnemyEntity : EnemyEntity
    {
        public int PointValue
        {
            get
            {
                var stateMachine = (RexEnemyStateMachine)StateMachine;
                if (stateMachine.State.Equals(stateMachine.LeftFacingSmallState) ||
                    stateMachine.State.Equals(stateMachine.RightFacingSmallState))
                {
                    DamageMultiplier = 1f;
                    return 600; // second hit
                }
                return 400; // first hit
            }
        }
        private DateTime _lastDamage;

        public RexEnemyEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            // Override the state machine with the Rex-specific state machine
            StateMachine = new RexEnemyStateMachine();
            var stateMachine = (RexEnemyStateMachine) StateMachine;

            DamageMultiplier = 2f;

            //Setup like a goomba
            var factory = new RexSpriteFactory();
            factory.LoadTextures(content);
            AddSpriteMapping(stateMachine.LeftFacingState, factory.CreateLeftFacingBigRex());
            AddSpriteMapping(stateMachine.RightFacingState, factory.CreateRightFacingBigRex());
            AddSpriteMapping(stateMachine.LeftFacingSmallState, factory.CreateLeftFacingFlatRex());
            AddSpriteMapping(stateMachine.RightFacingSmallState, factory.CreateRightFacingFlatRex());
            AddSpriteMapping(stateMachine.DeadState, factory.CreateLeftFacingDeadRex());
        }

        public override BaseEntity Clone()
        {
            return (BaseEntity) new RexEnemyEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);
        }

        public override void Die(CollidableEntity entity) 
        {
            if (_lastDamage == null || (DateTime.Now - _lastDamage).TotalMilliseconds > 200)
            {
                _lastDamage = DateTime.Now;
                StateMachine.Die();
            } 
        }
    }
}
