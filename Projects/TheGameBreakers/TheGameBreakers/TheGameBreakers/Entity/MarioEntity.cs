using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Collider;
using TheGameBreakers.Factory;
using TheGameBreakers.Sound;
using TheGameBreakers.Sprites;
using TheGameBreakers.State.Mario;
using TheGameBreakers.State.Mario.Action;
using TheGameBreakers.State.Mario.PowerUp;
using TheGameBreakers.Entity.Enemy;

namespace TheGameBreakers.Entity
{
    enum HealthState
    {
        Dead = 0,
        Normal = 50,
        Super = 100,
        Fire = 150,
    }

    class MarioEntity : CollidableEntity
    {
        // State machines
        public MarioActionStateMachine ActionStateMachine { get; private set; }
        public MarioPowerUpStateMachine PowerUpStateMachine { get; private set; }
        private AudioPlayer _audioPlayer;
        private SoundFactory _soundFactory;

        // Whether or not mario is in a super state
        public bool IsSuper => PowerUpStateMachine.IsSuper;

        // Sprites mappings for action/power-up states
        private readonly Dictionary<MarioActionState, Dictionary<MarioPowerUpState, Sprite>> _spriteMappings;

        // Health bar 
        public int Health { get; private set;  }
        private DateTime _lastDamage;

        public MarioEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY, AudioPlayer audioPlayer, SoundFactory soundFactory) : base(content, spriteBatch, positionX, positionY)
        {
            // Audio
            _audioPlayer = audioPlayer;
            _soundFactory = soundFactory;

            // Gravity
            AccelerationY = 1f;

            // Bounding box
            _boundScale = 0.8f;

            // Health 
            Health = (int) HealthState.Normal;
            _lastDamage = DateTime.Now;

            // Initialize states
            ActionStateMachine = new MarioActionStateMachine();
            PowerUpStateMachine = new MarioPowerUpStateMachine();

            // Initialize sprite factory
            var spriteFactory = new MarioSpriteFactory();
            spriteFactory.LoadTextures(content);

            // Initialize sprite mappings
            _spriteMappings = new Dictionary<MarioActionState, Dictionary<MarioPowerUpState, Sprite>>
            {
               // Idle mappings
               [ActionStateMachine.IdleRightState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateRightFacingStationaryMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateRightFacingStationarySuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateRightFacingStationaryFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },
               [ActionStateMachine.IdleLeftState] = new Dictionary<MarioPowerUpState, Sprite> {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateLeftFacingStationaryMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateLeftFacingStationarySuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateLeftFacingStationaryFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },

               // Running mappings
               [ActionStateMachine.RunRightState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateRightFacingWalkingMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateRightFacingWalkingSuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateRightFacingWalkingFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },
               [ActionStateMachine.RunLeftState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateLeftFacingWalkingMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateLeftFacingWalkingSuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateLeftFacingWalkingFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },

               // Jumping mappings
               [ActionStateMachine.JumpRightState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateRightFacingJumpingMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateRightFacingJumpingSuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateRightFacingJumpingFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },
               [ActionStateMachine.JumpLeftState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateLeftFacingJumpingMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateLeftFacingJumpingSuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateLeftFacingJumpingFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },

               // Falling mappings 
               [ActionStateMachine.FallRightState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateRightFacingJumpingMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateRightFacingJumpingSuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateRightFacingJumpingFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },
               [ActionStateMachine.FallLeftState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateLeftFacingJumpingMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateLeftFacingJumpingSuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateLeftFacingJumpingFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },

               // Crouching mappings
               [ActionStateMachine.CrouchRightState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateRightFacingCrouchingMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateRightFacingCrouchingSuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateRightFacingCrouchingFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },
               [ActionStateMachine.CrouchLeftState] = new Dictionary<MarioPowerUpState, Sprite>
               {
                  [PowerUpStateMachine.NormalState] = spriteFactory.CreateLeftFacingCrouchingMario(),
                  [PowerUpStateMachine.SuperState] = spriteFactory.CreateLeftFacingCrouchingSuperMario(),
                  [PowerUpStateMachine.FireState] = spriteFactory.CreateLeftFacingCrouchingFireMario(),
                  [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
               },

                // Dead mappings
                [ActionStateMachine.DeadState] = new Dictionary<MarioPowerUpState, Sprite>
                {
                    [PowerUpStateMachine.DeadState] = spriteFactory.CreateDyingMario()
                }
            };

            // Initialize collision mappings
            // Enemy mappings
            AddCollisionMapping(CollidableType.Enemy, new [] {Collision.Top, Collision.Right, Collision.Left}, (CollidableEntity entity) => {
                TakeDamage(((EnemyEntity)entity).DamageMultiplier);
            });
            AddCollisionMapping(CollidableType.Enemy, Collision.Bottom, (CollidableEntity entity) => Jump());

            // Item mappings
            AddCollisionMapping(CollidableType.SuperItem, (CollidableEntity entity) => ConsumeSuperItem());
            AddCollisionMapping(CollidableType.FireItem, (CollidableEntity entity) => ConsumeFireItem());

            // Block mappings
            AddCollisionMapping(new [] {CollidableType.Block, CollidableType.BreakableBlock}, new [] {Collision.Left, Collision.Right}, (CollidableEntity entity) => SideBump());
            AddCollisionMapping(new [] {CollidableType.Block, CollidableType.BreakableBlock}, Collision.Bottom, (CollidableEntity entity) => Land());
            AddCollisionMapping(new [] {CollidableType.Block, CollidableType.BreakableBlock}, Collision.Top, (CollidableEntity entity) => Fall());
        }

        public override BaseEntity Clone()
        {
            return (BaseEntity) new MarioEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY, _audioPlayer, _soundFactory);
        }

