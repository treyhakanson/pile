using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity;

namespace TheGameBreakers.Collider
{
    interface ICollisionHandler
    {
        void HandleCollision(CollidableEntity e1, CollidableEntity e2, Collision d);
    }
}
