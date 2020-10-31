using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JETS.Customer
{
    public class CartItem
    {
        public int imageID { get; set; }
        public string imageName { get; set; }
        public string imageLocation { get; set; }
        public int qty { get; set; }
        public double unitPrice { get; set; }

        public CartItem()
        {

        }

        public CartItem(int imageID, string imageName, string imageLocation, int qty, double unitPrice)
        {
            this.imageID = imageID;
            this.imageName = imageName;
            this.imageLocation = imageLocation;
            this.qty = qty;
            this.unitPrice = unitPrice;
        }
    }
}