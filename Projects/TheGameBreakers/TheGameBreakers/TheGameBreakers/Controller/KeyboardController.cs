using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using TheGameBreakers.Entity;
using TheGameBreakers.State;

namespace TheGameBreakers.Controller
{
    class KeyboardController : Controller<Keys>
    {
        public KeyboardController(ICommand idleCommand) : base(idleCommand)
        {
        }
        
        override
        public void Update(GameTime gameTime)
        {
            foreach (var key in Keyboard.GetState().GetPressedKeys())
            {
                Invoke(key, gameTime);
            }
            base.Update(gameTime);
        }
    }
}
