using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    // NOTE: performing hard transitions since no physics engine to tell when
    // mario has landed
    class MarioJumpLeftState : MarioActionState
    {
        public MarioJumpLeftState(MarioActionStateMachine marioStateMachine) : base(marioStateMachine)
        {
        }

        public override void Idle(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.FallLeftState);
            base.Idle(entity);
        }

        public override void MoveLeft(BaseEntity entity)
        {
            base.MoveLeft(entity);
        }

        public override void MoveRight(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.JumpRightState);
            base.MoveRight(entity);
        }

        public override void Crouch(BaseEntity entity)
        {
            // Do nothing
        }

        public override void Jump(BaseEntity entity)
        {
            // Do nothing
        }

        public override void Fall(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.FallRightState);
            base.Fall(entity);        
        }

        public override void Land(BaseEntity entity) 
        {
            StateMachine.SetState(StateMachine.IdleLeftState);
            base.Land(entity);
        }
    }
}
