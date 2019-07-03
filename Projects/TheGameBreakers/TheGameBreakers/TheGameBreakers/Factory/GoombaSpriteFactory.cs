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
    public class GoombaSpriteFactory
    {
        
        private Texture2D goomba;

        public GoombaSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            goomba = content.Load<Texture2D>("goomba"); 
        }

        public Sprite CreateGoombaSprite()
        {
            return new Sprite(goomba, 17, 17, 9, 7, 1, 4);
        }

        public Sprite CreateDeadGoombaSpirte()
        {
            return new Sprite(goomba, 20, 16, 9, 31, 1, 1);
        }
    }
}
