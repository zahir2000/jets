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
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCustomerData();
            }

            txtCurrent.Attributes.Add("onblur", "ValidatorOnChange(event);");
            txtNew.Attributes.Add("onblur", "ValidatorOnChange(event);");
            txtReNew.Attributes.Add("onblur", "ValidatorOnChange(event);");
        }

        protected void GetCustomerData()
        {
            string sqlCon = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string sql = "SELECT * from Customer C, CustomerAccount A WHERE C.custID = A.custID AND C.custID = @custID";

            using (SqlConnection con = new SqlConnection(sqlCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);

                SqlParameter u = new SqlParameter("@custID", Session["customerID"]);
                cmd.Parameters.Add(u);

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    txtFName.Value = dr.GetString(1);
                    txtLName.Value = dr.GetString(2);
                    txtMail.Value = dr.GetString(3);
                    txtPNum.Value = dr.GetString(4);
                    txtAdd.Value = dr.GetString(5);
                }
                con.Close();
            }
        }

        protected bool IsPassCorrect()
        {
            string sql = "SELECT password FROM CustomerAccount WHERE custID = @custID";
            string pass = "";
            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter id = new SqlParameter("@custID", Session["customerID"]);
                    cmd.Parameters.Add(id);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        pass = dr.GetString(0);
                    }

                    return Helper.VerifyHash(txtCurrent.Value, pass);
                }
                catch { }
                finally { con.Close(); }
            }

            return false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int counter = 0;

            if (isFieldEmpty() == true) { counter++; }
            if (isPhoneNumValid() == false) { counter++; }
            if (isEmailValid() == false) { counter++; }
            if (CheckDuplicateEmail(txtMail.Value) == true) { counter++; }

            if (counter == 0) { UpdateCustomerInfo(); } else { personalmsg.Style.Add("display", "none"); }
        }

        protected bool isFieldEmpty()
        {
            int thereis = 0;

            if (String.IsNullOrEmpty(txtFName.Value)) {
                //fnamecheck.Style.Remove("display");
                txtFName.Attributes.Add("class", "invalid jets-control"); thereis++;
            }
            else {
                //fnamecheck.Style.Add("display", "none");
                txtFName.Attributes.Add("class", "jets-control");
            }

            if (String.IsNullOrEmpty(txtLName.Value)) {
                //lnamecheck.Style.Remove("display");
                txtLName.Attributes.Add("class", "invalid jets-control"); thereis++;
            }
            else {
                //lnamecheck.Style.Add("display", "none");
                txtLName.Attributes.Add("class", "jets-control");
            }

            if (String.IsNullOrEmpty(txtAdd.Value)) {
                //addresscheck.Style.Remove("display");
                txtAdd.Attributes.Add("class", "invalid jets-control"); thereis++;
            }
            else {
                //addresscheck.Style.Add("display", "none");
                txtAdd.Attributes.Add("class", "jets-control");
            }

            if (String.IsNullOrEmpty(txtMail.Value)) {
                //emailcheck.Style.Remove("display");
                txtMail.Attributes.Add("class", "invalid jets-control"); thereis++;
            }
            else {
                //emailcheck.Style.Add("display", "none");
                txtMail.Attributes.Add("class", "jets-control");
            }

            if (String.IsNullOrEmpty(txtPNum.Value)) {
                //pnumcheck.Style.Remove("display");
                txtPNum.Attributes.Add("class", "invalid jets-control"); thereis++;
            }
            else {
                //pnumcheck.Style.Add("display", "none");
                txtPNum.Attributes.Add("class", "jets-control");
            }

            if (thereis > 0) { return true; } else { return false; }
        }

        protected bool isPasswordValid()
        {
            Regex regPass = new Regex(@"^[a-zA-Z0-9]*$");

            Match matchPass = regPass.Match(txtNew.Value);

            if (matchPass.Success && !(txtNew.Value.Length < 6) && !(txtNew.Value.Length > 16))
            {
                wrongrepass.Style.Add("display", "none"); txtNew.Attributes.Add("class", "valid jets-control");
                return true;
            }
            else
            {
                wrongrepass.Style.Remove("display"); txtNew.Attributes.Add("class", "invalid jets-control");
                return false;
            }
        }

        protected bool isPhoneNumValid()
        {
            Regex regNum = new Regex(@"^(\+601|01)[0-46-9]*[0-9]{7,8}$");

            Match matchNum = regNum.Match(txtPNum.Value);

            if (matchNum.Success)
            {
                //pnumcheck.Style.Add("display", "none"); txtPNum.Attributes.Add("class", "valid jets-control");
                return true;
            }
            else
            {
                //pnumcheck.InnerHtml = "Please enter a valid phone number \r\n Eg: +60109993610 or 0109993610";
                //pnumcheck.Style.Remove("display"); txtPNum.Attributes.Add("class", "invalid jets-control");
                return false;
            }
        }

        protected bool isEmailValid()
        {
            Regex regEmail = new Regex(@"^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$");

            Match matchEmail = regEmail.Match(txtMail.Value);

            if (matchEmail.Success)
            {
                //emailcheck.Style.Add("display", "none"); txtMail.Attributes.Add("class", "valid jets-control");
                return true;
            }
            else
            {
                //emailcheck.Style.Remove("display"); txtMail.Attributes.Add("class", "invalid jets-control");
                return false;
            }
        }

        private void UpdateCustomerInfo()
        {
            string sqlCon = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string sql = "UPDATE Customer SET custFName = @FName, custLName = @LName, custEmail = @email, custPhoneNum = @phoneNum, custAddress = @address WHERE custID = @custID";

            using (SqlConnection con = new SqlConnection(sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter id = new SqlParameter("@custID", Session["customerID"]);
                    SqlParameter fname = new SqlParameter("@FName", txtFName.Value);
                    SqlParameter lname = new SqlParameter("@LName", txtLName.Value);
                    SqlParameter email = new SqlParameter("@email", txtMail.Value);
                    SqlParameter phoneNum = new SqlParameter("@phoneNum", txtPNum.Value);
                    SqlParameter address = new SqlParameter("@address", txtAdd.Value);

                    cmd.Parameters.Add(id);
                    cmd.Parameters.Add(fname);
                    cmd.Parameters.Add(lname);
                    cmd.Parameters.Add(email);
                    cmd.Parameters.Add(phoneNum);
                    cmd.Parameters.Add(address);

                    cmd.ExecuteNonQuery();

                    personalmsg.Style.Remove("display");
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                }
            }
        }

        protected bool CheckDuplicateEmail(string email)
        {
            string sql = "SELECT custEmail FROM Customer WHERE custEmail = @email";

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

                        string foundEmail = "";
                        string userEmail = GetEmail();

                        while (dr.Read())
                        {
                            foundEmail = dr.GetString(0);
                        }

                        if (dr.HasRows)
                        {
                            if(foundEmail == userEmail)
                            {
                                return false;
                            }

                            //emailcheck.Style.Remove("display");
                            txtMail.Attributes.Add("class", "invalid jets-control");
                            //emailcheck.InnerText = "A customer with this email already exists.";
                            txtMail.Focus();
                            return true;
                        }
                    }
                    catch (Exception ex) { }
                    finally { con.Close(); }
                }
            }
            else {
                //emailcheck.InnerText = "Please enter a valid email";
                //emailcheck.Style.Remove("display");
                txtMail.Attributes.Add("class", "invalid jets-control");
                return true;
            }

            return false;
        }

        protected string GetEmail()
        {
            string sql = "SELECT custEmail FROM Customer WHERE custID = @custID";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter id = new SqlParameter("@custID", Session["customerID"]);
                    cmd.Parameters.Add(id);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        return dr.GetString(0);
                    }
                }
                catch (Exception ex) { }
                finally { con.Close(); }
            }

            return "";
        }

        protected void btnSavePass_Click(object sender, EventArgs e)
        {
            if (IsPassCorrect())
            {
                if (txtNew.Value == txtReNew.Value && isPasswordValid())
                {
                    string sql = "UPDATE CustomerAccount SET password = @pass WHERE custID = @custID";

                    using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                    {
                        try
                        {
                            con.Open();

                            string ePass = Helper.ComputeHash(txtNew.Value, null);

                            SqlCommand cmd = new SqlCommand(sql, con);

                            SqlParameter id = new SqlParameter("@custID", Session["customerID"]);
                            SqlParameter pass = new SqlParameter("@pass", ePass);

                            cmd.Parameters.Add(id);
                            cmd.Parameters.Add(pass);

                            cmd.ExecuteNonQuery();

                            wrongrepass.Style.Remove("display");
                            wrongrepass.Attributes["class"] = "text-left success-message jets-box";
                            wrongrepass.InnerHtml = "Password successfully changed.";
                        }
                        catch (Exception ex) { }
                        finally
                        {
                            con.Close();
                        }
                    }
                }
                else
                {
                    wrongrepass.Attributes["class"] = "text-left incorrect-message jets-box";
                    wrongrepass.Style.Remove("display");
                    wrongrepass.InnerHtml = "Password should be more than 6 characters & Alphanumeric.";
                }
            }
            else
            {
                wrongrepass.Attributes["class"] = "text-left incorrect-message jets-box";
                wrongrepass.Style.Remove("display");
                wrongrepass.InnerHtml = "Wrong current password. Please re-enter.";
            }
        }
    }
}