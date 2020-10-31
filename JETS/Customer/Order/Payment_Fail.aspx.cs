using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer.Order
{
    public partial class Payment_Fail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Convert.ToInt32(Request.QueryString["order"]) == (int)Session["orderNo"])
            {
                Session.Remove("myCart");
                Session.Remove("orderNo");
            }
        }
    }
}