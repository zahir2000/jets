<%@ Page Title="Shipping - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="JETS.Customer.Checkout" %>

<asp:Content ID="contentCheckout" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">

        <link rel="stylesheet" href="Checkout.css" />

        <style>
            .hrLine {
                border-bottom: 1px solid #dfdfdf;
            }

            .numberBackground{
                background-color: #fafbfb !important;
            }

            .step.active {
              background-color: #239216;
            }
            .step.active:hover {
              background-color: #1f8313;
              transition: .3s all ease;
            }
            .step.active:link{
                transition: .3s all ease;
            }
            .step.active:after {
              background-color: #239216;
            }
            .step.active:before {
              color: #239216;
            }
            .step.active:hover:before {
              color: #1f8313;
            }

            .step.active + .step {
              background-color: #008ecc;
            }
            .step.active + .step:hover {
              background-color: #007fb7;
              transition: .3s all ease;
            }
            .step.active + .step:hover:before{
              color: #007fb7;
              transition: .3s all ease;
            }
            .step.active + .step:before {
              color: #008ecc;
            }

            .paypal-button-text{
                font-family: 'PT Sans' !important;
            }

            .ddl-color{
                color: #008ecc !important;
            }

            .error-message{
                top: -20px;
            }

            .error-message-textarea {
                top: -6px !important;
            }
        </style>

    <script>
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
    </script>

        <div class="container">
            <div class="row">
                <div class="col-sm-12" id="content">
                    <div class="container pt-3">
                        <nav aria-label="breadcrumb">
                          <ol class="breadcrumb bg-light">
                            <li class="breadcrumb-item dark-blue-color"><a href="Gallery.aspx"><i class="fa fa-home"></i></a></li>
                              <li class="breadcrumb-item dark-blue-color"><a href="Cart.aspx">Cart</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Shipping</li>
                          </ol>
                        </nav>
                    </div>

                    <section id="checkoutHeader" runat="server" class="jumbotron text-center bg-white" style="padding-top:30px; padding-bottom:20px">
                        <div class="container">
                            <h1 class="jumbotron-heading"><i class="fa fa-truck"></i> Shipping</h1>
                        </div>

                        <div class="modal fade" runat="server" id="orderModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
                          <div class="modal-dialog" role="document">
                            <div class="modal-content">
                              <div class="modal-body">
                                  <h2><i class="fa fa-check text-success"></i></h2>
                                <h5>Thank you for your purchase.</h5>
                              </div>
                              <div class="modal-footer">
                                <span class="text-muted">Please wait </span><div class="spinner-border spinner-border-sm text-muted" style="font-size:8px;"></div>
                              </div>
                            </div>
                          </div>
                        </div>
                    </section>

                        <div class="checkout-panel container">
                            <div class="panel-body">
                                <div class="progress-bar1">
                                  <a href="Cart.aspx" class="step active"><i class="fa fa-check fa-centre-after" style="left: 13px;"></i></a>
                                  <div class="step"><i class="fa fa-truck fa-centre-after" style="left: 12px;"></i></div>
                                  <div class="step"><i class="fa fa-money fa-centre-after"></i></div>
                                  <div class="step"><i class="fa fa-thumbs-up fa-centre-after" style="left: 13px;"></i></div>
                                </div>
                            </div>
                        </div>

                    

                    <div class="row">
                        <div class="col-md-4 order-md-2 mb-4">
                           
                            <div class="express-checkout">
                                <h5 class="express-checkout-title text-info">Your Cart</h5>
                                    <asp:Repeater ID="itemRepeater" runat="server" OnItemDataBound="itemRepeater_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="express-checkout-body express-checkout-cart">
                                                <img src='/Images/<%# DataBinder.Eval(Container.DataItem, "imageLocation") %>' alt="Product Image" />
                                                <asp:Label ID="lblProductName" runat="server" CssClass="my-0 h6 express-checkout-body-name" Text='<%# Eval("imageName") %>'></asp:Label>
                                                <span class="express-checkout-body-qty text-muted">Quantity: <asp:Label ID="lblQty" runat="server" Text='<%#Eval("qty")%>'></asp:Label></span>
                                                <asp:Label ID="lblProductPrice" CssClass="text-muted express-checkout-body-price" runat="server" Text='<%# String.Format("RM{0:N2}", Double.Parse(Eval("unitPrice").ToString()) * Int32.Parse(Eval("qty").ToString())) %>'></asp:Label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <div class="express-checkout-footer">
                                        <span class="font-weight-bold" style="font-size: 1.2rem">Total</span>
                                            <span style="float:right"><span class="text-muted align-items-center" style="font-size: 0.78em; color: #717171 !important; vertical-align: 0.2em; margin-right: 0.4em;">MYR</span>
                                            <asp:Label ID="lblTotal" runat="server" CssClass="h4"></asp:Label>
                                        </span>
                                    </div>
                            </div>
                        </div>

                        <div class="col-md-8 order-md-1">
                            <div class="express-checkout">
                            <h5 class="express-checkout-title" style="color: #2C2E2F;">Express Checkout</h5>
                            <div class="express-checkout-body">
                                <div class="express-checkout-body-paypal">                    
                                    <button class="paypal-btn" runat="server" id="btnPaypal" onserverclick="btnPaypal_ServerClick">
                                      <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMzIiIHZpZXdCb3g9IjAgMCAyNCAzMiIgeG1sbnM9Imh0dHA6JiN4MkY7JiN4MkY7d3d3LnczLm9yZyYjeDJGOzIwMDAmI3gyRjtzdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiPjxwYXRoIGZpbGw9IiNmZmZmZmYiIG9wYWNpdHk9IjAuNyIgZD0iTSAyMC43MDIgOS40NDYgQyAyMC45ODIgNy4zNDcgMjAuNzAyIDUuOTQ3IDE5LjU3OCA0LjU0OCBDIDE4LjM2MSAzLjE0OCAxNi4yMDggMi41NDggMTMuNDkzIDIuNTQ4IEwgNS41MzYgMi41NDggQyA0Ljk3NCAyLjU0OCA0LjUwNiAyLjk0OCA0LjQxMiAzLjU0OCBMIDEuMTM2IDI1Ljc0IEMgMS4wNDIgMjYuMjM5IDEuMzIzIDI2LjYzOSAxLjc5MSAyNi42MzkgTCA2Ljc1MyAyNi42MzkgTCA2LjM3OCAyOC45MzggQyA2LjI4NSAyOS4yMzggNi42NTkgMjkuNjM4IDYuOTQgMjkuNjM4IEwgMTEuMTUzIDI5LjYzOCBDIDExLjYyMSAyOS42MzggMTEuOTk1IDI5LjIzOCAxMi4wODkgMjguNzM5IEwgMTIuMTgyIDI4LjUzOSBMIDEyLjkzMSAyMy4zNDEgTCAxMy4wMjUgMjMuMDQxIEMgMTMuMTE5IDIyLjQ0MSAxMy40OTMgMjIuMTQxIDEzLjk2MSAyMi4xNDEgTCAxNC42MTYgMjIuMTQxIEMgMTguNjQyIDIyLjE0MSAyMS43MzEgMjAuMzQyIDIyLjY2OCAxNS40NDMgQyAyMy4wNDIgMTMuMzQ0IDIyLjg1NSAxMS41NDUgMjEuODI1IDEwLjM0NSBDIDIxLjQ1MSAxMC4wNDYgMjEuMDc2IDkuNjQ2IDIwLjcwMiA5LjQ0NiBMIDIwLjcwMiA5LjQ0NiI+PC9wYXRoPjxwYXRoIGZpbGw9IiNmZmZmZmYiIG9wYWNpdHk9IjAuNyIgZD0iTSAyMC43MDIgOS40NDYgQyAyMC45ODIgNy4zNDcgMjAuNzAyIDUuOTQ3IDE5LjU3OCA0LjU0OCBDIDE4LjM2MSAzLjE0OCAxNi4yMDggMi41NDggMTMuNDkzIDIuNTQ4IEwgNS41MzYgMi41NDggQyA0Ljk3NCAyLjU0OCA0LjUwNiAyLjk0OCA0LjQxMiAzLjU0OCBMIDEuMTM2IDI1Ljc0IEMgMS4wNDIgMjYuMjM5IDEuMzIzIDI2LjYzOSAxLjc5MSAyNi42MzkgTCA2Ljc1MyAyNi42MzkgTCA3Ljk3IDE4LjM0MiBMIDcuODc2IDE4LjY0MiBDIDguMDYzIDE4LjA0MyA4LjQzOCAxNy42NDMgOS4wOTMgMTcuNjQzIEwgMTEuNDMzIDE3LjY0MyBDIDE2LjAyMSAxNy42NDMgMTkuNTc4IDE1LjY0MyAyMC42MDggOS45NDYgQyAyMC42MDggOS43NDYgMjAuNjA4IDkuNTQ2IDIwLjcwMiA5LjQ0NiI+PC9wYXRoPjxwYXRoIGZpbGw9IiNmZmZmZmYiIGQ9Ik0gOS4yOCA5LjQ0NiBDIDkuMjggOS4xNDYgOS40NjggOC44NDYgOS44NDIgOC42NDYgQyA5LjkzNiA4LjY0NiAxMC4xMjMgOC41NDYgMTAuMjE2IDguNTQ2IEwgMTYuNDg5IDguNTQ2IEMgMTcuMjM4IDguNTQ2IDE3Ljg5MyA4LjY0NiAxOC41NDggOC43NDYgQyAxOC43MzYgOC43NDYgMTguODI5IDguNzQ2IDE5LjExIDguODQ2IEMgMTkuMjA0IDguOTQ2IDE5LjM5MSA4Ljk0NiAxOS41NzggOS4wNDYgQyAxOS42NzIgOS4wNDYgMTkuNjcyIDkuMDQ2IDE5Ljg1OSA5LjE0NiBDIDIwLjE0IDkuMjQ2IDIwLjQyMSA5LjM0NiAyMC43MDIgOS40NDYgQyAyMC45ODIgNy4zNDcgMjAuNzAyIDUuOTQ3IDE5LjU3OCA0LjY0OCBDIDE4LjM2MSAzLjI0OCAxNi4yMDggMi41NDggMTMuNDkzIDIuNTQ4IEwgNS41MzYgMi41NDggQyA0Ljk3NCAyLjU0OCA0LjUwNiAzLjA0OCA0LjQxMiAzLjU0OCBMIDEuMTM2IDI1Ljc0IEMgMS4wNDIgMjYuMjM5IDEuMzIzIDI2LjYzOSAxLjc5MSAyNi42MzkgTCA2Ljc1MyAyNi42MzkgTCA3Ljk3IDE4LjM0MiBMIDkuMjggOS40NDYgWiI+PC9wYXRoPjxnIHRyYW5zZm9ybT0ibWF0cml4KDAuNDk3NzM3LCAwLCAwLCAwLjUyNjEyLCAxLjEwMTQ0LCAwLjYzODY1NCkiIG9wYWNpdHk9IjAuMiI+PHBhdGggZmlsbD0iIzIzMWYyMCIgZD0iTTM5LjMgMTYuN2MwLjkgMC41IDEuNyAxLjEgMi4zIDEuOCAxIDEuMSAxLjYgMi41IDEuOSA0LjEgMC4zLTMuMi0wLjItNS44LTEuOS03LjgtMC42LTAuNy0xLjMtMS4yLTIuMS0xLjdDMzkuNSAxNC4yIDM5LjUgMTUuNCAzOS4zIDE2Ljd6Ij48L3BhdGg+PHBhdGggZmlsbD0iIzIzMWYyMCIgZD0iTTAuNCA0NS4yTDYuNyA1LjZDNi44IDQuNSA3LjggMy43IDguOSAzLjdoMTZjNS41IDAgOS44IDEuMiAxMi4yIDMuOSAxLjIgMS40IDEuOSAzIDIuMiA0LjggMC40LTMuNi0wLjItNi4xLTIuMi04LjRDMzQuNyAxLjIgMzAuNCAwIDI0LjkgMEg4LjljLTEuMSAwLTIuMSAwLjgtMi4zIDEuOUwwIDQ0LjFDMCA0NC41IDAuMSA0NC45IDAuNCA0NS4yeiI+PC9wYXRoPjxwYXRoIGZpbGw9IiMyMzFmMjAiIGQ9Ik0xMC43IDQ5LjRsLTAuMSAwLjZjLTAuMSAwLjQgMC4xIDAuOCAwLjQgMS4xbDAuMy0xLjdIMTAuN3oiPjwvcGF0aD48L2c+PC9zdmc+" class="paypal-logo">

                                      <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjMyIiB2aWV3Qm94PSIwIDAgMTAwIDMyIiB4bWxucz0iaHR0cDomI3gyRjsmI3gyRjt3d3cudzMub3JnJiN4MkY7MjAwMCYjeDJGO3N2ZyIgcHJlc2VydmVBc3BlY3RSYXRpbz0ieE1pbllNaW4gbWVldCI+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSAxMiA0LjkxNyBMIDQuMiA0LjkxNyBDIDMuNyA0LjkxNyAzLjIgNS4zMTcgMy4xIDUuODE3IEwgMCAyNS44MTcgQyAtMC4xIDI2LjIxNyAwLjIgMjYuNTE3IDAuNiAyNi41MTcgTCA0LjMgMjYuNTE3IEMgNC44IDI2LjUxNyA1LjMgMjYuMTE3IDUuNCAyNS42MTcgTCA2LjIgMjAuMjE3IEMgNi4zIDE5LjcxNyA2LjcgMTkuMzE3IDcuMyAxOS4zMTcgTCA5LjggMTkuMzE3IEMgMTQuOSAxOS4zMTcgMTcuOSAxNi44MTcgMTguNyAxMS45MTcgQyAxOSA5LjgxNyAxOC43IDguMTE3IDE3LjcgNi45MTcgQyAxNi42IDUuNjE3IDE0LjYgNC45MTcgMTIgNC45MTcgWiBNIDEyLjkgMTIuMjE3IEMgMTIuNSAxNS4wMTcgMTAuMyAxNS4wMTcgOC4zIDE1LjAxNyBMIDcuMSAxNS4wMTcgTCA3LjkgOS44MTcgQyA3LjkgOS41MTcgOC4yIDkuMzE3IDguNSA5LjMxNyBMIDkgOS4zMTcgQyAxMC40IDkuMzE3IDExLjcgOS4zMTcgMTIuNCAxMC4xMTcgQyAxMi45IDEwLjUxNyAxMy4xIDExLjIxNyAxMi45IDEyLjIxNyBaIj48L3BhdGg+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSAzNS4yIDEyLjExNyBMIDMxLjUgMTIuMTE3IEMgMzEuMiAxMi4xMTcgMzAuOSAxMi4zMTcgMzAuOSAxMi42MTcgTCAzMC43IDEzLjYxNyBMIDMwLjQgMTMuMjE3IEMgMjkuNiAxMi4wMTcgMjcuOCAxMS42MTcgMjYgMTEuNjE3IEMgMjEuOSAxMS42MTcgMTguNCAxNC43MTcgMTcuNyAxOS4xMTcgQyAxNy4zIDIxLjMxNyAxNy44IDIzLjQxNyAxOS4xIDI0LjgxNyBDIDIwLjIgMjYuMTE3IDIxLjkgMjYuNzE3IDIzLjggMjYuNzE3IEMgMjcuMSAyNi43MTcgMjkgMjQuNjE3IDI5IDI0LjYxNyBMIDI4LjggMjUuNjE3IEMgMjguNyAyNi4wMTcgMjkgMjYuNDE3IDI5LjQgMjYuNDE3IEwgMzIuOCAyNi40MTcgQyAzMy4zIDI2LjQxNyAzMy44IDI2LjAxNyAzMy45IDI1LjUxNyBMIDM1LjkgMTIuNzE3IEMgMzYgMTIuNTE3IDM1LjYgMTIuMTE3IDM1LjIgMTIuMTE3IFogTSAzMC4xIDE5LjMxNyBDIDI5LjcgMjEuNDE3IDI4LjEgMjIuOTE3IDI1LjkgMjIuOTE3IEMgMjQuOCAyMi45MTcgMjQgMjIuNjE3IDIzLjQgMjEuOTE3IEMgMjIuOCAyMS4yMTcgMjIuNiAyMC4zMTcgMjIuOCAxOS4zMTcgQyAyMy4xIDE3LjIxNyAyNC45IDE1LjcxNyAyNyAxNS43MTcgQyAyOC4xIDE1LjcxNyAyOC45IDE2LjExNyAyOS41IDE2LjcxNyBDIDMwIDE3LjQxNyAzMC4yIDE4LjMxNyAzMC4xIDE5LjMxNyBaIj48L3BhdGg+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSA1NS4xIDEyLjExNyBMIDUxLjQgMTIuMTE3IEMgNTEgMTIuMTE3IDUwLjcgMTIuMzE3IDUwLjUgMTIuNjE3IEwgNDUuMyAyMC4yMTcgTCA0My4xIDEyLjkxNyBDIDQzIDEyLjQxNyA0Mi41IDEyLjExNyA0Mi4xIDEyLjExNyBMIDM4LjQgMTIuMTE3IEMgMzggMTIuMTE3IDM3LjYgMTIuNTE3IDM3LjggMTMuMDE3IEwgNDEuOSAyNS4xMTcgTCAzOCAzMC41MTcgQyAzNy43IDMwLjkxNyAzOCAzMS41MTcgMzguNSAzMS41MTcgTCA0Mi4yIDMxLjUxNyBDIDQyLjYgMzEuNTE3IDQyLjkgMzEuMzE3IDQzLjEgMzEuMDE3IEwgNTUuNiAxMy4wMTcgQyA1NS45IDEyLjcxNyA1NS42IDEyLjExNyA1NS4xIDEyLjExNyBaIj48L3BhdGg+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSA2Ny41IDQuOTE3IEwgNTkuNyA0LjkxNyBDIDU5LjIgNC45MTcgNTguNyA1LjMxNyA1OC42IDUuODE3IEwgNTUuNSAyNS43MTcgQyA1NS40IDI2LjExNyA1NS43IDI2LjQxNyA1Ni4xIDI2LjQxNyBMIDYwLjEgMjYuNDE3IEMgNjAuNSAyNi40MTcgNjAuOCAyNi4xMTcgNjAuOCAyNS44MTcgTCA2MS43IDIwLjExNyBDIDYxLjggMTkuNjE3IDYyLjIgMTkuMjE3IDYyLjggMTkuMjE3IEwgNjUuMyAxOS4yMTcgQyA3MC40IDE5LjIxNyA3My40IDE2LjcxNyA3NC4yIDExLjgxNyBDIDc0LjUgOS43MTcgNzQuMiA4LjAxNyA3My4yIDYuODE3IEMgNzIgNS42MTcgNzAuMSA0LjkxNyA2Ny41IDQuOTE3IFogTSA2OC40IDEyLjIxNyBDIDY4IDE1LjAxNyA2NS44IDE1LjAxNyA2My44IDE1LjAxNyBMIDYyLjYgMTUuMDE3IEwgNjMuNCA5LjgxNyBDIDYzLjQgOS41MTcgNjMuNyA5LjMxNyA2NCA5LjMxNyBMIDY0LjUgOS4zMTcgQyA2NS45IDkuMzE3IDY3LjIgOS4zMTcgNjcuOSAxMC4xMTcgQyA2OC40IDEwLjUxNyA2OC41IDExLjIxNyA2OC40IDEyLjIxNyBaIj48L3BhdGg+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSA5MC43IDEyLjExNyBMIDg3IDEyLjExNyBDIDg2LjcgMTIuMTE3IDg2LjQgMTIuMzE3IDg2LjQgMTIuNjE3IEwgODYuMiAxMy42MTcgTCA4NS45IDEzLjIxNyBDIDg1LjEgMTIuMDE3IDgzLjMgMTEuNjE3IDgxLjUgMTEuNjE3IEMgNzcuNCAxMS42MTcgNzMuOSAxNC43MTcgNzMuMiAxOS4xMTcgQyA3Mi44IDIxLjMxNyA3My4zIDIzLjQxNyA3NC42IDI0LjgxNyBDIDc1LjcgMjYuMTE3IDc3LjQgMjYuNzE3IDc5LjMgMjYuNzE3IEMgODIuNiAyNi43MTcgODQuNSAyNC42MTcgODQuNSAyNC42MTcgTCA4NC4zIDI1LjYxNyBDIDg0LjIgMjYuMDE3IDg0LjUgMjYuNDE3IDg0LjkgMjYuNDE3IEwgODguMyAyNi40MTcgQyA4OC44IDI2LjQxNyA4OS4zIDI2LjAxNyA4OS40IDI1LjUxNyBMIDkxLjQgMTIuNzE3IEMgOTEuNCAxMi41MTcgOTEuMSAxMi4xMTcgOTAuNyAxMi4xMTcgWiBNIDg1LjUgMTkuMzE3IEMgODUuMSAyMS40MTcgODMuNSAyMi45MTcgODEuMyAyMi45MTcgQyA4MC4yIDIyLjkxNyA3OS40IDIyLjYxNyA3OC44IDIxLjkxNyBDIDc4LjIgMjEuMjE3IDc4IDIwLjMxNyA3OC4yIDE5LjMxNyBDIDc4LjUgMTcuMjE3IDgwLjMgMTUuNzE3IDgyLjQgMTUuNzE3IEMgODMuNSAxNS43MTcgODQuMyAxNi4xMTcgODQuOSAxNi43MTcgQyA4NS41IDE3LjQxNyA4NS43IDE4LjMxNyA4NS41IDE5LjMxNyBaIj48L3BhdGg+PHBhdGggZmlsbD0iI2ZmZmZmZiIgZD0iTSA5NS4xIDUuNDE3IEwgOTEuOSAyNS43MTcgQyA5MS44IDI2LjExNyA5Mi4xIDI2LjQxNyA5Mi41IDI2LjQxNyBMIDk1LjcgMjYuNDE3IEMgOTYuMiAyNi40MTcgOTYuNyAyNi4wMTcgOTYuOCAyNS41MTcgTCAxMDAgNS42MTcgQyAxMDAuMSA1LjIxNyA5OS44IDQuOTE3IDk5LjQgNC45MTcgTCA5NS44IDQuOTE3IEMgOTUuNCA0LjkxNyA5NS4yIDUuMTE3IDk1LjEgNS40MTcgWiI+PC9wYXRoPjwvc3ZnPg==" class="paypal-logo">
                                      <span class="paypal-button-text"> Checkout</span>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="or-text strike"><span>OR</span></div>

                            <div class="express-checkout">
                                <h5 class="express-checkout-title" style="color: #008ecc">Shipping Address</h5>
                                <div class="express-checkout-body">
                                    <div class="mb-3 pt-3">
                                <asp:DropDownList ID="ddlAddress" runat="server" CssClass="jets-control mb-0 form-control custom-select text-muted ddl-color" AutoPostBack="true" OnSelectedIndexChanged="ddlAddress_SelectedIndexChanged" Height="50px" ForeColor="#008ECC">
                                    <asp:ListItem Text="New Address" Value="New"></asp:ListItem>
                                    <asp:ListItem Text="Default Address" Value="Default"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="row pt-3">
                                <div class="col-md-6 mb-3">
                                    <div class="jets-group">
                                        <input type="text" runat="server" class="jets-control fname" id="txtFNam" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 32" style="margin-bottom: 20px !important" />
                                        <label for="txtFNam">First Name<asp:RequiredFieldValidator ID="rfvFName" ErrorMessage="*" runat="server" ControlToValidate="txtFNam" ForeColor="#CC0000" ValidationGroup="Shipping"></asp:RequiredFieldValidator></label>
                                        <span class="error-message fnamecheck" id="fnamecheck" runat="server" style="display:none">Please enter your first name</span> 
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="jets-group">
                                        <input type="text" runat="server" class="jets-control txtLName" id="txtLNam" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 32" style="margin-bottom: 20px !important" />
                                        <label for="txtFNam">Last Name<asp:RequiredFieldValidator ID="rfvLName" ErrorMessage="*" runat="server" ControlToValidate="txtLNam" ForeColor="#CC0000" ValidationGroup="Shipping"></asp:RequiredFieldValidator></label>
                                        <span class="error-message lnamecheck" id="lnamecheck" runat="server" style="display:none">Please enter your last name</span> 
                                    </div>
                                </div>
                            </div>
         
                            <div class="mb-3">
                                <div class="jets-group">
                                    <input type="text" runat="server" class="jets-control txtPNum" id="txtPNum" onkeypress="return (event.charCode != 32)" style="margin-bottom: 20px !important" />
                                    <label for="txtPNum">Phone Number<asp:RequiredFieldValidator ID="rfvNum" runat="server" ErrorMessage="*" ControlToValidate="txtPNum" ForeColor="#CC0000" ValidationGroup="Shipping"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revNum" runat="server" ValidationExpression="^(\+601|01)[0-46-9]*[0-9]{7,8}$" ControlToValidate="txtPNum" ForeColor="#CC0000" ValidationGroup="Shipping"></asp:RegularExpressionValidator></label>
                                    <span class="error-message pnumcheck" id="pnumcheck" runat="server" style="display:none">Please enter a valid phone number<br />Eg: +60109993610 or 0109993610</span> 
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="jets-group">
                                    <input type="text" runat="server" class="jets-control txtMail" id="txtMail" onkeypress="return (event.charCode != 32)" style="margin-bottom: 20px !important" />
                                    <label for="txtMail">Email<asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="*" ControlToValidate="txtMail" ForeColor="#CC0000" ValidationGroup="Shipping"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ValidationExpression="^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$" ControlToValidate="txtMail" ForeColor="#CC0000" ValidationGroup="Shipping"></asp:RegularExpressionValidator></label>
                                    <span class="error-message emailcheck" id="emailcheck" runat="server" style="display:none">Please enter a valid email</span> 
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="jets-group">
                                    <textarea runat="server" class="jets-control txtAdd mb-0" id="txtAdd" />
                                    <label for="txtAddress">Address<asp:RequiredFieldValidator ID="rfvAdd" runat="server" ControlToValidate="txtAdd" ForeColor="#CC0000" ErrorMessage="*" ValidationGroup="Shipping"></asp:RequiredFieldValidator></label>
                                    <span class="error-message error-message-textarea addresscheck" id="addresscheck" runat="server" style="display:none">Please enter your address</span>
                                </div>
                            </div>
                                </div>
                            </div>
                           
                            <div class="row justify-content-between">
                                <a class="pl-3 back2shopping mt-3" style="color: #008ecc" href="/Customer/Cart.aspx">
                                    <label style="cursor: pointer"><i class="fa fa-chevron-left" style="font-size: 0.8rem"></i> Return To Cart</label>
                                </a>
                                <asp:Button ID="btnOrder" runat="server" CssClass="btn btn-dark mr-3 btn-order " Text="Continue to Payment" OnClick="btnOrder_Click" ValidationGroup="Shipping" /> <%--data-toggle="modal" data-target="#orderModal"--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:Label ID="lblTest" runat="server" Visible="false"></asp:Label>
        </div>

    </asp:Content>