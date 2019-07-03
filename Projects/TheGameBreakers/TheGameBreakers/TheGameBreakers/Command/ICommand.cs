using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;

namespace TheGameBreakers
{
    interface ICommand
    {
        void Execute(GameTime gameTime);
    }
}
