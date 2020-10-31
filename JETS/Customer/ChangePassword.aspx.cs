using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        string resetId, user;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("/Login.aspx");
            }
            else
            {
                resetId = Request.QueryString["id"].ToString();
                user = Request.QueryString["user"].ToString();

                if (isLocked() == true)
                {
                    Response.Redirect("/Login.aspx");
                }
            }
        }

        protected bool isLocked()
        {
            string sql = "SELECT resetLocked FROM CustomerPassReset WHERE resetID = @resetID";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);

                SqlParameter u = new SqlParameter("@resetID", resetId);
                cmd.Parameters.Add(u);

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        if(dr.GetInt32(0) == 0)
                        {
                            return false;
                        }
                    }

                    dr.Close();
                }
                catch (Exception ex) { }
                finally { con.Close(); }
            }

            return true;
        }

        protected void btnSave_ServerClick(object sender, EventArgs e)
        {
            if(!String.IsNullOrEmpty(txtPassword.Value) && !String.IsNullOrEmpty(txtRePassword.Value))
            {
                LockResetID();
                ChangePass();

                wronguser.Style.Remove("display");
                wronguser.Attributes["class"] = "text-center success-message jets-box";
                wronguser.InnerHtml = "Password changed. You can now <a class='jets-link' style='text-decoration: none !important' href='/Login.aspx'>login</a>.";
                txtPassword.Style.Add("display", "none");
                txtRePassword.Style.Add("display", "none");
                btnSave.Style.Add("display", "none");
                renewpass.Style.Add("display", "none");
                newpass.Style.Add("display", "none");
            }
        }

        protected void ChangePass()
        {
            string sql = "UPDATE CustomerAccount SET password = @password WHERE username = @username";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);

                SqlParameter p = new SqlParameter("@password", Helper.ComputeHash(txtPassword.Value, null));
                SqlParameter u = new SqlParameter("@username", user);
                cmd.Parameters.Add(u);
                cmd.Parameters.Add(p);

                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex) { }
                finally { con.Close(); }
            }
        }

        protected void LockResetID()
        {
            string sql = "UPDATE CustomerPassReset SET resetLocked = @resetLocked WHERE resetID = @resetID";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);

                SqlParameter u = new SqlParameter("@resetID", resetId);
                SqlParameter l = new SqlParameter("@resetLocked", 1);
                cmd.Parameters.Add(u);
                cmd.Parameters.Add(l);

                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex) { }
                finally { con.Close(); }
            }
        }
    }
}