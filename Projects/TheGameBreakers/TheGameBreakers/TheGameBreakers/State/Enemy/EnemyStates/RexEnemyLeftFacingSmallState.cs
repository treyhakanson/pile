using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Enemy.EnemyStates
{
    class RexEnemyLeftFacingSmallState : EnemyState
    {
        public RexEnemyLeftFacingSmallState(RexEnemyStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override int GetHashCode()
        {
            return 4;
        }

        public override void TurnRight()
        {
            StateMachine.SetState(((RexEnemyStateMachine)StateMachine).RightFacingSmallState);
        }

        public override void Die()
        {
            Console.WriteLine("Small state die\n");
            StateMachine.SetState(((RexEnemyStateMachine)StateMachine).DeadState);
        }
    }
}
