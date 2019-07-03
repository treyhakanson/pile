using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.Entity
{
    interface ISpawnerEntity
    {
        void InitializeSpawner(List<CollidableEntity> spawnLocation);
        void AddSpawnable(CollidableEntity spawnable);
    }
}
