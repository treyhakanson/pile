using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Sprites;
using TheGameBreakers.Collider;
using Microsoft.Xna.Framework.Content;

namespace TheGameBreakers.Entity
{
    abstract class BaseEntity
    {
        protected SpriteBatch SpriteBatch;
        protected ContentManager Content;
        public bool Collidable { get; set; } = false;
        public bool Visible { get; set; } = true;
        public Motion MotionObj;

        public int PositionX 
        {
            get => MotionObj.PositionX;
            set => MotionObj.PositionX = value;
        }
        public int PositionY
        {
            get => MotionObj.PositionY;
            set => MotionObj.PositionY = value;
        }
        public float VelocityX
        {
            get => MotionObj.VelocityX;
            set => MotionObj.VelocityX = value;
        }
        public float VelocityY
        {
            get => MotionObj.VelocityY;
            set => MotionObj.VelocityY = value;
        }
        public float AccelerationX 
        {
            set => MotionObj.AccelerationX = value;
        }
        public float AccelerationY 
        {
            set => MotionObj.AccelerationY = value;
        }

        protected BaseEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY)
        {
            SpriteBatch = spriteBatch;
            Content = content;
            MotionObj = new Motion(positionX, positionY);
        }

        public abstract BaseEntity Clone();

        // Concrete objects must define how to get the entities sprite; varies
        // based on state, transitions, etc.
        protected abstract ISprite GetSprite();

        // Default update method updates the position based on the rate and
        // velocity, and then updates the sprite
        public virtual void Update()
        {
            // Updates the x and y position of the entity based on the velocity
            if (Visible) 
            {
                MotionObj.Update();
                GetSprite().Update();
            }
        }

        // Retrieve the sprite, and draw it
        public virtual void Draw(bool drawBB=false)
        {
            if (Visible)
            {
                GetSprite().Draw(SpriteBatch, PositionX, PositionY);
            }
        }
    }
}
