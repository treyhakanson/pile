using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;

namespace TheGameBreakers.Entity.Block
{
	class UsedBlockEntity : BlockEntity
	{
		public UsedBlockEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
		{
			AddSpriteMapping(StateMachine.UsedBlockState, BlockFactory.CreateUsedBlock());
			AddSpriteMapping(StateMachine.UsedBlockBumpState, BlockFactory.CreateUsedBlockBump());
			StateMachine.SetState(StateMachine.UsedBlockState);
		}

		public override BaseEntity Clone()
		{
			UsedBlockEntity e = new UsedBlockEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);
            e.StateMachine.SetState(this.StateMachine.State);
            return (BaseEntity) e;
		}
	}
}
