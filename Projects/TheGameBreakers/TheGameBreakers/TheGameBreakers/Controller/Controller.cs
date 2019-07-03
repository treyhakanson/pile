using Microsoft.Xna.Framework.Graphics;
using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using TheGameBreakers.Entity;
using TheGameBreakers.State;

namespace TheGameBreakers.Controller
{
    abstract class Controller<TCommandKeyType> : IController
    {
        private const int ThrottleRate = 100;
        private readonly Dictionary<TCommandKeyType, ICommand> _gameCommandMap = new Dictionary<TCommandKeyType, ICommand>();
        private readonly Dictionary<TCommandKeyType, ICommand> _actionCommandMap = new Dictionary<TCommandKeyType, ICommand>();
        private readonly Dictionary<TCommandKeyType, DateTime> _throttleMap = new Dictionary<TCommandKeyType, DateTime>();
        private readonly ICommand _idleCommand;
        private bool _suspended;

        protected Controller(ICommand idleCommand)
        {
            _suspended = false;
            _idleCommand = idleCommand;
        }

        public virtual void Update(GameTime gameTime)
        {
            // TODO: remove stale key presses
            var now = DateTime.Now;
            var returnToIdle = _throttleMap.Count != 0;

            foreach(var entry in _throttleMap)
            {
                if (!((now - entry.Value).TotalMilliseconds < ThrottleRate)) continue;
                returnToIdle = false;
                break;
            }

            if (returnToIdle) {
                _idleCommand.Execute(gameTime);
            }
        }

        private void _addCommand(Dictionary<TCommandKeyType, ICommand> dict, object key, ICommand value)
        {
            dict[(TCommandKeyType) key] = value;
        }

        public void AddActionCommand(object key, ICommand value)
        {
            _addCommand(_actionCommandMap, key, value);
        }

        public void AddGameCommand(object key, ICommand value)
        {
            _addCommand(_gameCommandMap, key, value);
        }

        public void ToggleSuspended()
        {
            _suspended = !_suspended;
        }

        public IEnumerable<TCommandKeyType> CommandKeys()
        {
            foreach (var key in _actionCommandMap.Keys)
            {
                yield return key;
            }
        }

        public void Invoke(TCommandKeyType action, GameTime gameTime)
        {
            _actionCommandMap.TryGetValue(action, out var actionCommand);
            _gameCommandMap.TryGetValue(action, out var gameCommand);

            // Is an action command, but actions are suspended
            if (actionCommand != null && _suspended)
            {
                return;
            }

            // Neither a game nor action command
            if (actionCommand == null && gameCommand == null)
            {
                return;
            }

            if (_throttleMap.ContainsKey(action) &&
                !((DateTime.Now - _throttleMap[action]).TotalMilliseconds > ThrottleRate))
            {
                return;
            }

            _throttleMap[action] = DateTime.Now;

            // Invoke whichever command was a match
            actionCommand?.Execute(gameTime);
            gameCommand?.Execute(gameTime);
        }
    }
}
