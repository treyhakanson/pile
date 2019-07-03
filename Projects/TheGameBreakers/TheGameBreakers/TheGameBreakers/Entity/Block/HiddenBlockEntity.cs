using System.Collections.Generic;
using System.Runtime.InteropServices;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Entity.Block
{
    // TODO: need to send to used block state instead of brick block state if an item was yielded!
    class HiddenBlockEntity : ItemBlockEntity
    {
        public HiddenBlockEntity(ContentManager content, SpriteBatch spriteBatch, AudioPlayer audioPlayer, SoundFactory soundFactory, int positionX, int positionY) : base(content, spriteBatch, audioPlayer, soundFactory, positionX, positionY)
        {
            AddSpriteMapping(StateMachine.HiddenBlockState, BlockFactory.CreateHiddenBlock());
            AddSpriteMapping(StateMachine.UsedBlockState, BlockFactory.CreateUsedBlock());
            AddSpriteMapping(StateMachine.UsedBlockBumpState, BlockFactory.CreateUsedBlockBump());
            AddSpriteMapping(StateMachine.BrickBlockState, BlockFactory.CreateBrickBlock());
            AddSpriteMapping(StateMachine.BrickBlockBreakState, BlockFactory.CreateBrickBlockBreak());
            AddSpriteMapping(StateMachine.BrickBlockBumpState, BlockFactory.CreateBrickBlockBump());
            StateMachine.SetState(StateMachine.HiddenBlockState);
        }

        public override BaseEntity Clone()
        {
            HiddenBlockEntity e = new HiddenBlockEntity(this.Content, this.SpriteBatch, AudioPlayer, SoundFactory, this.PositionX, this.PositionY);
            e.StateMachine.SetState(this.StateMachine.State);
            return (BaseEntity) e;
        }
    }
}
