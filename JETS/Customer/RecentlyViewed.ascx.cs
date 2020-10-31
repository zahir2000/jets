using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class RecentlyViewed : System.Web.UI.UserControl
    {
        RecentData myRecent;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["myRecent"] == null)
            {
                myRecent = new RecentData();
                Session["myRecent"] = myRecent;
            }
            myRecent = (RecentData)Session["myRecent"];

            if(myRecent.Items.Count == 0)
            {
                recent.Style.Add("display", "none");
            }
            else
            {
                imageListView.DataSource = myRecent.Items;
                imageListView.DataBind();
            }
        }
    }
}