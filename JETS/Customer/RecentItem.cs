using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JETS.Customer
{
    public class RecentItem
    {

        public int imageID { get; set; }
        public string imageName { get; set; }
        public string imageLocation { get; set; }
        public double unitPrice { get; set; }
        public DateTime LastVisited { get; set; }

        public RecentItem()
        {

        }

        public RecentItem(int imageID, string imageName, string imageLocation, double unitPrice)
        {
            this.imageID = imageID;
            this.imageName = imageName;
            this.imageLocation = imageLocation;
            this.unitPrice = unitPrice;
            this.LastVisited = DateTime.Now;
        }

    }
}