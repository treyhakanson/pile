using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace XMLAsset
{
    [Serializable()]
    [XmlRoot("LevelAsset")]
    public class LevelAsset
    {
        public int Height;
        public int Width;

        [XmlArray("Entities"), XmlArrayItem(typeof(EntityAsset), ElementName = "Item")]
        public List<EntityAsset> Entities;
    }
}
