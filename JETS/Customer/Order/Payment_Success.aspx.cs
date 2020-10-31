using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.IO;
using System.Data.SqlClient;

namespace JETS.Customer.Order
{
    public partial class Payment_Success : System.Web.UI.Page
    {
        CartData myCart;
        CartData paidCart;
        Shipping myShipping;
        Shipping paidShipping;

        private string name, phoneNum, address, email;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["order"] == null)
            {
                Response.Redirect("/Customer/Cart.aspx");
            }
            else
            {
                if (Convert.ToInt32(Request.QueryString["order"]) == (int)Session["orderNo"])
                {
                    if (!IsPostBack)
                    {
                        myCart = (CartData)Session["myCart"];
                        myShipping = (Shipping)Session["myShipping"];

                        paidCart = (CartData)Session["paidCart"];
                        paidShipping = (Shipping)Session["paidShipping"];

                        FillData();

                        AddToOrderDB();
                        UpdateImageDetailsDB();

                        if ((string)Session["isEmailSentForOrder"] == null || (string)Session["isEmailSentForOrder"] != ("Email" + Session["orderNo"])){
                            SendEmail();
                        }

                        Session.Remove("myCart");
                        Session.Remove("myShipping");
                    }
                }
                else
                {
                    Response.Redirect("/Customer/Cart.aspx");
                }
            }
        }

        private void FillData()
        {
            if (paidCart.Items.Count == 0)
            {
                Response.Redirect("/Customer/Cart.aspx");
            }

            if (Session["expressCheckout"] != null && Session["expressCheckout"] == Session["orderNo"])
            {
                lblName.Text = Session["expressCheckoutName"].ToString();
                lblAddress.Text = Session["expressCheckoutAddress"].ToString();
                lblPhoneNum.Text = Session["expressCheckoutPhoneNum"].ToString();

                name = Session["expressCheckoutName"].ToString();
                address = Session["expressCheckoutAddress"].ToString();
                phoneNum = Session["expressCheckoutPhoneNum"].ToString();
                email = getEmail();
            }
            else
            {
                lblName.Text = paidShipping.custFName.ToString() + " " + paidShipping.custLName.ToString();
                lblAddress.Text = paidShipping.custAddress;
                lblPhoneNum.Text = paidShipping.custPhoneNum;

                name = paidShipping.custFName.ToString() + " " + paidShipping.custLName.ToString();
                address = paidShipping.custAddress;
                phoneNum = paidShipping.custPhoneNum;
                email = paidShipping.custEmail;
            }

            lblTotal.Text = string.Format(Helper.my, "{0:C}", paidCart.GrandTotal);
            lblOrderDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
            lblOrderID.Text = String.Format("{0:D6}", Convert.ToInt32(Session["orderNo"]));

            itemRepeater.DataSource = paidCart.Items;
            itemRepeater.DataBind();
        }

        private void SendEmail()
        {
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
            client.EnableSsl = true;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Credentials = new NetworkCredential("rustamovz-wm17@student.tarc.edu.my", "11234566");

            MailMessage msg = new MailMessage();
            msg.To.Add(new MailAddress(email));
            msg.From = new MailAddress("rustamovz-wm17@student.tarc.edu.my");
            msg.Subject = "Order Confirmed: " + Session["orderNo"] + " - JETS Gallery";
            msg.IsBodyHtml = true;
            msg.Body = EmailBody();

            try
            {
                client.Send(msg);
                Session["isEmailSentForOrder"] = "Email" + Session["orderNo"];
            }
            catch (Exception ex) { }
        }

        private string EmailBody()
        {
            string boughtItems = "";

            for(int i = 0; i < paidCart.Items.Count; i++)
            {
                boughtItems += "<tr style='border-bottom: solid 1px #f7f7f7;'><td style='font-size:13px;font-weight:normal;padding: 0px 6px;vertical-align:top;'>" + paidCart.Items[i].imageName + "</td><td style='font-size:13px;font-weight:normal;padding: 0px 6px;vertical-align:top;' align='right'>" + String.Format(Helper.my, "{0:C}", paidCart.Items[i].unitPrice * paidCart.Items[i].qty) + "</td></tr>";
            }

            string body = "<html><body style='width:97% !important;margin-top:0;margin-bottom:0;margin-right:auto;margin-left:auto;height:100%;background-color:#fafafa;background-image:none;background-repeat:repeat;background-position:top left;background-attachment:scroll;-webkit-font-smoothing:antialiased;-webkit-text-size-adjust:none; margin: 0; padding: 0; font-size: 100%; font-family: Arial, sans-serif; line-height: 1.65;'>"
                + "<table style='width:97% !important;margin-top:0;margin-bottom:0;margin-right:auto;margin-left:auto;height:100%;background-color:#fafafa;background-image:none;background-repeat:repeat;background-position:top left;background-attachment:scroll;-webkit-font-smoothing:antialiased;-webkit-text-size-adjust:none;'>"
                + "<tr><td style='display:block !important;clear:both !important;margin-top:20px !important;margin-bottom:0 !important;margin-right:auto !important;margin-left:auto !important;max-width:580px !important;'>"
                + "<table style='width:100% !important;border-collapse:collapse;'><tr><td style='font-size: 10px;color:#adadad;text-align:center; padding:5px;'>This is your order confirmation.</td>"
                + "</tr><tr><td align='center' style='padding-top:80px;padding-bottom:80px;padding-right:0;padding-left:0;background-color:#2a333b;color:white;'>"
                + "<h1 style='line-height:1.25;font-size:32px;margin-top:10px !important;margin-bottom:0 !important;margin-right:auto !important;margin-left:auto !important;max-width:90%;'>Order Confirmation #" + Session["orderNo"] + "</h1></td></tr>"
                + "<tr><td style='background-color:white;background-image:none;background-repeat:repeat;background-position:top left;background-attachment:scroll;padding-top:20px;padding-bottom:0;padding-right:20px;padding-left:20px;'>"
                + "<p style='font-size:14px;font-weight:normal;margin-bottom:20px;'>Hello <b>" + name + "</b>,</p><p style='font-size:14px;font-weight:normal;margin-bottom:20px;'>Thank you for your order! A record of your purchase information appears below. Please keep this email as the confirmation of your order.</p>"
                + "<p style='font-size:18px;font-weight:bold;margin-bottom:20px; margin-bottom: 0;'>ORDER INFORMATION</p><p style='font-size:14px; margin-top: 0 !important; font-weight:normal;margin-bottom:20px;'>Order Date: <b>" + DateTime.Now.ToString("dd-MMM-yyyy") + "</b><br>Order ID: <b>" + Session["orderNo"] + "</b><br>Paid with: <b>PayPal</b></p>"
                + "<table style='width: 100%; margin: 0 auto; margin-bottom: 20px;'><tr style='background-color: #2a333b; color: #fff;'><th style='font-size:13px;font-weight:bold;text-align:left;padding: 3px 6px;' width='70%'>Product</th><th style='font-size:13px;font-weight:bold;text-align:right;padding: 3px 6px;' width='30%' align='right'>Price</th></tr>"
                + boughtItems + "</table><table style='width: 40%!important; margin-left: 60%; margin-bottom: 20px;'><tr style='border-top: solid 2px #ccc;'><td style='font-size:13px;font-weight:bold;padding: 0px 6px;vertical-align:top;' align='right'>Total Payment:</td><td style='font-size:13px;font-weight:bold;padding: 0px 6px;vertical-align:top;' align='right'>" + string.Format(Helper.my, "{0:C}", paidCart.GrandTotal) + "</td></tr></table>"
                + "<p style='font-size:14px;font-weight:normal;margin-bottom:20px;'>If you have questions about this order, you can simply reply to this email with your questions and we will get back to you shortly with an answer. You can access a printable receipt for all of your transactions in <a href='" + HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Customer/PurchaseHistory.aspx'>your JETS account</a>.</p><p style='font-size:14px;font-weight:normal;margin-bottom:20px;'>Thanks again for your purchase! We appreciate that you've chosen us.</p><p style='font-size:14px;font-weight:normal;margin-bottom:20px;'>Thanks,</p><p style='font-size:14px;font-weight:normal;margin-bottom:20px;'>JETS</p><p style='font-size:14px;font-weight:normal;margin-bottom:20px;'></td></tr></table></td></tr><tr><td  style='display:block !important;clear:both !important;margin-top:20px !important;margin-bottom:0 !important;margin-right:auto !important;margin-left:auto !important;max-width:580px !important;'><table style='width:100% !important;border-collapse:collapse;'><tr><td align='center' style='background-color:#efefef;background-image:none;background-repeat:repeat;background-position:top left;background-attachment:scroll;padding-top:20px;padding-bottom:0;padding-right:20px;padding-left:20px;'><p style='font-size:14px;font-weight:normal;margin-bottom:20px;'>You were sent this email because you are a customer of <a href='" + HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Landing.aspx'>JETSGallery.com</a></p></td></tr></table></td></tr></table></body></html>";
            return body;
        }

        private string getEmail()
        {
            string sql = "SELECT custEmail FROM Customer WHERE custID = @custID";
            string email = "";
            using(SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();

                try
                {
                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlParameter custID = new SqlParameter("@custID", Session["customerID"]);
                    cmd.Parameters.Add(custID);
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        email = dr.GetString(0);
                    }
                    dr.Close();

                }catch (Exception ex) { }
                finally { con.Close(); }
            }

            return email;
        }

        protected void AddToOrderDB()
        {
            string sql = "INSERT INTO Orders(orderID, custID, orderDate, totalPrice, shipName, shipAddress, custPhoneNum) VALUES(@orderID, @custID, @date, @total, @name, @address, @phone)";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                con.Open();

                try
                {
                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter orderID = new SqlParameter("@orderID", String.Format("{0:D6}", Session["orderNo"]));
                    SqlParameter custID = new SqlParameter("@custID", Session["customerID"]);
                    SqlParameter date = new SqlParameter("@date", DateTime.Now.ToString());
                    SqlParameter total = new SqlParameter("@total", myCart.GrandTotal);
                    SqlParameter custName = new SqlParameter("@name", name);
                    SqlParameter custAddress = new SqlParameter("@address", address);
                    SqlParameter custPhone = new SqlParameter("@phone", phoneNum);

                    cmd.Parameters.Add(orderID);
                    cmd.Parameters.Add(custID);
                    cmd.Parameters.Add(date);
                    cmd.Parameters.Add(total);
                    cmd.Parameters.Add(custName);
                    cmd.Parameters.Add(custAddress);
                    cmd.Parameters.Add(custPhone);

                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                    AddToOrderDetailsDB();
                }
            }
        }

        protected void AddToOrderDetailsDB()
        {
            string sql;

            for (int i = 0; i < myCart.Items.Count; i++)
            {
                sql = "INSERT INTO OrderDetails(orderID, imageID, unitPrice, quantity, imageName, imageLocation) VALUES(@orderID, @imageID, @price, @qty, @imgname, @imglocation)";

                using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                {
                    con.Open();

                    try
                    {
                        SqlCommand cmd = new SqlCommand(sql, con);

                        SqlParameter orderID = new SqlParameter("@orderID", String.Format("{0:D6}", Session["orderNo"]));
                        SqlParameter imageID = new SqlParameter("@imageID", myCart.Items[i].imageID);
                        SqlParameter price = new SqlParameter("@price", myCart.Items[i].unitPrice);
                        SqlParameter qty = new SqlParameter("@qty", myCart.Items[i].qty);
                        SqlParameter imgname = new SqlParameter("@imgname", myCart.Items[i].imageName);
                        SqlParameter imglocation = new SqlParameter("@imglocation", myCart.Items[i].imageLocation);
                        //SqlParameter disc = new SqlParameter("@disc", 0.0); //for later when we implement discount feature ;)

                        cmd.Parameters.Add(orderID);
                        cmd.Parameters.Add(imageID);
                        cmd.Parameters.Add(price);
                        cmd.Parameters.Add(qty);
                        cmd.Parameters.Add(imgname);
                        cmd.Parameters.Add(imglocation);
                        //cmd.Parameters.Add(disc);

                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex) { Response.Write(ex.Message); }
                    finally
                    {
                        con.Close();
                    }
                }
            }
        }

        protected void UpdateImageDetailsDB()
        {
            for (int i = 0; i < myCart.Items.Count; i++)
            {
                string sql = "UPDATE ImageDetails SET stockCount = @stockCount WHERE imageID = @imageID";

                using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                {
                    con.Open();

                    try
                    {
                        //check the qty is not more than stockCount

                        int newStockCount = CalculateStock(myCart.Items[i].imageID, Helper.sqlCon) - myCart.Items[i].qty;

                        SqlCommand cmd = new SqlCommand(sql, con);

                        SqlParameter imageID = new SqlParameter("@imageID", myCart.Items[i].imageID);
                        SqlParameter stockCount = new SqlParameter("@stockCount", newStockCount);

                        cmd.Parameters.Add(imageID);
                        cmd.Parameters.Add(stockCount);

                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex) { }
                    finally
                    {
                        con.Close();
                    }
                }
            }
        }

        protected int CalculateStock(int imageID, string sqlCon)
        {
            string sql = "SELECT stockCount FROM ImageDetails, Image WHERE Image.imageID = ImageDetails.imageID AND ImageDetails.imageID = @imageID";
            int stockCount = 0;

            using (SqlConnection con = new SqlConnection(sqlCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlParameter m = new SqlParameter("@imageID", imageID);
                cmd.Parameters.Add(m);

                SqlDataReader dr = cmd.ExecuteReader();

                try
                {
                    while (dr.Read())
                    {
                        stockCount = dr.GetInt32(0);
                    }
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                    dr.Close();
                }
            }

            return stockCount;
        }
    }
}