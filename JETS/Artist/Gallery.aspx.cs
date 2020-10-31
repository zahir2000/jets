using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Artist
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
                artistGalleryListView.Sort("imageName", SortDirection.Ascending);
            }
            else if (ddlSorting.SelectedItem.Value == "nameZA")
            {
                artistGalleryListView.Sort("imageName", SortDirection.Descending);
            }
            else if (ddlSorting.SelectedItem.Value == "priceHL")
            {
                artistGalleryListView.Sort("imagePrice", SortDirection.Ascending);
            }
            else if (ddlSorting.SelectedItem.Value == "priceLH")
            {
                artistGalleryListView.Sort("imagePrice", SortDirection.Descending);
            }
            else if (ddlSorting.SelectedItem.Value == "dateON")
            {
                artistGalleryListView.Sort("imageDateUploaded", SortDirection.Ascending);
            }
            else if (ddlSorting.SelectedItem.Value == "dateNO")
            {
                artistGalleryListView.Sort("imageDateUploaded", SortDirection.Descending);
            }
            else
            {
                artistGalleryListView.Sort("imageDateUploaded", SortDirection.Descending);
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

        protected void artistGalleryListView_DataBound(object sender, EventArgs e)
        {
            if (artistGalleryListView.Items.Count == 0)
            {
                divSort.Style.Add("display", "none");
                artistPager.Style.Add("display", "none");
                artistHeader.Style.Add("display", "none");
            }
        }
    }
}