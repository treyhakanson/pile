using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Block
{
    class BrickBlockState : BlockState
    {
        public BrickBlockState(BlockStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void Bump()
        {
            StateMachine.SetState(StateMachine.BrickBlockBumpState);
        }

        public override void HeavyBump()
        {
            StateMachine.SetState(StateMachine.BrickBlockBreakState);
        }

        public override int GetHashCode()
        {
            return 3;
        }
    }
}
