using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Media;
using TheGameBreakers.Collider;

namespace TheGameBreakers.Sound
{
    class AudioPlayer
    {
        // Currently playing sounds
        private int _soundId = 0;
        private readonly Dictionary<string, int> _playingSoundCounts;
        private readonly Dictionary<int, NamedSoundEffect> _playingSounds;
        private Song _song;
        public bool Muted { get; private set; } = false;

        public AudioPlayer()
        {
            _playingSoundCounts = new Dictionary<string, int>();
            _playingSounds = new Dictionary<int, NamedSoundEffect>();
            MediaPlayer.IsRepeating = true;
        }

        public void LoadSong(Song song)
        {
            _song = song;
            MediaPlayer.Play(_song);
        }

        public void Mute()
        {
            MediaPlayer.Pause();
        }

        public void UnMute()
        {
            MediaPlayer.Resume();
        }

        public void ToggleMuted()
        {
            Muted = !Muted;
            if (Muted)
            {
                Mute();
            }
            else
            {
                UnMute();
            }
        }

        // Will add sound to _playingSounds
        public void PlaySound(NamedSoundEffect namedSfx)
        {
            if (Muted)
            {
                return;
            }
            if (!_playingSoundCounts.ContainsKey(namedSfx.Name))
            {
                _playingSoundCounts[namedSfx.Name] = 0;
            }
            var id = _soundId;
            _playingSoundCounts[namedSfx.Name] += 1;
            _playingSounds[id] = namedSfx;
            _soundId += 1;
            namedSfx.Play();
        }

        // Will add sound IFF not already in _playingSounds
        public void PlaySoundIfNotPlaying(NamedSoundEffect namedSfx)
        {
            if (
                _playingSoundCounts.ContainsKey(namedSfx.Name) && 
                _playingSoundCounts[namedSfx.Name] > 0
            )
            {
                return;
            }
            PlaySound(namedSfx);
        }

        public void Update()
        {
            List<int> soundsToUpdate = new List<int>();
            foreach (var id in _playingSounds.Keys)
            {
                var sound = _playingSounds[id];
                if (!sound.Stopped)
                {
                    continue;
                }

                soundsToUpdate.Add(id);
            }

            foreach (var id in soundsToUpdate)
            {
                var sound = _playingSounds[id];
                if (--_playingSoundCounts[sound.Name] == 0)
                {
                    _playingSounds.Remove(id);
                }
            }
        }
    }
}
