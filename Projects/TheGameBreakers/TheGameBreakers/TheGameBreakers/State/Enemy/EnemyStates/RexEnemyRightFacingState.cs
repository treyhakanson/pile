using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Enemy.EnemyStates
{
    class RexEnemyRightFacingState : EnemyState
    {
        public RexEnemyRightFacingState(RexEnemyStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override int GetHashCode()
        {
            return 7;
        }

        public override void TurnLeft()
        {
            StateMachine.SetState(((RexEnemyStateMachine)StateMachine).LeftFacingState);
        }

        public override void Die()
        {
            StateMachine.SetState(((RexEnemyStateMachine)StateMachine).RightFacingSmallState);
        }
    }
}
