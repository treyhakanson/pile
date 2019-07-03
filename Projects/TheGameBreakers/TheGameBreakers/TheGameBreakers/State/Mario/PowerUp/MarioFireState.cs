using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Mario.PowerUp
{
    class MarioFireState : MarioPowerUpState
    {
        public MarioFireState(MarioPowerUpStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void CollideEnemy()
        {
            StateMachine.SetState(StateMachine.SuperState);
        }

        public override void CollideStar()
        {
            StateMachine.SetState(StateMachine.InvincibleState);
        }
    }
}
