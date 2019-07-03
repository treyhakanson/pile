using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using TheGameBreakers.Sound;
using TheGameBreakers.Scoring;

namespace TheGameBreakers.Command
{
    class PauseCommand : ICommand
    {
        private readonly List<IController> _controllers;
        private readonly AudioPlayer _player;
        private readonly GameTimer _gameTimer;
        private bool _wasMuted;
        private bool _paused;

        public PauseCommand(List<IController> controllers, AudioPlayer player, GameTimer gameTimer)
        {
            _wasMuted = true;
            _paused = false;
            _player = player;
            _gameTimer = gameTimer;
            _controllers = controllers;
        }

        public void Execute(GameTime gameTime)
        {
            _paused = !_paused;

            if (_paused)
            {
                _wasMuted = _player.Muted;
                _player.Mute();

            } else if (!_wasMuted)
            {
                _player.UnMute();
            }

            foreach (var controller in _controllers)
            {
                controller.ToggleSuspended();
            }

            _gameTimer.Toggle(gameTime);
        }
    }
}
