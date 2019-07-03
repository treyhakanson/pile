using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Audio;

namespace TheGameBreakers.Sound
{
    class NamedSoundEffect
    {
        public string Name { get; private set; }
        public SoundEffectInstance Sfx { get; private set; }
        public bool Stopped => Sfx.State == SoundState.Stopped;

        public NamedSoundEffect(string name, SoundEffectInstance sfx)
        {
            Name = name;
            Sfx = sfx;
        }

        public void Play()
        {
            Sfx.Play();
        }
    }
}
