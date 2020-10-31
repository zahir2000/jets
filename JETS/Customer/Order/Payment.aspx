<%@ Page Title="Payment - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="JETS.Customer.Payment" %>

<asp:Content ID="contentShipping" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <style>
        .btn-order{
                padding:0.7rem 2.345rem 0.7rem 2.345rem;
                border-radius: 0;
        }

        .linkNoDeco a{
            text-decoration: none;
            color: #263238;
            transition: .3s all ease;
        }

        .linkNoDeco a:hover{
            text-decoration: none;
            color: #008ecc;
            transition: .3s all ease;
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
              background-color: #239216 !important;
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
              color: #239216 !important;
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

            .express-checkout-body{
                border: 1px #e6e6e6 solid;
                border-top: 0;
                padding: 0.9em 1.42857em 0.9em;
                position: relative;
                padding-top: 0.5rem;
                padding-bottom: 0.5rem;
            }

            .express-checkout-cart{
                border-bottom: none;
                padding-bottom: 1rem;
            }

            .express-checkout-body-paypal{
                max-width: 300px;
                margin: auto;
                margin-top: 8px;
            }

            .express-checkout{
                margin-bottom: 1rem;
            }

            .or-text {
                margin-bottom: 1rem;
            }  

            .express-checkout-title{
                color: #737373;
                font-size: 1.25rem;
                font-weight: 500;
                margin: 0;
                display: flex;
                width: 100%;
                justify-content: center;
                align-items: flex-end;
                text-align: center;
            }

            .express-checkout-title::before {
                content: '';
                border: 1px #e6e6e6 solid;
                border-bottom: 0;
                height: 0.5em;
                flex: 1 0 2em;
            }

            .express-checkout-title::before {
                border-right: 0;
                margin-right: 1em;
            }

            .express-checkout-title::after {
                border-left: 0;
                margin-left: 1em;
            }

            .express-checkout-title::after {
                content: '';
                border: 1px #e6e6e6 solid;
                border-left: none;
                border-bottom: 0;
                height: 0.5em;
                flex: 1 0 2em;
            }

            .strike {
                display: block;
                text-align: center;
                overflow: hidden;
                white-space: nowrap; 
            }

            .strike > span {
                position: relative;
                display: inline-block;
            }
	
            .strike > span:before,
            .strike > span:after {
                content: "";
                position: absolute;
                top: 50%;
                width: 9999px;
                height: 1px;
                background: #ccc;
            }

            .strike > span:before {
                right: 100%;
                margin-right: 15px;
            }

            .strike > span:after {
                left: 100%;
                margin-left: 15px;
            }

            .express-checkout-body img{
                width: 70px;
                height: 50px;
                border: 1px solid #ccc;
                float: left;
                margin-right: 12px;
            }

            .express-checkout-body-name{
                font-weight:bold;
                color: #333;
                display: block;
            }

            .express-checkout-body-price{
                float:right;
                font-size: 0.9rem;
            }

            .express-checkout-body-qty{
                font-size: 0.9rem !important;
            }

            .express-checkout-footer{
                padding: 0.92857em 1.42857em 0.92857em;
                border: 1px solid #e6e6e6;
            }

            .jets-rdl {
              display: block;
              position: relative;
              padding-left: 35px;
              margin-bottom: 12px;
              cursor: pointer;
              font-size: 22px;
              -webkit-user-select: none;
              -moz-user-select: none;
              -ms-user-select: none;
              user-select: none;
              float: left;
            }

            .jets-rdl input {
              position: absolute;
              opacity: 0;
              cursor: pointer;
            }

            .jets-chk {
              position: absolute;
              top: 0;
              left: 0;
              height: 18px;
              width: 18px;
              background-color: #eee;
              border-radius: 50%;
              box-shadow: 0 0 0 10px #008ecc inset;
              border: none;
            }

            .jets-chk-disabled {
              box-shadow: 0 0 0 10px #6c757d inset;
            }

            .jets-rdl:hover input ~ .jets-chk {
              background-color: #ccc;
            }

            .jets-rdl input:checked ~ .jets-chk {
              background-color: #008ecc;
            }

            .jets-chk:after {
              content: "";
              position: absolute;
              display: none;
            }

            .jets-rdl input:checked ~ .jets-chk:after {
              display: block;
            }

            .jets-rdl .jets-chk:after {
 	            top: 7px;
	            left: 7px;
	            width: 4px;
                height: 4px;
	            border-radius: 50%;
	            background: white;
            }

        .paypal-payment{
            height: 24px !important;
            display: block;
            margin-top: -2px;
            border: 0 !important;
            width: auto !important;
        }

        .card-header{
            background: #fff;
        }

        .next-page-img{
            width: 163px;
            height: 81px;
            background-image: url(../../nextpage.svg);
            background-position: center center;
            background-repeat: no-repeat;
            display: inline-block;
            margin-bottom: 1em;
        }

        .next-page{
            padding: 1.5em;
            text-align: center;
        }

        @media (min-width: 750px){
        .next-page {
            padding-left: 4.5em;
            padding-right: 4.5em;
        }}

        .card-body{
            background: #fafafa;
            text-align: center;
        }

        p {
            margin: 0;
            line-height: 1.5em;
            font-size: 0.9rem;
            color: #545454;
        }

        .back2shopping{
                transition: .2s all ease-in-out;
            }

            .back2shopping:hover{
                color: #263238 !important;
                text-decoration: none !important;
                transition: .2s all ease-in-out;
            }
    </style>

    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                
                <div class="container pt-3">
                        <nav aria-label="breadcrumb">
                          <ol class="breadcrumb bg-light">
                            <li class="breadcrumb-item dark-blue-color linkNoDeco"><a href="/Customer/Gallery.aspx"><i class="fa fa-home"></i></a></li>
                              <li class="breadcrumb-item dark-blue-color linkNoDeco"><a href="/Customer/Cart.aspx">Cart</a></li>
                              <li class="breadcrumb-item dark-blue-color linkNoDeco"><a href="/Customer/Checkout.aspx">Shipping</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Payment</li>
                          </ol>
                        </nav>
                    </div>

                <section id="paymentHeader" runat="server" class="jumbotron text-center bg-white" style="padding-top:30px; padding-bottom:20px">
                    <div class="container">
                        <h1 class="jumbotron-heading"><i class="fa fa-credit-card"></i> Payment</h1>
                    </div>
                </section>

                <div class="checkout-panel container">
                            <div class="panel-body">
                                <div class="progress-bar1">
                                  <a href="/Customer/Cart.aspx" class="step active"><i class="fa fa-check fa-centre-after" style="left: 13px;"></i></a>
                                  <div class="step active"><i class="fa fa-check fa-centre-after" style="left: 13px;"></i></div>
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
                            <h5 class="express-checkout-title" style="color: #2C2E2F;">Payment Method</h5>
                            <div class="express-checkout-body">
                                <div class="container pt-3 pb-3">
                                    <div id="accordion">
                                        <div class="card">
                                            <div class="card-header" data-toggle="collapse" href="#collapseOne" style="cursor: pointer">
                                                <a class="card-link" data-toggle="collapse" href="#collapseOne">
                                                    <label class="jets-rdl">
                                                          <input type="radio" checked="checked" name="radio">
                                                          <span class="jets-chk"></span>
                                                    </label>
                                                    <img src="../../paypal.png" class="paypal-payment" />
                                                </a>
                                            </div>
                                            <div id="collapseOne" class="collapse show" data-parent="#accordion">
                                                <div class="card-body">
                                                        <div class="next-page">
                                                            <i class="next-page-img"></i>
                                                            <p>After clicking “<b>Complete Order</b>”, you will be redirected to PayPal to complete your purchase securely.</p>
                                                        </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card" style="border-top: 0;border-bottom: 0;">
                                            <div class="card-header" data-toggle="collapse" style="cursor: not-allowed">
                                                <a class="card-link" data-toggle="collapse" aria-disabled="true">
                                                    <label class="jets-rdl">
                                                          <input type="radio" name="radio">
                                                          <span class="jets-chk jets-chk-disabled"></span>
                                                    </label>
                                                    <img src="../../amazon.png" class="paypal-payment" /> <span class="text-muted" style="font-size: 0.8rem">Coming Soon</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row justify-content-between">
                                <a class="pl-3 back2shopping mt-3" style="color: #008ecc" href="/Customer/Checkout.aspx">
                                    <label style="cursor: pointer"><i class="fa fa-chevron-left" style="font-size: 0.8rem"></i> Return To Shipping</label>
                                </a>
                                <asp:Button ID="btnCompleteOrder" runat="server" CssClass="btn btn-dark mr-3 btn-order" Text="Complete Order" OnClick="btnCompleteOrder_Click" /> <%--data-toggle="modal" data-target="#orderModal"--%>
                            </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>