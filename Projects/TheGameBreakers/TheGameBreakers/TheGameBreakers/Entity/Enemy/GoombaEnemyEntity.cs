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
    class GoombaEnemyEntity : EnemyEntity
    {
        public GoombaEnemyEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            var factory = new GoombaSpriteFactory();
            var stateMachine = (EnemyStateMachine) StateMachine;
            factory.LoadTextures(content);
            AddSpriteMapping(stateMachine.LeftFacingAliveState, factory.CreateGoombaSprite());
            AddSpriteMapping(stateMachine.RightFacingAliveState, factory.CreateGoombaSprite());
            AddSpriteMapping(stateMachine.DeadState, factory.CreateDeadGoombaSpirte());
        }

        public override BaseEntity Clone()
        {
            return (BaseEntity) new GoombaEnemyEntity(this.Content, this.SpriteBatch, this.PositionX, this.PositionY);
        }
    }
}
