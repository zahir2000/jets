<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="JETS.Customer.ResetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Reset Password - JETS</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="../js/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <link href="../css/fonts.css" rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="../css/Login.css" />
    <link rel="icon" href="../cat.ico" />
    <link rel="stylesheet" href="../Global.css" />

    <style>
        .jets-control:focus ~ label, .jets-control.valid ~ label{
            color: #d86c70;
        }

        .error-message{
            top: -20px;
        }
    </style>

    <script>
        $(document).ready(function () {
              $('#txtUsername').keyup(function () {
                checkEmptyField($('#txtUsername').val(), $('#usernamecheck'), $('#txtUsername'));
            });
          });

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
    </script>
</head>
<body class="body-background">
    <form id="form1" runat="server" onsubmit="return validateForm()">
        <div class="login">
                <h3 style="margin-bottom: 30px !important; color: #d86c70;">Reset Password</h3>
                <a href="../Login.aspx"><i class="fa fa-times times-btn pr-3" style="color: #d86c70"></i></a>

                <div class="text-center incorrect-message jets-box" id="wronguser" runat="server" style="display: none;">Incorrect username.</div>

                <div class="jets-group">
                    <input type="text" runat="server" class="jets-control" id="txtUsername" onkeypress="return (event.charCode != 32)" style="margin-bottom: 20px !important" />
                    <label for="txtUsername">Your Username</label>
                    <span class="error-message" id="usernamecheck" runat="server" style="display:none">Please enter your username</span>
                </div>

                <button id="btnReset" runat="server" onserverclick="btnReset_ServerClick" class="jets-btn" style="margin-top: 10px; background: #d86c70">Reset</button>
        </div>
    </form>
</body>
</html>
