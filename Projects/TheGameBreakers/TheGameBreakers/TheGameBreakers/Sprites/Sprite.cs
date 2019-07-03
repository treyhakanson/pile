using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace TheGameBreakers.Sprites
{
    public class Sprite : ISprite
    {
        private int height;
        private int width;
        private Texture2D sprite;
        private int offsetX;
        private int offsetY;
        private int rows;
        private int cols;
        private int currentFrame;
        private bool normalized;
        private int scale = 4;
        private readonly float _drawScale;
        private int framesPerCycle = 10;

        public Sprite(Texture2D sprite, int height, int width, int offsetX, int offsetY, int rows, int cols)
        {
            _drawScale = 1.0f;
            this.sprite = sprite;
            this.height = height;
            this.width = width;
            this.offsetX = offsetX;
            this.offsetY = offsetY;
            this.rows = rows;
            this.cols = cols;
            currentFrame = 0;
            this.normalized = true;
        }

        public Sprite(Texture2D sprite, int height, int width, int offsetX, int offsetY, int rows, int cols, bool normalized)
        {
            _drawScale = 1.0f;
            this.sprite = sprite;
            this.height = height;
            this.width = width;
            this.offsetX = offsetX;
            this.offsetY = offsetY;
            this.rows = rows;
            this.cols = cols;
            currentFrame = 0;
            this.normalized = normalized;
        }

        public Sprite(Texture2D sprite, int height, int width, int offsetX, int offsetY, int rows, int cols, bool normalized, float drawScale)
        {
            _drawScale = drawScale;
            this.sprite = sprite;
            this.height = height;
            this.width = width;
            this.offsetX = offsetX;
            this.offsetY = offsetY;
            this.rows = rows;
            this.cols = cols;
            currentFrame = 0;
            this.normalized = normalized;
        }

        public void Update()
        {
            currentFrame = (currentFrame + 1) % (framesPerCycle * rows * cols);
        }

        public void Draw(SpriteBatch spriteBatch, int positionX, int positionY)
        {
            int cycle = currentFrame / framesPerCycle;
            int row = (int)((float)cycle / (float)cols);
            int col = cycle % cols;

            float multiplier = normalized ? ((float)16)/width: 1;
            int normalizedWidth = (int) (width * multiplier * scale * _drawScale);
            int normalizedHeight = (int) (height * multiplier * scale * _drawScale);

            Rectangle srcRect = new Rectangle(offsetX + width * col, offsetY + height * row, width, height);
            Rectangle destRect = new Rectangle(positionX, (int) (positionY - normalizedHeight), normalizedWidth, normalizedHeight);

            if (sprite == null) return;

            spriteBatch.Draw(sprite, destRect, srcRect, Color.White);
        }

        public int GetWidth()
        {
            float multiplier = normalized ? ((float)16)/width: 1;
            return (int) (width * multiplier * scale * _drawScale);
        }

        public int GetHeight()
        {
            float multiplier = normalized ? ((float)16)/width: 1;
            return (int) (height * multiplier * scale * _drawScale);
        }
    }
}
