using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Factory;
using TheGameBreakers.Scoring;
using TheGameBreakers.Sprites;
using TheGameBreakers.Entity;

namespace TheGameBreakers.Level
{
    class Hud
    {
        private int Coins { get; set; }
        private int Lives { get; set; }
        private int Score { get; set; }
        private int Time { get; set; }
        private int Health { get; set; }
        private SpriteBatch _spriteBatch;
        private GraphicsDeviceManager _graphics;

        private Sprite _coinSprite;
        private ItemSpriteFactory _itemFactory;
        private Sprite _marioSprite;
        private MarioSpriteFactory _marioFactory;

        private SpriteFont _marioFont;
        private Texture2D _healthbarTexture;
        private string _name;

        private ScoreTracker _scoreTracker;
        private GameTimer _gameTimer;
        private MarioEntity _mario;
        private Vector2 _coinPos;
        private Vector2 _playerPos;
        private Vector2 _scorePos;
        private Vector2 _livesPos;
        private Vector2 _healthPos;
        private Vector2 _timePos;



        public Hud(ContentManager content, SpriteBatch spriteBatch, GraphicsDeviceManager graphics, ScoreTracker scoreTracker, GameTimer gameTimer, MarioEntity mario)
        {
            _marioFont = content.Load<SpriteFont>("MarioFont");
            _healthbarTexture = new Texture2D(spriteBatch.GraphicsDevice, 1, 1);
            _healthbarTexture.SetData(new Color[] { Color.Red * 0.75f });
            _spriteBatch = spriteBatch;
            _graphics = graphics;
            _scoreTracker = scoreTracker;
            _gameTimer = gameTimer;
            _mario = mario;

            //Coin
            _itemFactory = new ItemSpriteFactory();
            _itemFactory.LoadTextures(content);
            _coinSprite = _itemFactory.CreateCoinSprite();

            //Mario
            _marioFactory = new MarioSpriteFactory();
            _marioFactory.LoadTextures(content);
            _marioSprite = _marioFactory.CreateDyingMario();

            //Player name (could be passed in)
            _name = "Mario";

            //HUD positions
            _playerPos = new Vector2(50, 10);
            _scorePos = new Vector2(50, 50);
            _coinPos = new Vector2(400, 50);
            _livesPos = new Vector2(750, 50);
            _healthPos = new Vector2(700, 20);
            _timePos = new Vector2(1050, 50);
        }

        public void Draw()
        {
            // Coins and score
            _coinSprite.Draw(_spriteBatch, (int)_coinPos.X - 50, (int)_coinPos.Y + 60);
            _spriteBatch.DrawString(_marioFont, " x " + Coins, _coinPos, Color.White);
            _spriteBatch.DrawString(_marioFont, "" + _name, _playerPos, Color.White);
            _spriteBatch.DrawString(_marioFont, "" + Score, _scorePos, Color.White);

            // Lives and time 
            _marioSprite.Draw(_spriteBatch, (int)_livesPos.X - 50, (int)_livesPos.Y +60);
            _spriteBatch.DrawString(_marioFont, " x " + Lives, _livesPos, Color.White);
            _spriteBatch.DrawString(_marioFont, "Time", new Vector2(_timePos.X, _timePos.Y - 40), Color.White);
            _spriteBatch.DrawString(_marioFont, "" + Time, _timePos, Color.White);

            // Health bar 
            int border = 2, height=20;
            _spriteBatch.Draw(_healthbarTexture, new Rectangle((int)_healthPos.X, (int)_healthPos.Y, Health, height), Color.Red);
            _spriteBatch.Draw(_healthbarTexture, new Rectangle((int)_healthPos.X, (int)_healthPos.Y, _mario.MaxHealth(), border), Color.Black);
            _spriteBatch.Draw(_healthbarTexture, new Rectangle((int)_healthPos.X, (int)_healthPos.Y + height - border, _mario.MaxHealth(), border), Color.Black);
            foreach (var offset in Enum.GetValues(typeof(HealthState)))
            {
                _spriteBatch.Draw(_healthbarTexture, new Rectangle((int)_healthPos.X+(int)offset, (int)_healthPos.Y, border, height), Color.Black);
            }
        }

        public void Update()
        {
            _coinSprite.Update();
            _marioSprite.Update();

            //Update HUD values
            Coins = _scoreTracker.Scores[Counter.Coin];
            Score = _scoreTracker.Scores[Counter.Score];
            Lives = _scoreTracker.Scores[Counter.Life];
            Time = (int) _gameTimer.TimeRemaining;
            Health = _mario.Health;
        }
    }
}
