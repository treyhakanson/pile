using System;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using System.Collections.Generic;
using TheGameBreakers.Command;
using TheGameBreakers.Command.Mario.Action;
using TheGameBreakers.Command.Mario.PowerUp;
using TheGameBreakers.Entity;
using TheGameBreakers.Collider;
using TheGameBreakers.Entity.Enemy;
using TheGameBreakers.Level;
using TheGameBreakers.Scoring;
using TheGameBreakers.Sound;
using TheGameBreakers.State.Mario.Action;

namespace TheGameBreakers
{
    public class Game1 : Game
    {
        private SpriteBatch _spriteBatch;

        // Background
        private List<Background> _backgrounds;

        // Entities
        private List<CollidableEntity> _entities;

        // Controllers
        private List<IController> _controllers;

        // Graphics
        private readonly GraphicsDeviceManager _graphics;

        // Level Manager
        private LevelManager _levelManager;

        // Collision detector
        private CollisionDetector _collisionDetector;
        public bool drawBB;

        // Collision handlers
        private ScoreTracker _pointTracker;
        private CollisionSoundsHandler _collisionSounds;

        // Audio
        private AudioPlayer _audioPlayer;
        private SoundFactory _soundFactory;

        // Hud
        private Hud _hud;

        // Game Over
        OverlayManager _gameOver;

        // Game Timer
        private GameTimer _gameTimer;

        public Game1()
        {
            _graphics = new GraphicsDeviceManager(this);

            Content.RootDirectory = "Content";
        }

