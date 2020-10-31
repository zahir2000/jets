<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Landing.aspx.cs" Inherits="JETS.Landing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Homepage</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <link href=' http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>
        <link href='https://fonts.googleapis.com/css?family=PT+Sans' rel='stylesheet' type='text/css'/>
        <link rel="icon" href="jets.ico" />

    <style>
        #banner {
            position: relative;
            background: #21252e;
            padding: 100px 0 80px;
        }

        .banner-text {
            position: relative;
            font-family:'PT Sans' !important;
        }

        .banner-text h2 {
            color: #008ecc;
            font-size: 55px;
            font-family:'PT Sans' !important;
        }

        .banner-text h3 {
            color: #fff;
            font-size: 30px;
            font-family:'PT Sans' !important;
        }

        .banner-text h4 {
            color: #a5a5a5;
            font-size: 20px;
            font-family:'PT Sans' !important;
        }

        .banner-text p {
            color: #fff;
            font-size: 15px;
            line-height: 25px;
            padding-bottom: 16px;
            padding-top: 10px;
            font-family:'PT Sans' !important;
        }

        .banner-text a {
            color: #fff;
            font-size: 16px;
            background: #008ecc;
            border: 1px solid #008ecc;
            padding: 14px 20px;
            font-family:'PT Sans' !important;
            transition: all linear .3s;
        }

        .a2 {
            color: #fff;
            font-size: 16px;
            background: none !important;
            border: 1px solid #008ecc;
            padding: 14px 20px;
            font-family:'PT Sans' !important;
            transition: all linear .3s;
        }

        .a2:hover {
            background: #008ecc !important;
            color: #fff !important;
        }

        a {
            text-decoration: none;
        }

        a:hover {
            text-decoration: none;
            cursor: pointer;
        }

        .banner-text a:hover {
            background: none;
            color: #008ecc;
        }

        .navbar {
            position: absolute;
            width: 100%;
            z-index: 999999;
            transition: all linear .3s;
            padding-top: 15px;
            background: transparent !important;
        }

        .navbar-light .navbar-brand {
            color: #ffffff;
            font-family: 'PT Sans';
            font-size: 26px;
            transition: all linear .3s;
            position: relative;
            z-index: 1;
        }

        .navbar-brand {
            display: inline-block;
            padding-top: .3125rem;
            padding-bottom: .3125rem;
            margin-right: 1rem;
            font-size: 1.25rem;
            line-height: inherit;
            white-space: nowrap;
        }

        .navbar-light .navbar-brand::after {
            position: absolute;
            content: '';
            top: -35px;
            background: #008ecc;
            width: 78px;
            height: 99px;
            left: -7px;
            z-index: -1;
            transition: all linear .3s;
        }

        .navbar a:hover{
            color:#212529 !important;
            transition: .2s all linear;
        }

        #banner::before {
            position: absolute;
            content: '';
            bottom: -60px;
            left: 0;
            width: 100%;
            height: 369px;
            background: #FF416C;
            background: linear-gradient(to right, #008ecc, #008ecc);
            background: linear-gradient(to left, #008ecc, #008ecc);
            z-index: -1;
        }

        @media (min-width: 768px) {
        .banner-text{
            text-align:center !important;
        }
        }

        .banner-text{
            text-align:center;
        }

        html,body, section{
            height:100%;
            min-height:100%;
        }

        .zigZag {
            position: relative;
            padding: 8px 8px 32px 8px;
        }

        .zigZag:after {
            background: linear-gradient(-45deg, #008ecc 16px, transparent 0), linear-gradient(45deg, #008ecc 16px, transparent 0);
            background-position: left-bottom;
            background-repeat: repeat-x;
            background-size: 32px 32px;
            content: " ";
            display: block;
            position: absolute;
            bottom: 0px;
            left: 0px;
            width: 100%;
            height: 32px;
        }

        .zigZag2 {
            position: relative;
            padding: 8px 8px 32px 8px;
            background: #008ecc;
        }

        .zigZag2:after {
            background: linear-gradient(-45deg, #212529 16px, transparent 0), linear-gradient(45deg, #212529 16px, transparent 0);
            background-position: left-bottom;
            background-repeat: repeat-x;
            background-size: 32px 32px;
            content: " ";
            display: block;
            position: absolute;
            bottom: 0px;
            left: 0px;
            width: 100%;
            height: 32px;
        }

        .a3 {
            color: #fff;
            font-size: 16px;
            background: none !important;
            border: 1px solid #fff;
            padding: 14px 20px;
            font-family:'PT Sans' !important;
            transition: all linear .3s;
        }

        .a3:hover {
            background: #212529 !important;
            color: #fff !important;
        }
    </style>

</head>
<body>
    <form id="landing" runat="server">
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
            <div class="container">
                <a class="navbar-brand" href="Landing.aspx"><b style="margin-left:0.785rem">Jets</b></a>
            </div>    
        </nav>

        <section id="banner">
            <div class="container pb-5">
                <div class="text-center">
                    <div class="zigZag2 pt-5 mt-3"></div>
                    <div class="banner-text pt-5 pt-md-5 pb-5">
                        <h2 class="font-weight-bold">WELCOME</h2>
                        <h3>Jets Art Gallery</h3>
                        <p class="text-muted">JETS is an art gallery website that offers wide range of functions from buying to selling art works.</p>
                        <a href="Login.aspx">Login</a><a class="ml-3 a2" href="Customer/Registration.aspx">Register</a>
                    </div>
                    <div class="zigZag pt-4"></div>
                    <div class="container pb-5" style="background-color: #008ecc">
                        <h3 class="pt-4 text-white">Are you an artist?</h3>
                        <p class="text-white pb-4">We're more than happy to create a platform for our artists to seamlessly sell their artworks.</p>
                        <a href="Artist/Login.aspx" class="a3">Login</a><a class="ml-3 a3" href="Artist/Registration.aspx">Register</a>
                    </div>
                </div>
            </div>
    </section>
        
    </form>
</body>
</html>
