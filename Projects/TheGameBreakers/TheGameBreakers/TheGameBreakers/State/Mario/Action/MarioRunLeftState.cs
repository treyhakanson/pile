using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    class MarioRunLeftState : MarioActionState
    {
        public MarioRunLeftState(MarioActionStateMachine marioStateMachine) : base(marioStateMachine)
        {
        }

        public override void Idle(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.IdleLeftState);
            base.Idle(entity);
        }

        public override void SideBump(BaseEntity entity) 
        {
            StateMachine.SetState(StateMachine.IdleLeftState);
            base.SideBump(entity);
        }

        public override void MoveRight(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.IdleLeftState);
            base.Idle(entity);
        }

        public override void Jump(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.JumpLeftState);
            base.Jump(entity);
        }

        public override void Crouch(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.CrouchLeftState);
            base.Crouch(entity);
        }
    }
}
