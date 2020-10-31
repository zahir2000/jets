using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Artist
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtDescription.Attributes.Add("onblur", "ValidatorOnChange(event);");
            txtImageName.Attributes.Add("onblur", "ValidatorOnChange(event);");
            txtPrice.Attributes.Add("onblur", "ValidatorOnChange(event);");
            txtQty.Attributes.Add("onblur", "ValidatorOnChange(event);");
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

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
                HttpPostedFile imageFile = fuImage.PostedFile;
                string imageName = Path.GetFileName(imageFile.FileName);
                string imageExt = Path.GetExtension(imageName);
                int imageSize = imageFile.ContentLength;

                if (imageExt.ToLower() == ".jpg" || imageExt.ToLower() == ".png" || imageExt.ToLower() == ".jpeg" || imageExt.ToLower() == ".gif")
                {
                    string fileName = newFileName() + imageExt.ToLower();
                    string filePath = Server.MapPath("/Images/" + fileName);

                    string sql = "INSERT INTO Image(imageName, imageDesc, imageType, imagePrice, imageDateUploaded, imageLocation, artistID) VALUES (@name, @desc, @type, @price, @date, @location, @artistID); SELECT CAST(scope_identity() AS int);";

                    int currentID = 0;

                    using (SqlConnection con = new SqlConnection(Helper.sqlCon))
                    {
                        try
                        {
                            SqlCommand cmd = new SqlCommand(sql, con);

                            SqlParameter name = new SqlParameter("@name", txtImageName.Value);
                            SqlParameter desc = new SqlParameter("@desc", txtDescription.Value);
                            SqlParameter prc = new SqlParameter("@price", txtPrice.Value);
                            SqlParameter date = new SqlParameter("@date", DateTime.Now);
                            SqlParameter location = new SqlParameter("@location", fileName);
                            SqlParameter type = new SqlParameter("@type", ddlType.SelectedItem.Value);
                            SqlParameter artistID = new SqlParameter("@artistID", Session["artistID"]);

                            cmd.Parameters.Add(name);
                            cmd.Parameters.Add(desc);
                            cmd.Parameters.Add(prc);
                            cmd.Parameters.Add(date);
                            cmd.Parameters.Add(location);
                            cmd.Parameters.Add(type);
                            cmd.Parameters.Add(artistID);

                            con.Open();

                            fuImage.SaveAs(filePath);

                            SqlDataReader dr = cmd.ExecuteReader();

                            while (dr.Read())
                            {
                                currentID = dr.GetInt32(0);
                            }

                            dr.Close();
                        }
                        catch (Exception ex) { }
                        finally
                        {
                            con.Close();
                            AddImageDetails(currentID);
                        }
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "", "$('.modal').modal();", true);
                        ScriptManager.RegisterStartupScript(this, typeof(Page), "", "setTimeout(function(){window.location.href='/Artist/Gallery.aspx';},3000);", true);
                    }
                }
                else
                {
                    status.InnerHtml = "Please select the product image. <br />Allowed Image Types (<b>.jpg, .png, .jpeg, .gif</b>)";
                    status.Style.Remove("display");
                }
            }catch(Exception ex) { status.InnerHtml = "Max. allowed file size is 4MB"; status.Style.Remove("display"); }
        }

        protected void AddImageDetails(int imageID)
        {
            string sql = "INSERT INTO ImageDetails(imageID, stockCount) VALUES (@imageID, @stockCount)";

            using (SqlConnection con = new SqlConnection(Helper.sqlCon))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(sql, con);

                    SqlParameter id = new SqlParameter("@imageID", imageID);
                    SqlParameter stock = new SqlParameter("@stockCount", txtQty.Value);

                    cmd.Parameters.Add(id);
                    cmd.Parameters.Add(stock);

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
}