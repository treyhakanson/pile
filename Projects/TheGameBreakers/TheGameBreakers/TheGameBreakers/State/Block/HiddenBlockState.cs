using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Block
{
    class HiddenBlockState : BlockState
    {
        public HiddenBlockState(BlockStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void Bump()
        {
            StateMachine.SetState(StateMachine.BrickBlockBumpState);
        }

        public override int GetHashCode()
        {
            return 4;
        }
    }
}
