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
    class BooSpriteFactory
    {
        private Texture2D enemies;
        private Texture2D booRight;

        public BooSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            enemies = content.Load<Texture2D>("enemies");
            booRight = content.Load<Texture2D>("booRight");
        }

        public Sprite CreateLeftFacingBooSprite()
        {
            return new Sprite(enemies, 16, 16, 108, 581, 1, 2, true);
        }

        public Sprite CreateRightFacingBooSprite()
        {
            return new Sprite(booRight, 16, 16, 0, 0, 1, 2, true);
        }
    }
}
