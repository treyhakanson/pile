using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using TheGameBreakers.Entity;

namespace TheGameBreakers.Command.Mario.Action
{
    class MarioIdleCommand : MarioCommand
    {
        public MarioIdleCommand(MarioEntity entity) : base(entity)
        {
        }

        public override void Execute(GameTime gameTime)
        {
            Entity.Idle();
        }
    }
}