        public void TakeDamage(float multiplier = 1f)
        {
            DateTime now = DateTime.Now;
            if (_lastDamage == null || (now - _lastDamage).TotalMilliseconds > 200)
            {
               Health -= (int)(25 * multiplier);
              _lastDamage = now;
              if (Health <= (int)HealthState.Dead) 
              {
                PowerUpStateMachine.SetState(PowerUpStateMachine.DeadState);
                Die();
              } 
              else if (Health <= (int)HealthState.Normal)
              {
                PowerUpStateMachine.SetState(PowerUpStateMachine.NormalState);
              }
              else if (Health <= (int)HealthState.Super)
              {
                PowerUpStateMachine.SetState(PowerUpStateMachine.SuperState);
              }
              else 
              {
                PowerUpStateMachine.SetState(PowerUpStateMachine.FireState);
              }            
            }
        }

        public int MaxHealth()
        {
            return (int) HealthState.Fire;
        }

        // BaseEntity overrides
        protected override ISprite GetSprite()
        {
            return _spriteMappings[ActionStateMachine.State][PowerUpStateMachine.State];
        }

        // CollidableEntity overrides
        public override CollidableType GetCollidableType()
        {
            return IsSuper ? CollidableType.HeavyMario : CollidableType.Mario;
        }

        // Power-up state changes
        public void ConsumeFireItem()
        {
            Health = Health >= (int)HealthState.Super ? (int)HealthState.Fire : Math.Max(Health, (int)HealthState.Super);
            PowerUpStateMachine.CollideFlower();
        }

        public void ConsumeSuperItem()
        {
          Health = Math.Max(Health, (int)HealthState.Super);
          PowerUpStateMachine.CollideMushroom();
        }

        public void SendToNormal()
        {
            Collidable = true;
            AccelerationY = 1f;
            ActionStateMachine.SendToNormal();
            PowerUpStateMachine.SendToNormal();
            Health = (int)HealthState.Normal;
        }

        // Action state changes
        public void Crouch()
        {
            ActionStateMachine.Crouch(this);
        }

        public void Idle()
        {
            ActionStateMachine.Idle(this);
        }

        public void SideBump()
        {
            ActionStateMachine.SideBump(this);
        }

        public void Jump()
        {
            ActionStateMachine.Jump(this);
            NamedSoundEffect sound = IsSuper ? 
                _soundFactory.CreateHeavyMarioJumpSound() : 
                _soundFactory.CreateMarioJumpSound();
            _audioPlayer.PlaySoundIfNotPlaying(sound);
        }

        public void MoveLeft()
        {
            ActionStateMachine.MoveLeft(this);
        }

        public void MoveRight()
        {
            ActionStateMachine.MoveRight(this);
        }

        public void Die()
        {
            ActionStateMachine.Die(this);
            _audioPlayer.PlaySound(_soundFactory.CreateMarioDeathSound());
            Health = (int) HealthState.Dead; 
        }

        public void Land()
        {
            ActionStateMachine.Land(this);
        }

        public void Fall()
        {
            ActionStateMachine.Fall(this);
        }
    }
}
