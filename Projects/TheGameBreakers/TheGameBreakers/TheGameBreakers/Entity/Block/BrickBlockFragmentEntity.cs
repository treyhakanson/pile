using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Factory;

namespace TheGameBreakers.Entity.Block
{
    class BrickBlockFragmentEntity : StatelessEntity
    {
        public BrickBlockFragmentEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var blockFactory = new BlockSpriteFactory();
            blockFactory.LoadTextures(content);
            Sprite = blockFactory.CreateBrickBlockFragment();
            Collidable = false;
            AccelerationY = 1f;
        }

        public override BaseEntity Clone()
        {
            return new BrickBlockFragmentEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);    
        }

        public override CollidableType GetCollidableType()
        {
            return CollidableType.Block;
        }
    }
}
