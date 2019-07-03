using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;

namespace TheGameBreakers
{
    interface IController
    {
        void Update(GameTime gameTime);
        void AddGameCommand(object key, ICommand value);
        void AddActionCommand(object key, ICommand value);
        void ToggleSuspended();
    }
}
