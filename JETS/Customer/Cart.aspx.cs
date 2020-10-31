using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class Cart : System.Web.UI.Page
    {
        CartData myCart;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["myCart"] == null)
            {
                Session["myCart"] = new CartData();
            }

            myCart = (CartData)Session["myCart"];

            if (!IsPostBack)
            {
                myCart = (CartData)Session["myCart"];
                        FillData();
            }
        }

        private void FillData()
        {
            if (myCart.Items.Count != 0)
            {
                headerText.Style.Add("display", "block");
                cartButtons.Style.Remove("display");
                emptyCart.Style.Add("display", "none");
                CheckoutPanel.Style.Remove("display");
            }

            gvCart.DataSource = myCart.Items;
            gvCart.DataBind();
        }

        protected void gvCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            myCart.Delete(e.RowIndex);
            FillData();
            Response.Redirect(Request.RawUrl);
        }

        protected void gvCart_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            TextBox txtQty = (TextBox)gvCart.Rows[e.RowIndex].Cells[3].Controls[0];
            GridViewRow row = gvCart.Rows[e.RowIndex];

            int imageID = Convert.ToInt32(row.Cells[2].Text);

            if (Regex.IsMatch(txtQty.Text, @"^\d{1,2}$"))
            {
                int qty = Convert.ToInt32(txtQty.Text);
                if(qty <= CheckStock(imageID, Helper.sqlCon))
                {
                    myCart.Update(e.RowIndex, qty);
                    gvCart.EditIndex = -1;
                    FillData();

                    if (qty == 0)
                    {
                        status.InnerHtml = "Item Removed";
                    }
                    else
                    {
                        status.InnerHtml = "Quantity updated";
                    }

                    status.Style.Remove("display");
                    status.Attributes["class"] = "text-center success-message jets-box";
                }
                else
                {
                    status.Style.Remove("display");
                    status.InnerHtml = "Please enter within quantity range. Stock: <b>" + CheckStock(imageID, Helper.sqlCon).ToString() + "</b>";
                    status.Attributes["class"] = "text-center incorrect-message jets-box";

                    gvCart.EditIndex = -1;
                    FillData();
                }
            }
            else
            {
                status.Style.Remove("display");
                status.InnerHtml = "Please enter digit only. Ensure the range entered is below 100";
                status.Attributes["class"] = "text-center incorrect-message jets-box";

                gvCart.EditIndex = -1;
                FillData();
            }
        }

        protected void gvCart_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCart.EditIndex = -1;
            FillData();
        }

        protected void gvCart_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCart.EditIndex = e.NewEditIndex;
            FillData();
        }

        protected void gvCart_PreRender(object sender, EventArgs e)
        {
            GridView gv = (GridView)sender;

            if ((gv.ShowHeader == true && gv.Rows.Count > 0)
            || (gv.ShowHeaderWhenEmpty == true))
            {
                gv.HeaderRow.TableSection = TableRowSection.TableHeader;
                gv.HeaderRow.CssClass = "thead-dark";
            }
            if (gv.ShowFooter == true && gv.Rows.Count > 0)
            {
                gv.FooterRow.TableSection = TableRowSection.TableFooter;
            }
        }

        protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotalPrice = (Label)e.Row.FindControl("lblGrandTotal");

                lblTotalPrice.Text = string.Format(Helper.my, "{0:C}", myCart.GrandTotal);
            }
        }

        protected int CheckStock(int imgID, string sqlCon)
        {
            string sql = "SELECT stockCount FROM ImageDetails, Image WHERE Image.imageID = ImageDetails.imageID AND ImageDetails.imageID = @imageID";
            int stockCount = 0;

            using (SqlConnection con = new SqlConnection(sqlCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlParameter m = new SqlParameter("@imageID", imgID);
                cmd.Parameters.Add(m);

                SqlDataReader dr = cmd.ExecuteReader();

                try
                {
                    while (dr.Read())
                    {
                        stockCount = dr.GetInt32(0);
                    }
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                    dr.Close();
                }
            }

            return stockCount;
        }
    }
}