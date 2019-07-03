using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Graphics;

namespace TheGameBreakers.Sprites
{
    interface ISprite
    {
        void Draw(SpriteBatch spriteBatch, int positionX, int positionY);
        void Update();
        int GetHeight();
        int GetWidth();
    }
}
