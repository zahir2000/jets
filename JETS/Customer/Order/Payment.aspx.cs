using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class Payment : System.Web.UI.Page
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
            if (myCart.Items.Count == 0)
            {
                Response.Redirect("/Customer/Cart.aspx");
            }

            itemRepeater.DataSource = myCart.Items;
            itemRepeater.DataBind();
        }

        protected void itemRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            lblTotal.Text = string.Format(Helper.my, "{0:C}", myCart.GrandTotal);
        }

        protected void btnCompleteOrder_Click(object sender, EventArgs e)
        {
            Session["orderNo"] = Helper.NewOrderNo();

            Session["paidCart"] = (CartData)Session["myCart"];
            Session["paidShipping"] = (Shipping)Session["myShipping"];

            Response.Write("<form action='https://www.sandbox.paypal.com/cgi-bin/webscr' method='post' name='buyArt' id='buyArt'>");
            Response.Write("<input type='hidden' name='cmd' value='_xclick'>");
            Response.Write("<input type='hidden' name='business' value='jetsgallery@icloud.com'>");
            Response.Write("<input type='hidden' name='currency_code' value='MYR'>");
            Response.Write("<input type='hidden' name='no_shipping' value='1'>");
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