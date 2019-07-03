using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    abstract class MarioActionState
    {
        protected MarioActionStateMachine StateMachine;

        protected MarioActionState(MarioActionStateMachine stateMachine)
        {
            this.StateMachine = stateMachine;
        }

        // NOTE: each of these methods performs the default velocity changes for the
        // transition. Call base.Action(entity) as needed in overrides.
        public virtual void Idle(BaseEntity entity)
        {
            entity.VelocityX = 0;
            entity.AccelerationX = 0;
            if (entity.VelocityY < 0) 
            {
                entity.VelocityY = 0;
            }
        }

        public virtual void SideBump(BaseEntity entity) 
        {
            entity.VelocityX = 0; 
            entity.AccelerationX = 0;
        }

        public virtual void Crouch(BaseEntity entity)
        {
            entity.VelocityX = 0;
            entity.VelocityY = 1;
        }

        public virtual void MoveLeft(BaseEntity entity)
        {
            if (entity.VelocityX >= 0)
            {
                entity.VelocityX = -1;
            }
            entity.AccelerationX = -0.2f;
        }

        public virtual void MoveRight(BaseEntity entity)
        {
            if (entity.VelocityX <= 0)
            {
                entity.VelocityX = 1;
            }
            entity.AccelerationX = 0.2f;
        }

        public virtual void Jump(BaseEntity entity)
        {
            entity.VelocityY = -20;
        }

        public virtual void Land(BaseEntity entity)
        {
            entity.VelocityY = 0;
        }  

        public virtual void Fall(BaseEntity entity)
        {
            if (entity.VelocityY < 0)
            {
                entity.VelocityY = 0;
            }
        }  

        public virtual void Die(BaseEntity entity)
        {
            entity.Collidable = false;
            entity.VelocityX = 0;
            entity.VelocityY = 0;
            entity.AccelerationX = 0;
            entity.AccelerationY = 0;
            StateMachine.SetState(StateMachine.DeadState);
        }
    }
}
