using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Enemy.EnemyStates
{
    class RexEnemyRightFacingSmallState : EnemyState
    {
        public RexEnemyRightFacingSmallState(RexEnemyStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override int GetHashCode()
        {
            return 6;
        }

        public override void TurnLeft()
        {
            StateMachine.SetState(((RexEnemyStateMachine)StateMachine).LeftFacingSmallState);
        }

        public override void Die()
        {
            StateMachine.SetState(((RexEnemyStateMachine)StateMachine).DeadState);
        }
    }
}
