using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    class MarioRunRightState : MarioActionState
    {
        public MarioRunRightState(MarioActionStateMachine marioStateMachine) : base(marioStateMachine)
        {
        }

        public override void Idle(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.IdleRightState);
            base.Idle(entity);
        }
        
        public override void SideBump(BaseEntity entity) 
        {
            StateMachine.SetState(StateMachine.IdleRightState);
            base.SideBump(entity);
        }

        public override void MoveLeft(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.IdleRightState);
            base.Idle(entity);
        }

        public override void Jump(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.JumpRightState);
            base.Jump(entity);
        }

        public override void Crouch(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.CrouchRightState);
            base.Crouch(entity);
        }
    }
}
