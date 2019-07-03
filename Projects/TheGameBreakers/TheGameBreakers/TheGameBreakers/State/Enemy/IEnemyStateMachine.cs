using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.State.Enemy.EnemyStates;

namespace TheGameBreakers.State.Enemy
{
    interface IEnemyStateMachine
    {
        EnemyState State { get; }
        void SetState(EnemyState state);
        void Die();
        void TurnRight();
        void TurnLeft();
    }
}
