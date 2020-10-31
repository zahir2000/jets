<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="JETS.Customer.ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Change Password - JETS</title>

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
        var isPassValid = false;
        var isFieldEmpty = false;

        $(document).ready(function () {
              $('#txtPassword').keyup(function () {
                checkEmptyField($('#txtPassword').val(), $('#passcheck'), $('#txtPassword'));
            });

            $('#txtRePassword').keyup(function () {
                comparePass();
            });
          });

        function comparePass() {
            checkEmptyField($('#txtRePassword').val(), $('#repasscheck'), $('#txtRePassword'));

            var pass = $('#txtPassword').val();
            var repass = $('#txtRePassword').val();

            if (pass != repass) {
                document.getElementById("repasscheck").textContent = 'Retype password does not match';
                $('#repasscheck').show();
                $('#txtRePassword').addClass('invalid');
                $('#repasscheck').focus();
            } else {
                document.getElementById("repasscheck").textContent = 'Please enter your password';
                $('#repasscheck').hide();
                $('#txtRePassword').removeClass('invalid');
            }
        }

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
            validatePassword();
            isInputFieldEmpty();

            if (isInputFieldEmpty() == false && isPassValid == true) {
                return true;
            }
            else {
                return false;
            }
        }

        function isInputFieldEmpty() {
            var emptyField = 0;
            if (checkEmptyField($('#txtPassword').val(), $('#passcheck'), $('#txtPassword')) == true) { emptyField++; }
            if (checkEmptyField($('#txtRePassword').val(), $('#repasscheck'), $('#txtRePassword')) == true) { emptyField++; }

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

        function validatePassword() {
            var pass = $('#txtPassword').val();
            var repass = $('#txtRePassword').val();
                var counter = 0;

            if (pass.length < 6 || pass.length > 16 || checkPasswordComplexity(pass) == false || pass != repass) {
                $('#wronguser').show();
                isPassValid = false
                } else {
                $('#wronguser').hide();
                isPassValid = true
            }
        }

        function checkPasswordComplexity(pass) {
            var letter = /[a-zA-Z]/; 
            var number = /[0-9]/;
            var valid = number.test(pass) && letter.test(pass);
            return valid;
        }
    </script>
</head>
<body class="body-background">
    <form id="form1" runat="server" onsubmit="return validateForm()">
        <div class="login">
                <h3 style="margin-bottom: 30px !important; color: #d86c70;">Reset Password</h3>
                <a href="../Login.aspx"><i class="fa fa-times times-btn pr-3" style="color: #d86c70"></i></a>

                <div class="text-center incorrect-message jets-box" id="wronguser" runat="server" style="display: none;">Password must be between 6-16 characters and Alphanumeric.</div>

                <div class="jets-group">
                    <input type="password" runat="server" class="jets-control" id="txtPassword" onkeypress="return (event.charCode != 32)" style="margin-bottom: 16px !important" maxlength="16" />
                    <label for="txtPassword" id="newpass" runat="server">New Password</label>
                    <span class="error-message" id="passcheck" runat="server" style="display:none; margin-top: 8px;">Please enter your password</span>
                </div>
            <div class="jets-group">
                    <input type="password" runat="server" class="jets-control" id="txtRePassword" onkeypress="return (event.charCode != 32)" style="margin-bottom: 16px !important" maxlength="16" />
                    <label for="txtPassword" id="renewpass" runat="server">Retype New Password</label>
                    <span class="error-message" id="repasscheck" runat="server" style="display:none; margin-top: 8px;">Please enter your password</span>
                </div>

                <button id="btnSave" runat="server" onserverclick="btnSave_ServerClick" class="jets-btn" style="margin-top: 10px; background: #d86c70">Save Password</button>
        </div>
    </form>
</body>
</html>
