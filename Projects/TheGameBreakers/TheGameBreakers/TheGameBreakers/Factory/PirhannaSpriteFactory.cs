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
    public class PirhanaSpriteFactory
    {
        
        private Texture2D enemies;

        public PirhanaSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            enemies = content.Load<Texture2D>("enemies"); 
        }

        public Sprite CreatePirhanaSprite()
        {
            return new Sprite(enemies, 32, 18, 409, 155, 1, 2, true);
        }
    }
}
