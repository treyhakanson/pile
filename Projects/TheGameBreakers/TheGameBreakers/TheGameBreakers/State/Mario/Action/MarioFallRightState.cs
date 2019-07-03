using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    class MarioFallRightState : MarioActionState
    {
        public MarioFallRightState(MarioActionStateMachine marioStateMachine) : base(marioStateMachine)
        {
        }

        public override void Crouch(BaseEntity entity)
        {
            // Do nothing 
        }

        public override void MoveLeft(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.FallLeftState);
            base.MoveLeft(entity);        
        }

        public override void MoveRight(BaseEntity entity)
        {
            base.MoveRight(entity);
        }

        public override void Jump(BaseEntity entity)
        {
            // Do nothing 
        }

        public override void Land(BaseEntity entity)
        {
            StateMachine.SetState(StateMachine.IdleRightState);
            base.Land(entity);
        }  

        public override void Fall(BaseEntity entity)
        {
            // Do nothing 
        }
    }
}
