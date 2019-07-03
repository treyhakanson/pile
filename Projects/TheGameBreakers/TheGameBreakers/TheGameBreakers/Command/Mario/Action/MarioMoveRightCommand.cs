using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using TheGameBreakers.Entity;
using TheGameBreakers.State;

namespace TheGameBreakers.Command.Mario.Action
{
    class MarioMoveRightCommand : MarioCommand
    {
        public MarioMoveRightCommand(MarioEntity entity) : base(entity)
        {
        }

        public override void Execute(GameTime gameTime)
        {
            Entity.MoveRight();
        }
    }
}
