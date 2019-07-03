using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Entity;
using TheGameBreakers.Level;
using XMLAsset;

namespace TheGameBreakers.Command
{
    class ResetCommand : ICommand
    {
        private LevelManager _levelManager;

        public ResetCommand(LevelManager levelManager)
        {
            _levelManager = levelManager;
        }

        public void Execute(GameTime gameTime)
        {
            _levelManager.Reset(gameTime, true);
        }
    }
}
