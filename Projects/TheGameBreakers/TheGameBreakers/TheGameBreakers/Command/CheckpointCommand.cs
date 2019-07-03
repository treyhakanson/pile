using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using TheGameBreakers.Level;

namespace TheGameBreakers.Command
{
    class CheckpointCommand : ICommand
    {
        private readonly LevelManager _lm;
        
        public CheckpointCommand(LevelManager levelManager)
        {
            this._lm = levelManager;
        }
        
        public void Execute(GameTime gameTime)
        {
            _lm.Checkpoint();
        }
    }
}
