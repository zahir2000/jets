<%@ Page Title="Profile - JETS" Language="C#" MasterPageFile="~/Artist/Artist.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="Profile.aspx.cs" Inherits="JETS.Artist.Profile" %>

<asp:Content ID="contentProfile" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">

    <link rel="stylesheet" href="../css/animate.css">

    <style>
        .btnStyle{
            padding: .375rem 2.75rem !important;
        }

        .makeMeStrong{
            font-weight:bold;
        }

        .makeMeCentered{
            text-align: left;
            align-items:center;
            margin:auto;
        }

        .hrLine {
            border-bottom: 1px solid #dfdfdf;
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

          .dark-blue-color a {
        color: #263238 !important;
        text-decoration: none !important;
        transition: .2s all ease;
    }

    .dark-blue-color a:hover {
        color: #008ecc !important;
        text-decoration: none !important;
        transition: .2s all ease;
    }

    .inputField {
            border-radius: 0 3px 3px 0;
            box-shadow: inset 0 0 2px rgba(0,0,0,.2) !important;
        }

    .jets-btn{
        height: 40px;
    }

    .error-message{
        top: -20px;
    }

    .error-message-textarea{
        top: -36px !important;
    }

    .compare-msg{
        margin-bottom: 0;
    }

    .req-field{
        color: #8a1919;
        vertical-align: top;
    }

    .second-validation{
        top: -35px;
    }

    .error-message{
        top: -21px;
    }

    .error-message-textarea {
        top: -37px !important;
    }
            </style>

    <script>
        var isPhoneNumValid = false;
        var isEmailValid = false;
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
            $('.fname').on('focusout', function () {
                checkEmptyField($('.fname').val(), $('.fnamecheck'), $('.fname'));
            });

            $('.txtLName').on('focusout', function () {
                checkEmptyField($('.txtLName').val(), $('.lnamecheck'), $('.txtLName'));
            });

            $('.txtMail').on('focusout', function () {
                validate();
            });

            $('.txtPNum').on('focusout', function () {
                validatePhoneNumber();
            });

            $('.txtAdd').on('focusout', function () {
                checkEmptyField($('.txtAdd').val(), $('.addresscheck'), $('.txtAdd'));
            });

            $('.txtCurrent').on('focusout', function () {
                checkEmptyField($('.txtCurrent').val(), $('.passcheck'), $('.txtCurrent'));
            });

            //instant validation while typing
            $('.fname').keyup(function () {
                checkEmptyField($('.fname').val(), $('.fnamecheck'), $('.fname'));
            });

            $('.txtLName').keyup(function () {
                checkEmptyField($('.txtLName').val(), $('.lnamecheck'), $('.txtLName'));
            });

            $('.txtMail').keyup(function () {
                checkEmptyField($('.txtMail').val(), $('.emailcheck'), $('.txtMail'));
            });

            $('.txtPNum').keyup(function () {
                validatePhoneNumber();
            });

            $('.txtAddress').keyup(function () {
                checkEmptyField($('.txtAdd').val(), $('.addresscheck'), $('.txtAdd'));
            });

            //prevent pasting
            $('.fname').bind("paste", function (e) {
                e.preventDefault();
            });

            $('.txtLName').bind("paste", function (e) {
                e.preventDefault();
            });

            $('.txtPNum').bind("paste", function (e) {
                e.preventDefault();
            });
        });

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

        function validateEmail(email) {
          var re = /^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$/;
          return re.test(email);
        }

        function validatePhoneNumber() {
            var num = document.getElementById('<%= txtPNum.ClientID %>').value;
            var regNum = /^(\+601|01)[0-46-9]*[0-9]{7,8}$/;
            if (regNum.test(num) == false) {
                $('.pnumcheck').show();
                $('.txtPNum').addClass('invalid');
                var eg = "Eg: +60109993610 or 0109993610";
                document.getElementById("pnumcheck").textContent = 'Please enter a valid phone number \r\n' + eg;
                isPhoneNumValid = false;
            } else {
                $('.pnumcheck').hide();
                $('.txtPNum').removeClass('invalid');
                isPhoneNumValid = true;
            }
        }

        function validate() {
          var email = $(".txtMail").val();
          if (validateEmail(email) == false) {
                $('.emailcheck').show();
                $('.txtMail').addClass('invalid');
                $('.emailcheck').focus();
                isEmailValid = false;
          } else {
                $('.emailcheck').hide();
                $('.txtMail').removeClass('invalid');
                isEmailValid = true;
          }
          return false;
        }

        function validateForm() {
            isInputFieldEmpty();
            validatePhoneNumber();
            validate();
            

            if (isPhoneNumValid == true && isEmailValid == true && isInputFieldEmpty() == false) {
                return true;
            }
            else {
                return false;
            }
        }

        function isInputFieldEmpty() {
            var emptyField = 0;
            if (checkEmptyField($('.fname').val(), $('.fnamecheck'), $('.fname')) == true) { emptyField++; }
            if (checkEmptyField($('.txtLName').val(), $('.lnamecheck'), $('.txtLName')) == true) { emptyField++; }
            if (checkEmptyField($('.txtMail').val(), $('.emailcheck'), $('.txtMail')) == true) { emptyField++; }
            if (checkEmptyField($('.txtPNum').val(), $('.pnumcheck'), $('.txtPNum')) == true) { emptyField++; }
            if (checkEmptyField($('.txtAdd').val(), $('.addresscheck'), $('.txtAdd')) == true) { emptyField++; }

            if (emptyField == 0) {
                return false;
            } else {
                return true;
            }
        }

        function HideLabel() {
            document.getElementById('<%= wrongrepass.ClientID %>').style.display = "none";
            document.getElementById('<%= personalmsg.ClientID %>').style.display = "none";
                }
                setTimeout("HideLabel();", 3000);
    </script>

    <div class="container pt-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-light">
            <li class="breadcrumb-item dark-blue-color"><a href="Gallery.aspx"><i class="fa fa-home"></i></a></li>
            <li class="breadcrumb-item active" aria-current="page">Profile</li>
          </ol>
        </nav>
    </div>

    <div class="container">
            <section id="headerText" runat="server" class="jumbotron text-center bg-white pb-4" style="padding-top:30px; padding-bottom:20px;">
                <div class="container">
                    <h1 class="jumbotron-heading"><i class="fa fa-user"></i> Profile</h1>
                    <h6 class="text-muted">Tell us who you are! You can modify your personal information here.</h6>
                </div>     
            </section>

        <div class="row justify-content-center">
            <div class="container col-md-8">
                <div class="container pb-4">
                    <div class="row hrLine">
                        <h5 style="color: #cabd80; margin-bottom: 4px !important">Personal Information</h5>
                        <div style="margin-left: auto; padding-right:10px;"><i class="fa fa-question" style="color:#cabd80;" data-toggle="tooltip" title="All Fields are Required"></i></div>
                    </div>
                </div>     
                <div class="text-left success-message jets-box" id="personalmsg" runat="server" style="margin-bottom: 20px; display: none">Your changes have been successfully saved.</div>
                <div class="row">
                    <div class="col-md pb-3 pb-md-0">
                        <div class="jets-group">
                            <input type="text" runat="server" class="jets-control fname" id="txtFName" maxlength="50" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 32" style="margin-bottom: 20px !important" />
                            <label for="txtFName">First Name</label>
                            <asp:RequiredFieldValidator ID="rfvFName" runat="server" CssClass="error-message" ControlToValidate="txtFName" ErrorMessage="Please enter your first name" ForeColor="#CC0000" ValidationGroup="Info" Display="Dynamic"></asp:RequiredFieldValidator>

                            <%--<span class="error-message fnamecheck" id="fnamecheck" runat="server" style="display:none">Please enter your first name</span>--%> 
                        </div>
                    </div>
                    <div class="col-md pb-3 pb-md-0">
                        <div class="jets-group">
                            <input type="text" runat="server" class="jets-control txtLName" id="txtLName" maxlength="50" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 32" style="margin-bottom: 20px !important" />
                            <label for="txtLName">Last Name</label>
                            <asp:RequiredFieldValidator ID="rfvLName" runat="server" CssClass="error-message" ControlToValidate="txtLName" ErrorMessage="Please enter your last name" ForeColor="#CC0000" ValidationGroup="Info" Display="Dynamic"></asp:RequiredFieldValidator>
                            
                            <%--<span class="error-message lnamecheck" id="lnamecheck" runat="server" style="display:none">Please enter your last name</span>--%> 
                        </div>
                    </div>
                </div>
                <div class="row pt-0 pt-md-2">
                    <div class="col-md pb-3 pb-md-0">
                        <div class="jets-group">
                            <input type="text" runat="server" class="jets-control txtPNum" id="txtPNum" onkeypress="return (event.charCode != 32)" style="margin-bottom: 20px !important" />
                            <label for="txtPNum">Phone Number</label>
                            <asp:RequiredFieldValidator ID="rfvNum" runat="server" CssClass="error-message" ControlToValidate="txtPNum" ErrorMessage="Please enter your phone number" ForeColor="#CC0000" ValidationGroup="Info" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revNum" runat="server" CssClass="error-message second-validation" ValidationExpression="^(\+601|01)[0-46-9]*[0-9]{7,8}$" ErrorMessage="Please enter a valid phone number <br />Eg: +60109993610 or 0109993610" ControlToValidate="txtPNum" ForeColor="#CC0000" ValidationGroup="Info" Display="Dynamic"></asp:RegularExpressionValidator>
                            
                            <%--<span class="error-message pnumcheck" id="pnumcheck" runat="server" style="display:none">Please enter a valid phone number <br />Eg: +60109993610 or 0109993610</span>--%> 
                        </div>
                    </div>
                    <div class="col-md pb-3 pb-md-0">
                            <div class="jets-group">
                                <input type="text" runat="server" class="jets-control txtMail" id="txtMail" maxlength="100" onkeypress="return (event.charCode != 32)" style="margin-bottom: 20px !important" />
                                <label for="txtMail">Email</label>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtMail" ErrorMessage="Please enter your email" ForeColor="#CC0000" ValidationGroup="Info" Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ValidationExpression="^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$" ErrorMessage="Please enter a valid email. Eg: yourname@site.com" ControlToValidate="txtMail" ForeColor="#CC0000" ValidationGroup="Info" Display="Dynamic" CssClass="error-message"></asp:RegularExpressionValidator>
                                
                                <%--<span class="error-message emailcheck" id="emailcheck" runat="server" style="display:none">Please enter a valid email</span>--%> 
                            </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row justify-content-end" style="width: 250px; float: right;">
                        <asp:Button runat="server" ID="btnSave" text="Save Changes" CssClass="jets-btn jets-artist-btn" OnClick="btnSave_Click" ValidationGroup="Info"></asp:Button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function(){
                $('[data-toggle="tooltip"]').tooltip();   
            });
        </script>

        <style>
            .pass-validation{
                top: -17px;
            }

            .newpass-validation{
                top: -6px;
            }
        </style>
        
        <div class="row justify-content-center pt-5">
            <div class="container col-md-8">
                <div class="container pb-3">
                    <div class="row hrLine">
                        <h5 style="color: #cabd80; margin-bottom: 4px !important">Password</h5>
                        <div style="margin-left: auto; padding-right:10px;"><i class="fa fa-question" style="color:#cabd80;" data-toggle="tooltip" title="Password must be between 6-16 characters & alphanumerical"></i></div>
                    </div>
                </div>
                <div class="text-left incorrect-message jets-box" id="wrongrepass" runat="server" style="margin-bottom: 15px; display: none">Password should be more than 6 characters & Alphanumeric.</div>
                <div class="row">
                    <div class="col-md">
                        <div class="jets-group">
                            <input type="password" runat="server" class="jets-control txtCurrent" id="txtCurrent" onkeypress="return (event.charCode != 32)" style="margin-bottom: 16px !important;" maxlength="16" />
                            <label for="txtCurrent">Current Password</label>
                            <asp:RequiredFieldValidator ID="rfvCurr" runat="server" CssClass="error-message pass-validation" ControlToValidate="txtCurrent" ErrorMessage="Please enter your password" Display="Dynamic" ValidationGroup="PasswordValidation"></asp:RequiredFieldValidator>
                            
                            <%--<span class="error-message passcheck" id="passcheck" runat="server" style="display:none; margin-top: 8px;">Please enter your password</span>--%>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md pb-3 pb-md-0" style="padding-right: 0">
                        <div class="jets-group">
                            <input type="password" runat="server" class="jets-control" id="txtNew" onkeypress="return (event.charCode != 32)" style="margin-bottom: 5px !important;" maxlength="16" />                 
                            <label for="txtCurrent">New Password</label>
                            <asp:RequiredFieldValidator ID="rvgNew" runat="server" CssClass="error-message newpass-validation" ControlToValidate="txtNew" ErrorMessage="Please enter your new password" Display="Dynamic" ValidationGroup="PasswordValidation" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPass" CssClass="error-message newpass-validation" ErrorMessage="Must be between 6-16 characters & Alphanumeric" runat="server" ControlToValidate="txtNew" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$" ValidationGroup="PasswordValidation" ForeColor="#CC0000" ToolTip="Password must be between 6-16 characters & Alphanumeric" Width="100%" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="jets-group">
                            <input type="password" runat="server" class="jets-control" id="txtReNew" onkeypress="return (event.charCode != 32)" style="margin-bottom: 5px !important;" maxlength="16" />
                            <label for="txtCurrent">Retype New Password<asp:RequiredFieldValidator ID="rfvReNew" runat="server" ControlToValidate="txtReNew" ErrorMessage="*" Display="Dynamic" ValidationGroup="PasswordValidation" ForeColor="#CC0000"></asp:RequiredFieldValidator></label>
                            
                            <asp:CompareValidator ID="cmrNewPass" runat="server" CssClass="error-message newpass-validation" ControlToValidate="txtNew" ControlToCompare="txtReNew" ErrorMessage="Password does not match." Width="100%" ValidationGroup="PasswordValidation" Display="Dynamic"></asp:CompareValidator>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row justify-content-end pt-2" style="width: 250px; float: right;">
                        <asp:Button runat="server" ID="btnSavePass" text="Save Password" CssClass="jets-btn jets-artist-btn" OnClick="btnSavePass_Click" ValidationGroup="PasswordValidation"></asp:Button>
                    </div>
                </div>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="makeMeStrong" Visible="False"></asp:Label>
        </div>
</asp:Content>