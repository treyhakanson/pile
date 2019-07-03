using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace XMLAsset
{
    [Serializable()]
    [XmlRoot("PipeAsset")]
    public class PipeAsset
    {
        public int WarpId = -1;
        public int WarpDest = -1;
    }
}
