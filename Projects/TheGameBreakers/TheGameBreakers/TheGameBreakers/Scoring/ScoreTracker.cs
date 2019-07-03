using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TheGameBreakers.Collider;
using TheGameBreakers.Entity;
using TheGameBreakers.Scoring;

namespace TheGameBreakers.Scoring
{
    public enum Counter
    {
        Score = 0,
        Coin,
        Life
    };

    class ScoreTracker : ICollisionHandler
    {
        public Dictionary<Counter, int> Scores { get; }
        private Dictionary<Counter, int> _initialScores;
        private Dictionary<Counter, List<IScoreHandler>> _scoreHandlers;
        private int _livesAwarded = 0;
        private readonly Dictionary<
                // The key is the instigator's type, the target's type, and the collision's direction
                Tuple<CollidableType, CollidableType, Collision>,
                // The value is the counter to apply the heuristic too, as well as the heuristic function
                Tuple<Counter, Func<CollidableEntity, CollidableEntity, Collision, int>>
            > _heuristics;

        public ScoreTracker(Dictionary<Counter, int> initialScores)
        {
            Scores = new Dictionary<Counter, int>();
            _scoreHandlers = new Dictionary<Counter, List<IScoreHandler>>();
            _initialScores = initialScores;
            _heuristics =
                new Dictionary<Tuple<CollidableType, CollidableType, Collision>,
                    Tuple<Counter, Func<CollidableEntity, CollidableEntity, Collision, int>>>();
            foreach (var counter in Enum.GetValues(typeof(Counter)).Cast<Counter>())
            {
                initialScores.TryGetValue(counter, out var value);
                Scores[counter] = value;
                _scoreHandlers[counter] = new List<IScoreHandler>();
            }
        }

        public void Reset()
        {
            _livesAwarded = 0;
            foreach (var counter in Enum.GetValues(typeof(Counter)).Cast<Counter>())
            {
                _initialScores.TryGetValue(counter, out var value);
                Scores[counter] = value;
            }
        }

        public void UpdateScore(Counter counter, int increment)
        {
            Scores[counter] += increment;
            if (counter != Counter.Coin || Scores[Counter.Coin] != 100 * _livesAwarded + 1)
            {
                return;
            }
            UpdateScore(Counter.Life, 1);
            _livesAwarded += 1;
        }

        //public void AddScoreHandler(Counter counter, IScoreHandler scoreHandler)
        //{
        //    _scoreHandlers[counter].Add(scoreHandler);
        //}

        public void AddScoreHeuristic(
            CollidableType instigator,
            CollidableType target,
            Collision direction,
            Counter counter,
            Func<CollidableEntity, CollidableEntity, Collision, int> scoreHeuristic
        )
        {
            var key = Tuple.Create(instigator, target, direction);
            var value = Tuple.Create(counter, scoreHeuristic);
            _heuristics[key] = value;
        }

        public void AddScoreHeuristic(
            CollidableType instigator,
            CollidableType target,
            Collision direction,
            Counter counter,
            int increment
        )
        {
            int ScoreHeuristic(CollidableEntity e1, CollidableEntity e2, Collision d) => increment;
            var key = Tuple.Create(instigator, target, direction);
            var value = Tuple.Create<
                Counter,
                Func<CollidableEntity, CollidableEntity, Collision, int>
            >(counter, ScoreHeuristic);
            _heuristics[key] = value;
        }

        public void AddScoreHeuristic(
            CollidableType instigator,
            CollidableType target,
            Counter counter,
            int increment)
        {
            var directions = new[] {Collision.Top, Collision.Right, Collision.Bottom, Collision.Left};
            foreach (var direction in directions)
            {
                AddScoreHeuristic(instigator, target, direction, counter, increment);
            }
        }

        public void HandleCollision(CollidableEntity e1, CollidableEntity e2, Collision d)
        {
            var key = Tuple.Create(e1.GetCollidableType(), e2.GetCollidableType(), d);
            if (!_heuristics.TryGetValue(key, out var heuristicData))
            {
                return;
            }
            var counter = heuristicData.Item1;
            var func = heuristicData.Item2;
            UpdateScore(counter, func(e1, e2, d));
        }
    }
}
