using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace XMLAsset
{
    [Serializable()]
    [XmlRoot("EntityAsset")]
    public class EntityAsset
    {
        public int EntityType;
        public int Row;
        public int Column;
        public int OffsetX;
        public int OffsetY;

        [XmlArray("EntityItems"), XmlArrayItem(typeof(ItemAsset), ElementName = "Item")]
        public List<ItemAsset> EntityItems;
        public PipeAsset Pipe;
    }
}
