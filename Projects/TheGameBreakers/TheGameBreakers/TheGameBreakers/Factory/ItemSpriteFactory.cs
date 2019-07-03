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
    public class ItemSpriteFactory
    {
        private Texture2D items;
        private Texture2D coins;

        public ItemSpriteFactory() { }

        public void LoadTextures(ContentManager content)
        {
            // Items are included in the mario sprite sheet 
            items = content.Load<Texture2D>("items"); 
            coins = content.Load<Texture2D>("coins"); 
        }

        public Sprite CreateStarSprite()
        {
            return new Sprite(items, 16, 16, 175, 215, 1, 1);
        }

        public Sprite CreateFireFlowerSprite()
        {
            return new Sprite(items, 16, 16, 193, 215, 1, 1);
        }

        public Sprite CreateGreenMushroomSprite()
        {
            return new Sprite(items, 16, 16, 229, 216, 1, 1);
        }

        public Sprite CreateRedMushroomSprite()
        {
            return new Sprite(items, 16, 16, 211, 216, 1, 1);
        }

        public Sprite CreateCoinSprite()
        {
            return new Sprite(coins, 16, 16, 0, 0, 1, 4);
        }
    }
}
