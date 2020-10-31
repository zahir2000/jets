using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;

namespace JETS.Artist
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            string sql = "SELECT c.artistID, A.password from ArtistAccount A, Artist C WHERE C.artistID = A.artistID AND username = @user";
            string pass = "";
            bool isPass = false;

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter u = new SqlParameter("@user", txtUser.Value);
                    cmd.Parameters.Add(u);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        pass = dr.GetString(1);
                        Session["artistID"] = dr.GetString(0);
                        Session["role"] = "artist";
                    }

                    isPass = Helper.VerifyHash(txtPass.Value, pass);
                }
                catch (Exception ex) { }
                finally { con.Close(); }

                if (isPass)
                {
                    Session["usernameArtist"] = txtUser.Value;
                    FormsAuthentication.RedirectFromLoginPage(txtUser.Value, true);
                    Response.Redirect("/Artist/Gallery.aspx");
                }
                else
                {
                    wronglogin.Style.Remove("display");
                }
            }
        }
    }
}