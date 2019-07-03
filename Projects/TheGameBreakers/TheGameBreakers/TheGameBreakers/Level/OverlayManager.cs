using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.Level
{
    class OverlayManager
    {
        private SpriteBatch _spriteBatch;
        private SpriteFont _marioFont;
        private GraphicsDeviceManager _graphics;

        public OverlayManager(SpriteBatch spriteBatch, ContentManager content, GraphicsDeviceManager graphics)
        {
            _spriteBatch = spriteBatch;
            _graphics = graphics;
            _marioFont = content.Load<SpriteFont>("MarioFont");
        }

        public void DisplayOverlay(string title, List<string> options)
        {
            _graphics.GraphicsDevice.Clear(Color.Black);
            _spriteBatch.DrawString(_marioFont, "" + title, new Vector2(_graphics.GraphicsDevice.Viewport.Width / 2, _graphics.GraphicsDevice.Viewport.Height / 2 - 50), Color.Yellow);

            for (int i = 0; i < options.Capacity; i++){
                _spriteBatch.DrawString(_marioFont, "" + options[i], new Vector2(_graphics.GraphicsDevice.Viewport.Width / 2, _graphics.GraphicsDevice.Viewport.Height / 2 + 50*i), Color.Yellow );
            }
        }
    }
}
