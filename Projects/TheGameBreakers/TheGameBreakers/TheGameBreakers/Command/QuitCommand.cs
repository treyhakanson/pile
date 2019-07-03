using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;

namespace TheGameBreakers.Command
{
    class QuitCommand : ICommand
    {
        private readonly Game _game;
        
        public QuitCommand(Game game)
        {
            this._game = game;
        }
        
        public void Execute(GameTime gameTime)
        {
            _game.Exit();
        }
    }
}
