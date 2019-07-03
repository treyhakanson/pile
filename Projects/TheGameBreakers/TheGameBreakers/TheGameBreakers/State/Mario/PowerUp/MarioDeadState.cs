using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Mario.PowerUp
{
    class MarioDeadState : MarioPowerUpState
    {
        public MarioDeadState(MarioPowerUpStateMachine stateMachine) : base(stateMachine)
        {
        }
    }
}
