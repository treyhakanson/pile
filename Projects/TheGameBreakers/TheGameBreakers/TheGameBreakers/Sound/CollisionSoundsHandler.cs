using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Collider;
using TheGameBreakers.Entity;

namespace TheGameBreakers.Sound
{
    class CollisionSoundsHandler : ICollisionHandler
    {
        private readonly Dictionary<
            // The key is the instigator's type, the target's type, and the collision's direction
            Tuple<CollidableType, CollidableType, Collision>,
            // The sound to play for the corresponding collision
            NamedSoundEffect
        > _soundMapping;

        private readonly AudioPlayer _player;


        public CollisionSoundsHandler(AudioPlayer player)
        {
            _soundMapping = new Dictionary<Tuple<CollidableType, CollidableType, Collision>, NamedSoundEffect>();
            _player = player;
        }

        public void AddSoundMapping(
            CollidableType instigator,
            CollidableType target,
            Collision direction,
            NamedSoundEffect sound
        )
        {
            var key = Tuple.Create(instigator, target, direction);
            _soundMapping[key] = sound;
        }

        public void AddSoundMapping(
            CollidableType instigator,
            CollidableType target,
            NamedSoundEffect sound)
        {
            var directions = new[] { Collision.Top, Collision.Right, Collision.Bottom, Collision.Left };
            foreach (var direction in directions)
            {
                AddSoundMapping(instigator, target, direction, sound);
            }
        }

        public void HandleCollision(CollidableEntity e1, CollidableEntity e2, Collision d)
        {
            var key = Tuple.Create(e1.GetCollidableType(), e2.GetCollidableType(), d);
            if (_soundMapping.TryGetValue(key, out var sound))
            {
                _player.PlaySoundIfNotPlaying(sound);
            }
        }
    }
}
