using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Command
{
    class MuteCommand : ICommand
    {
        private readonly AudioPlayer _player;

        public MuteCommand(AudioPlayer player)
        {
            _player = player;
        }

        public void Execute(GameTime gameTime)
        {
            _player.ToggleMuted();
        }
    }
}
