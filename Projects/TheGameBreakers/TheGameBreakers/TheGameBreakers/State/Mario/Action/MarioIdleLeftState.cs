using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    class MarioIdleLeftState : MarioActionState
    {
        public MarioIdleLeftState(MarioActionStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void MoveLeft(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.RunLeftState);
            base.MoveLeft(entity);
        }

        public override void MoveRight(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.IdleRightState);
            base.Idle(entity);
        }

        public override void Jump(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.JumpLeftState);
            base.Jump(entity);
        }

        public override void Fall(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.FallLeftState);
            base.Fall(entity);
        }

        public override void Crouch(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.CrouchLeftState);
            base.Crouch(entity);
        }
    }
}
