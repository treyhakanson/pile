using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Mario.PowerUp
{
    abstract class MarioPowerUpState
    {
        protected MarioPowerUpStateMachine StateMachine;

        protected MarioPowerUpState(MarioPowerUpStateMachine stateMachine)
        {
            StateMachine = stateMachine;
        }

        public virtual void CollideMushroom()
        {
            // Do nothing
        }

        public virtual void CollideStar()
        {
            // Do nothing
        }

        public virtual void CollideEnemy()
        {
            // Do nothing
        }

        public virtual void CollideFlower()
        {
            // Do nothing
        }
    }
}
