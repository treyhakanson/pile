using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Factory;
using TheGameBreakers.State.Enemy;

namespace TheGameBreakers.Entity.Enemy
{
    class RedKoopaEnemyEntity : EnemyEntity
    {
        public RedKoopaEnemyEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var factory = new KoopaSpriteFactory();
            var stateMachine = (EnemyStateMachine)StateMachine;
            factory.LoadTextures(content);
            AddSpriteMapping(stateMachine.LeftFacingAliveState, factory.CreateLeftWalkingRedKoopa());
            AddSpriteMapping(stateMachine.RightFacingAliveState, factory.CreateRightWalkingRedKoopa());
            AddSpriteMapping(stateMachine.DeadState, factory.CreateDeadRedKoopa()); // TODO: dead koopa sprite?
        }

        public override BaseEntity Clone()
        {
            return (BaseEntity) new RedKoopaEnemyEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);
        }
    }
}
