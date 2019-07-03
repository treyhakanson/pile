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
    public class BlockSpriteFactory
    {   
        private Texture2D blockSheet;
        private Texture2D extraBlockSheet;
        private Texture2D flagSheet;

        public BlockSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            blockSheet = content.Load<Texture2D>("background-objects");
            extraBlockSheet = content.Load<Texture2D>("items");
            flagSheet = content.Load<Texture2D>("flagpole");
        }

        public Sprite CreateBrickBlock()
        {
            return new Sprite(blockSheet, 16, 16, 126, 559, 1, 1);
        }

        public Sprite CreateBrickBlockFragment()
        {
            return new Sprite(blockSheet, 16, 16, 126, 559, 1, 1, true, 0.35f);
        }

        public Sprite CreateBrickBlockBump()
        {
            return new Sprite(blockSheet, 16, 16, 126, 559, 1, 1);
        }

        public Sprite CreateBrickBlockBreak()
        {
            return new Sprite(blockSheet, 16, 16, 127, 584, 1, 5);
        }

        public Sprite CreateQuestionBlock()
        {
            return new Sprite(extraBlockSheet, 16, 16, 177, 241, 1, 4);
        }

        public Sprite CreateUsedBlock()
        {
            return new Sprite(blockSheet, 16, 16, 126, 529, 1, 1);
        }

        public Sprite CreateUsedBlockBump()
        {
            return new Sprite(blockSheet, 16, 16, 126, 529, 1, 1);
        }

        public Sprite CreateFloorBlock()
        {
            return new Sprite(blockSheet, 16, 16, 27, 62, 1, 1);
        }

        public Sprite CreateStairBlock()
        {
            return new Sprite(blockSheet, 16, 16, 63, 62, 1, 1);
        }

        public Sprite CreateHiddenBlock()
        {
            return new Sprite(blockSheet, 16, 16, 6, 499, 1, 1);
        }

        public Sprite CreateNullSprite()
        {
            return new NullSprite(blockSheet, 0, 0, 0, 0, 1, 1);
        }

        public Sprite CreatePipeBlock()
        {
            return new Sprite(extraBlockSheet, 27, 31, 144, 345, 1, 1, true, 2);
        }

        public Sprite CreateFlagBlock()
        {
            return new Sprite(flagSheet, 168, 24, 0, 0, 1, 1, true);
        }
    }
}
