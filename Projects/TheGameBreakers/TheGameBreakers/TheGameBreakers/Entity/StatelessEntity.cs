using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.State.Block;
using TheGameBreakers.State.Mario;
using TheGameBreakers.Factory;
using Microsoft.Xna.Framework.Graphics;
using TheGameBreakers.Sprites;
using Microsoft.Xna.Framework.Content;

namespace TheGameBreakers.Entity
{
    abstract class StatelessEntity : CollidableEntity
    {
        protected ISprite Sprite { get; set; }

        protected StatelessEntity(ContentManager content, SpriteBatch spriteBatch, int positionX, int positionY) : base(content, spriteBatch, positionX, positionY)
        {
            Sprite = new NullSprite();
        }

        // BaseEntity overrides
        protected override ISprite GetSprite() {
            return Sprite;
        }
    }
}
