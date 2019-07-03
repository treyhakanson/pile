using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Block
{
    // Has no sprite, and will be ignored by the collider
    class NullBlockState : BlockState
    {
        public NullBlockState(BlockStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override int GetHashCode()
        {
            return 5;
        }
    }
}
