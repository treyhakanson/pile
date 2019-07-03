using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;
using TheGameBreakers.Entity;

namespace TheGameBreakers.Command.Mario
{
    abstract class MarioCommand : ICommand
    {
        protected MarioEntity Entity;
        
        protected MarioCommand(MarioEntity entity)
        {
            Entity = entity;
        }
        
        public abstract void Execute(GameTime gameTime);
    }
}
