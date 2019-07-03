using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Sprites;

namespace TheGameBreakers.Factory
{
    public class BackgroundSpriteFactory
    {
        private Texture2D backgrounds;

        public BackgroundSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            backgrounds = content.Load<Texture2D>("backgrounds"); 
        }

        public Sprite CreateGreenHillsWorldSprite()
        {
            return new Sprite(backgrounds, 160, 512, 0, 337, 1, 1, false);
        }

        public Sprite CreateCastleWorldSprite()
        {
            return new Sprite(backgrounds, 160, 512, 0, 170, 1, 1, false);
        }
    }
}
