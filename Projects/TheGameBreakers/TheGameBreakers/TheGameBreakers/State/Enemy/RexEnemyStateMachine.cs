using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.State.Enemy.EnemyStates;

namespace TheGameBreakers.State.Enemy
{
    class RexEnemyStateMachine : IEnemyStateMachine
    {
        public EnemyState LeftFacingState { get; private set; }
        public EnemyState LeftFacingSmallState { get; private set; }
        public EnemyState RightFacingState { get; private set; }
        public EnemyState RightFacingSmallState { get; private set; }
        public EnemyState DeadState { get; private set; }

        public EnemyState State { get; private set; }

        public RexEnemyStateMachine()
        {
            LeftFacingState = new RexEnemyLeftFacingState(this);
            LeftFacingSmallState = new RexEnemyLeftFacingSmallState(this);
            RightFacingState = new RexEnemyRightFacingState(this);
            RightFacingSmallState = new RexEnemyRightFacingSmallState(this);
            DeadState = new EnemyDeadState(this);
            State = LeftFacingState;
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
