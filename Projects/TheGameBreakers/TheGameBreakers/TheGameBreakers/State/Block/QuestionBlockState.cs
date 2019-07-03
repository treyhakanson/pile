using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Block
{
    class QuestionBlockState : BlockState
    {
        public QuestionBlockState(BlockStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void Bump()
        {
            StateMachine.SetState(StateMachine.UsedBlockBumpState);
        }

        public override int GetHashCode()
        {
            return 6;
        }
    }
}
