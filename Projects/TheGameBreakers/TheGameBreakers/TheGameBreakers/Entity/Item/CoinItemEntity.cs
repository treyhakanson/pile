using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Factory;

namespace TheGameBreakers.Entity.Item
{
    class CoinItemEntity : ItemEntity
    {
        public CoinItemEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX,
            positionY)
        {
            var factory = new ItemSpriteFactory();
            factory.LoadTextures(content);
            var sprite = factory.CreateCoinSprite();
            Sprite = sprite;
        }

        public override BaseEntity Clone()
        {
            return (BaseEntity) new CoinItemEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);
        }

        public override CollidableType GetCollidableType()
        {
            return CollidableType.CoinItem;
        }

        protected override Tuple<float, float> DetermineVelocity(int marioPositionX)
        {
            return Tuple.Create(0.0f, -1.0f);
        }
    }
}
