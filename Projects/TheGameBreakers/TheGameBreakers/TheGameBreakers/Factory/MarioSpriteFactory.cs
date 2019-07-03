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
    public class MarioSpriteFactory
    {
        private Texture2D mario;
        private Texture2D fireMario;

        public MarioSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            mario = content.Load<Texture2D>("mario");
            fireMario = content.Load<Texture2D>("fire-mario");
        }

        // Mario Sprites
        public Sprite CreateDyingMario()
        {
            return new Sprite(mario, 22, 22, 100, 860, 1, 1);
        }
        
        public Sprite CreateRightFacingStationaryMario()
        {
            return new Sprite(mario, 22, 22, 12, 860, 1, 1);
        }

        public Sprite CreateLeftFacingStationaryMario()
        {
            return new Sprite(mario, 22, 22, 386, 860, 1, 1);
        }

        public Sprite CreateRightFacingWalkingMario()
        {
            return new Sprite(mario, 22, 22, 12, 860, 1, 3);
        }

        public Sprite CreateLeftFacingWalkingMario()
        {
            return new Sprite(mario, 22, 22, 342, 860, 1, 3);
        }

        public Sprite CreateRightFacingCrouchingMario()
        {
            return new Sprite(mario, 22, 22, 166, 860, 1, 1);
        }

        public Sprite CreateLeftFacingCrouchingMario()
        {
            return new Sprite(mario, 22, 22, 276, 860, 1, 1);
        }

        public Sprite CreateRightFacingGazingMario()
        {
            return new Sprite(mario, 22, 22, 144, 860, 1, 1);
        }

        public Sprite CreateLeftFacingGazingMario()
        {
            return new Sprite(mario, 22, 22, 298, 860, 1, 1);
        }

        public Sprite CreateRightFacingJumpingMario()
        {
            return new Sprite(mario, 22, 22, 188, 860, 1, 1);
        }

        public Sprite CreateLeftFacingJumpingMario()
        {
            return new Sprite(mario, 22, 22, 254, 860, 1, 1);
        }

        public Sprite CreateRightFacingFallingMario()
        {
            return new Sprite(mario, 22, 22, 210, 860, 1, 1);
        }

        public Sprite CreateLeftFacingFallingMario()
        {
            return new Sprite(mario, 22, 22, 232, 860, 1, 1);
        }

        // Super Mario Sprites 
        public Sprite CreateRightFacingStationarySuperMario()
        {
            return new Sprite(mario, 30, 22, 12, 132, 1, 1);
        }

        public Sprite CreateLeftFacingStationarySuperMario()
        {
            return new Sprite(mario, 30, 22, 386, 132, 1, 1);
        }

        public Sprite CreateRightFacingWalkingSuperMario()
        {
            return new Sprite(mario, 30, 22, 12, 132, 1, 3);
        }

        public Sprite CreateLeftFacingWalkingSuperMario()
        {
            return new Sprite(mario, 30, 22, 342, 132, 1, 3);
        }

        public Sprite CreateRightFacingCrouchingSuperMario()
        {
            return new Sprite(mario, 22, 22, 166, 140, 1, 1);
        }

        public Sprite CreateLeftFacingCrouchingSuperMario()
        {
            return new Sprite(mario, 22, 22, 276, 140, 1, 1);
        }

        public Sprite CreateRightFacingGazingSuperMario()
        {
            return new Sprite(mario, 30, 22, 144, 132, 1, 1);
        }

        public Sprite CreateLeftFacingGazingSuperMario()
        {
            return new Sprite(mario, 30, 22, 298, 132, 1, 1);
        }

        public Sprite CreateRightFacingJumpingSuperMario()
        {
            return new Sprite(mario, 30, 22, 188, 132, 1, 1);
        }

        public Sprite CreateLeftFacingJumpingSuperMario()
        {
            return new Sprite(mario, 30, 22, 254, 132, 1, 1);
        }

        public Sprite CreateRightFacingFallingSuperMario()
        {
            return new Sprite(mario, 30, 22, 210, 132, 1, 1);
        }

        public Sprite CreateLeftFacingFallingSuperMario()
        {
            return new Sprite(mario, 30, 22, 232, 132, 1, 1);
        }

        // Fire Mario
        public Sprite CreateRightFacingStationaryFireMario()
        {
            return new Sprite(fireMario, 30, 22, 12, 132, 1, 1);
        }

        public Sprite CreateLeftFacingStationaryFireMario()
        {
            return new Sprite(fireMario, 30, 22, 386, 132, 1, 1);
        }

        public Sprite CreateRightFacingWalkingFireMario()
        {
            return new Sprite(fireMario, 30, 22, 12, 132, 1, 3);
        }

        public Sprite CreateLeftFacingWalkingFireMario()
        {
            return new Sprite(fireMario, 30, 22, 342, 132, 1, 3);
        }

        public Sprite CreateRightFacingCrouchingFireMario()
        {
            return new Sprite(fireMario, 22, 22, 166, 140, 1, 1);
        }

        public Sprite CreateLeftFacingCrouchingFireMario()
        {
            return new Sprite(fireMario, 22, 22, 276, 140, 1, 1);
        }

        public Sprite CreateRightFacingGazingFireMario()
        {
            return new Sprite(fireMario, 30, 22, 144, 132, 1, 1);
        }

        public Sprite CreateLeftFacingGazingFireMario()
        {
            return new Sprite(fireMario, 30, 22, 298, 132, 1, 1);
        }

        public Sprite CreateRightFacingJumpingFireMario()
        {
            return new Sprite(fireMario, 30, 22, 188, 132, 1, 1);
        }

        public Sprite CreateLeftFacingJumpingFireMario()
        {
            return new Sprite(fireMario, 30, 22, 254, 132, 1, 1);
        }

        public Sprite CreateRightFacingFallingFireMario()
        {
            return new Sprite(fireMario, 30, 22, 210, 132, 1, 1);
        }

        public Sprite CreateLeftFacingFallingFireMario()
        {
            return new Sprite(fireMario, 30, 22, 232, 132, 1, 1);
        }
    }
}
