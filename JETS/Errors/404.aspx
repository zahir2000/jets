<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="JETS.Errors.error404" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page Not Found - JETS</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=PT+Sans' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="../Global.css" />
    <link rel="icon" href="../cat.ico" />

    <style>
        html, body{
            background: #F6B416;
            text-align: center;
            font-family: 'PT Sans';
        }

        body{
            padding-top: 150px;
        }

        img{
            width: 100%;
            max-width: 400px;
        }

        .jets-btn{
            width: 20%;
            min-width: 150px;
            height: 40px;
        }

        .btn-404{
            background: #3E2939;
            color: #FAFCF1;
            border: 1px solid #FAFCF1;
            margin-right: 10px;
        }

        .btn-404:hover{
            background: #3E2939;
            filter: brightness(1.1);
        }

        .btn-outline-404{
            background: #FAFCF1;
            color: #3E2939;
            border: 1px solid #3E2939;
            transition: .4s all ease;
        }

        .btn-outline-404:hover{
            background: #3E2939;
            color: #FAFCF1;
            transition: .4s all ease;
        }

        .error-btn{
            padding-top: 45px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container" style="">
            <img src="../cat404.png" alt="404-cat" />
            <div class="error-btn">
                <input type="button" value="Go Back" class="jets-btn btn-404" onclick="javascript:history.go(-1)" />
                <input type="button" value="Homepage" class="jets-btn btn-outline-404" onclick="location.href='/Landing.aspx';" />
            </div>
        </div>
    </form>
</body>
</html>
