using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    class MarioFallLeftState : MarioActionState
    {
        public MarioFallLeftState(MarioActionStateMachine marioStateMachine) : base(marioStateMachine)
        {
        }

        public override void Crouch(BaseEntity entity)
        {
            // Do nothing 
        }

        public override void MoveLeft(BaseEntity entity)
        {
            base.MoveLeft(entity);
        }

        public override void MoveRight(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.FallRightState);
            base.MoveRight(entity);
        }

        public override void Jump(BaseEntity entity)
        {
            // Do nothing 
        }

        public override void Land(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.IdleLeftState);
            base.Land(entity);
        }  

        public override void Fall(BaseEntity entity)
        {
            // Do nothing 
        }
    }
}
