using System.Collections.Generic;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Entity.Block
{
    class QuestionBlockEntity : ItemBlockEntity
    {
        public QuestionBlockEntity(ContentManager content, SpriteBatch spriteBatch, AudioPlayer audioPlayer, SoundFactory soundFactory, int positionX, int positionY) : base(content, spriteBatch, audioPlayer, soundFactory, positionX, positionY)
        {
            AddSpriteMapping(StateMachine.QuestionBlockState, BlockFactory.CreateQuestionBlock());
            AddSpriteMapping(StateMachine.UsedBlockState, BlockFactory.CreateUsedBlock());
            AddSpriteMapping(StateMachine.UsedBlockBumpState, BlockFactory.CreateUsedBlockBump());
            StateMachine.SetState(StateMachine.QuestionBlockState);
        }

        public override BaseEntity Clone()
        {
            QuestionBlockEntity e = new QuestionBlockEntity(this.Content, this.SpriteBatch, AudioPlayer, SoundFactory, this.PositionX, this.PositionY);
            e.StateMachine.SetState(this.StateMachine.State);
            e.ItemSpawner = this.ItemSpawner;
            return (BaseEntity) e;
        }
    }
}
