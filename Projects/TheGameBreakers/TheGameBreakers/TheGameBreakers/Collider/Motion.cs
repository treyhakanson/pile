using System;
using System.Collections.Generic;

namespace TheGameBreakers.Collider
{
    class Motion
    {
        public int PositionX { get; set; }
        public int PositionY { get; set; }
        public float VelocityX { get; set; }
        public float VelocityY { get; set; }
        public float AccelerationX { get; set; }
        public float AccelerationY { get; set; }
        public float MaxVelocityX { get; set; }
        public float MaxVelocityY { get; set; }

        public Motion(int positionX=0, int positionY=0, float velocityX=0, float velocityY=0, float accelerationX=0, float accelerationY=0, float maxVelocityX=10, float maxVelocityY=20)
        {
        	PositionX = positionX;
            PositionY = positionY;
            VelocityX = velocityX;
            VelocityY = velocityY;
            AccelerationX = accelerationX;
            AccelerationY = accelerationY;
            MaxVelocityX = maxVelocityX;
            MaxVelocityY = maxVelocityY;
        }

        public void Update() 
        {
            PositionX += (int) VelocityX;
            PositionY += (int) VelocityY;
            VelocityX += AccelerationX;
            VelocityY += AccelerationY;
            if (Math.Abs(VelocityX) > MaxVelocityX) VelocityX = MaxVelocityX * (VelocityX > 0 ? 1: -1);
            if (Math.Abs(VelocityY) > MaxVelocityY) VelocityY = MaxVelocityY * (VelocityY > 0 ? 1: -1);
        }
    }
}
