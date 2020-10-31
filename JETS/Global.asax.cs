using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Management;
using System.Web.Security;
using System.Web.SessionState;

namespace JETS
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            var serverError = Server.GetLastError() as HttpException;

            if (serverError != null)
            {
                if (serverError.GetHttpCode() == 403)
                {
                    Server.ClearError();
                    Server.Transfer("/Errors/403.aspx");
                }
                else if(serverError.GetHttpCode() == 404)
                {
                    Server.ClearError();
                    Server.Transfer("/Errors/404.aspx");
                }
                else
                {
                    Server.ClearError();
                    Server.Transfer("/Errors/httperror.aspx");
                }
            }
        }
    }
}