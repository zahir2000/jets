using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        string resetId;

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected bool IsUserValid()
        {
            string sql = "SELECT username FROM CustomerAccount WHERE username = @username";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);

                SqlParameter u = new SqlParameter("@username", txtUsername.Value);
                cmd.Parameters.Add(u);

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        return true;
                    }

                    dr.Close();
                }
                catch (Exception ex) { }
                finally { con.Close(); }
            }

            return false;
        }

        public static int ResetId()
        {

            string num = "0123456789";
            int len = num.Length;
            string newId = String.Empty;
            int newIdRange = 9;
            string digit = String.Empty;
            int index;

            for (int i = 0; i < newIdRange; i++)
            {
                do
                {
                    index = new Random().Next(0, len);
                    digit = num.ToCharArray()[index].ToString();
                } while (newId.IndexOf(digit) != -1);

                newId += digit;
            }

            return Convert.ToInt32(newId);
        }

        private void SendEmail()
        {
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
            client.EnableSsl = true;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Credentials = new NetworkCredential("rustamovz-wm17@student.tarc.edu.my", "11234566");

            MailMessage msg = new MailMessage();
            msg.To.Add(new MailAddress(getEmail()));
            msg.From = new MailAddress("rustamovz-wm17@student.tarc.edu.my");
            msg.Subject = "Password Reset - JETS Gallery";
            msg.IsBodyHtml = true;
            msg.Body = EmailBody();

            try
            {
                client.Send(msg);
            }
            catch (Exception ex) { }
        }

        private string EmailBody()
        {
            string body;

            body = "<html><body style='background-color: #e9ecef;'><table border='0' cellpadding='0' cellspacing='0' width='100%' style='padding-top: 30px; padding-bottom: 30px'><tr><td align='center' bgcolor='#e9ecef'><table border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px;'><tr><td align='left' bgcolor='#ffffff' style='padding: 36px 24px 0; border-top: 3px solid #d4dadf;'><h1 style='margin: 0; font-size: 24px; font-weight: 700; letter-spacing: -1px; line-height: 48px;'>Reset Your Password (JETS)</h1></td></tr></table></td></tr><tr><td align='center' bgcolor='#e9ecef'><table border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px;'><tr><td align='left' bgcolor='#ffffff' style='padding: 24px; font-size: 16px; line-height: 24px;'><p style='margin: 0;'>Tap the button below to reset your customer account password. If you didn't request a new password, you can ignore this mail.</p></td></tr><tr><td align='left' bgcolor='#ffffff'><table border='0' cellpadding='0' cellspacing='0' width='100%'><tr><td align='center' bgcolor='#ffffff' style='padding: 12px;'><table border='0' cellpadding='0' cellspacing='0'><tr><td align='center' bgcolor='#008ecc' style=''>"
                + "<a href='" + HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Customer/ChangePassword.aspx?id=" + resetId + "&user=" + txtUsername.Value + "' target='_blank' style='display: inline-block; padding: 16px 36px; font-size: 16px; color: #ffffff; text-decoration: none; border-radius: 6px;'>Reset Password</a>"
                + "</td></tr></table></td></tr></table></td></tr><tr><td align='left' bgcolor='#ffffff' style='padding: 24px; font-size: 16px; line-height: 24px;'><p style='margin: 0;'>If that the button doesn't work, copy and paste the following link in your browser:</p>"
                + "<p style='margin: 0;'><a href='" + HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Customer/ChangePassword.aspx?id=" + resetId + "&user=" + txtUsername.Value + "' target='_blank'>" + HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/ResetPassword.aspx</a></p>"
                + "</td></tr></table></td></tr></table></body></html>";

            return body;
        }

        private string getEmail()
        {
            string sql = "SELECT custID FROM CustomerAccount WHERE username = @username";
            string email = "", custId = "";
            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();

                try
                {
                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlParameter u = new SqlParameter("@username", txtUsername.Value);
                    cmd.Parameters.Add(u);
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        custId = dr.GetString(0);
                    }

                    dr.Close();

                    string sql2 = "SELECT custEmail FROM Customer WHERE custID = @custID";
                    SqlCommand cmd2 = new SqlCommand(sql2, con);
                    SqlParameter c = new SqlParameter("@custID", custId);
                    cmd2.Parameters.Add(c);

                    SqlDataReader dr2 = cmd2.ExecuteReader();

                    while (dr2.Read())
                    {
                        email = dr2.GetString(0);
                    }

                    dr2.Close();
                }
                catch (Exception ex) { }
                finally { con.Close(); }
            }

            return email;
        }

        protected void btnReset_ServerClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtUsername.Value))
            {
                if (IsUserValid())
                {
                    wronguser.Style.Add("display", "none");

                    resetId = ResetId().ToString();

                    SendEmail();

                    string sql = "INSERT INTO CustomerPassReset(username, resetID, resetDate) VALUES(@username, @resetID, @resetDate)";

                    using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand(sql, con);

                        SqlParameter u = new SqlParameter("@username", txtUsername.Value);
                        SqlParameter rId = new SqlParameter("@resetID", resetId);
                        SqlParameter rDate = new SqlParameter("@resetDate", DateTime.Now);
                        cmd.Parameters.Add(u);
                        cmd.Parameters.Add(rId);
                        cmd.Parameters.Add(rDate);

                        try
                        {
                            cmd.ExecuteNonQuery();
                            wronguser.InnerHtml = "Reset instructions sent to your email.";
                            wronguser.Attributes["class"] = "text-center success-message jets-box";
                            wronguser.Style.Remove("display");
                            txtUsername.Value = "";
                        }
                        catch (Exception ex) { }
                        finally { con.Close(); }
                    }
                }
                else
                {
                    wronguser.InnerHtml = "Incorrect username.";
                    wronguser.Style.Remove("display");
                }
            }
        }
    }
}