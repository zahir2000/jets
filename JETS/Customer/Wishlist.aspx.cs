using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class Wishlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btnDelete = (LinkButton)sender;

            string sql = "DELETE FROM Wishlist WHERE custID = @custID AND imageID = @imageID";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter custID = new SqlParameter("@custID", Session["customerID"]);
                    SqlParameter imageID = new SqlParameter("@imageID", btnDelete.CommandArgument);

                    cmd.Parameters.Add(custID);
                    cmd.Parameters.Add(imageID);

                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {

                }
                finally
                {
                    con.Close();
                    Response.Redirect(Request.RawUrl);
                }
            }
        }

        protected void wishListView_DataBound(object sender, EventArgs e)
        {
            if (wishListView.Items.Count == 0)
            {
                wishlistHeader.Style.Add("display", "none");
                wishlistPagerDiv.Style.Add("display", "none");
            }
        }
    }
}