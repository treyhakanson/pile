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
    class FlagBlockEntity : StatelessEntity
    {
        public FlagBlockEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var blockFactory = new BlockSpriteFactory();
            blockFactory.LoadTextures(content);
            Sprite = blockFactory.CreateFlagBlock();
        }

        public override BaseEntity Clone()
        {
            return new FlagBlockEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);   
        }

        // CollidableEntity overrides
        public override CollidableType GetCollidableType()
        {
            return CollidableType.FlagPole;
        }
    }
}
