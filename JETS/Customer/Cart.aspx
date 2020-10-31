<%@ Page Title="Cart - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="JETS.Customer.Cart" %>
<%@ Register TagPrefix="Recent" TagName="RecentlyViewed" Src="/Customer/RecentlyViewed.ascx" %>

<asp:Content ID="Cart" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
        <script src="../ArtGallery.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../css/animate.css">

        <style>
            td {
                vertical-align: middle !important;
            }
            
            .imgMax {
                max-width: 100px;
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
            }

            .dark-blue-color a:hover {
                color: #008ecc !important;
                text-decoration: none !important;
                transition: .2s all ease-in-out;
            }

            .back2shopping:hover{
                color: #263238 !important;
                text-decoration: none !important;
                transition: .2s all ease-in-out;
            }

            .btn-checkout{
                padding:0.7rem 2.345rem 0.7rem 2.345rem;
                border-radius: 0;
            }

            .progress-bar1 {
              display: flex;
              margin-bottom: 50px;
              justify-content: space-between;
            }

            .checkout-panel {
              display: flex;
              flex-direction: column;
              width: 940px;
              margin-left: auto;
              margin-right: auto;
            }

            @media screen and (max-width: 575px) {
                .checkout-panel{
                    width: 100%;
                }
            }

            .step {
              box-sizing: border-box;
              position: relative;
              z-index: -1;
              display: block;
              width: 50px;
              height: 50px;
              margin-bottom: 30px;
              border: 4px solid #fff;
              border-radius: 50%;
              background-color: #d7d7d7;
            }

            .step:after {
              position: absolute;
              z-index: -1;
              top: 19px;
              left: 45px;
              width: 220px;
              height: 6px;
              content: '';
              background-color: #d7d7d7;
            }

            @media screen and (max-width: 992px){
                .step:after {
                  width: 150px !important;
                }
            }

            @media screen and (max-width: 768px) {
                .step:after {
                  width: 90px !important;
                }
            }

            @media screen and (max-width: 565px) {
                .step:after {
                  width: 70px !important;
                }

                .step:nth-child(1):before {
                  display:none !important;
                }
                .step:nth-child(2):before {
                  display:none !important;
                }
                .step:nth-child(3):before {
                  display:none !important;
                }
                .step:nth-child(4):before {
                  display:none !important;
                }
            }

            .step:before {
              color: #777;
              position: absolute;
              top: 43px;
              width: 120px;
            }

            .step:last-child:after {
              content: none;
            }

            .step.active {
              background-color: #008ecc;
            }
            .step.active:hover {
              background-color: #007fb7;
              transition: .3s all ease;
            }

            .step.active:hover:before{
              color: #007fb7;
              transition: .3s all ease;
            }

            .step.active:link:before{
              transition: .3s all ease;
            }

            .step.active:link{
                transition: .3s all ease;
            }

            .step.active:before {
              color: #008ecc;
            }

            .step:nth-child(1):before {
              font-family: FontAwesome, 'PT Sans';
              content: 'Cart';
              left: 7px;
            }

            .step:nth-child(2):before {
              font-family: FontAwesome, 'PT Sans';
              right: -70px;
              content: 'Shipping';
            }
            .step:nth-child(3):before {
              font-family: FontAwesome, 'PT Sans';
              right: -70px;
              content: 'Payment';
            }
            .step:nth-child(4):before {
              font-family: FontAwesome, 'PT Sans';
              right: -55px;
              content: 'Confirmation';
            }

            .panel-body {
              padding: 45px 80px 0;
              flex: 1;
            }

            .fa-centre-after{
                bottom: 12px;
                left: 12px;
                position: absolute;
                color: white;
            }

            .back2shopping{
                transition: .2s all ease-in-out;
                cursor: pointer;
            }
        </style>

        <script>
            function HideLabel() {
                    document.getElementById('<%= status.ClientID %>').style.display = "none";
                }
                setTimeout("HideLabel();", 3000);
        </script>

        <div class="container" style="padding-bottom: 50px">
            <div class="row">
                <div class="col-sm-12" id="content">
                    <div class="container pt-3">
                        <nav aria-label="breadcrumb">
                          <ol class="breadcrumb bg-light">
                            <li class="breadcrumb-item dark-blue-color"><a href="Gallery.aspx"><i class="fa fa-home"></i></a></li>
                            <li class="breadcrumb-item active" aria-current="page">Cart</li>
                          </ol>
                        </nav>
                    </div>

                    <section id="headerText" runat="server" class="jumbotron text-center bg-white pb-5" style="padding-top:30px; padding-bottom:20px !important; display:none">
                        <div class="container">
                            <h1 class="jumbotron-heading"><i class="fa fa-shopping-cart"></i> Cart</h1>
                        </div>
                    </section>

                    <div class="checkout-panel container" id="CheckoutPanel" runat="server" style="display:none">
                            <div class="panel-body">
                                <div class="progress-bar1">
                                  <a href="Cart.aspx" class="step active"><i class="fa fa-shopping-basket fa-centre-after" style="left: 12px;"></i></a>
                                  <div class="step"><i class="fa fa-truck fa-centre-after" style="left: 12px;"></i></div>
                                  <div class="step"><i class="fa fa-money fa-centre-after"></i></div>
                                  <div class="step"><i class="fa fa-thumbs-up fa-centre-after" style="left: 13px;"></i></div>
                                </div>
                            </div>
                        </div>

                    <div class="container pt-5 pb-3" id="emptyCart" runat="server">
                        <div class="row justify-content-center">
                            <asp:Image ID="imgCartEmpty" runat="server" ImageUrl="cart.png" Width="100px" Height="100px" />
                        </div>
                        <div class="row justify-content-center">
                            <h3>Cart is empty</h3>
                        </div>
                        <div class="row justify-content-center">
                            <h6>Looks like you have no items in your shopping cart.</h6>
                        </div>
                        <div class="row justify-content-center">
                            <h6>Click <a class="linkNoDeco text-danger" href="Gallery.aspx">here</a> to continue shopping.</h6>
                        </div>
                    </div>
                    <div class="text-center incorrect-message jets-box" id="status" runat="server" style="margin-bottom: 15px; display: none">Please enter within quantity range.</div>
                    <asp:GridView ID="gvCart" CssClass="table table-bordered table-hover" runat="server" AutoGenerateColumns="False" OnRowDeleting="gvCart_RowDeleting" OnRowCancelingEdit="gvCart_RowCancelingEdit" OnRowEditing="gvCart_RowEditing" OnRowUpdating="gvCart_RowUpdating" OnPreRender="gvCart_PreRender" OnRowDataBound="gvCart_RowDataBound" ShowFooter="True">
                        <Columns>
                            <asp:ImageField DataImageUrlField="imageLocation" DataImageUrlFormatString="/Images/{0}" ReadOnly="True">
                                <ControlStyle Width="100%" CssClass="img-thumbnail" Height="100px" />
                                <ItemStyle CssClass="imgMax" />
                            </asp:ImageField>
                            <asp:BoundField DataField="imageName" HeaderText="PRODUCT NAME" ReadOnly="True" />
                            <asp:BoundField DataField="imageID" HeaderText="ID" ReadOnly="True">
                                <ItemStyle />
                            </asp:BoundField>
                            <asp:BoundField DataField="qty" HeaderText="QUANTITY" NullDisplayText="Error">
                                <HeaderStyle CssClass="text-center" />
                                <ItemStyle CssClass="text-center" />
                                <ControlStyle CssClass="form-control jets-control mb-0" />
                            </asp:BoundField>

                                <asp:TemplateField HeaderText="UNIT PRICE">
                                    <HeaderStyle CssClass="text-right" />
                                    <ItemStyle CssClass="text-right" />
                                    <FooterStyle CssClass="text-right font-weight-bold" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblUnitPrice" runat="server" Text='<%#String.Format("RM{0:N2}", Eval("unitPrice")) %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblGrandTotalText" runat="server" Text="Grand Total: "></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="TOTAL PRICE">
                                    <HeaderStyle CssClass="text-right" />
                                    <ItemStyle CssClass="text-right" />
                                    <FooterStyle CssClass="text-right text-danger font-weight-bold" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalPrice" runat="server" Text='<%# String.Format("RM{0:N2}", Double.Parse(Eval("unitPrice").ToString()) * Int32.Parse(Eval("qty").ToString())) %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblGrandTotal" runat="server" />
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:CommandField ShowEditButton="True" UpdateText="&lt;i class=&quot;fa fa-check&quot;&gt;&lt;/i&gt;" CancelText="&lt;i class=&quot;fa fa-times&quot;&gt;&lt;/i&gt;" EditText="&lt;i class=&quot;fa fa-edit&quot;&gt;&lt;/i&gt;">
                                    <ControlStyle CssClass="btn btn-sm btn-dark"></ControlStyle>
                                    <ItemStyle Width="50px" />
                                </asp:CommandField>

                                <asp:CommandField ShowDeleteButton="True" DeleteText="&lt;i class=&quot;fa fa-times-circle&quot;&gt;&lt;/i&gt;">
                                    <ControlStyle CssClass="btn btn-sm btn-danger"></ControlStyle>
                                    <ItemStyle Width="50px" />
                                </asp:CommandField>
                        </Columns>
                    </asp:GridView>

                    <div class="container pt-3" runat="server" id="cartButtons" style="display:none;">
                        <div class="row justify-content-between">
                            <a class="pl-3 back2shopping mt-3" style="color: #008ecc; cursor: pointer;" href="Gallery.aspx">
                                <label style="cursor: pointer;"><i class="fa fa-chevron-left" style="font-size: 0.8rem"></i> Continue Shopping</label>
                            </a>
                            <asp:Button ID="btnCheckout" runat="server" Text="Check Out" CssClass="btn btn-dark btn-checkout" PostBackUrl="Checkout.aspx" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <Recent:RecentlyViewed ID="recent" runat="server" />
    </asp:Content>