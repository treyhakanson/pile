using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Media;

namespace TheGameBreakers.Sound
{
    class SoundFactory
    {
        private readonly ContentManager _content;

        public SoundFactory(ContentManager content)
        {
            _content = content;
        }

        private NamedSoundEffect _createNamedSoundEffect(string name)
        {
            var sfx = _content.Load<SoundEffect>(name);
            var sound = new NamedSoundEffect(name, sfx.CreateInstance());
            return sound;
        }

        public Song CreateMainSong()
        {
            return _content.Load<Song>("Sounds/smb_song");
        }

        public NamedSoundEffect CreateMarioJumpSound()
        {
            return _createNamedSoundEffect("Sounds/smb_jumpsmall");
        }

        public NamedSoundEffect CreateHeavyMarioJumpSound()
        {
            return _createNamedSoundEffect("Sounds/smb_jump-super");
        }

        public NamedSoundEffect CreateMarioStompSound()
        {
            return _createNamedSoundEffect("Sounds/smb_stomp");
        }

        public NamedSoundEffect CreateMarioDeathSound()
        {
            return _createNamedSoundEffect("Sounds/smb_mariodie");
        }

        public NamedSoundEffect CreateCoinCollectionSound()
        {
            return _createNamedSoundEffect("Sounds/smb_coin");
        }

        public NamedSoundEffect CreatePowerUpAppearsSound()
        {
            return _createNamedSoundEffect("Sounds/smb_powerup_appears");
        }

        public NamedSoundEffect CreatePowerUpCollectionSound()
        {
            return _createNamedSoundEffect("Sounds/smb_powerup");
        }

        public NamedSoundEffect CreateOneUpCollectionSound()
        {
            return _createNamedSoundEffect("Sounds/smb_1-up");
        }

        public NamedSoundEffect CreateBrickBumpSound()
        {
            return _createNamedSoundEffect("Sounds/smb_bump");
        }

        public NamedSoundEffect CreateBrickBreakSound()
        {
            return _createNamedSoundEffect("Sounds/smb_breakblock");
        }

        public NamedSoundEffect CreateWarpSound()
        {
            return _createNamedSoundEffect("Sounds/smb_pipe");
        }

        public NamedSoundEffect CreateTimeWarningSound()
        {
            return _createNamedSoundEffect("Sounds/smb_warning");
        }

        public NamedSoundEffect CreateGameOverSound()
        {
            return _createNamedSoundEffect("Sounds/smb_gameover");
        }
    }
}
