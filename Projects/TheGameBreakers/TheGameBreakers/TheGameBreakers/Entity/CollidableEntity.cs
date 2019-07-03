using System;
using System.Collections.Generic;
using TheGameBreakers.Collider;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;

namespace TheGameBreakers.Entity
{
    enum CollidableType
    {
      Mario = 1,
      HeavyMario,
      Block,
      BreakableBlock,
      Enemy,
      SuperItem,
      FireItem,
      InvincibilityItem,
      OneUpItem,
      CoinItem,
      FlagPole
    }

    abstract class CollidableEntity : BaseEntity, IDisposable
    {
        // Concrete classes must define the type of collidable so that the
        public abstract CollidableType GetCollidableType();
        private Dictionary<CollidableType, Dictionary<Collision, Action<CollidableEntity>>> _collisionMappings;
        protected float _boundScale = 1;
        protected Texture2D _bbTexture;
        protected int _isColliding; // This variable counts down frames in order to flash a color when colliding. The single frame
        // flash never was visible. This is not useful to the functionality of the class, just for acceptance criteria and debugging

        protected CollidableEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY): base(content, spriteBatch, positionX, positionY)
        {
            this.Collidable = true;
            _isColliding = 1;
            _bbTexture = new Texture2D(spriteBatch.GraphicsDevice, 1, 1);
            _collisionMappings = new Dictionary<CollidableType, Dictionary<Collision, Action<CollidableEntity>>>();
        }

        public void Collide(CollidableEntity collidableEntity, Collision collision)
        {
            _bbTexture.SetData(new Color[] { Color.Purple });
            _isColliding = 4;

            // Check if a mapping exists for the collidable type
            Dictionary<Collision, Action<CollidableEntity>> innerMapping;
            if (!_collisionMappings.TryGetValue(collidableEntity.GetCollidableType(), out innerMapping))
            {
              return;
            }

            // Check if a callback exists for the collision type within the
            // mapping for the collidable type
            Action<CollidableEntity> collisionCallback;
            if (!innerMapping.TryGetValue(collision, out collisionCallback))
            {
              return;
            }

            // Invoke the callback with the colliding entity
            collisionCallback(collidableEntity);
        }

        // NOTE: only allows one mapping per type! (can be extended to use a
        // collection in the future)
        protected void AddCollisionMapping(CollidableType collidableType, Collision collision, Action<CollidableEntity> collisionCallback)
        {
          Dictionary<Collision, Action<CollidableEntity>> innerMapping;
          if (_collisionMappings.TryGetValue(collidableType, out innerMapping))
          {
            // If the mapping to the type already exists, add the callback
            innerMapping[collision] = collisionCallback;
          }
          else
          {
            // If the mapping does not yet exist, add a mapping that contains the callback
            _collisionMappings[collidableType] = new Dictionary<Collision, Action<CollidableEntity>>
            {
              [collision] = collisionCallback
            };
          }
        }

        // overload to add a callback to a collision type for multiple collidable types
        protected void AddCollisionMapping(CollidableType[] collidableTypes, Collision collision, Action<CollidableEntity> collisionCallback)
        {
          foreach (var collidableType in collidableTypes)
          {
            AddCollisionMapping(collidableType, collision, collisionCallback);
          }
        }

        // overload to add a callback to a collision type for multiple collidable types
        protected void AddCollisionMapping(CollidableType[] collidableTypes, Collision[] collisions, Action<CollidableEntity> collisionCallback)
        {
          foreach (var collidableType in collidableTypes)
          {
            AddCollisionMapping(collidableType, collisions, collisionCallback);
          }
        }

        // overload to add a callback to multiple collision types for a given collidable type
        protected void AddCollisionMapping(CollidableType collidableType, Collision[] collisions, Action<CollidableEntity> collisionCallback)
        {
          foreach (var collision in collisions)
          {
            AddCollisionMapping(collidableType, collision, collisionCallback);
          }
        }

        // overload to add a callback to all collisions for multiple collidable types
        protected void AddCollisionMapping(CollidableType[] collidableTypes, Action<CollidableEntity> collisionCallback)
        {
            foreach (var collidableType in collidableTypes)
            {
                AddCollisionMapping(collidableType, collisionCallback);
            }
        }

        // overload to add a callback to every collision type for a given collidable type
        protected void AddCollisionMapping(CollidableType collidableType, Action<CollidableEntity> collisionCallback)
        {
          AddCollisionMapping(collidableType, Collision.Top, collisionCallback);
          AddCollisionMapping(collidableType, Collision.Right, collisionCallback);
          AddCollisionMapping(collidableType, Collision.Bottom, collisionCallback);
          AddCollisionMapping(collidableType, Collision.Left, collisionCallback);
        }

        // Get the bounding box for the entity
        public Collider.BoundingBox GetBoundingBox()
        {
            return new Collider.BoundingBox(MotionObj, GetSprite().GetWidth(), GetSprite().GetHeight(), _boundScale);
        }

        public void AllignWith(CollidableEntity other, Collision axis)
        {
            switch (axis)
            {
                case Collision.Top:
                    PositionY -= (this.GetBoundingBox().MinY - other.GetBoundingBox().MaxY);
                    break;
                case Collision.Right:
                    PositionX += (other.GetBoundingBox().MinX - this.GetBoundingBox().MaxX);
                    break;
                case Collision.Bottom:
                    PositionY += (other.GetBoundingBox().MinY - this.GetBoundingBox().MaxY);
                    break;
                case Collision.Left:
                    PositionX -= (this.GetBoundingBox().MinX - other.GetBoundingBox().MaxX);
                    break;
            }
        }

        private void _setBBColor()
        {
            Color color;
            switch (GetCollidableType())
            {
                case CollidableType.Mario:
                case CollidableType.HeavyMario:
                    color = Color.Yellow;
                    break;
                case CollidableType.Enemy:
                    color = Color.Red;
                    break;
                case CollidableType.Block:
                    color = Color.Blue;
                    break;
                default:
                    color = Color.Green;
                    break;
            }
            _bbTexture.SetData(new Color[] {color * 0.25f});
        }

        public override void Draw(bool drawBB)
        {
            if (--_isColliding == 0)
            {
                _setBBColor();
            }
            if (Visible)
            {
                if (drawBB)
                {
                    GetBoundingBox().Draw(SpriteBatch, _bbTexture);
                }
                base.Draw();
            }
        }

        public void Dispose()
        {
            _bbTexture.Dispose();
        }
    }
}
