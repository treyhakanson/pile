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
    class MarioJumpRightState : MarioActionState
    {
        public MarioJumpRightState(MarioActionStateMachine marioStateMachine) : base(marioStateMachine)
        {
        }

        public override void Idle(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.FallRightState);
            base.Idle(entity);
        }

        public override void MoveLeft(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.JumpLeftState);
            base.MoveLeft(entity);
        }

        public override void MoveRight(BaseEntity entity)
        {
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
            StateMachine.SetState(StateMachine.IdleRightState);
            base.Land(entity);
        }
    }
}
