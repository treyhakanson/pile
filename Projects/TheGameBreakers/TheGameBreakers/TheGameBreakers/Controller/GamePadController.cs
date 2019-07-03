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
    class GamePadController : Controller<Buttons>
    {
        public GamePadController(ICommand idleCommand) : base(idleCommand)
        {
        }
        
        override
        public void Update(GameTime gameTime)
        {
            var state = GamePad.GetState(PlayerIndex.One);
            foreach (var key in this.CommandKeys())
            {
                if (state.IsButtonDown(key))
                {
                    this.Invoke(key, gameTime);
                }
            }
            base.Update(gameTime);
        }
    }
}
