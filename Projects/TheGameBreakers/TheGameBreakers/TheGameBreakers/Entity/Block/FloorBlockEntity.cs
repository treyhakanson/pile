using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Factory;

namespace TheGameBreakers.Entity.Block
{
    class FloorBlockEntity : StatelessEntity
    {
        public FloorBlockEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var blockFactory = new BlockSpriteFactory();
            blockFactory.LoadTextures(content);
            Sprite = blockFactory.CreateFloorBlock();
        }

        public override BaseEntity Clone()
        {
            return new FloorBlockEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);    
        }

        // CollidableEntity overrides
        public override CollidableType GetCollidableType()
        {
            return CollidableType.Block;
        }
    }
}
