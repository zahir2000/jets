using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace JETS.Customer
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string GetNewID()
        {
            string sql = "SELECT COUNT(*) FROM Customer";
            string newID = "";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        newID = "C" + (dr.GetInt32(0) + 1).ToString("0000");
                    }
                }catch(Exception ex) { }
                finally { con.Close(); }
            }

            return newID;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            int counter = 0;

            if (isFieldEmpty() == true) { counter++; }
            if (CheckDuplicateUsername(txtUsername.Value) == true) { passcheck.Style.Remove("display"); txtPassword.Attributes.Add("class", "invalid jets-control"); counter++; }
            if (CheckDuplicateEmail(txtEmail.Value) == true) { passcheck.Style.Remove("display"); txtPassword.Attributes.Add("class", "invalid jets-control"); counter++; }
            if (isPasswordValid() == false) { counter++; }
            if (isPhoneNumValid() == false) { passcheck.Style.Remove("display"); txtPassword.Attributes.Add("class", "invalid jets-control"); counter++; }
            if (isEmailValid() == false) { passcheck.Style.Remove("display"); txtPassword.Attributes.Add("class", "invalid jets-control"); counter++; }
            
            if (counter == 0)
                AddCustomer();
        }

        protected bool isPasswordValid()
        {
            Regex regPass = new Regex(@"^[a-zA-Z0-9]*$");

            Match matchPass = regPass.Match(txtPassword.Value);

            if(matchPass.Success && !(txtPassword.Value.Length < 6) && !(txtPassword.Value.Length > 16))
            {
                return true;
            }
            else
            {
                passcheck.Style.Remove("display"); txtPassword.Attributes.Add("class", "invalid jets-control");
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

            Match matchEmail = regEmail.Match(txtEmail.Value);

            if (matchEmail.Success)
            {
                return true;
            }
            else
            {
                emailcheck.Style.Remove("display"); txtEmail.Attributes.Add("class", "invalid jets-control");
                return false;
            }
        }

        protected bool isFieldEmpty()
        {
            int thereis = 0;

            if (String.IsNullOrEmpty(txtFName.Value)) { fnamecheck.Style.Remove("display"); txtFName.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { fnamecheck.Style.Add("display", "none"); txtFName.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtLName.Value)) { lnamecheck.Style.Remove("display"); txtLName.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { lnamecheck.Style.Add("display", "none"); txtLName.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtAddress.Value)) { addresscheck.Style.Remove("display"); txtAddress.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { addresscheck.Style.Add("display", "none"); txtAddress.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtEmail.Value)) { emailcheck.Style.Remove("display"); txtEmail.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { emailcheck.Style.Add("display", "none"); txtEmail.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtPhoneNum.Value)) { phonenumcheck.Style.Remove("display"); txtPhoneNum.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { phonenumcheck.Style.Add("display", "none"); txtPhoneNum.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtUsername.Value)) { usernamecheck.Style.Remove("display"); txtUsername.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { usernamecheck.Style.Add("display", "none"); txtUsername.Attributes.Add("class", "jets-control"); }

            if (String.IsNullOrEmpty(txtPassword.Value)) { passcheck.Style.Remove("display"); txtPassword.Attributes.Add("class", "invalid jets-control"); thereis++; }
            else { passcheck.Style.Add("display", "none"); txtPassword.Attributes.Add("class", "jets-control"); }

            if (thereis > 0) { return true; } else { return false; }
        }

        protected bool CheckDuplicateUsername(string username)
        {
            string sql = "SELECT * FROM CustomerAccount WHERE username = @username";

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
                            txtUsername.Attributes.Add("class", "invalid jets-control");
                            usernamecheck.InnerText = "A customer with this username already exists.";
                            txtUsername.Focus();
                            txtUsername.Attributes.Add("onfocus", "selectUsername();");
                            return true;
                        }
                    }
                    catch (Exception ex) { }
                    finally { con.Close(); }
                }
            }
            else { usernamecheck.InnerText = "Please enter your username"; usernamecheck.Style.Remove("display"); txtUsername.Attributes.Add("class", "invalid jets-control"); return true; }

            return false;
        }

        protected bool CheckDuplicateEmail(string email)
        {
            string sql = "SELECT * FROM Customer WHERE custEmail = @email";

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
                            txtEmail.Attributes.Add("class", "invalid jets-control");
                            emailcheck.InnerText = "A customer with this email already exists.";
                            txtEmail.Focus();
                            txtEmail.Attributes.Add("onfocus", "selectEmail();");
                            return true;
                        }
                    }
                    catch (Exception ex) { }
                    finally { con.Close(); }
                }
            }
            else { emailcheck.InnerText = "Please enter a valid email"; emailcheck.Style.Remove("display"); txtEmail.Attributes.Add("class", "invalid jets-control"); return true; }

            return false;
        }

        protected void AddCustomer()
        {
            string sql = "INSERT INTO Customer(custID, custFName, custLName, custEmail, custPhoneNum, custAddress) VALUES (@custID, @fName, @lName, @email, @num, @address)";
            string newid = GetNewID();

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter id = new SqlParameter("@custID", newid);
                    SqlParameter fname = new SqlParameter("@fName", txtFName.Value);
                    SqlParameter lname = new SqlParameter("@lName", txtLName.Value);
                    SqlParameter email = new SqlParameter("@email", txtEmail.Value);
                    SqlParameter num = new SqlParameter("@num", txtPhoneNum.Value);
                    SqlParameter address = new SqlParameter("@address", txtAddress.Value);

                    cmd.Parameters.Add(id);
                    cmd.Parameters.Add(fname);
                    cmd.Parameters.Add(lname);
                    cmd.Parameters.Add(email);
                    cmd.Parameters.Add(num);
                    cmd.Parameters.Add(address);

                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    
                }
                finally
                {
                    con.Close();
                    AddCustomerAccount(newid);
                }
            }
        }

        protected void AddCustomerAccount(string newID)
        {
            string sql = "INSERT INTO CustomerAccount(username, password, custID) VALUES (@username, @password, @custID)";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    string ePass = Helper.ComputeHash(txtPassword.Value, null);

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter id = new SqlParameter("@custID", newID);
                    SqlParameter username = new SqlParameter("@username", txtUsername.Value);
                    SqlParameter password = new SqlParameter("@password", ePass);

                    cmd.Parameters.Add(id);
                    cmd.Parameters.Add(username);
                    cmd.Parameters.Add(password);

                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    
                }
                finally
                {
                    con.Close();
                }

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "", "$('#regModal').modal();", true);
                ScriptManager.RegisterStartupScript(this, typeof(Page), "", "setTimeout(function(){window.location.href='../Login.aspx';},3000);", true);
            }
        }
    }
}