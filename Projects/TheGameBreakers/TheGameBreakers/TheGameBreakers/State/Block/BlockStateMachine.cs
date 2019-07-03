using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.State.Mario;
using TheGameBreakers.State.Mario.PowerUp;

namespace TheGameBreakers.State.Block
{
    class BlockStateMachine
    {
        // Possible states
        public BlockState BrickBlockState { get; private set; }
        public BlockState BrickBlockBumpState { get; private set; }
        public BlockState BrickBlockBreakState { get; private set; }
        public BlockState HiddenBlockState { get; private set; }
        public BlockState QuestionBlockState { get; private set; }
        public BlockState UsedBlockState { get; private set; }
        public BlockState UsedBlockBumpState { get; private set; }
        public BlockState NullBlockState { get; private set; }

        // Current State
        public BlockState State { get; private set; }

        // Whether or not the block is in the process of transitioning
        public bool Transitioning { get; private set; }

        public BlockStateMachine()
        {
            BrickBlockState = new BrickBlockState(this);
            BrickBlockBumpState = new BrickBlockBumpState(this);
            BrickBlockBreakState = new BrickBlockBreakState(this);
            HiddenBlockState = new HiddenBlockState(this);
            QuestionBlockState = new QuestionBlockState(this);
            UsedBlockState = new UsedBlockState(this);
            UsedBlockBumpState = new UsedBlockBumpState(this);
            NullBlockState = new NullBlockState(this);
            Transitioning = false;
            State = BrickBlockState;
        }

        public void SetState(BlockState state)
        {
            // Don't attempt to change the state if in the process of transitioning
            if (Transitioning)
            {
                return;
            }

            // Update the state
            State = state;

            // If the block is undergoing a state with a settling time, lock
            // state changes and wait the settle time before unlocking and
            // settling
            if (State.SettleTime > TimeSpan.Zero)
            {
                Transitioning = true;
                Task.Delay(State.SettleTime).ContinueWith((task) =>
                {
                    Transitioning = false;
                    State.Settle();
                });
            }

            // Console.WriteLine("Current State:  " + State.GetType().ToString());
            // Console.WriteLine("");
        }

        public void Bump()
        {
           State.Bump();
        }

        public void HeavyBump()
        {
           State.HeavyBump();
        }

        public void Settle()
        {
           State.Settle();
        }

        public bool GetIsBumpState() {
            return State.IsBumpState;
        }
    }
}
