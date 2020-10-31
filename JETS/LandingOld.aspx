<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingOld.aspx.cs" Inherits="JETS.LandingOld" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Landing Page</title>

    <style>
        body, html{
            height: 100%;
            margin: 0;            
            font-family: Arial, Helvetica, sans-serif;
        }

        img {
            height: 100%;
            width: 100%;

            background-position: center center;
            background-repeat: no-repeat;
            background-size: contain;
            background-attachment: fixed;

            filter: blur(8px);
            -webkit-filter: blur(8px);
        }

        .container{
            position: relative;
            text-align: center;
            color: white;
        }

        .text-centered{
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;  
            font-size: 25px;
        }

        .button{
            width: 210px;
            background-color: #555555;
            border: none;
            color: white;
            padding: 14px 28px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 20px;
            cursor:pointer;
            border-radius: 8px;
            margin: 4px 2px;
        }

        .button:hover{
            background: #A9A9A9;
        }

        .auto-style1 {
            position: relative;
            text-align: center;
            color: white;
            left: 0px;
            top: 0px;
            height: 757px;
        }

        .text-block{
            position: absolute;
            background-color: white;
            color: black;
            top: 15%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;   
            padding-left: 10px;
            padding-right: 10px;
            border-radius: 4px;
           
        }

        .text-footer{
            text-align: center;
            position: absolute;
            bottom: 10%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: grey;        
        }

    </style>
 </head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1 container">
            <img src="LandingImages/marbleLP.jpg"/ alt="Marble" >
            <div class="text-block">
                <h1>Art Gallery</h1>
            </div>
            <div class="text-centered">
                <h2>Join Us to<br />Buy or Sell Arts</h2>
                <asp:Button ID="btnRegCust" runat="server" cssClass="button" Text="Join As Customer" PostBackUrl="~/Customer/Registration.aspx"/>
                    &nbsp;<asp:Button ID="btnRegArtist" runat="server" class="button" Text="Join As Artist" PostBackUrl="~/Artist/Registration.aspx" /><br />
                <h2>Or</h2>
                <asp:Button ID="btnLogin" runat="server" cssClass="button" Text="Login" PostBackUrl="~/Login.aspx" />
            </div>
            <div class="text-footer">
                <h5>Art Gallery 2019 &copy is a website developed by unskilled individuals.</h5>
            </div>
        </div>
     </form>
</body>
</html>