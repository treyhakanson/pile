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
    public class KoopaSpriteFactory
    {
        private Texture2D koopas, enemySheet;

        public KoopaSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            koopas = content.Load<Texture2D>("koopas");
            enemySheet = content.Load<Texture2D>("dead_koopas");
        }

        public Sprite CreateLeftFacingRedKoopa()
        {
            return new Sprite(koopas, 28, 18, 74, 2, 1, 1);
        }

        public Sprite CreateRightFacingRedKoopa()
        {
            return new Sprite(koopas, 28, 18, 17, 2, 1, 1);
        }

        public Sprite CreateLeftWalkingRedKoopa()
        {
            return new Sprite(koopas, 28, 18, 56, 2, 1, 2);
        }

        public Sprite CreateRightWalkingRedKoopa()
        {
            return new Sprite(koopas, 28, 18, 17, 2, 1, 2);
        }

        public Sprite CreateLeftFacingGreenKoopa()
        {
            return new Sprite(koopas, 28, 18, 74, 104, 1, 1);
        }

        public Sprite CreateRightFacingGreenKoopa()
        {
            return new Sprite(koopas, 28, 18, 17, 104, 1, 1);
        }

        public Sprite CreateLeftWalkingGreenKoopa()
        {
            return new Sprite(koopas, 28, 18, 56, 104, 1, 2);
        }

        public Sprite CreateRightWalkingGreenKoopa()
        {
            return new Sprite(koopas, 28, 18, 17, 104, 1, 2);
        }

        public Sprite CreateDeadGreenKoopa()
        {
            return new Sprite(enemySheet, 15, 15, 429, 541, 1, 1);
        }

        public Sprite CreateDeadRedKoopa()
        {
            return new Sprite(enemySheet, 15, 15, 429, 579, 1, 1);
        }
    }
}
