<%@ Page Title="Wishlist - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="JETS.Customer.Wishlist" %>
<%@ Register TagPrefix="Recent" TagName="RecentlyViewed" Src="/Customer/RecentlyViewed.ascx" %>

<asp:Content ID="contentWishlist" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <style>
        .smallBtn{
            font-size: .7rem !important;
            border-radius: 0;
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
    </style>

    <div class="container pt-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-light">
            <li class="breadcrumb-item dark-blue-color"><a href="Gallery.aspx"><i class="fa fa-home"></i></a></li>
            <li class="breadcrumb-item active" aria-current="page">Wishlist</li>
          </ol>
        </nav>
    </div>

    <section class="jumbotron text-center bg-white pb-5" id="wishlistHeader" runat="server" style="padding-top:30px; padding-bottom:20px">
        <div class="container">
            <h1 class="jumbotron-heading"><i class="fa fa-heart text-danger"></i> Wishlist</h1>
        </div>
    </section>

    <div class="album py-5 bg-white" style="padding-top:0 !important">
        <div class="container">
            <div class="row">
                <asp:ListView ID="wishListView" runat="server" DataSourceID="SqlDataSourceWishList" OnDataBound="wishListView_DataBound">
                    <ItemTemplate>
                        <div class="col-md-3">
                            <div class="card mb-4 box-shadow">
                                <div class="imgContainer img-hover-zoom">
                                    <img class="card-img-top" src='/Images/<%# DataBinder.Eval(Container.DataItem, "imageLocation") %>' alt="Wishlist" style="height: 150px;">
                                    <a href="SingleImage.aspx?id=<%#Eval(" imageID ")%>">
                                        <div class="imgOverlay"><span class="imgText"><i class="fa fa-search"></i></span></div>
                                    </a>
                                </div>
                                <div class="card-body" style="padding-top:10px !important">
                                    <div class="product-name text-center" style="font-size:20px">
                                        <a href="SingleImage.aspx?id=<%#Eval(" imageID ")%>"><asp:Label ID="lblName" runat="server" Text='<%# Eval("imageName") %>' CssClass="font-weight-bold"></asp:Label></a>
                                    </div>
                                    <div class="d-flex justify-content-center align-items-center">
                                        <asp:LinkButton runat="server" ID="btnDelete" class="btn btn-sm btn-outline-danger smallBtn" CommandArgument='<%#Eval("imageID")%>' OnClick="btnDelete_Click">
                                            <i class="fa fa-times" aria-hidden="true"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <div class="container pt-5 pb-3" id="emptyWishlist" runat="server">
                        <div class="row justify-content-center">
                            <h1><i class="fa fa-frown-o text-danger"></i></h1>
                        </div>
                        <div class="row justify-content-center">
                            <h3>Empty WishList</h3>
                        </div>
                        <div class="row justify-content-center">
                            <h6>Looks like you have no items in your wishlist.</h6>
                        </div>
                        <div class="row justify-content-center">
                            <h6>Click <a class="linkNoDeco text-danger" href="Gallery.aspx">here</a> to check our amazing catalog.</h6>
                        </div>
                    </div>
                    </EmptyDataTemplate>
                </asp:ListView>
                <asp:SqlDataSource ID="SqlDataSourceWishList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT I.imageID, imageName, imageLocation FROM Image I, Wishlist W WHERE custID = @custID AND W.imageID = I.imageID">
                    <SelectParameters>
                        <asp:SessionParameter Name="custID" SessionField="customerID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
        <div class="container bg-secondary pt-2 pb-2 jets-box" style="background-color:#f8f9fa !important; border-radius:4px;" id="wishlistPagerDiv" runat="server">
                <div class="row justify-content-center">
                    <asp:DataPager ID="wishListPager" runat="server" PageSize="12" PagedControlID="wishListView">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="mr-3 btn btn-link noDeco btn-sm" PreviousPageText="<" />
                            <asp:NumericPagerField NumericButtonCssClass="pagerColor mr-1 ml-1" ButtonCount="4" CurrentPageLabelCssClass="mr-1 ml-1" />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="ml-3 btn btn-link noDeco btn-sm" NextPageText=">" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
    </div>
    <Recent:RecentlyViewed ID="recent" runat="server" />
</asp:Content>