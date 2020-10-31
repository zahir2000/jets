using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            string sqlCon = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string sql = "SELECT c.custID, A.password from CustomerAccount A, Customer C WHERE C.custID = A.custID AND username = @user";
            string pass = "";
            bool isPass = false;

            using (SqlConnection con = new SqlConnection(sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter u = new SqlParameter("@user", txtUsername.Value);
                    cmd.Parameters.Add(u);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        pass = dr.GetString(1);
                        Session["customerID"] = dr.GetString(0);
                        Session["role"] = "customer";
                    }

                    isPass = Helper.VerifyHash(txtPassword.Value, pass);
                }
                catch (Exception ex) { }
                finally { con.Close(); }

                if (isPass)
                {
                    Session["username"] = txtUsername.Value;
                    FormsAuthentication.RedirectFromLoginPage(txtUsername.Value, true);
                    Response.Redirect("Customer/Gallery.aspx");
                }
                else
                {
                    wronglogin.Style.Remove("display");
                }
            }
        }
    }
}