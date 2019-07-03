using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.State.Enemy.EnemyStates;

namespace TheGameBreakers.State.Enemy
{
    class EnemyStateMachine : IEnemyStateMachine
    {
        public EnemyState LeftFacingAliveState { get; private set; }
        public EnemyState RightFacingAliveState { get; private set; }
        public EnemyState DeadState { get; private set; }

        public EnemyState State { get; private set; }

        public EnemyStateMachine()
        {
            LeftFacingAliveState = new EnemyLeftFacingAliveState(this);
            RightFacingAliveState = new EnemyRightFacingAliveState(this);
            DeadState = new EnemyDeadState(this);
            State = LeftFacingAliveState;
        }

        public void SetState(EnemyState state)
        {
            State = state;
        }

        public void Die()
        {
            State.Die();
        }

        public void TurnRight()
        {
            State.TurnRight();
        }

        public void TurnLeft()
        {
            State.TurnLeft();
        }
    }
}
