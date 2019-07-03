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
    class BulletBillSpriteFactory
    {
            private Texture2D enemies;

            public BulletBillSpriteFactory() { }

            public void LoadTextures(ContentManager content)
            {
                enemies = content.Load<Texture2D>("enemies");
            }

            public Sprite CreateBulletBillSprite()
            {
                return new Sprite(enemies, 64, 64, 7, 314, 1, 1, true, 3);
            }
        }
}
