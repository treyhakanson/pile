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
    class RexSpriteFactory
    {
        private Texture2D rex;

        public RexSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            rex = content.Load<Texture2D>("Rex");
        }

        public Sprite CreateLeftFacingBigRex()
        {
            return new Sprite(rex, 32, 20, 1, 1, 1, 2, true);
        }

        public Sprite CreateRightFacingBigRex()
        {
            return new Sprite(rex, 32, 20, 1, 34, 1, 2, true);
        }
        //Probably won't need medium rex, but added anyways
        public Sprite CreateLeftFacingMediumRex()
        {
            return new Sprite(rex, 18, 23, 49, 8, 1, 1, true);
        }

        public Sprite CreateRightFacingMediumRex()
        {
            return new Sprite(rex, 18, 23, 88, 42, 1, 1, true);
        }
        
        public Sprite CreateLeftFacingFlatRex()
        {
            return new Sprite(rex, 16, 16, 48, 1, 1, 2, true);
        }

        public Sprite CreateRightFacingFlatRex()
        {
            return new Sprite(rex, 16, 16, 48, 34, 1, 2, true);
        }

        public Sprite CreateLeftFacingDeadRex()
        {
            return new Sprite(rex, 16, 16, 48, 1, 1, 1, true);
        }

        public Sprite CreateRightFacingDeadRex()
        {
            return new Sprite(rex, 16, 16, 48, 34, 1, 1, true);
        }

    }
}
