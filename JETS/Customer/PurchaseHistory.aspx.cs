using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class PurchaseHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ordersListView_DataBound(object sender, EventArgs e)
        {
            if (ordersListView.Items.Count == 0)
            {
                orderHeader.Style.Add("display", "none");
                orderPagerDiv.Style.Add("display", "none");
            }
        }
    }
}