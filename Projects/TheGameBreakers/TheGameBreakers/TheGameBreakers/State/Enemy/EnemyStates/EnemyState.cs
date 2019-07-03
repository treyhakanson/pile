using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Enemy.EnemyStates
{
    abstract class EnemyState
    {
        protected IEnemyStateMachine StateMachine;

        protected EnemyState(IEnemyStateMachine stateMachine)
        {
            StateMachine = stateMachine;
        }

        public virtual void Die()
        {
            // Do nothing
        }

        public virtual void TurnRight()
        {
            // Do nothing
        }

        public virtual void TurnLeft()
        {
            // Do nothing
        }

        public override bool Equals(object obj)
        {
            return this.GetHashCode() == obj.GetHashCode();
        }
    }
}
