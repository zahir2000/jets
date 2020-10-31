using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Artist
{
    public partial class EditImage : System.Web.UI.Page
    {
        int stockCount = 0;
        string image;
        int imageID;
        string oldImageName;

        protected void Page_Load(object sender, EventArgs e)
        {
            imageID = Convert.ToInt32(Request.QueryString["id"].ToString());
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("/Artist/Gallery.aspx");
                }
                else
                {
                    string sql = "SELECT imageName, imageDesc, imageType, imagePrice FROM Image WHERE imageID = @imageID";

                    using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                    {
                        con.Open();

                        SqlCommand cmd = new SqlCommand(sql, con);
                        SqlParameter m = new SqlParameter("@imageID", imageID);
                        cmd.Parameters.Add(m);

                        SqlDataReader dr = cmd.ExecuteReader();

                        CheckStock(imageID, Helper.sqlCon);

                        try
                        {
                            while (dr.Read())
                            {
                                txtImageName.Value = dr.GetString(0);
                                txtDescription.Value = dr.GetString(1);
                                ddlType.Text = dr.GetString(2);
                                txtPrice.Value = dr.GetSqlValue(3).ToString();
                                txtQty.Value = stockCount.ToString();
                            }
                        }
                        catch (Exception ex){ }
                        finally
                        {
                            con.Close();
                            dr.Close();
                        }
                    }

                    txtDescription.Attributes.Add("onblur", "ValidatorOnChange(event);");
                    txtImageName.Attributes.Add("onblur", "ValidatorOnChange(event);");
                    txtPrice.Attributes.Add("onblur", "ValidatorOnChange(event);");
                    txtQty.Attributes.Add("onblur", "ValidatorOnChange(event);");
                }
            }
        }

        public string getImageSource()
        {
            GetOldImage();
            return "/Images/" + oldImageName;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string sqlCon = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string sql = "BEGIN TRANSACTION;" +
                "UPDATE Image SET imageName = @imageName, imageDesc = @imageDesc, imageType = @imageType, imagePrice = @imagePrice WHERE imageID = @imageID;" +
                "UPDATE ImageDetails SET stockCount = @stockCount WHERE imageID = @imageID;" +
                "COMMIT;";
            using (SqlConnection con = new SqlConnection(sqlCon))
            {
                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlParameter imageName = new SqlParameter("@imageName", txtImageName.Value);
                    SqlParameter imageIDSQL = new SqlParameter("@imageID", imageID);
                    SqlParameter imageDesc = new SqlParameter("@imageDesc", txtDescription.Value);
                    SqlParameter imageType = new SqlParameter("@imageType", ddlType.SelectedItem.Value);
                    SqlParameter imagePriceSQL = new SqlParameter("@imagePrice", txtPrice.Value);
                    SqlParameter qtySQL = new SqlParameter("@stockCount", txtQty.Value);

                    cmd.Parameters.Add(imageName);
                    cmd.Parameters.Add(imageIDSQL);
                    cmd.Parameters.Add(imageDesc);
                    cmd.Parameters.Add(imageType);
                    cmd.Parameters.Add(imagePriceSQL);
                    cmd.Parameters.Add(qtySQL);

                    cmd.ExecuteNonQuery();

                    if (fuEditImage.HasFile)
                    {
                        UpdateImage();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "", "$('.modal').modal();", true);
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "", "setTimeout(function(){window.location.href='/Artist/Gallery.aspx';},3000);", true);
                    }
                }
                catch (Exception ex){ }
                finally
                {
                    con.Close();
                }
            }
        }

        protected string newFileName()
        {
            string[] filename = Directory.GetFileSystemEntries(Server.MapPath("/Images/"), "*.*");
            string newImageName = "";
            int j = 0;
            int k = 0;
            int i = 0;

            for (j = 0; j <= k; j++)
            {
                for (i = 0; i < filename.Length; i++)
                {
                    string file = filename[i];
                    file = file.Split('\\').Last();
                    file = file.Split('.').First();
                    newImageName = "image" + (j + 1).ToString("D1");

                    if (newImageName == file)
                    {
                        k++;
                        break;
                    }
                }
            }
            return newImageName;
        }

        public void UpdateImage()
        {
            try
            {
                GetOldImage();
                string fileName = Path.GetFileName(fuEditImage.FileName);
                string fileExtension = Path.GetExtension(fuEditImage.FileName);
                string oldFileName = oldImageName;

                if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".png" || fileExtension.ToLower() == ".jpeg" || fileExtension.ToLower() == ".gif")
                {
                    if (fuEditImage.HasFile)
                    {
                        File.Delete(Server.MapPath("/Images/" + oldFileName));
                        fuEditImage.Dispose();
                        fileName = newFileName() + fileExtension;
                        string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                        SqlConnection con = new SqlConnection(strConnString);
                        string strQuery = "UPDATE Image SET imageLocation = @imageLocation WHERE imageID = @imageID";
                        SqlCommand cmd = new SqlCommand(strQuery);
                        cmd.Parameters.AddWithValue("@imageID", imageID);
                        cmd.Parameters.AddWithValue("@imageLocation", fileName);
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        fuEditImage.PostedFile.SaveAs(Server.MapPath("/Images/" + fileName));
                        fuEditImage.Dispose();
                    }
                    else
                    {
                        fuEditImage.PostedFile.SaveAs(Server.MapPath("/Images/" + oldFileName));
                        fuEditImage.Dispose();
                    }
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "", "$('.modal').modal();", true);
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "", "setTimeout(function(){window.location.href='/Artist/Gallery.aspx';},3000);", true);
                }
                else
                {
                    status.InnerHtml = "Please select the product image. <br />Allowed Image Types (<b>.jpg, .png, .jpeg, .gif</b>)";
                    status.Style.Remove("display");
                }
            }
            
            catch (Exception ex){ }
        }

        public void GetOldImage()
        {
            string sql = "SELECT imageLocation FROM Image WHERE imageID = @imageID";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
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
                        oldImageName = dr.GetString(0);
                    }
                }
                catch (Exception ex) { }
                finally
                {
                    con.Close();
                    dr.Close();
                }
            }
        }

        protected void CheckStock(int imgID, string sqlCon)
        {
            string sql = "SELECT stockCount FROM ImageDetails, Image WHERE Image.imageID = ImageDetails.imageID AND ImageDetails.imageID = @imageID";

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
        }
    }
}