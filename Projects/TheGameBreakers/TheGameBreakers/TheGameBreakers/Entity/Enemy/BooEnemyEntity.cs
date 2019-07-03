using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Collider;
using TheGameBreakers.Factory;
using TheGameBreakers.State.Enemy;

namespace TheGameBreakers.Entity.Enemy
{
    class BooEnemyEntity : EnemyEntity
    {
        private MarioEntity _marioEntity;
        public BooEnemyEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY, MarioEntity marioEntity) : base(content, spriteBatch, positionX, positionY)
        {
            var factory = new BooSpriteFactory();
            var stateMachine = (EnemyStateMachine)StateMachine;
            factory.LoadTextures(content);
            AddSpriteMapping(stateMachine.LeftFacingAliveState, factory.CreateLeftFacingBooSprite());
            AddSpriteMapping(stateMachine.RightFacingAliveState, factory.CreateRightFacingBooSprite());
            AddSpriteMapping(stateMachine.DeadState, factory.CreateLeftFacingBooSprite());

            // Gravity
            AccelerationY = 0f;
            VelocityX = 0;
            VelocityY = 0;

            // Damage Multiplier
            DamageMultiplier = .5f;


            // Mario
            _marioEntity = marioEntity;

            Orient(marioEntity);

            // Collision mappings
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Top, DoNothing);
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Left, DoNothing);
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Right, DoNothing);
            AddCollisionMapping(new[] { CollidableType.Mario, CollidableType.HeavyMario, CollidableType.Enemy, CollidableType.Block, CollidableType.BreakableBlock }, Collision.Bottom, DoNothing);
        }

        private void DoNothing(CollidableEntity obj)
        {
        }

        public override BaseEntity Clone()
        {
            return (BaseEntity)new BooEnemyEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY, _marioEntity);
        }

        public override void Update()
        {
            if(PositionX < _marioEntity.PositionX)
            {
                TurnRight(this);
                if (_marioEntity.ActionStateMachine.State == _marioEntity.ActionStateMachine.IdleLeftState)
                {
                    VelocityX = 0;
                    VelocityY = 0;
                    AccelerationX = 0;
                }
                else
                {
                    Orient(_marioEntity);
                    if (PositionY < _marioEntity.PositionY)
                    {
                        VelocityY = 1;
                    }
                    else if (PositionY > _marioEntity.PositionY)
                    {
                        VelocityY = -1;
                    }
                    else
                    {
                        VelocityY = 0;
                    }

                }
            }
            else
            {
                TurnLeft(this);
                if (_marioEntity.ActionStateMachine.State == _marioEntity.ActionStateMachine.IdleRightState)
                {
                    VelocityX = 0;
                    VelocityY = 0;
                    AccelerationX = 0;
                }
                else
                {
                    Orient(_marioEntity);
                    if (PositionY < _marioEntity.PositionY)
                    {
                        VelocityY = 1;
                    }
                    else if (PositionY > _marioEntity.PositionY)
                    {
                        VelocityY = -1;
                    }
                    else
                    {
                        VelocityY = 0;
                    }

                }
            }
            base.Update();
        }

        public int PointValue => -100;
    }
}
