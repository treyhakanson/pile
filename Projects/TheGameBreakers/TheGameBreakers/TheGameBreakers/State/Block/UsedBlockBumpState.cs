using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Block
{
    class UsedBlockBumpState : BlockState
    {
        public UsedBlockBumpState(BlockStateMachine stateMachine) : base(stateMachine)
        {
            IsBumpState = true;
        }

        public override void Settle()
        {
            StateMachine.SetState(StateMachine.UsedBlockState);
        }

        public override int GetHashCode()
        {
            return 7;
        }
    }
}
