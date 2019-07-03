using System;
using TheGameBreakers.Entity;
using TheGameBreakers.State.Mario.Action;

namespace TheGameBreakers.State.Mario
{
    class MarioActionStateMachine
    {
        // Possible states
        public MarioActionState IdleRightState { get; private set; }
        public MarioActionState IdleLeftState { get; private set; }
        public MarioActionState RunRightState { get; private set; }
        public MarioActionState RunLeftState { get; private set; }
        public MarioActionState JumpRightState { get; private set; }
        public MarioActionState JumpLeftState { get; private set; }
        public MarioActionState FallRightState { get; private set; }
        public MarioActionState FallLeftState { get; private set; }
        public MarioActionState CrouchRightState { get; private set; }
        public MarioActionState CrouchLeftState { get; private set; }
        public MarioActionState DeadState { get; private set; }
        
        // Current State
        public MarioActionState State { get; private set; }

    public MarioActionStateMachine()
        {
            // Initialize states
            IdleRightState = new MarioIdleRightState(this);
            IdleLeftState = new MarioIdleLeftState(this);
            RunRightState = new MarioRunRightState(this);
            RunLeftState = new MarioRunLeftState(this);
            JumpRightState = new MarioJumpRightState(this);
            JumpLeftState = new MarioJumpLeftState(this);
            FallRightState = new MarioFallRightState(this);
            FallLeftState = new MarioFallLeftState(this);
            CrouchRightState = new MarioCrouchRightState(this);
            CrouchLeftState = new MarioCrouchLeftState(this);
            DeadState = new MarioDeadState(this);

            // Set initial states
            State = IdleRightState;
        }

        public void SetState(MarioActionState nextState)
        {
            State = nextState;
        }

        public void SendToNormal()
        {
            SetState(IdleRightState);
        }

        public void Idle(BaseEntity entity)
        {
            State.Idle(entity);
        }

        public void SideBump(BaseEntity entity)
        {
            State.SideBump(entity); 
        }

        public void MoveLeft(BaseEntity entity)
        {
            State.MoveLeft(entity);
        }

        public void MoveRight(BaseEntity entity)
        {
            State.MoveRight(entity);
        }

        public void Jump(BaseEntity entity)
        {
            State.Jump(entity);
        }

        public void Crouch(BaseEntity entity)
        {
            State.Crouch(entity);
        }

        public void Die(BaseEntity entity)
        {
            State.Die(entity);
        }

        public void Land(BaseEntity entity)
        {
            State.Land(entity);
        }

        public void Fall(BaseEntity entity)
        {
            State.Fall(entity);
        }
    }
}
