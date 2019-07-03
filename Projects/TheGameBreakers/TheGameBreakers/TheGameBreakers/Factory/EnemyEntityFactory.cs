using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Entity.Enemy;
using TheGameBreakers.Entity;

namespace TheGameBreakers.Factory
{
    class EnemyEntityFactory
    {
        private readonly ContentManager _content;
        private readonly SpriteBatch _spriteBatch;
        private readonly List<CollidableEntity> _entities;
        private readonly MarioEntity _marioEntity;

        public EnemyEntityFactory(ContentManager content, SpriteBatch spriteBatch, List<CollidableEntity> entities, MarioEntity marioEntity)
        {
            _content = content;
            _spriteBatch = spriteBatch;
            _entities = entities;
            _marioEntity = marioEntity;
        }

        public GoombaEnemyEntity CreateGoombaEnemyEntity(int positionX, int positionY)
        {
            return new GoombaEnemyEntity(_content, _spriteBatch, positionX, positionY);
        }

        public RedKoopaEnemyEntity CreateRedKoopaEnemyEntity(int positionX, int positionY)
        {
            return new RedKoopaEnemyEntity(_content, _spriteBatch, positionX, positionY);
        }

        public GreenKoopaEnemyEntity CreateGreenKoopaEnemyEntity(int positionX, int positionY)
        {
            return new GreenKoopaEnemyEntity(_content, _spriteBatch, positionX, positionY);
        }

        public PirhanaEnemyEntity CreatePirhanaEnemyEntity(int positionX, int positionY)
        {
            return new PirhanaEnemyEntity(_content, _spriteBatch, positionX, positionY);
        }

        public BooEnemyEntity CreateBooEnemyEntity(int positionX, int positionY)
        {
            return new BooEnemyEntity(_content, _spriteBatch, positionX, positionY, _marioEntity);
        }

        public BulletBillEnemyEntity CreateBulletBillEnemyEntity(int positionX, int positionY)
        {
            return new BulletBillEnemyEntity(_content, _spriteBatch, positionX, positionY);
        }

        public RexEnemyEntity CreateRexEnemyEntity(int positionX, int positionY)
        {
            return new RexEnemyEntity(_content, _spriteBatch, positionX, positionY);
        }
    }
}
