using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class Checkout : System.Web.UI.Page
    {
        CartData myCart;
        Shipping myShipping;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["myCart"] == null)
            {
                Session["myCart"] = new CartData();
            }

            if (Session["myShipping"] == null)
            {
                Session["myShipping"] = new Shipping();
            }

            myCart = (CartData)Session["myCart"];
            myShipping = (Shipping)Session["myShipping"];

            if (!IsPostBack)
            {
                myCart = (CartData)Session["myCart"];
                myShipping = (Shipping)Session["myShipping"];
                FillData();
                FillShipping();
            }
        }

        private void FillData()
        {
            if (myCart.Items.Count == 0)
            {
                Response.Redirect("Cart.aspx");
            }

            itemRepeater.DataSource = myCart.Items;
            itemRepeater.DataBind();
        }

        private void FillShipping()
        {
            txtFNam.Value = myShipping.custFName;
            txtLNam.Value = myShipping.custLName;
            txtMail.Value = myShipping.custEmail;
            txtAdd.Value = myShipping.custAddress;
            txtPNum.Value = myShipping.custPhoneNum;
        }

        protected void itemRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            lblTotal.Text = string.Format(Helper.my, "{0:C}", myCart.GrandTotal);
        }

        protected void loadUserDetails()
        {
            string sql = "SELECT * from Customer WHERE custID = @custID";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlParameter m = new SqlParameter("@custID", Session["customerID"]);
                cmd.Parameters.Add(m);

                SqlDataReader dr = cmd.ExecuteReader();

                try
                {
                    while (dr.Read())
                    {
                        txtFNam.Value = dr.GetString(1);
                        txtLNam.Value = dr.GetString(2);
                        txtMail.Value = dr.GetString(3);
                        txtPNum.Value = dr.GetString(4);
                        txtAdd.Value = dr.GetString(5);
                    }
                }
                catch (Exception ex)
                {

                }
                finally
                {
                    con.Close();
                    dr.Close();
                }
            }
        }

        protected void clearShippingAddress()
        {
            txtFNam.Value = "";
            txtLNam.Value = "";
            txtMail.Value = "";
            txtPNum.Value = "";
            txtAdd.Value = "";
        }

        protected void ddlAddress_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAddress.SelectedItem.Value == "Default")
            {
                loadUserDetails();
            }
            else
            {
                clearShippingAddress();
            }
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            /* 
             * SAVE TO DATABASE
             * 1. Save to Orders
             * 2. Save to OrderDetails
             * 3. Reduce StockCount from ImageDetails
             * 4. Successful message & return to Gallery (Order History later on)
             * 
             * INSERT INTO Orders(orderID, custID, orderDate, totalPrice, shipName, shipAddress, custPhoneNum) VALUES(@orderID, @custID, @date, @total, @name, @address, @phone);
             * INSERT INTO OrderDetails(orderID, imageID, unitPrice, quantity, discount) VALUES (@orderID, @imageID, @unitPrice, @qty, @discount);
             * UPDATE ImageDetails SET stockCount = @stockCount WHERE imageID = @imageID;
             */

            if (Session["myShipping"] == null)
            {
                myShipping = new Shipping();
                Session["myShipping"] = myShipping;
            }
            myShipping = (Shipping)Session["myShipping"];

            myShipping.custFName = txtFNam.Value;
            myShipping.custLName = txtLNam.Value;
            myShipping.custEmail = txtMail.Value;
            myShipping.custAddress = txtAdd.Value;
            myShipping.custPhoneNum = txtPNum.Value;

            Response.Redirect("/Customer/Order/Payment.aspx");
        }

        protected void btnPaypal_ServerClick(object sender, EventArgs e)
        {
            Session["orderNo"] = Helper.NewOrderNo();
            Session["expressCheckout"] = Session["orderNo"];

            string sql = "SELECT * from Customer WHERE custID = @custID";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlParameter m = new SqlParameter("@custID", Session["customerID"]);
                cmd.Parameters.Add(m);

                SqlDataReader dr = cmd.ExecuteReader();

                try
                {
                    while (dr.Read())
                    {
                        Session["expressCheckoutName"] = dr.GetString(1) + " " + dr.GetString(2);
                        Session["expressCheckoutPhoneNum"] = dr.GetString(4);
                        Session["expressCheckoutAddress"] = dr.GetString(5);
                    }
                }
                catch (Exception ex)
                {

                }
                finally
                {
                    con.Close();
                    dr.Close();
                }
            }

            Session["paidCart"] = (CartData)Session["myCart"];

            Response.Write("<form action='https://www.sandbox.paypal.com/cgi-bin/webscr' method='post' name='buyArt' id='buyArt'>");
            Response.Write("<input type='hidden' name='cmd' value='_xclick'>");
            Response.Write("<input type='hidden' name='business' value='jetsgallery@icloud.com'>");
            Response.Write("<input type='hidden' name='currency_code' value='MYR'>");
            Response.Write("<input type='hidden' name='no_shipping' value='2'>");
            Response.Write("<input type='hidden' name='item_name' value='JETS Payment - " + Session["username"] + "'>");
            Response.Write("<input type='hidden' name='amount' value='" + myCart.GrandTotal + "'>");
            Response.Write("<input type='hidden' name='return' value='" + HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Customer/Order/Payment_Success.aspx?order=" + Session["orderNo"] + "'>");
            Response.Write("<input type='hidden' name='cancel_return' value='" + HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Customer/Order/Payment_Fail.aspx?order=" + Session["orderNo"] + "'>");
            Response.Write("</form>");

            Response.Write("<script type='text/javascript'>");
            Response.Write("document.getElementById('buyArt').submit();");
            Response.Write("</script>");
        }
    }
}