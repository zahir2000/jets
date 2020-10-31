using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JETS.Customer
{
    public class CartData
    {
        public List<CartItem> Items { get; set; }

        public CartData()
        {
            Items = new List<CartItem>();
        }

        private int ItemIndexOf(int imageID)
        {
            foreach (CartItem item in Items)
            {
                if (item.imageID == imageID)
                {
                    return Items.IndexOf(item);
                }
            }
            return -1;
        }

        public void Insert(CartItem item)
        {
            int index = ItemIndexOf(item.imageID);
            if (index == -1)
            {
                Items.Add(item);
            }
            else
            {
                Items[index].qty++;
            }
        }

        public void Delete(int rowID)
        {
            Items.RemoveAt(rowID);
        }

        public void Update(int rowID, int qty)
        {
            if (qty > 0)
            {
                Items[rowID].qty = qty;
            }
            else
            {
                Delete(rowID);
            }
        }

        public double GrandTotal
        {
            get
            {
                if (Items == null)
                {
                    return 0;
                }
                else
                {
                    double grandTotal = 0;
                    foreach (CartItem item in Items)
                    {
                        grandTotal += item.qty * item.unitPrice;
                    }
                    return grandTotal;
                }
            }
        }
    }
}