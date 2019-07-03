using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.State.Mario.Action
{
    class MarioDeadState : MarioActionState
    {
        public MarioDeadState(MarioActionStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void Idle(BaseEntity entity)
        {
            // Do nothing
        }

        public override void SideBump(BaseEntity entity) 
        {
            // Do nothing 
        }

        public override void Crouch(BaseEntity entity)
        {
            // Do nothing
        }

        public override void MoveLeft(BaseEntity entity)
        {
            // Do nothing
        }

        public override void MoveRight(BaseEntity entity)
        {
            // Do nothing
        }

        public override void Jump(BaseEntity entity)
        {
            // Do nothing
        }
    }
}
