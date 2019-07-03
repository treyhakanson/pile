using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Block
{
    class BrickBlockBumpState : BlockState
    {
        public BrickBlockBumpState(BlockStateMachine stateMachine) : base(stateMachine)
        {
            IsBumpState = true;
        }

        public override void Settle()
        {
           StateMachine.SetState(StateMachine.BrickBlockState);
        }

        public override int GetHashCode()
        {
            return 2;
        }
    }
}
