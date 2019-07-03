using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Entity;
using TheGameBreakers.Entity.Item;

namespace TheGameBreakers.Factory
{
    class ItemEntityFactory
    {
        private readonly SpriteBatch _spriteBatch;
        private readonly ContentManager _content;

        public ItemEntityFactory(ContentManager content, SpriteBatch spriteBatch)
        {
            _content = content;
            _spriteBatch = spriteBatch;
        }

        public ItemEntity CreateOneUpItemEntity(int positionX, int positionY)
        {
            return new OneUpItemEntity(_content, _spriteBatch, positionX, positionY);
        }

        public ItemEntity CreateInvincibilityItemEntity(int positionX, int positionY)
        {
            return new InvincibilityItemEntity(_content, _spriteBatch, positionX, positionY);
        }

        public ItemEntity CreateSuperItemEntity(int positionX, int positionY)
        {
            return new SuperItemEntity(_content, _spriteBatch, positionX, positionY);
        }

        public ItemEntity CreateFireItemEntity(int positionX, int positionY)
        {
            return new FireItemEntity(_content, _spriteBatch, positionX, positionY);
        }

        public ItemEntity CreateCoinItemEntity(int positionX, int positionY)
        {
            return new CoinItemEntity(_content, _spriteBatch, positionX, positionY);
        }
    }
}
