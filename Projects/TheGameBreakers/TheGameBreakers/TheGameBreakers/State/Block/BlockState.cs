using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.State.Block
{
    abstract class BlockState
    {
        protected BlockStateMachine StateMachine;
        public TimeSpan SettleTime { get; set; }
        public bool IsBumpState { get; set; }

        protected BlockState(BlockStateMachine stateMachine)
        {
            StateMachine = stateMachine;
            SettleTime = TimeSpan.Zero;
        }

        public virtual void Bump()
        {
            // Do nothing
        }

        public virtual void HeavyBump()
        {
            // Invoke `Bump` by default, since most blocks behavior does not
            // change for a heavy bump
            this.Bump();
        }

        public virtual void Settle()
        {
            // Do nothing
        }

        public override bool Equals(object obj)
        {
            return this.GetHashCode() == obj.GetHashCode();
        }
    }
}
