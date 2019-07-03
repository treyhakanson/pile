using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace TheGameBreakers.Collider
{
    class BoundingBox
    {
        public int MinX { get; private set; }
        public int MaxX { get; private set; }
        public int MinY { get; private set; }
        public int MaxY { get; private set; }

        public BoundingBox(Motion motion, int width, int height, float scale=1)
        {
        	float halfWidth = (float) width / 2;
        	float halfHeight = (float) height / 2;
        	float centerX = motion.PositionX + halfWidth;
        	MinX = (int) (centerX - (scale * halfWidth));
        	MaxX = (int) (centerX + (scale * halfWidth));
        	MinY = (int) (motion.PositionY - halfHeight - (halfHeight * scale));
        	MaxY = motion.PositionY;
        	if (motion.VelocityX > 0) {
        		MaxX += (int) motion.VelocityX;
        	} else {
        		MinX += (int) motion.VelocityX;
        	}
        	if (motion.VelocityY > 0) {
        		MaxY += (int) motion.VelocityY;
        	} else {
        		MinY += (int) motion.VelocityY;
        	}
        }

        // Returns an int (enumerated in this.Collision) for how other will collide with this 
        public Collision Overlaps(BoundingBox other) 
        {
            if (this.MaxX <= other.MinX || this.MinX >= other.MaxX) { return (int) Collision.NoCollision; }
            if (this.MaxY <= other.MinY || this.MinY >= other.MaxY) { return (int) Collision.NoCollision; }
            int xCenterDiff = (this.MinX + this.MaxX) - (other.MinX + other.MaxX);
            int yCenterDiff = (this.MinY + this.MaxY) - (other.MinY + other.MaxY);
            int xOverlap = (xCenterDiff > 0) ? (other.MaxX - this.MinX): (this.MaxX - other.MinX);
            int yOverlap = (yCenterDiff > 0) ? (other.MaxY - this.MinY): (this.MaxY - other.MinY);
            if (xOverlap < yOverlap) {
                return (xCenterDiff > 0) ? Collision.Left: Collision.Right;
            } else {
                return (yCenterDiff > 0) ? Collision.Top: Collision.Bottom;
            }
        }

        public void Draw(SpriteBatch spriteBatch, Texture2D texture) 
        {
            spriteBatch.Draw(texture, new Rectangle(MinX, MinY, MaxX-MinX, MaxY-MinY), Color.White);
        }
    }
}
