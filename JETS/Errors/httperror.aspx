﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="httperror.aspx.cs" Inherits="JETS.Errors.httperror" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forbidden Access - JETS</title>
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
            background: #00b2fd;
            text-align: center;
            font-family: 'PT Sans';
        }

        img{
            width: 100%;
            max-width: 700px;
        }

        body{
            padding-top: 100px;
        }

        .jets-btn{
            width: 20%;
            min-width: 150px;
            height: 40px;
        }

        .btn-403 {
            background: #0097dc;
            color: #ffffff;
            border: 1px solid #DFE5F1;
            margin-right: 10px;
        }

        .btn-403:hover{
            background: #0097dc;
            filter: brightness(1.1);
        }

        .btn-outline-403 {
            background: #ffffff;
            color: #007bae;
            border: 1px solid #0097dc;
        }

        .btn-outline-403:hover{
            background: #DFE5F1;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <img src="../httperror.png" alt="404-cat" />
            <div class="error-btn" style="padding-top: 50px;">
                <input type="button" value="Go Back" class="jets-btn btn-403" onclick="javascript:history.go(-1)" />
                <input type="button" value="Homepage" class="jets-btn btn-outline-403" onclick="location.href='/Landing.aspx';" />
            </div>
        </div>
    </form>
</body>
</html>