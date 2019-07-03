using System;
using TheGameBreakers.State.Mario.PowerUp;

namespace TheGameBreakers.State.Mario
{
    class MarioPowerUpStateMachine
    {
        // Possible states
        public MarioPowerUpState NormalState { get; private set; }
        public MarioPowerUpState SuperState { get; private set; }
        public MarioPowerUpState FireState { get; private set; }
        public MarioPowerUpState InvincibleState { get; private set; }
        public MarioPowerUpState DeadState { get; private set; }

        // Current State
        public MarioPowerUpState State { get; private set; }

        // Helpers
        public bool IsSuper => State == SuperState || State == FireState || State == InvincibleState;

        public MarioPowerUpStateMachine()
        {
            // Initialize states
            NormalState = new MarioNormalState(this);
            SuperState = new MarioSuperState(this);
            FireState = new MarioFireState(this);
            InvincibleState = new MarioInvincibleState(this);
            DeadState = new MarioDeadState(this);

            // Set initial State to normal
            State = NormalState;
        }

        public void SetState(MarioPowerUpState state)
        {
            State = state;
        }

        public void SendToNormal()
        {
            SetState(NormalState);
        }

        public void CollideMushroom()
        {
            State.CollideMushroom();
        }

        public void CollideEnemy()
        {
            State.CollideEnemy();
        }

        public void CollideFlower()
        {
            State.CollideFlower();
        }
    }
}
