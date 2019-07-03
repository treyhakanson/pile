using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Entity.Enemy;

namespace TheGameBreakers.Entity
{
    class Spawner
    {
        private List<CollidableEntity> _spawnLocation;
        private readonly Queue<CollidableEntity> _spawnQueue;
        public int Count => _spawnQueue.Count;

        public Spawner()
        {
            _spawnQueue = new Queue<CollidableEntity>();
        }

        public Spawner(List<CollidableEntity> spawnables) : this()
        {
            foreach (var spawnable in spawnables)
            {
                QueueSpawnable(spawnable);
            }
        }

        public void RegisterSpawnLocation(List<CollidableEntity> spawnLocation)
        {
            _spawnLocation = spawnLocation;
        }

        public void QueueSpawnable(CollidableEntity spawnable)
        {
            _spawnQueue.Enqueue(spawnable);
        }

        public List<CollidableEntity> Spawn(int n = -1)
        {
            if (n < 0 || n > _spawnQueue.Count)
            {
                n = _spawnQueue.Count;
            }

            var spawned = new List<CollidableEntity>();
            while (n > 0)
            {
                var spawnable = _spawnQueue.Dequeue();
                _spawnLocation.Insert(3, spawnable); // TODO: need to not hardcode position (using 3 to place only above backgrounds and such)
                spawned.Add(spawnable);
                n--;
            }
            return spawned;
        }

        public CollidableEntity SpawnOne()
        {
            CollidableEntity e = Spawn(1)[0];
            if (e is EnemyEntity)
             {
                Task.Delay(5000).ContinueWith((task) =>
                {
                    QueueSpawnable((CollidableEntity) e.Clone());
                });
            }
            return e;
        }

        public List<CollidableEntity> SpawnAll()
        {
            return Spawn();
        }
    }
}
