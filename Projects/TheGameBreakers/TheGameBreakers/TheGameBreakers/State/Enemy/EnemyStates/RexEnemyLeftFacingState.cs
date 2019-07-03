using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Enemy.EnemyStates
{
    class RexEnemyLeftFacingState : EnemyState
    {
        public RexEnemyLeftFacingState(RexEnemyStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override int GetHashCode()
        {
            return 5;
        }

        public override void TurnRight()
        {
            StateMachine.SetState(((RexEnemyStateMachine)StateMachine).RightFacingState);
        }

        public override void Die()
        {
            Console.WriteLine("Big state die\n");
            StateMachine.SetState(((RexEnemyStateMachine)StateMachine).LeftFacingSmallState);
        }
    }
}
