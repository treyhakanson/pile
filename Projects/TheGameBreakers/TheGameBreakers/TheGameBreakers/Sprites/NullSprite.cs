using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Graphics;

namespace TheGameBreakers.Sprites
{
    class NullSprite : Sprite
    {
        public NullSprite(Texture2D sprite=null, int height=0, int width=0, int offsetX=0, int offsetY=0, int rows=1, int cols=1) : base(sprite,  height,  width,  offsetX,  offsetY,  rows,  cols)
        {
        }
    }
}
