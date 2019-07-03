using System.Collections.Generic;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Entity;
using TheGameBreakers.Entity.Block;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Factory
{
   class BlockEntityFactory
   {
       private readonly ContentManager _content;
       private readonly SpriteBatch _spriteBatch;
       private readonly List<CollidableEntity> _entities;
       private readonly AudioPlayer _audioPlayer;
       private readonly SoundFactory _soundFactory;

       public BlockEntityFactory(ContentManager content, SpriteBatch spriteBatch, AudioPlayer audioPlayer, SoundFactory soundFactory, List<CollidableEntity> entities)
       {
           _audioPlayer = audioPlayer;
           _soundFactory = soundFactory;
           _content = content;
           _spriteBatch = spriteBatch;
           _entities = entities;
       }

      public BrickBlockEntity CreateBrickBlockEntity(int positionX, int positionY)
      {
          var entity = new BrickBlockEntity(_content, _spriteBatch, this, _audioPlayer, _soundFactory, positionX, positionY);
          entity.InitializeSpawner(_entities);
          return entity;
      }

       public BrickBlockFragmentEntity CreateBrickBlockFragmentEntity(int positionX, int positionY)
       {
           return new BrickBlockFragmentEntity(_content, _spriteBatch, positionX, positionY);
       }

      public HiddenBlockEntity CreateHiddenBlockEntity(int positionX, int positionY)
      {
          var entity = new HiddenBlockEntity(_content, _spriteBatch, _audioPlayer, _soundFactory, positionX, positionY);
          entity.InitializeSpawner(_entities);
          return entity;
      }

      public QuestionBlockEntity CreateQuestionBlockEntity(int positionX, int positionY)
      {
          var entity = new QuestionBlockEntity(_content, _spriteBatch, _audioPlayer, _soundFactory, positionX, positionY);
          entity.InitializeSpawner(_entities);
          return entity;
      }

      public UsedBlockEntity CreateUsedBlockEntity(int positionX, int positionY)
      {
        return new UsedBlockEntity(_content, _spriteBatch, positionX, positionY);
      }

      public FloorBlockEntity CreateStairBlockEntity(int positionX, int positionY)
      {
        return new FloorBlockEntity(_content, _spriteBatch, positionX, positionY);
      }

      public StairBlockEntity CreateFloorBlockEntity(int positionX, int positionY)
      {
        return new StairBlockEntity(_content, _spriteBatch, positionX, positionY);
      }

      public PipeBlockEntity CreatePipeBlockEntity(int positionX, int positionY)
      {
        var entity = new PipeBlockEntity(_content, _spriteBatch, _audioPlayer, _soundFactory, positionX, positionY);
        entity.InitializeSpawner(_entities);
        return entity;
       }

       public FlagBlockEntity CreateFlagBlockEntity(int positionX, int positionY)
       {
           return new FlagBlockEntity(_content, _spriteBatch, positionX, positionY);
       }
   }
}
