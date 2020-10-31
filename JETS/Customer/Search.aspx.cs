using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (!String.IsNullOrEmpty(Request.QueryString["id"].ToString()))
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "", "searchTerm('" + Request.QueryString["id"].ToString() + "')", true);
                        lblSearchTerm.Text = Request.QueryString["id"].ToString();
                        lblSearchTerm1.Text = Request.QueryString["id"].ToString();
                    }
                    else
                    {
                        Response.Redirect("Gallery.aspx");
                    }
                }
                catch(Exception ex)
                {
                    Response.Redirect("Gallery.aspx");
                }
            }
        }

        protected void imageListView_DataBound(object sender, EventArgs e)
        {
            int totalNum = imageListView.Items.Count;

            if (totalNum == 0)
            {
                EmptySearch.Style.Remove("display");
            }
            else
            {
                SearchResult.Style.Remove("display");
            }
        }
    }
}