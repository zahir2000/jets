<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="JETS.Login" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Login - JETS</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/fonts.css" rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/Login.css" />
    <link rel="icon" href="cat.ico" />
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="Global.css" />

      <style>
          body{
            margin:0;
            padding: 0;
            font-family: 'PT Sans';
        }

          .notifications {
                bottom: 10px;
                position: fixed;
                right: 10px;
                z-index: 999999;
                color:white;
                text-align:center;
          }

          .notifications .notification-item {
            background: #dc3545 !important;
            margin-top: 6px;
            max-width: 500px;
            min-width: 300px;
            padding: 10px;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            border-radius: 4px;
        }
          
          .notifications .notification-item .notification-close {
                color: #fff;
                margin: 0 0 0 10px;
                z-index: 1;
            }

          .right {
                float: right!important;
            }

          .notifications p{
              margin-bottom:0;
          }

          .forgot-link{
                display: block;
                position: absolute;
                right: 16px;
                top: 0;
                z-index: 2;
                height: 48px;
                line-height: 48px;
                color: #008ecc;
                font-weight: lighter;
                transition: .3s all ease;
                text-decoration: none !important;
            }

          .forgot-link:hover{
              color: #009ecc;
              transition: .3s all ease;
          }

          .error-message {
                top: -20px;
            }
      </style>

      <script>
          function hideDiv() {
              document.getElementById('notification').setAttribute("class", "notifications animated fadeOut");
          }

          setTimeout(function () {
                  document.getElementById('notification').setAttribute("class", "notifications animated fadeOut");
          }, 3500);

          function checkState($formControl) {
            if ($formControl.val().length > 0) {
                $formControl.addClass('valid');
            } else {
                $formControl.removeClass('valid');
            }
          }


          $(function () {
            $('.jets-control').on('focusout', function(){
                checkState($(this));
            });
        
            //validation for copying/etc
            $('.jets-control').each(function(){
                checkState($(this));
            });
          });

          function validateForm() {
            isInputFieldEmpty();

            if (isInputFieldEmpty() == false) {
                return true;
            }
            else {
                return false;
            }
          }

          function isInputFieldEmpty() {
            var emptyField = 0;
            if (checkEmptyField($('#txtUsername').val(), $('#usernamecheck'), $('#txtUsername')) == true) { emptyField++; }
            if (checkEmptyField($('#txtPassword').val(), $('#passcheck'), $('#txtPassword')) == true) { emptyField++; }

            if (emptyField == 0) {
                return false;
            } else {
                return true;
            }
          }

          function checkEmptyField(fieldVal, errSpan, field){
              if(fieldVal.length == ''){
                    errSpan.show();
                    field.addClass('invalid');
                    errSpan.focus();
                    return true;
              }
              else {
                    errSpan.hide();
                    field.removeClass('invalid');
                    return false;
              }
          }

          $(document).ready(function () {
              $('#txtUsername').keyup(function () {
                checkEmptyField($('#txtUsername').val(), $('#usernamecheck'), $('#txtUsername'));
            });

            $('#txtPassword').keyup(function () {
                checkEmptyField($('#txtPassword').val(), $('#passcheck'), $('#txtPassword'));
            });
          });
      </script>
  </head>

    <body class="body-background">
        <form runat="server" onsubmit="return validateForm()">
            <div class="login">
                <h3 style="margin-bottom: 30px !important;">Login</h3>
                <a href="Landing.aspx"><i class="fa fa-times times-btn pr-3"></i></a>

                <div class="text-center incorrect-message jets-box" id="wronglogin" runat="server" style="display: none;">Incorrect username or password.</div>

                <div class="jets-group">
                    <input type="text" runat="server" class="jets-control" id="txtUsername" onkeypress="return (event.charCode != 32)" style="margin-bottom: 20px !important" />
                    <label for="txtUsername">Username</label>
                    <span class="error-message" id="usernamecheck" runat="server" style="display:none">Please enter your username</span>
                </div>
                <div class="jets-group">
                    <input type="password" runat="server" class="jets-control" id="txtPassword" onkeypress="return (event.charCode != 32)" style="margin-bottom: 16px !important" maxlength="16" />
                    <label for="txtPassword">Password</label>
                    <a class="forgot-link" href="Customer/ResetPassword.aspx">Forgot?</a>
                    <span class="error-message" id="passcheck" runat="server" style="display:none; margin-top: 8px;">Please enter your password</span>
                </div>

                <button id="btnLogin" runat="server" onserverclick="btnSubmit_ServerClick" class="jets-btn" style="margin-top: 10px;">Login</button>
                <div class="text-center registration-login-link">Don't have an account? <a href="Customer/Registration.aspx">Sign up here</a></div>
                <div class="or-text">OR</div>
                <input type="button" id="btnArtistLogin" runat="server" onclick="location.href='Artist/Login.aspx';" class="jets-btn artist-btn" causesvalidation="False" value="Artist Login" />
            </div>
        </form>
    </body>
</html>