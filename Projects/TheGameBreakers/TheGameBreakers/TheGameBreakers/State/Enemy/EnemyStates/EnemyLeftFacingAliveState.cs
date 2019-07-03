using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Enemy.EnemyStates
{
    class EnemyLeftFacingAliveState : EnemyState
    {
        public EnemyLeftFacingAliveState(EnemyStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void Die()
        {
            StateMachine.SetState(((EnemyStateMachine)StateMachine).DeadState);
        }

        public override void TurnRight()
        {
            StateMachine.SetState(((EnemyStateMachine)StateMachine).RightFacingAliveState);
        }

        public override int GetHashCode()
        {
            return 2;
        }
    }
}
