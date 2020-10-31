using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JETS.Customer
{
    public class RecentData
    {
        public List<RecentItem> Items { get; set; }
        private int maxItems = 6;

        public RecentData()
        {
            Items = new List<RecentItem>();
        }

        private int ItemIndexOf(int imageID)
        {
            foreach (RecentItem item in Items)
            {
                if (item.imageID == imageID)
                {
                    return Items.IndexOf(item);
                }
            }
            return -1;
        }

        public void Insert(RecentItem item)
        {
            int index = ItemIndexOf(item.imageID);
            if (index == -1)
            {
                Items.Add(item);
            }

            while(Items.Count > maxItems)
            {
                Items.RemoveAt(0);
            }
        }
    }
}