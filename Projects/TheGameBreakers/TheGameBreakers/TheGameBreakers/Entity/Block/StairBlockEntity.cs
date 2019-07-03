using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Factory;

namespace TheGameBreakers.Entity.Block
{
    class StairBlockEntity : StatelessEntity
    {
        public StairBlockEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var blockFactory = new BlockSpriteFactory();
            blockFactory.LoadTextures(content);
            Sprite = blockFactory.CreateStairBlock();
        }

        public override BaseEntity Clone()
        {
            return new StairBlockEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);
        }

        // CollidableEntity overrides
        public override CollidableType GetCollidableType()
        {
            return CollidableType.Block;
        }
    }
}
