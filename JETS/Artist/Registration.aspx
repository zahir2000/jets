<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="JETS.Artist.Registration" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <title>Artist Registration - Art Gallery</title>
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
        <link rel="stylesheet" href="Artist.css" />

    <style>
        body{
            margin:0;
            padding: 0;
            font-family: 'PT Sans';
        }
        </style>

    <script>
        var isPhoneNumValid = false;
        var isEmailValid = false;
        var isPassValid = false;
        var isFieldEmpty = false;
        
        function checkState($formControl) {
            if ($formControl.val().length > 0) {
                $formControl.addClass('valid');
            } else {
                $formControl.removeClass('valid');
            }
        }

        $(function(){
            $('.jets-control').on('focusout', function(){
                checkState($(this));
            });
        
            //validation for copying/etc
            $('.jets-control').each(function(){
                checkState($(this));
            });
        });


        $(document).ready(function () {
            //validation after focus out
            $('#txtFNam').on('focusout', function () {
                checkEmptyField($('#txtFNam').val(), $('#fnamecheck'), $('#txtFNam'));
            });

            $('#txtLNam').on('focusout', function () {
                checkEmptyField($('#txtLNam').val(), $('#lnamecheck'), $('#txtLNam'));
            });

            $('#txtMail').on('focusout', function () {
                validate();
            });

            $('#txtPhoneNum').on('focusout', function () {
                validatePhoneNumber();
            });

            $('#txtUser').on('focusout', function () {
                checkEmptyField($('#txtUser').val(), $('#usernamecheck'), $('#txtUser'));
            });

            $('#txtPass').on('focusout', function () {
                checkEmptyField($('#txtPass').val(), $('#passcheck'), $('#txtPass'));
                //    passwordCheck();
            });


            //FOCUS IN
            $('#txtPass').on('focusin', function () {
                $('#passBubble').show();
            });


            //instant validation while typing
            $('#txtFNam').keyup(function () {
                checkEmptyField($('#txtFNam').val(), $('#fnamecheck'), $('#txtFNam'));
            });

            $('#txtLNam').keyup(function () {
                checkEmptyField($('#txtLNam').val(), $('#lnamecheck'), $('#txtLNam'));
            });

            $('#txtMail').keyup(function () {
                document.getElementById("emailcheck").textContent = 'Please enter a valid email';
                checkEmptyField($('#txtMail').val(), $('#emailcheck'), $('#txtMail'));
            });

            $('#txtPhoneNum').keyup(function () {
                checkEmptyField($('#txtPhoneNum').val(), $('#phonenumcheck'), $('#txtPhoneNum'));
            });

            $('#txtUser').keyup(function () {
                document.getElementById("usernamecheck").textContent = 'Please enter your username';
                checkEmptyField($('#txtUser').val(), $('#usernamecheck'), $('#txtUser'));
            });

            $('#txtPass').keyup(function () {
                checkEmptyField($('#txtPass').val(), $('#passcheck'), $('#txtPass'));
            });

            $('#txtPass').keyup(function () {
                validatePassword();
            });

            //prevent pasting
            $('#txtFNam').bind("paste", function (e) {
                e.preventDefault();
            });

            $('#txtLNam').bind("paste", function (e) {
                e.preventDefault();
            });

            $('#txtPhoneNum').bind("paste", function (e) {
                e.preventDefault();
            });

            $('#txtUser').bind("paste", function (e) {
                e.preventDefault();
            });
        });

        function validateForm() {
            isInputFieldEmpty();
            validatePhoneNumber();
            validate();
            validatePassword();
            

            if (isPhoneNumValid == true && isEmailValid == true && isPassValid == true && isInputFieldEmpty() == false) {
                return true;
            }
            else {
                return false;
            }
        }

        function validatePassword() {
                var pass = $('#txtPass').val();
                var counter = 0;

                if (pass.length < 6 || pass.length > 16) {
                    $('#cond_1').addClass('not-valid-pass');
                    $('#fa_cond_1').removeClass('valid-pass');
                    $('#fa_cond_1').removeClass('fa-circle');
                    counter += 1;
                } else {
                    $('#cond_1').removeClass('not-valid-pass');
                    $('#fa_cond_1').addClass('valid-pass');
                    $('#fa_cond_1').addClass('fa-circle');
                }

                if (checkPasswordComplexity(pass) == false) {
                    $('#cond_2').addClass('not-valid-pass');
                    $('#fa_cond_2').removeClass('valid-pass');
                    $('#fa_cond_2').removeClass('fa-circle');
                    counter += 1;
                } else {
                    $('#cond_2').removeClass('not-valid-pass');
                    $('#fa_cond_2').addClass('valid-pass');
                    $('#fa_cond_2').addClass('fa-circle');
                }

                if (pass.length < 6 || pass.length > 16 || checkPasswordComplexity(pass) == false) {
                    $('#password-correct').hide();
                    $('#password-field').addClass('eye-icon-no-checkmark');
                    $('#passBubble').show();
                } else {
                    $('#password-correct').show();
                    $('#password-field').addClass('eye-icon');
                    $('#password-field').removeClass('eye-icon-no-checkmark');
                    $('#passBubble').hide();
            }

            if (counter == 0) {
                isPassValid = true;
            } else {
                isPassValid = false;
            }
        }

        function isInputFieldEmpty() {
            var emptyField = 0;
            if (checkEmptyField($('#txtFNam').val(), $('#fnamecheck'), $('#txtFNam')) == true) { emptyField++; }
            if (checkEmptyField($('#txtLNam').val(), $('#lnamecheck'), $('#txtLNam')) == true) { emptyField++; }
            if (checkEmptyField($('#txtMail').val(), $('#emailcheck'), $('#txtMail')) == true) { emptyField++; }
            if (checkEmptyField($('#txtPhoneNum').val(), $('#phonenumcheck'), $('#txtPhoneNum')) == true) { emptyField++; }
            if (checkEmptyField($('#txtUser').val(), $('#usernamecheck'), $('#txtUser')) == true) { emptyField++; }
            if (checkEmptyField($('#txtPass').val(), $('#passcheck'), $('#txtPass')) == true) { emptyField++; }

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

        function checkPasswordComplexity(pass) {
            var letter = /[a-zA-Z]/; 
            var number = /[0-9]/;
            var valid = number.test(pass) && letter.test(pass);
            return valid;
        }

        function validateEmail(email) {
          var re = /^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$/;
          return re.test(email);
        }

        function validatePhoneNumber() {
            var num = $("#txtPhoneNum").val();
            var regNum = /^(\+601|01)[0-46-9]{7,9}$/;
            if (regNum.test(num) == false) {
                $('#phonenumcheck').show();
                $('#txtPhoneNum').addClass('invalid');
                var eg = "Eg: +60109993610 or 0109993610";
                document.getElementById("phonenumcheck").textContent = 'Please enter a valid phone number \r\n' + eg;
                isPhoneNumValid = false;
            } else {
                $('#phonenumcheck').hide();
                $('#txtPhoneNum').removeClass('invalid');
                isPhoneNumValid = true;
            }
        }

        function validate() {
          var email = $("#txtMail").val();
          if (validateEmail(email) == false) {
                $('#emailcheck').show();
                $('#txtMail').addClass('invalid');
                $('#emailcheck').focus();
                isEmailValid = false;
          } else {
                $('#emailcheck').hide();
                $('#txtMail').removeClass('invalid');
                isEmailValid = true;
          }
          return false;
        }

        function viewPassword()
        {
          var passwordInput = document.getElementById('txtPass');
          var passStatus = document.getElementById('password-field');
            var x = document.getElementById("password-correct");

          if (passwordInput.type == 'password'){
              passwordInput.type = 'text';
              
              if (window.getComputedStyle(x).display == "none") {
                  passStatus.className = 'fa fa-fw fa-eye-slash eye-icon-no-checkmark';
              } else {
                  passStatus.className = 'fa fa-fw fa-eye-slash eye-icon';
              }
          }
          else{
              passwordInput.type='password';

              if (window.getComputedStyle(x).display == "none") {
                  passStatus.className = 'fa fa-fw fa-eye eye-icon-no-checkmark';
              } else {
                  passStatus.className='fa fa-fw fa-eye eye-icon';
              }
          }
        }

        function selectUsername()
        {
              document.getElementById("<%=txtUser.ClientID %>").select();
        }

        function selectEmail()
        {
              document.getElementById("<%=txtMail.ClientID %>").select();
        }
    </script>
</head>

<body class="body-background">
    <form runat="server" onsubmit="return validateForm()">

        <div class="modal fade" style="top: 1.8rem" runat="server" id="regModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">        
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body text-center">
                            <h4><i class="fa fa-check text-success"></i></h4>
                            <span style="font-size: 1.3rem;">Registration Successful<br></span>
                            <span class="text-muted" style="font-size: 0.9rem;">  Please wait while we redirect you to login page </span>
                        </div>
                    </div> 
                </div>
            </div>

        <div class="registration">
            <h3>Registration</h3>
            <a href="/Artist/Login.aspx"><i class="fa fa-times times-btn pr-3"></i></a>

            <div class="jets-group">
                <input type="text" runat="server" class="jets-control" id="txtFNam" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 32" />
                <label for="txtFNam">First Name</label>
                <span class="error-message" id="fnamecheck" runat="server" style="display:none">Please enter your first name</span>
            </div>
            <div class="jets-group">
                <input type="text" runat="server" class="jets-control" id="txtLNam" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 32" />
                <label for="txtLNam">Last Name</label>
                <span class="error-message" id="lnamecheck" runat="server" style="display:none">Please enter your last name</span>
            </div>
            <div class="jets-group">
                <input type="email" runat="server" class="jets-control" id="txtMail" onkeypress="return (event.charCode != 32)" />
                <label for="txtMail">Email</label>
                <span class="error-message" id="emailcheck" runat="server" style="display:none">Please enter a valid email</span>
            </div>
            <div class="jets-group">
                <input type="text" runat="server" class="jets-control" id="txtPhoneNum" onkeypress="return (event.charCode != 32)" />
                <label for="txtPhoneNum">Phone Number</label>
                <span class="error-message" id="phonenumcheck" runat="server" style="display:none">Please enter a valid phone number</span>
            </div>
            <hr class="pb-1" />
            <div class="jets-group">
                <input type="text" runat="server" class="jets-control" id="txtUser" onkeypress="return (event.charCode != 32)" />
                <label for="txtUser">Username</label>
                <span class="error-message" id="usernamecheck" runat="server" style="display:none">Please enter your username</span>
            </div>
            <div class="jets-group">
                <input type="password" runat="server" class="jets-control" id="txtPass" onkeypress="return (event.charCode != 32)" />
                <label for="txtPass">Password</label>
                <div class="password-bubble" id="passBubble" runat="server" style="display:none">
                    <div class="password-bubble-content">Password Requirements :</div> 
                    
                    <div id="cond_1" runat="server" class="password-bubble-content not-valid-pass" style="padding-bottom: 0">
                        <i id="fa_cond_1" runat="server" class="fa fa-circle-o"></i> 6-16 Characters only.
                    </div>

                    <div id="cond_2" runat="server" class="password-bubble-content not-valid-pass" style="padding-top: 0">
                        <i id="fa_cond_2" runat="server" class="fa fa-circle-o"></i> Alphanumerical (e.g abcd1234).
                    </div>
                </div>
                <span class="checkmark" id="password-correct" style="display:none"></span>
                <span id="password-field" class="fa fa-fw fa-eye eye-icon-no-checkmark toggle-password" onclick="viewPassword()"></span>
                <span class="error-message" id="passcheck" runat="server" style="display:none">Please enter your password</span>
            </div>
            <button id="btnSubmit" class="jets-artist-btn" runat="server" onserverclick="btnRegister_Click">Register</button>
            <div class="text-center registration-login-link">You have an account? <a href="/Artist/Login.aspx">Login</a></div>
        </div>
    </form>
</body>
</html>