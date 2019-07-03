using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using TheGameBreakers.Level;

namespace TheGameBreakers.Command
{
    class BBCommand : ICommand
    {
        private Game1 _game;

        public BBCommand(Game1 game)
        {
            this._game = game;
        }

        public void Execute(GameTime gameTime)
        {
            _game.drawBB = !_game.drawBB;
        }
    }
}
