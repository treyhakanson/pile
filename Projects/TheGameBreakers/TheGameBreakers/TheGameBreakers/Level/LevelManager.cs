using System;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using System.Collections.Generic;
using System.IO;
using System.Xml.Serialization;
using TheGameBreakers.Entity;
using TheGameBreakers.Factory;
using XMLAsset;
using TheGameBreakers.Entity.Item;
using TheGameBreakers.Entity.Block;
using TheGameBreakers.Entity.Enemy;
using TheGameBreakers.Collider;
using TheGameBreakers.Scoring;
using TheGameBreakers.State.Mario.Action;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Level
{
    enum ItemType
    {
        OneUpItem = 0,
        SuperItem,
        CoinItem,
        FireItem,
        InvincibilityItem
    };

    class LevelManager
    {
        private ContentManager _content;
        private SpriteBatch _spriteBatch;
        private GraphicsDeviceManager _graphics;
        public MarioEntity _marioEntity { get; set; }
        public bool HasWon { get; set; } = false;
        public ScoreTracker _scoreTracker;
        private List<CollidableEntity> _entities;
        private List<CollidableEntity> _pipes;
        private string _assetPath;
        private string _secretAssetPath;
        private GameTimer _gameTimer;
        private AudioPlayer _audioPlayer;
        private SoundFactory _soundFactory;
        
        public int LevelWidth;
        public int LevelHeight;
        public bool SecretStage = false;

        // Used to reset to checkpoints
        private Motion _marioEntityLocationMemento;
        private List<CollidableEntity> _entitiesMemento;

        public LevelManager(ContentManager content, SpriteBatch spriteBatch, AudioPlayer audioPlayer, SoundFactory soundFactory, GraphicsDeviceManager graphics, MarioEntity marioEntity, List<CollidableEntity> entities, ScoreTracker scoreTracker, GameTimer gameTimer)
        {
            _content = content;
            _spriteBatch = spriteBatch;
            _graphics = graphics;
            _marioEntity = marioEntity;
            _entities = entities;
            _entitiesMemento = new List<CollidableEntity>();
            _pipes = new List<CollidableEntity>();
            _scoreTracker = scoreTracker;
            _gameTimer = gameTimer;
            _audioPlayer = audioPlayer;
            _soundFactory = soundFactory;
        }

        public void Load(string assetPath, string secretAssetPath)
        {
            // Save the asset path so it can be used by future resets
            _assetPath = assetPath;
            _secretAssetPath = secretAssetPath;

            // Deserialize the XML associated with the asset path into an object
            var serializer = new XmlSerializer(typeof(LevelAsset), new XmlRootAttribute("LevelAsset"));
            var streamReader = new StreamReader(assetPath);
            var levelAsset = (LevelAsset)serializer.Deserialize(streamReader);
            streamReader.Close();

            streamReader = new StreamReader(secretAssetPath);
            var secretLevelAsset = (LevelAsset)serializer.Deserialize(streamReader);
            streamReader.Close();

            // Create factories
            var enemyEntityFactory = new EnemyEntityFactory(_content, _spriteBatch, _entities, _marioEntity);
            var blockEntityFactory = new BlockEntityFactory(_content, _spriteBatch, _audioPlayer, _soundFactory, _entities);
            var itemEntityFactory = new ItemEntityFactory(_content, _spriteBatch);

            // Set background
            _graphics.PreferredBackBufferWidth = 1200;
            LevelWidth = levelAsset.Width * 4;
            _graphics.PreferredBackBufferHeight = (levelAsset.Height * 4);
            LevelHeight = levelAsset.Height * 4;
            _graphics.ApplyChanges();

            Dictionary<int, Motion> pipeLocations = new Dictionary<int, Motion>();
            Dictionary<PipeBlockEntity, int> pipeDest = new Dictionary<PipeBlockEntity, int>();
            foreach (var rawEntity in levelAsset.Entities)  
            {
                CollidableEntity entity;
                var positionX = rawEntity.Column * 16 * 4 + rawEntity.OffsetX;
                var positionY = rawEntity.Row * 16 * 4 + rawEntity.OffsetY;

                switch (rawEntity.EntityType)
                {
                    case 1:
                        // MarioImg
                        _marioEntity.PositionX = positionX;
                        _marioEntity.PositionY = positionY;
                        entity = _marioEntity;
                        break;
                    case 2:
                        //usedImage
                        entity = blockEntityFactory.CreateUsedBlockEntity(positionX, positionY);
                        break;
                    case 3:
                        //brickImg
                        var bb = blockEntityFactory.CreateBrickBlockEntity(positionX, positionY);
                        _loadSpawnerItems(rawEntity.EntityItems, bb, positionX, positionY, itemEntityFactory);
                        entity = bb;
                        break;
                    case 4:
                        //questionImg
                        var qb = blockEntityFactory.CreateQuestionBlockEntity(positionX, positionY);
                        _loadSpawnerItems(rawEntity.EntityItems, qb, positionX, positionY, itemEntityFactory);
                        entity = qb;
                        break;
                    case 5:
                        //stairImg
                        entity = blockEntityFactory.CreateStairBlockEntity(positionX, positionY);
                        break;
                    case 6:
                        //floorImg
                        entity = blockEntityFactory.CreateFloorBlockEntity(positionX, positionY);
                        break;
                    case 7:
                        //redKoopaImg
                        entity = enemyEntityFactory.CreateRedKoopaEnemyEntity(positionX, positionY);
                        break;
                    case 8:
                        //greenKoopaImg
                        entity = enemyEntityFactory.CreateGreenKoopaEnemyEntity(positionX, positionY);
                        break;
                    case 9:
                        //goombaImg
                        entity = enemyEntityFactory.CreateGoombaEnemyEntity(positionX, positionY);
                        break;
                    case 10:
                        //Hidden block
                        var hb = blockEntityFactory.CreateHiddenBlockEntity(positionX, positionY);
                        _loadSpawnerItems(rawEntity.EntityItems, hb, positionX, positionY, itemEntityFactory);
                        entity = hb;
                        break;
                    case 11:
                        //Pipe block
                        entity = blockEntityFactory.CreatePipeBlockEntity(positionX, positionY);
                        if (rawEntity.Pipe.WarpId != -1) {
                            pipeLocations.Add(rawEntity.Pipe.WarpId, new Motion(positionX + 8 * 4, positionY - 32 * 4));
                            pipeDest.Add((PipeBlockEntity)entity, rawEntity.Pipe.WarpDest);
                        }
                        _pipes.Add(entity);
                        if (rawEntity.EntityItems.Count > 0)
                        {
                            _loadSpawnerItems(rawEntity.EntityItems, (ISpawnerEntity) entity, positionX + 8 * 4, positionY- 10*4, itemEntityFactory);
                        }
                        else
                        {
                            ((ISpawnerEntity) entity).AddSpawnable((CollidableEntity) enemyEntityFactory.CreatePirhanaEnemyEntity(positionX + (8*4), positionY));
                        }
                        break;
                    case 12:
                        // Flag block
                        entity = blockEntityFactory.CreateFlagBlockEntity(positionX, positionY);
                        break;
                    case 14:
                        // Bullet bill (14 to match secret level)
                        entity = enemyEntityFactory.CreateBulletBillEnemyEntity(positionX, positionY);
                        break;
                    case 15:
                        // Boo
                        entity = enemyEntityFactory.CreateBooEnemyEntity(positionX, positionY);
                        break;
                    case 16:
                        // Rex
                        entity = enemyEntityFactory.CreateRexEnemyEntity(positionX, positionY);
                        break;
                    default:
                        // Do nothing if no match
                        entity = null;
                        break;
                }

                if (entity != null)
                {
                    _entities.Add(entity);
                }
            }

            foreach (var rawEntity in secretLevelAsset.Entities)
            {
                CollidableEntity entity;
                var positionX = rawEntity.Column * 16 * 4 + rawEntity.OffsetX;
                var positionY = LevelHeight + rawEntity.Row * 16 * 4 + rawEntity.OffsetY;

                switch (rawEntity.EntityType)
                {
                    case 1:
                        // MarioImg
                        _marioEntity.PositionX = positionX;
                        _marioEntity.PositionY = positionY;
                        entity = _marioEntity;
                        break;
                    case 2:
                        //usedImage
                        entity = blockEntityFactory.CreateUsedBlockEntity(positionX, positionY);
                        break;
                    case 3:
                        //brickImg
                        var bb = blockEntityFactory.CreateBrickBlockEntity(positionX, positionY);
                        _loadSpawnerItems(rawEntity.EntityItems, bb, positionX, positionY, itemEntityFactory);
                        entity = bb;
                        break;
                    case 4:
                        //questionImg
                        var qb = blockEntityFactory.CreateQuestionBlockEntity(positionX, positionY);
                        _loadSpawnerItems(rawEntity.EntityItems, qb, positionX, positionY, itemEntityFactory);
                        entity = qb;
                        break;
                    case 5:
                        //stairImg
                        entity = blockEntityFactory.CreateStairBlockEntity(positionX, positionY);
                        break;
                    case 6:
                        //floorImg
                        entity = blockEntityFactory.CreateFloorBlockEntity(positionX, positionY);
                        break;
                    case 7:
                        //redKoopaImg
                        entity = enemyEntityFactory.CreateRedKoopaEnemyEntity(positionX, positionY);
                        break;
                    case 8:
                        //greenKoopaImg
                        entity = enemyEntityFactory.CreateGreenKoopaEnemyEntity(positionX, positionY);
                        break;
                    case 9:
                        //goombaImg
                        entity = enemyEntityFactory.CreateGoombaEnemyEntity(positionX, positionY);
                        break;
                    case 10:
                        //Hidden block
                        var hb = blockEntityFactory.CreateHiddenBlockEntity(positionX, positionY);
                        _loadSpawnerItems(rawEntity.EntityItems, hb, positionX, positionY, itemEntityFactory);
                        entity = hb;
                        break;
                    case 11:
                        //Pipe block
                        entity = blockEntityFactory.CreatePipeBlockEntity(positionX, positionY);
                        if (rawEntity.Pipe.WarpId != -1) {
                            pipeLocations.Add(rawEntity.Pipe.WarpId, new Motion(positionX + 8 * 4, positionY - 32 * 4));
                            pipeDest.Add((PipeBlockEntity)entity, rawEntity.Pipe.WarpDest);
                        }
                        _pipes.Add(entity);
                        if (rawEntity.EntityItems.Count > 0)
                        {
                            _loadSpawnerItems(rawEntity.EntityItems, (ISpawnerEntity) entity, positionX + 8 * 4, positionY- 10*4, itemEntityFactory);
                        }
                        else
                        {
                            ((ISpawnerEntity) entity).AddSpawnable((CollidableEntity) enemyEntityFactory.CreatePirhanaEnemyEntity(positionX + (8*4), positionY));
                        }
                        break;
                    case 12:
                        // Flag block
                        entity = blockEntityFactory.CreateFlagBlockEntity(positionX, positionY);
                        break;
                    case 13:
                        // Item block
                        entity = itemEntityFactory.CreateCoinItemEntity(positionX, positionY);
                        ((ItemEntity)entity).Reveal(0);
                        break;
                    case 14:
                        // Bullet bill
                        entity = enemyEntityFactory.CreateBulletBillEnemyEntity(positionX, positionY);
                        break;
                    case 15:
                        // Boo
                        entity = enemyEntityFactory.CreateBooEnemyEntity(positionX, positionY);
                        break;
                    case 16:
                        // Rex
                        entity = enemyEntityFactory.CreateRexEnemyEntity(positionX, positionY);
                        break;
                    default:
                        // Do nothing if no match
                        entity = null;
                        break;
                }

                if (entity != null)
                {
                    entity.Visible = false;
                    _entities.Add(entity);
                }
            }

            // Second pass
            foreach (var entity in _entities)
            {
                if (entity is EnemyEntity)
                {
                    ((EnemyEntity) entity).Orient(_marioEntity);
                }
                if (entity is PipeBlockEntity)
                {
                    PipeBlockEntity pipe = (PipeBlockEntity) entity;
                    pipe.levelManager = this;
                    if (pipeDest.ContainsKey(pipe) && pipeLocations.ContainsKey(pipeDest[pipe]))
                    {
                        pipe.warpDestination = pipeLocations[pipeDest[pipe]];
                    }
                }
            }
        }

        private static void _loadSpawnerItems(List<ItemAsset> rawItems, ISpawnerEntity entity, int positionX, int positionY, ItemEntityFactory factory)
        {
            foreach (var rawItem in rawItems)
            {
                var item = _loadItem(rawItem, positionX, positionY, factory);
                entity.AddSpawnable(item);
            }
        }

        private static ItemEntity _loadItem(ItemAsset rawItem, int positionX, int positionY, ItemEntityFactory factory)
        {
            ItemEntity itemEntity;

            switch ((ItemType) rawItem.ItemType)
            {
                case ItemType.SuperItem:
                    itemEntity = factory.CreateSuperItemEntity(positionX, positionY);
                    break;
                case ItemType.OneUpItem:
                    itemEntity = factory.CreateOneUpItemEntity(positionX, positionY);
                    break;
                case ItemType.CoinItem:
                    itemEntity = factory.CreateCoinItemEntity(positionX, positionY);
                    ((CoinItemEntity) itemEntity).Reveal(0);
                    break;
                case ItemType.FireItem:
                    itemEntity = factory.CreateFireItemEntity(positionX, positionY);
                    break;
                case ItemType.InvincibilityItem:
                    itemEntity = factory.CreateInvincibilityItemEntity(positionX, positionY);
                    break;
                default:
                    throw new InvalidOperationException("This can never happen C#, stop making me write defaults for enums");
            }
            return itemEntity;
        }

        public void Update(GameTime gameTime)
        {
            foreach (var pipe in _pipes)
            {
                if (pipe.Visible)
                {
                    if (_marioEntity.PositionX > pipe.PositionX && _marioEntity.PositionX < pipe.PositionX + (4*16*2) && (_marioEntityLocationMemento == null || _marioEntityLocationMemento.PositionX + (2*16*4) < _marioEntity.PositionX))
                    {
                        Checkpoint();
                    }
                    Collider.BoundingBox marioBB = _marioEntity.GetBoundingBox();
                    Collider.BoundingBox pipeBB = pipe.GetBoundingBox();
                    int leftOffset = pipeBB.MinX - marioBB.MaxX, rightOffset = marioBB.MinX - pipeBB.MaxX;
                    if ((leftOffset < 4*16*4 && leftOffset > 16*4) || (rightOffset < 4 * 16 * 4 && rightOffset > 16 * 4))
                    {
                        ((PipeBlockEntity)pipe).Spawn();
                    }
                }
            }
            if (_marioEntity.ActionStateMachine.State is MarioDeadState)
            {
                Reset(gameTime);
            }
        }

        public void Reset(GameTime gameTime, bool hardReset = false)
        {
            if (!hardReset && _scoreTracker.Scores[Counter.Life] <= 0)
            {
                return;
            }
            _scoreTracker.Scores[Counter.Life]--;
            _entities.Clear();
            _marioEntity.SendToNormal();
            if (_marioEntityLocationMemento != null && _entitiesMemento.Count > 0 && _scoreTracker.Scores[Counter.Life] >= 0)
            {
                foreach (CollidableEntity entity in _entitiesMemento)
                {
                    _entities.Add(((CollidableEntity) entity.Clone()));
                }

                _marioEntity.MotionObj = new Motion(_marioEntityLocationMemento.PositionX, _marioEntityLocationMemento.PositionY, 0, 0, 0, 1f);
                WarpTo(_marioEntity.MotionObj);
                _entities.Add(_marioEntity);
            }
            else
            {
                if (_scoreTracker.Scores[Counter.Life] < 0)
                {
                    _scoreTracker.Reset();
                }
                Load(_assetPath, _secretAssetPath);
                _gameTimer.Resume(gameTime);
            }

            HasWon = false;
            _gameTimer.Reset(gameTime);
        }

        public void Checkpoint()
        {
            _entitiesMemento.Clear();
            _entitiesMemento = new List<CollidableEntity>();
            foreach (CollidableEntity entity in _entities)
            {
                if (! (entity is MarioEntity))
                {
                    _entitiesMemento.Add(((CollidableEntity) entity.Clone()));
                }
            }
            _marioEntityLocationMemento = new Motion(_marioEntity.PositionX, _marioEntity.PositionY);
        }

        public void WarpTo(Motion motionObj, bool showTransition=false)
        {
            SecretStage = motionObj.PositionY > LevelHeight;
            foreach (var entity in _entities)
            {
                if (entity is MarioEntity)
                {
                    entity.PositionX = motionObj.PositionX;
                    entity.PositionY = motionObj.PositionY;
                    _audioPlayer.PlaySound(_soundFactory.CreateWarpSound());
                }
                else
                {
                    entity.Visible = entity.PositionY > LevelHeight ? SecretStage : !SecretStage;
                }
            }
        }
    }
}
