using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Collider;
using TheGameBreakers.Sprites;

namespace TheGameBreakers.Entity.Item
{
    abstract class ItemEntity : StatelessEntity
    {
        private readonly ISprite _nullSprite = new NullSprite();
        private bool _consumed = false;
        protected bool Revealed = false;
        protected bool Revealing = false;
        private int _initialPositionY;
        private int _bumpMaxOffset = 4 * 16;
        private int _marioPositionX;

        protected ItemEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            _initialPositionY = positionY;

            // Initialize collision mappings
            // Non-mario mappings
            AddCollisionMapping(new [] {CollidableType.Block, CollidableType.BreakableBlock, CollidableType.Enemy}, Collision.Top, CollideWithNonMarioFromTop);
            AddCollisionMapping(new [] {CollidableType.Block, CollidableType.BreakableBlock, CollidableType.Enemy}, Collision.Right, CollideWithNonMarioFromRight);
            AddCollisionMapping(new [] {CollidableType.Block, CollidableType.BreakableBlock, CollidableType.Enemy}, Collision.Bottom, CollideWithNonMarioFromBottom);
            AddCollisionMapping(new [] {CollidableType.Block, CollidableType.BreakableBlock, CollidableType.Enemy}, Collision.Left, CollideWithNonMarioFromLeft);

            // Mario mappings
            AddCollisionMapping(new [] {CollidableType.Mario, CollidableType.HeavyMario}, CollideWithMario);

            // Don't make the item collidable until its been revealed
            Collidable = false;
        }

        protected abstract Tuple<float, float> DetermineVelocity(int marioPositionX);

        public void Reveal(int marioPositionX)
        {
            _marioPositionX = marioPositionX;
            Revealing = true;
        }


        public void Consume()
        {
            Collidable = false;
            VelocityX = 0;
            VelocityY = 0;
            _consumed = true;
        }

        public override void Update()
        {
            if (Revealing)
            {
                if (VelocityY == 0)
                {
                    Revealed = true;
                    VelocityY = -1;
                }
                if (_initialPositionY - PositionY > _bumpMaxOffset)
                {
                    var velocity = DetermineVelocity(_marioPositionX);
                    VelocityX = velocity.Item1;
                    VelocityY = velocity.Item2;
                    Revealing = false;
                    AccelerationY = 0.5f;
                    Collidable = true;
                }
            }
            base.Update();
        }

        protected virtual void CollideWithMario(CollidableEntity entity)
        {
            Consume();
        }

        protected virtual void CollideWithNonMarioFromTop(CollidableEntity entity)
        {
            VelocityY = 0;
        }

        protected virtual void CollideWithNonMarioFromRight(CollidableEntity entity)
        {
            VelocityX = -1;
        }

        protected virtual void CollideWithNonMarioFromBottom(CollidableEntity entity)
        {
            VelocityY = 0;
        }

        protected virtual void CollideWithNonMarioFromLeft(CollidableEntity entity)
        {
            VelocityX = 1;
        }

        protected override ISprite GetSprite()
        {
            return (_consumed || !Revealed) ? _nullSprite : Sprite;
        }
    }
}
