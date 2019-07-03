using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TheGameBreakers.Scoring
{
    interface IScoreHandler
    {
        void ScoreChanged(int score);
    }
}
