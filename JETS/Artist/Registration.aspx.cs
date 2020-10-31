using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Artist
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string GetNewID()
        {
            string sql = "SELECT COUNT(*) FROM Artist";
            string newArtistID = "";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        newArtistID = "A" + (dr.GetInt32(0) + 1).ToString("0000");
                    }
                }catch(Exception ex)
                {

                }
                finally
                {
                    con.Close();
                }
            }

            return newArtistID;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            int counter = 0;

            if (isFieldEmpty() == true) { counter++; }
            if (CheckDuplicateUsername(txtUser.Value) == true) { passcheck.Style.Remove("display"); txtPass.Attributes.Add("class", "invalid jets-control"); counter++; }
            if (CheckDuplicateEmail(txtMail.Value) == true) { passcheck.Style.Remove("display"); txtPass.Attributes.Add("class", "invalid jets-control"); counter++; }
            if (isPasswordValid() == false) { counter++; }
            if (isPhoneNumValid() == false) { passcheck.Style.Remove("display"); txtPass.Attributes.Add("class", "invalid jets-control"); counter++; }
            if (isEmailValid() == false) { passcheck.Style.Remove("display"); txtPass.Attributes.Add("class", "invalid jets-control"); counter++; }

            if (counter == 0)
                AddArtist();
        }

        protected bool isPasswordValid()
        {
            Regex regPass = new Regex(@"^[a-zA-Z0-9]*$");

            Match matchPass = regPass.Match(txtPass.Value);

            if (matchPass.Success && !(txtPass.Value.Length < 6) && !(txtPass.Value.Length > 16))
            {
                return true;
            }
            else
            {
                passcheck.Style.Remove("display"); txtPass.Attributes.Add("class", "invalid jets-control");
                return false;
            }
        }

        protected bool isPhoneNumValid()
        {
            Regex regNum = new Regex(@"^(\+601|01)[0-46-9]{7,9}$");

            Match matchNum = regNum.Match(txtPhoneNum.Value);

            if (matchNum.Success)
            {
                return true;
            }
            else
            {
                phonenumcheck.InnerHtml = "Please enter a valid phone number \r\n Eg: +60109993610 or 0109993610";
                phonenumcheck.Style.Remove("display"); txtPhoneNum.Attributes.Add("class", "invalid jets-control");
                return false;
            }
        }

        protected bool isEmailValid()
        {
            Regex regEmail = new Regex(@"^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$");

            Match matchEmail = regEmail.Match(txtMail.Value);

            if (matchEmail.Success)
            {
                return true;
            }
            else
            {
                emailcheck.Style.Remove("display"); txtMail.Attributes.Add("class", "invalid jets-control");
                return false;
            }
        }

        protected bool isFieldEmpty()
        {
            int thereis = 0;

            if (String.IsNullOrEmpty(txtFNam.Value)) { fnamecheck.Style.Remove("display"); txtFNam.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { fnamecheck.Style.Add("display", "none"); txtFNam.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtLNam.Value)) { lnamecheck.Style.Remove("display"); txtLNam.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { lnamecheck.Style.Add("display", "none"); txtLNam.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtMail.Value)) { emailcheck.Style.Remove("display"); txtMail.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { emailcheck.Style.Add("display", "none"); txtMail.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtPhoneNum.Value)) { phonenumcheck.Style.Remove("display"); txtPhoneNum.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { phonenumcheck.Style.Add("display", "none"); txtPhoneNum.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtUser.Value)) { usernamecheck.Style.Remove("display"); txtUser.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { usernamecheck.Style.Add("display", "none"); txtUser.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtPass.Value)) { passcheck.Style.Remove("display"); txtPass.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { passcheck.Style.Add("display", "none"); txtPass.Attributes.Add("class", "jets-control"); }

            if (thereis > 0) { return true; } else { return false; }
        }

        protected bool CheckDuplicateUsername(string username)
        {
            string sql = "SELECT * FROM ArtistAccount WHERE username = @username";

            if (!String.IsNullOrEmpty(username))
            {
                using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                {
                    try
                    {
                        con.Open();

                        SqlCommand cmd = new SqlCommand(sql, con);

                        SqlParameter user = new SqlParameter("@username", username);
                        cmd.Parameters.Add(user);

                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            usernamecheck.Style.Remove("display");
                            txtUser.Attributes.Add("class", "invalid jets-control");
                            usernamecheck.InnerText = "A customer with this username already exists.";
                            txtUser.Focus();
                            txtUser.Attributes.Add("onfocus", "selectUsername();");
                            return true;
                        }
                    }
                    catch (Exception ex) { }
                    finally { con.Close(); }
                }
            }
            else { usernamecheck.InnerText = "Please enter your username"; usernamecheck.Style.Remove("display"); txtUser.Attributes.Add("class", "invalid jets-control"); return true; }

            return false;
        }

        protected bool CheckDuplicateEmail(string email)
        {
            string sql = "SELECT * FROM Artist WHERE artistEmail = @email";

            if (!String.IsNullOrEmpty(email))
            {
                using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                {
                    try
                    {
                        con.Open();

                        SqlCommand cmd = new SqlCommand(sql, con);

                        SqlParameter e = new SqlParameter("@email", email);
                        cmd.Parameters.Add(e);

                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            emailcheck.Style.Remove("display");
                            txtMail.Attributes.Add("class", "invalid jets-control");
                            emailcheck.InnerText = "A customer with this email already exists.";
                            txtMail.Focus();
                            txtMail.Attributes.Add("onfocus", "selectEmail();");
                            return true;
                        }
                    }
                    catch (Exception ex) { }
                    finally { con.Close(); }
                }
            }
            else { emailcheck.InnerText = "Please enter a valid email"; emailcheck.Style.Remove("display"); txtMail.Attributes.Add("class", "invalid jets-control"); return true; }

            return false;
        }

        protected void AddArtist()
        {
            string sql = "INSERT INTO Artist(artistID, artistFName, artistLName, artistEmail, artistPhoneNum) VALUES (@artistID, @fName, @lName, @email, @num)";
            string newArtistid = GetNewID();

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter id = new SqlParameter("@artistID", newArtistid);
                    SqlParameter fname = new SqlParameter("@fName", txtFNam.Value);
                    SqlParameter lname = new SqlParameter("@lName", txtLNam.Value);
                    SqlParameter email = new SqlParameter("@email", txtMail.Value);
                    SqlParameter num = new SqlParameter("@num", txtPhoneNum.Value);

                    cmd.Parameters.Add(id);
                    cmd.Parameters.Add(fname);
                    cmd.Parameters.Add(lname);
                    cmd.Parameters.Add(email);
                    cmd.Parameters.Add(num);

                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                    AddArtistAccount(newArtistid);
                }
            }
        }

        protected void AddArtistAccount(string newID)
        {
            string sql = "INSERT INTO ArtistAccount(username, password, artistID) VALUES (@username, @password, @artistID)";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    string ePass = Helper.ComputeHash(txtPass.Value, null);

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter id = new SqlParameter("@artistID", newID);
                    SqlParameter username = new SqlParameter("@username", txtUser.Value);
                    SqlParameter password = new SqlParameter("@password", ePass);

                    cmd.Parameters.Add(id);
                    cmd.Parameters.Add(username);
                    cmd.Parameters.Add(password);

                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                }

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "", "$('#regModal').modal();", true);
                ScriptManager.RegisterStartupScript(this, typeof(Page), "", "setTimeout(function(){window.location.href='/Artist/Login.aspx';},3000);", true);
            }
        }
    }
}