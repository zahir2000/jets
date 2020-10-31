<%@ Page Title="Purchase History - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="PurchaseHistory.aspx.cs" Inherits="JETS.Customer.PurchaseHistory" %>
<%@ Register TagPrefix="Recent" TagName="RecentlyViewed" Src="/Customer/RecentlyViewed.ascx" %>

<asp:Content ID="contentPurchaseHistory" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <link rel="stylesheet" href="Checkout.css" />

    <style>
        .bodySize {
            position: relative;
            min-height: 1px;
            max-width: 450px;
            padding: 0 24px 20px;
            background-color: #fff;
            margin: 0 auto;
            margin-top: 24px;       
            margin-bottom: 8px;
            border-radius: 2px;
            font-family:'PT Sans';
        }

        .items{
            font-size: 1rem;
            font-weight: 300;
            color: #707070;
        }

        .noDeco {
                text-decoration: none;
                color: #008ecc !important;
            }
            
            .noDeco:hover {
                text-decoration: none;
                color: #6c757d !important;
                transition: all linear .3s;
            }
            
            .noDeco:disabled {
                color: #6c757d !important;
            }

    .dark-blue-color {
    color: #263238 !important;
    text-decoration: none !important;
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

    .btn-link{
          text-decoration: none !important;
          color: #eaeaea !important;
          transition: .3s all ease;
          font-weight: bolder !important;
          font-size: 1.1rem !important;
        }

        .btn-link:hover{
          filter: brightness(0.8);
          transition: .3s all ease;
        }

        .card-header{
          background: #263238 !important;
          border-radius: 0 !important;
        }

        .card, .card-body {
          border-radius: 0 !important;
        }

        .coll-btn{
          float: right;
          color: #eaeaea !important;
          font-size: 1.3rem;
        }

        .coll-btn a{
          text-decoration: none !important;
          color: #eaeaea !important;
          transition: .3s all ease;
          display: inline-block;
          vertical-align: middle;
          padding: 0.475rem .0rem;
        }

        .coll-btn a:hover{
          filter: brightness(0.8) !important;
        }

        .order-date{
          padding-left: 7px;
          font-weight: normal !important;
        }

        .name, .address, .tel{
          display: block;
        }

        .personal-info{
          float: left;
          width: 30%;
          margin-bottom: 15px;
        }

        .order-items{  
            float: left;
            width: 70%;
            padding-left: 5%;
            border-left: 1px solid #ccc;
            margin-bottom: 15px;
        }
    </style>

    <script>
        $("[data-collapse-group='myDivs']").click(function () {
            var $this = $(this);
            $("[data-collapse-group='myDivs']:not([data-target='" + $this.data("target") + "'])").each(function () {
                $($(this).data("target")).removeClass("in").addClass('collapse');
            });
        });
    </script>

    <div class="container pt-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-light">
            <li class="breadcrumb-item dark-blue-color"><a href="Gallery.aspx"><i class="fa fa-home"></i></a></li>
            <li class="breadcrumb-item active" aria-current="page">Orders</li>
          </ol>
        </nav>
    </div>

    <div class="container">
        <section class="jumbotron text-center bg-white" style="padding-top:30px; padding-bottom:20px" id="orderHeader" runat="server">
                <div class="container">
                    <h1 class="jumbotron-heading"><i class="fa fa-history"></i> Purchase History</h1>
                </div>
            </section>
        
        <asp:ListView ID="ordersListView" runat="server" DataSourceID="SqlDataSourceOrders" OnDataBound="ordersListView_DataBound">
            <ItemTemplate>
                <div class="accordion" id="accordionOrder" style="box-shadow: 0 2px 16px 0 rgba(0,0,0,0.08);">
                  <div class="card">
                    <div class="card-header" id="headingOne" data-collapse-group="myDivs" data-target="#collapse<%# Eval("orderID") %>" data-toggle="collapse" style="cursor: pointer">
                      <h2 class="mb-0">
                        <button class="btn btn-link" type="button" data-toggle="collapse" data-collapse-group="myDivs" data-target="#collapse<%# Eval("orderID") %>" aria-expanded="true" aria-controls="collapseOne">
                          <span class="">Order No: #<asp:Label ID="lblOrderID" runat="server" Text='<%# String.Format("{0:D6}", Convert.ToInt32(Eval("orderID"))) %>'></asp:Label></span>
                          <span class="order-date"><asp:Label ID="lblDate" runat="server" Text='<%# String.Format("{0:MMM dd, yyyy}", Eval("orderDate")) %>'></asp:Label></span>
                        </button>
                        <div class="coll-btn">
                        <a href="#" data-toggle="collapse" data-collapse-group="myDivs" data-target="#collapse<%# Eval("orderID") %>" aria-controls="collapseOne"><i class="fa fa-chevron-down"></i></a>
                        </div>
                      </h2>
                    </div>

                    <div id="collapse<%# Eval("orderID") %>" class="collapse" aria-labelledby="headingOne" data-parent="#accordionOrder">
                      <div class="card-body">
                        <div class="personal-info">
                          <span class="name"><b>Name:</b> <asp:Label ID="lblName" runat="server" Text='<%# Eval("shipName") %>'></asp:Label></span>
                          <span class="address"><b>Address:</b> <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("shipAddress") %>'></asp:Label></span>
                          <span class="tel"><b>Tel:</b> <asp:Label ID="lblPhoneNum" runat="server" Text='<%# Eval("custPhoneNum") %>'></asp:Label></span>
                        </div>
                          <div></div>
                        <div class="order-items">
                            <asp:Repeater ID="orderRepeater" runat="server" DataSourceID="SqlDataSourceOrderItems">
                                <ItemTemplate>
                                    <div style="position: relative; padding-bottom: 1.42857em;">
                                        <img src='/Images/<%# DataBinder.Eval(Container.DataItem, "imageLocation") %>' alt="Product Image" style="width: 70px;height: 50px;border: 1px solid #ccc;float: left;margin-right: 12px;" />
                                        <asp:Label ID="lblProductName" runat="server" CssClass="my-0 h6 express-checkout-body-name" Text='<%# Eval("imageName") %>'></asp:Label>
                                        <span class="express-checkout-body-qty text-muted">Quantity: <asp:Label ID="lblQty" runat="server" Text='<%#Eval("quantity")%>'></asp:Label></span>
                                        <asp:Label ID="lblProductPrice" CssClass="text-muted express-checkout-body-price" runat="server" Text='<%# String.Format("RM{0:N2}", Double.Parse(Eval("unitPrice").ToString()) * Int32.Parse(Eval("quantity").ToString())) %>'></asp:Label>
                                    </div>    
                                </ItemTemplate>
                            </asp:Repeater>
                            
                            <div class="total-price" style="padding-top: 10px;border-top: 1px solid #eee;">
                                <span style="font-size: 1.1rem;font-weight: bold;text-transform: uppercase;">Total: </span>
                                <span class="items" style="font-size: 1.1rem;float: right;color: #263238;font-weight: bold;"><asp:Label ID="lblPrice" runat="server" Text='<%# String.Format("RM{0:N2}", Eval("totalPrice")) %>'></asp:Label></span>
                            </div>
                            
                            <asp:SqlDataSource ID="SqlDataSourceOrderItems" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [OrderDetails] WHERE ([orderID] = @orderID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblOrderID" Name="orderID" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <div class="container pt-5 pb-3" id="emptyOrder" runat="server">
                        <div class="row justify-content-center">
                            <h1><i class="fa fa-history text-danger"></i></h1>
                        </div>
                        <div class="row justify-content-center">
                            <h3>Empty Purchase History</h3>
                        </div>
                        <div class="row justify-content-center">
                            <h6>Looks like you have no items in your purchase history.</h6>
                        </div>
                        <div class="row justify-content-center">
                            <h6>Click <a class="linkNoDeco text-danger" href="Gallery.aspx">here</a> to shopping.</h6>
                        </div>
                    </div>
            </EmptyDataTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSourceOrders" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Orders] WHERE ([custID] = @custID) ORDER BY orderDate DESC">
            <SelectParameters>
                <asp:SessionParameter Name="custID" SessionField="customerID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div class="container bg-secondary pt-2 pb-2 mt-5 mb-3 jets-box" style="background-color:#f8f9fa !important;" id="orderPagerDiv" runat="server">
                <div class="row justify-content-center">
                    <asp:DataPager ID="ordersPager" runat="server" PagedControlID="ordersListView" PageSize="10">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="mr-3 btn btn-link noDeco btn-sm" PreviousPageText="&laquo;" />
                            <asp:NumericPagerField NumericButtonCssClass="pagerColor mr-1 ml-1 noDeco" ButtonCount="4" CurrentPageLabelCssClass="mr-1 ml-1" />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="ml-3 btn btn-link noDeco btn-sm" NextPageText="&raquo;" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
    </div>
    <Recent:RecentlyViewed ID="recent" runat="server" />
</asp:Content>