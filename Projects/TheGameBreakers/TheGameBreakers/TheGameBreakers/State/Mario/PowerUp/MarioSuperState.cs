using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Mario.PowerUp
{
    class MarioSuperState : MarioPowerUpState
    {
        public MarioSuperState(MarioPowerUpStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void CollideEnemy()
        {
            StateMachine.SetState(StateMachine.NormalState);
        }

        public override void CollideFlower()
        {
            StateMachine.SetState(StateMachine.FireState);
        }

        public override void CollideStar()
        {
            StateMachine.SetState(StateMachine.InvincibleState);
        }
    }
}