        protected override void Initialize()
        {
            // Initialize sprite batch
            _spriteBatch = new SpriteBatch(GraphicsDevice);

            // Initialize _entities
            _entities = new List<CollidableEntity>();

            // Level Loader
            _soundFactory = new SoundFactory(Content);
            _audioPlayer = new AudioPlayer();
            MarioEntity marioEntity = new MarioEntity(Content, _spriteBatch, 0, 0, _audioPlayer, _soundFactory);
            _gameTimer = new GameTimer(_audioPlayer, _soundFactory);
            _pointTracker = new ScoreTracker(new Dictionary<Counter, int>()
            {
                [Counter.Score] = 0,
                [Counter.Life] = 1,
                [Counter.Coin] = 0
            });
            _levelManager = new LevelManager(Content, _spriteBatch, _audioPlayer, _soundFactory, _graphics, marioEntity, _entities, _pointTracker, _gameTimer);
            _levelManager.Load(@".\LevelDefinition.xml", @".\SecretLevelDefinition.xml");

            // Collision detector
            _collisionDetector = new CollisionDetector();

            // Collision trackers
            _collisionSounds = new CollisionSoundsHandler(_audioPlayer);
            var marioTypes = new [] {CollidableType.Mario, CollidableType.HeavyMario};
            var powerUpTypes = new[] { CollidableType.SuperItem, CollidableType.InvincibilityItem, CollidableType.FireItem };
            foreach (var marioType in marioTypes)
            {
                // Basic scoring off pick-ups
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.CoinItem, Counter.Score, 200);
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.SuperItem, Counter.Score, 1000);
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.FireItem, Counter.Score, 1000);
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.InvincibilityItem, Counter.Score, 1000);

                // Scoring off enemy eliminations
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.Enemy, Collision.Bottom, Counter.Score, 100);
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.Enemy, Collision.Bottom, Counter.Score,
                    (CollidableEntity e1, CollidableEntity e2, Collision d) =>
                    {
                        if (e2 is RexEnemyEntity rex)
                        {
                            return rex.PointValue;
                        } else if (e2 is BooEnemyEntity boo)
                        {
                            return boo.PointValue;
                        }
                        return 100;
                    });

                _pointTracker.AddScoreHeuristic(marioType, CollidableType.Enemy, Collision.Top, Counter.Score,
                    (CollidableEntity e1, CollidableEntity e2, Collision d) =>
                    {
                        if (e2 is BulletBillEnemyEntity bulletBill)
                        {
                            return bulletBill.PointValue;
                        }
                        return 100;
                    });
                // Non-score counter increments
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.OneUpItem, Counter.Life, 1);
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.CoinItem, Counter.Coin, 1);

                // Game completion heuristic
                _pointTracker.AddScoreHeuristic(marioType, CollidableType.FlagPole, Collision.Right, Counter.Score,
                    (CollidableEntity e1, CollidableEntity e2, Collision d) =>
                    {
                        _levelManager.HasWon = true;
                        var timeBonus = 1f + (float) _gameTimer.TimeRemaining / GameTimer.InitialTime;
                        var maxScore = 2000;
                        var height = e2.GetBoundingBox().MaxY;
                        var score = timeBonus * maxScore * e1.PositionY / height;
                        return (int) score;
                    });


                // Collision sounds
                _collisionSounds.AddSoundMapping(marioType, CollidableType.Enemy, Collision.Bottom, _soundFactory.CreateMarioStompSound());
                _collisionSounds.AddSoundMapping(marioType, CollidableType.CoinItem, _soundFactory.CreateCoinCollectionSound());
                _collisionSounds.AddSoundMapping(marioType, CollidableType.Block, Collision.Top, _soundFactory.CreateBrickBumpSound());
                _collisionSounds.AddSoundMapping(marioType, CollidableType.OneUpItem, _soundFactory.CreateOneUpCollectionSound());
                foreach (var powerUpType in powerUpTypes)
                {
                    _collisionSounds.AddSoundMapping(marioType, powerUpType, _soundFactory.CreatePowerUpCollectionSound());
                }
            }

            // Additional sounds
            _collisionSounds.AddSoundMapping(CollidableType.Mario, CollidableType.BreakableBlock, Collision.Top,
                _soundFactory.CreateBrickBumpSound());
            _collisionSounds.AddSoundMapping(CollidableType.HeavyMario, CollidableType.BreakableBlock, Collision.Top,
                _soundFactory.CreateBrickBreakSound());

            // Main song
            _audioPlayer.LoadSong(_soundFactory.CreateMainSong());

            // Add collision handlers
            _collisionDetector.AddCollisionHandler(_collisionSounds);
            _collisionDetector.AddCollisionHandler(_pointTracker);

            // Initialize controllers
            ICommand idleCommand = new MarioIdleCommand(marioEntity);
            IController gamePadController = new Controller.GamePadController(idleCommand);
            IController keyboardController = new Controller.KeyboardController(idleCommand);
            _controllers = new List<IController>() { keyboardController, gamePadController };

            // General, game-level commands
            ICommand quitCommand = new QuitCommand(this);
            ICommand resetCommand = new ResetCommand(_levelManager);
            ICommand pauseCommand = new PauseCommand(_controllers, _audioPlayer, _gameTimer);
            ICommand checkpointCommand = new CheckpointCommand(_levelManager);
            ICommand drawBBCommand = new BBCommand(this);

            // Mario action state commands
            ICommand jumpCommand = new MarioJumpCommand(marioEntity);
            ICommand moveLeftCommand = new MarioMoveLeftCommand(marioEntity);
            ICommand moveRightCommand = new MarioMoveRightCommand(marioEntity);
            ICommand crouchCommand = new MarioCrouchActionCommand(marioEntity);

            // Mario power-up commands
            ICommand superCommand = new MarioSuperCommand(marioEntity);
            ICommand takeDamageCommand = new MarioTakeDamageCommand(marioEntity);
            ICommand normalCommand = new MarioNormalCommand(marioEntity);
            ICommand fireCommand = new MarioFireCommand(marioEntity);

            // Miscellaneous commands
            ICommand muteCommand = new MuteCommand(_audioPlayer); // not a game level command, because pause menu should toggle sound off

            // Setup keyboard controller
            keyboardController.AddGameCommand(Keys.Q, quitCommand);
            keyboardController.AddGameCommand(Keys.R, resetCommand);
            keyboardController.AddGameCommand(Keys.P, pauseCommand);
            keyboardController.AddGameCommand(Keys.C, checkpointCommand);
            keyboardController.AddGameCommand(Keys.B, drawBBCommand);
            keyboardController.AddActionCommand(Keys.M, muteCommand);
            keyboardController.AddActionCommand(Keys.Up, jumpCommand);
            keyboardController.AddActionCommand(Keys.Left, moveLeftCommand);
            keyboardController.AddActionCommand(Keys.Right, moveRightCommand);
            keyboardController.AddActionCommand(Keys.Down, crouchCommand);
            keyboardController.AddActionCommand(Keys.W, jumpCommand);
            keyboardController.AddActionCommand(Keys.A, moveLeftCommand);
            keyboardController.AddActionCommand(Keys.D, moveRightCommand);
            keyboardController.AddActionCommand(Keys.S, crouchCommand);
            keyboardController.AddActionCommand(Keys.Y, normalCommand);
            keyboardController.AddActionCommand(Keys.U, superCommand);
            keyboardController.AddActionCommand(Keys.I, fireCommand);
            keyboardController.AddActionCommand(Keys.O, takeDamageCommand);

            // Setup game-pad controller
            gamePadController.AddGameCommand(Buttons.Start, quitCommand);
            gamePadController.AddActionCommand(Buttons.DPadUp, jumpCommand);
            gamePadController.AddActionCommand(Buttons.DPadLeft, moveLeftCommand);
            gamePadController.AddActionCommand(Buttons.DPadRight, moveRightCommand);
            gamePadController.AddActionCommand(Buttons.DPadDown, crouchCommand);

            // Backgrounds
            _backgrounds = new List<Background>();

            //Camera
            //Viewport has to be set the actual size of the level (test level = 640 x 226, LevelDefinition = 320 x 226)
            _graphics.GraphicsDevice.Viewport = new Viewport(0, 0, 640 * 4, 226 * 4);

            // Hud
            _hud = new Hud(Content, _spriteBatch, _graphics, _pointTracker, _gameTimer, marioEntity);

            // Game over
            _gameOver = new OverlayManager(_spriteBatch, Content, _graphics);

            base.Initialize();
        }

        protected override void LoadContent()
        {
            //Load the background images
            _backgrounds.Add(new Background(_graphics, Content.Load<Texture2D>(@"BG_TEST"), new Vector2(10, 0), 2.5f, new Rectangle(0, 0, _graphics.PreferredBackBufferWidth, _graphics.PreferredBackBufferHeight)));
            _backgrounds.Add(new Background(_graphics, Content.Load<Texture2D>(@"clouds"), new Vector2(100, 0), 2.5f, new Rectangle(0, 0, 311, 56)));
            _backgrounds.Add(new Background(_graphics, Content.Load<Texture2D>(@"clouds"), new Vector2(200, 0), 2.5f, new Rectangle(0, 56 * 3, 311, 56)));
        }

        protected override void Update(GameTime gameTime)
        {
            // Don't update anything's position (or related information) if the
            // game timer isn't running (game is paused)
            if (!_gameTimer.Paused)
            {
              _collisionDetector.DetectCollisions(_entities);

              // Update each entity
              foreach (var entity in _entities)
              {
                entity.Update();
              }
            }

            // Update the _controllers
            foreach (IController controller in _controllers)
            {
                controller.Update(gameTime);
            }

            // Update miscellaneous
            _gameTimer.Update(gameTime);
            _audioPlayer.Update();
            _levelManager.Update(gameTime);
            _hud.Update();

            if (_gameTimer.TimeRemaining == 0)
            {
                _levelManager.Reset(gameTime);
            }

            base.Update(gameTime);
        }

        protected override void Draw(GameTime gameTime)
        {
            if (!_levelManager.SecretStage)
            {
                int xOffset = 0, halfscreenWidth = _graphics.GraphicsDevice.Viewport.Width/2;
                if (_levelManager._marioEntity.PositionX > halfscreenWidth){
                    if (_levelManager._marioEntity.PositionX < _levelManager.LevelWidth - halfscreenWidth) {
                        xOffset -= _levelManager._marioEntity.PositionX - halfscreenWidth;
                    } else {
                        xOffset -= _levelManager.LevelWidth - _graphics.GraphicsDevice.Viewport.Width;
                    }
                }
                _spriteBatch.Begin(SpriteSortMode.Deferred, null, null, null, null, null, Matrix.CreateTranslation(xOffset,0,0));

                //Draw each background
                foreach (Background bg in _backgrounds)
                {
                    bg.Draw(_spriteBatch);
                }
            }
            else
            {
                GraphicsDevice.Clear(Color.Black);
                _spriteBatch.Begin(SpriteSortMode.Deferred, null, null, null, null, null, Matrix.CreateTranslation(0, -_levelManager.LevelHeight, 0));
            }

            // Draw each entity
            foreach (var entity in _entities)
            {
                entity.Draw(drawBB);
            }

            // End drawing sprite batch
            _spriteBatch.End();

            //Draw Hud
            _spriteBatch.Begin();
            _hud.Draw();

            //Test of game over screen
            if (_levelManager._marioEntity.ActionStateMachine.State is MarioDeadState && _pointTracker.Scores[Counter.Life] == 0)
            {
                List<string> gameOverList = new List<string>(new string[] { "Replay [R]", "Exit [Q]" });
                _gameOver.DisplayOverlay("Game Over!", gameOverList);
                _gameTimer.Pause(gameTime);
                _audioPlayer.PlaySoundIfNotPlaying(_soundFactory.CreateGameOverSound());
            }

            if (_levelManager.HasWon)
            {
                List<string> gameWonList = new List<string>(new string[] { "Replay [R]", "Exit [Q]" });
                _gameOver.DisplayOverlay("You Won!", gameWonList);
                _gameTimer.Pause(gameTime);
            }

            _spriteBatch.End();
            base.Draw(gameTime);
        }
    }
}
