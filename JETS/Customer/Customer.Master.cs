using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class Customer : System.Web.UI.MasterPage
    {
        CartData myCart;

        protected void Page_Init(object sender, EventArgs e)
        {
            try
            {
                if ((String)Session["role"] != "customer" || Session["role"] == null)
                {
                    Response.Redirect("/Errors/403.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("/Errors/403.aspx");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["myCart"] == null)
            {
                Session["myCart"] = new CartData();
            }

            myCart = (CartData)Session["myCart"];

            qty.Text = myCart.Items.Count.ToString();
            
            if (myCart.Items.Count > 0)
            {
                CartData.Style.Remove("display");
                cartRepeater.DataSource = myCart.Items;
                cartRepeater.DataBind();
                lblTotalCart.Text = String.Format(Helper.my, "{0:C}", myCart.GrandTotal);
            }
            else
            {
                NoCart.Style.Remove("display");
            }
        }

        protected void logout_ServerClick(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();

            // clear authentication cookie
            HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie1.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie1);

            // clear session cookie (not necessary for your current problem but i would recommend you do it anyway)
            SessionStateSection sessionStateSection = (SessionStateSection)WebConfigurationManager.GetSection("system.web/sessionState");
            HttpCookie cookie2 = new HttpCookie(sessionStateSection.CookieName, "");
            cookie2.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie2);

            FormsAuthentication.RedirectToLoginPage();
        }
    }
}