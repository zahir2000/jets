using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JETS.Errors
{
    public partial class error403 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.TrySkipIisCustomErrors = true;
            Response.StatusCode = 403;
            Response.StatusDescription = "Forbidden Access";
        }
    }
}