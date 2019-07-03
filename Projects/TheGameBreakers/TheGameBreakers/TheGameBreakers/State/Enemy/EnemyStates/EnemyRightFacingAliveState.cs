using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Enemy.EnemyStates
{
    class EnemyRightFacingAliveState: EnemyState
    {
        public EnemyRightFacingAliveState(EnemyStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void Die()
        {
            StateMachine.SetState(((EnemyStateMachine)StateMachine).DeadState);
        }

        public override void TurnLeft()
        {
            StateMachine.SetState(((EnemyStateMachine)StateMachine).LeftFacingAliveState);
        }

        public override int GetHashCode()
        {
            return 3;
        }
    }
}
