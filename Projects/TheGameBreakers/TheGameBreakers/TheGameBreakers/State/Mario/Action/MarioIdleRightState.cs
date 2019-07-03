using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    class MarioIdleRightState : MarioActionState
    {
        public MarioIdleRightState(MarioActionStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void MoveLeft(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.IdleLeftState);
            base.Idle(entity);
        }

        public override void MoveRight(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.RunRightState);
            base.MoveRight(entity);
        }

        public override void Jump(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.JumpRightState);
            base.Jump(entity);
        }

        public override void Fall(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.FallRightState);
            base.Fall(entity);
        }

        public override void Crouch(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.CrouchRightState);
            base.Crouch(entity);
        }
    }
}
