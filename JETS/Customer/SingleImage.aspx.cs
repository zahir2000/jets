using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Customer
{
    public partial class SingleImage : System.Web.UI.Page
    {
        CartData myCart;
        RecentData myRecent;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("Gallery.aspx");
            }
            else
            {
                if (Session["myCart"] == null)
                {
                    myCart = new CartData();
                    Session["myCart"] = myCart;
                }
                myCart = (CartData)Session["myCart"];

                if(Session["myRecent"] == null)
                {
                    myRecent = new RecentData();
                    Session["myRecent"] = myRecent;
                }
                myRecent = (RecentData)Session["myRecent"];

                int imageID = Convert.ToInt32(Request.QueryString["id"].ToString());
                string sql = "SELECT imageID, imageName, imageDesc, imageType, imagePrice, imageDateUploaded, imageLocation, "
                    + "concat(artistFName, ' ', artistLName) as artistName FROM Image, Artist WHERE Image.imageID = @imageID AND Artist.artistID = Image.artistID";

                using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlParameter m = new SqlParameter("@imageID", imageID);
                    cmd.Parameters.Add(m);

                    SqlDataReader dr = cmd.ExecuteReader();

                    int cartQty = 0;
                        for (int i = 0; i < myCart.Items.Count; i++)
                        {
                            if (imageID == myCart.Items[i].imageID)
                            {
                                cartQty = myCart.Items[i].qty;
                            }
                        }

                    RangeValidatorQty.MaximumValue = (CheckStock(imageID, Helper.sqlCon) - cartQty).ToString();
                    
                    if(RangeValidatorQty.MaximumValue == "0")
                    {
                        txtQty.Text = "0";
                        btnCart.Enabled = false;
                    }

                    try
                    {
                        while (dr.Read())
                        {
                            lblID.Text = dr.GetInt32(0).ToString();
                            lblName.Text = dr.GetString(1);
                            lblDesc.Text = dr.GetString(2);
                            lblType.Text = dr.GetString(3);
                            lblPrice.Text = "RM" + dr.GetSqlMoney(4).ToString();
                            lblDate.Text = dr.GetDateTime(5).ToShortDateString();
                            img.Src = "/Images/" + dr.GetString(6) + "?" + DateTime.Now.Ticks.ToString();
                            lblArtist.Text = dr.GetString(7);
                        }
                    }
                    catch (Exception ex) { }
                    finally
                    {
                        con.Close();
                        dr.Close();
                    }
                }

                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlParameter m = new SqlParameter("@imageID", imageID);

                    cmd.Parameters.Add(m);
                    dt.Load(cmd.ExecuteReader());
                    con.Close();
                }

                DataRow row = dt.Rows[0];

                myRecent.Insert(new RecentItem(imageID, row["imageName"].ToString(), row["imageLocation"].ToString(), Double.Parse(row["imagePrice"].ToString())));
            }
        }

        protected int CheckStock(int imgID, string sqlCon)
        {
            string sql = "SELECT stockCount FROM ImageDetails, Image WHERE Image.imageID = ImageDetails.imageID AND ImageDetails.imageID = @imageID";
            int stockCount = 0;

            using (SqlConnection con = new SqlConnection(sqlCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlParameter m = new SqlParameter("@imageID", imgID);
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

            if (stockCount > 0)
            {
                lblAvailibility.Text = "In Stock (" + stockCount + ")";
                btnCart.Enabled = true;
                txtQty.Enabled = true;
            }
            else
            {
                btnCart.Enabled = false;
                txtQty.Enabled = false;
                lblAvailibility.Text = "Out of Stock";
                lblAvailibility.CssClass = "stockNo";
            }

            return stockCount;
        }

        protected void btnCart_Click(object sender, EventArgs e)
        {
            if(Convert.ToInt32(txtQty.Text) == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "","alert('Quantity cannot be 0');", true);
            }
            else
            {
                if (Session["myCart"] == null)
                {
                    myCart = new CartData();
                    Session["myCart"] = myCart;
                }
                myCart = (CartData)Session["myCart"];

                string sql = "SELECT * FROM Image, Artist WHERE Image.imageID = @imageID AND Artist.artistID = Image.artistID";

                int imageID = Convert.ToInt32(Request.QueryString["id"].ToString());

                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlParameter m = new SqlParameter("@imageID", imageID);

                    try
                    {
                        cmd.Parameters.Add(m);
                        dt.Load(cmd.ExecuteReader());
                    }
                    catch (Exception ex) { }
                    finally { con.Close(); }
                }

                DataRow row = dt.Rows[0];

                myCart.Insert(new CartItem(imageID, row["imageName"].ToString(), row["imageLocation"].ToString(), verifyQty(), Double.Parse(row["imagePrice"].ToString())));
                Response.Redirect("Cart.aspx");
            }
        }

        protected int verifyQty()
        {
            int qty;

            if (int.TryParse(txtQty.Text, out qty))
            {
                return qty;
            }
            else
            {
                return 1;
            }
        }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            if (CheckWishlistExist())
            {
                lblTest.Text = "Already in Wishlist";
                messageWishlist.Style.Remove("display");
                messageWishlist.Attributes["class"] = "jets-box mt-2 incorrect-message";
            }
            else
            {
                messageWishlist.Style.Remove("display");

                string sql = "INSERT INTO Wishlist(custID, imageID) VALUES (@custID, @imageID)";

                using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                {
                    try
                    {
                        con.Open();

                        SqlCommand cmd = new SqlCommand(sql, con);
                        SqlParameter custID = new SqlParameter("@custID", Session["customerID"]);
                        SqlParameter imageID = new SqlParameter("@imageID", Convert.ToInt32(Request.QueryString["id"].ToString()));

                        cmd.Parameters.Add(custID);
                        cmd.Parameters.Add(imageID);
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

        protected bool CheckWishlistExist()
        {
            string sql = "SELECT * FROM Wishlist WHERE custID = @custID";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlParameter custID = new SqlParameter("@custID", Session["customerID"]);

                    cmd.Parameters.Add(custID);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        if (dr.GetInt32(1) == Convert.ToInt32(Request.QueryString["id"].ToString()))
                        {
                            return true;
                        }
                    }
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                }
            }

            return false;
        }
    }
}