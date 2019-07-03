using Microsoft.Xna.Framework;
using TheGameBreakers.Sound;

namespace TheGameBreakers.Scoring
{
    class GameTimer
    {
      public static double InitialTime = 80;
      public static double TimeWarning = 20;
      public double TimeRemaining {get; private set;} = InitialTime;
      public bool Paused { get; private set; } = false;

      private double _pausedTime = 0;
      private double _resumedTime = 0;
      private double _ignoredTime = 0;
      private bool _shouldPlayWarning = true;
      private readonly AudioPlayer _audioPlayer;
      private readonly SoundFactory _soundFactory;

      public GameTimer(AudioPlayer audioPlayer, SoundFactory soundFactory)
      {
          _audioPlayer = audioPlayer;
          _soundFactory = soundFactory;
      }

      public void Reset(GameTime gameTime)
      {
          _shouldPlayWarning = true;
          TimeRemaining = GameTimer.InitialTime;
      }

      public void Pause(GameTime gameTime)
      {
        Paused = true;
        _pausedTime = gameTime.ElapsedGameTime.TotalSeconds;
      }

      public void Resume(GameTime gameTime)
      {
        Paused = false;
        _resumedTime = gameTime.ElapsedGameTime.TotalSeconds;
      }

      public void Toggle(GameTime gameTime) {
        Paused = !Paused;
        if (Paused)
        {
          Pause(gameTime);
        }
        else
        {
          Resume(gameTime);
          _ignoredTime = _resumedTime - _pausedTime;
        }
      }

      public void Update(GameTime gameTime)
      {
          if (Paused)
          {
              return;
          }

          var elapsed = gameTime.ElapsedGameTime.TotalSeconds;

          TimeRemaining -= elapsed - _ignoredTime;

          if (TimeRemaining <= TimeWarning && _shouldPlayWarning)
          {
              _audioPlayer.PlaySound(_soundFactory.CreateTimeWarningSound());
              _shouldPlayWarning = false;
          }
      }
    }
}
