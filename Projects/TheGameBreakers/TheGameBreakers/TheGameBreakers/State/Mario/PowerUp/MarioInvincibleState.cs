using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Mario.PowerUp
{
    class MarioInvincibleState : MarioPowerUpState
    {
        public MarioInvincibleState(MarioPowerUpStateMachine stateMachine) : base(stateMachine)
        {
        }

        public override void CollideEnemy()
        {
            throw new NotImplementedException();
        }

        public override void CollideFlower()
        {
            throw new NotImplementedException();
        }

        public override void CollideMushroom()
        {
            throw new NotImplementedException();
        }

        public override void CollideStar()
        {
            throw new NotImplementedException();
        }
    }
}
