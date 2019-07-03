using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;
using TheGameBreakers.Entity.Block;
using TheGameBreakers.Entity.Item;
using TheGameBreakers.Entity.Enemy;

namespace TheGameBreakers.Collider
{
    enum Collision
    {
        NoCollision = 0,
        Top,
        Right,
        Bottom,
        Left
    }

    class CollisionDetector
    {
        private readonly List<ICollisionHandler> _collisionHandlers;

        public static Collision GetOppositeCollision(Collision col)
        {
            switch (col)
            {
                case Collision.Top: return Collision.Bottom;
                case Collision.Right: return Collision.Left;
                case Collision.Bottom: return Collision.Top;
                case Collision.Left: return Collision.Right;
                default: return Collision.NoCollision;
            }
        }

        public CollisionDetector()
        {
            _collisionHandlers = new List<ICollisionHandler>();
        }

        private void _invokeCollisionHandlers(CollidableEntity e1, CollidableEntity e2, Collision d)
        {
            foreach (var collisionHandler in _collisionHandlers)
            {
                collisionHandler.HandleCollision(e1, e2, d);
                collisionHandler.HandleCollision(e2, e1, d);
            }
        }

        public void AddCollisionHandler(ICollisionHandler collisionHandler)
        {
            _collisionHandlers.Add(collisionHandler);
        }

        public void DetectCollisions(List<CollidableEntity> entities) {
            if (entities.Count < 2) { return; }
            int a, b;
            CollidableEntity e1, e2;
            BoundingBox bb1;
            Collision collision;
            for (a=0; a<entities.Count; a++) 
            {
                e1 = entities[a];
                bb1 = e1.GetBoundingBox();
                bool mobileE1 = e1.VelocityX != 0 || e1.VelocityY != 0;
                if (!e1.Collidable) continue;
                for (b=a+1; b<entities.Count; b++) 
                {
                    e2 = entities[b];
                    bool mobileE2 = e2.VelocityX != 0 || e2.VelocityY != 0;
                    if (!e2.Collidable || (!mobileE1 && !mobileE2)) continue;
                    
                    collision = bb1.Overlaps(e2.GetBoundingBox());
                    if (collision <= 0) continue;
                    e1.Collide(e2, collision);
                    e2.Collide(e1, GetOppositeCollision(collision));
                    _invokeCollisionHandlers(e1, e2, collision);
                    if ((e1 is ItemEntity && e2 is MarioEntity) || (e2 is ItemEntity && e1 is MarioEntity)) return;

                    // Stateless entities should interact first since other entities may change state 
                    if (e1 is StatelessEntity) {
                        e1.Collide(e2, collision);
                        e2.Collide(e1, GetOppositeCollision(collision));
                    } else {
                        e2.Collide(e1, GetOppositeCollision(collision));
                        e1.Collide(e2, collision);
                    }

                    // Invoke reistered collision handlers
                    _invokeCollisionHandlers(e1, e2, collision);

                    // Cases without allignment 
                    if ((e1 is ItemEntity && e2 is MarioEntity) || (e2 is ItemEntity && e1 is MarioEntity)) continue;
                    if ((e1 is PipeBlockEntity && e2 is MarioEntity) || (e2 is PipeBlockEntity && e1 is MarioEntity)) continue;
                    if (e1 is PirhanaEnemyEntity || e2 is PirhanaEnemyEntity) continue;
                    if ((e1 is BulletBillEnemyEntity && e2 is BlockEntity) || (e2 is BulletBillEnemyEntity && e1 is BlockEntity)) continue;
                    if ((e1 is BulletBillEnemyEntity && e2 is EnemyEntity) || (e2 is BulletBillEnemyEntity && e1 is EnemyEntity)) continue;
                    if ((e1 is BulletBillEnemyEntity && e2 is StatelessEntity) || (e2 is BulletBillEnemyEntity && e1 is StatelessEntity)) continue;
                    if ((e1 is FlagBlockEntity && e2 is MarioEntity) || (e2 is FlagBlockEntity && e1 is MarioEntity)) continue;
                    if (e1 is BooEnemyEntity || e2 is BooEnemyEntity) continue;

                    // Cases with allignment 
                    if (e1 is MarioEntity || e1 is EnemyEntity || e1 is ItemEntity) e1.AllignWith(e2, collision);
                    else e2.AllignWith(e1, GetOppositeCollision(collision));
                    if ((e1 is BulletBillEnemyEntity && e2 is MarioEntity) || (e2 is BulletBillEnemyEntity && e1 is MarioEntity)) e1.AllignWith(e2, collision);
                    else e2.AllignWith(e1, GetOppositeCollision(collision));
                }
            }
        }
    }
}
