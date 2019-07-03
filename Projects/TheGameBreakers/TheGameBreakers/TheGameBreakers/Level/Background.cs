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
    public class Background
    {
        private Texture2D Texture;      
        private Vector2 Offset;         
        private Vector2 Speed;           
        private float Zoom;
        //private ContentManager Content;
        private Rectangle Rect;     
        private Viewport Viewport;
        private GraphicsDeviceManager _graphics;

        public Background(GraphicsDeviceManager graphics, Texture2D texture, Vector2 speed, float zoom, Rectangle rect)
        {
            Texture = texture;
            Offset = Vector2.Zero;
            Speed = speed;
            Zoom = zoom;
            Rect = rect;
            _graphics = graphics;
        }


        public void Update(GameTime gametime, Vector2 direction, int marioX, int bufferWidth)
        {
            float elapsed = (float)gametime.ElapsedGameTime.TotalSeconds;

            Vector2 distance = direction * Speed * elapsed;

            //Determines when the background will move
            //Second part of if prevents background from moving for some reason
            if (marioX >= bufferWidth / 2.0f && (marioX < _graphics.GraphicsDevice.Viewport.Width - (bufferWidth / 2.0f)))
            {
                Offset += distance * 2;
                Console.WriteLine(marioX + " " + _graphics.GraphicsDevice.Viewport.Width + " " + (int) (_graphics.GraphicsDevice.Viewport.Width - (bufferWidth / 2.0f)));
            }
            

            //This causes auto scrolling
            //if (marioX >= viewport.Width / 2.0f)
                //Rect.X += 1;
        }

        public void Draw(SpriteBatch spriteBatch)
        {
            spriteBatch.Draw(Texture, new Vector2(Viewport.X + Offset.X + Rect.X, Viewport.Y + Offset.Y + Rect.Y), Rect, Color.White, 0, Vector2.Zero, Zoom, SpriteEffects.None, 1);
        }
    }
}
