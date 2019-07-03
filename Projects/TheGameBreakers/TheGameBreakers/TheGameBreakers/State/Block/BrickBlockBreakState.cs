using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Block
{
    class BrickBlockBreakState : BlockState
    {
        public BrickBlockBreakState(BlockStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void Settle()
        {
           StateMachine.SetState(StateMachine.NullBlockState);
        }

        public override int GetHashCode()
        {
            return 1;
        }
    }
}
