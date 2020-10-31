using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class Gallery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ddlSorting_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSorting.SelectedItem.Value == "nameAZ")
            {
                imageListView.Sort("imageName", SortDirection.Ascending);
            }
            else if (ddlSorting.SelectedItem.Value == "nameZA")
            {
                imageListView.Sort("imageName", SortDirection.Descending);
            }
            else if (ddlSorting.SelectedItem.Value == "priceHL")
            {
                imageListView.Sort("imagePrice", SortDirection.Ascending);
            }
            else if (ddlSorting.SelectedItem.Value == "priceLH")
            {
                imageListView.Sort("imagePrice", SortDirection.Descending);
            }
            else if (ddlSorting.SelectedItem.Value == "dateON")
            {
                imageListView.Sort("imageDateUploaded", SortDirection.Ascending);
            }
            else if (ddlSorting.SelectedItem.Value == "dateNO")
            {
                imageListView.Sort("imageDateUploaded", SortDirection.Descending);
            }
            else
            {
                imageListView.Sort("imageDateUploaded", SortDirection.Descending);
            }
        }

        protected void ddlShow_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlShow.SelectedItem.Value == "show25")
            {
                Pager.PageSize = 25;
            }
            else if (ddlShow.SelectedItem.Value == "show35")
            {
                Pager.PageSize = 35;
            }
            else if (ddlShow.SelectedItem.Value == "show50")
            {
                Pager.PageSize = 50;
            }
            else
            {
                Pager.PageSize = 20;
            }
        }
    }
}