<%@ Page Title="Gallery - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="JETS.Customer.Gallery" %>
<%@ Register TagPrefix="Recent" TagName="RecentlyViewed" Src="/Customer/RecentlyViewed.ascx" %>

<asp:Content ID="Gallery" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
        <style>
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
            
            .pagerColor {
                color: #008ecc !important;
                text-decoration: none !important;
            }
            
            .pagerColor:hover {
                color: #6c757d !important;
                transition: all linear .3s;
            }

            .custom-select{
                padding: .375rem 1.75rem .375rem .75rem;;
                margin: 0;
            }

            .small-font{
                font-size: 0.9rem;
            }
        </style>

        <main role="main">
            <section class="jumbotron text-center bg-white pb-5" style="padding-top:60px; padding-bottom:20px">
                <div class="container">
                    <h1 class="jumbotron-heading"><i class="fa fa-image"></i> Gallery</h1>
                </div>
            </section>

            <div class="container">
                <div class="row bg-light jets-box" style="margin:0 !important; padding: .75rem 1rem; margin-bottom: 2rem !important;">
                    <div class="col-md-1 text-left" style="padding-left:0 !important; padding-right:0 !important;">
                        <label for="ddlSorting" class="mt-1" style="padding-left:0 !important; padding-right:0 !important;">Sort By:</label>
                    </div>
                    <div class="col-md-2" style="padding-left:0 !important; padding-right:0 !important;">
                        <asp:DropDownList ID="ddlSorting" runat="server" CssClass="jets-control form-control custom-select" AutoPostBack="True" OnSelectedIndexChanged="ddlSorting_SelectedIndexChanged">
                            <asp:ListItem Selected="true" Value="default">Default</asp:ListItem>
                            <asp:ListItem Value="nameAZ">Name (A - Z)</asp:ListItem>
                            <asp:ListItem Value="nameZA">Name (Z - A)</asp:ListItem>
                            <asp:ListItem Value="priceHL">Price (Low &gt; High)</asp:ListItem>
                            <asp:ListItem Value="priceLH">Price (High &gt; Low)</asp:ListItem>
                            <asp:ListItem Value="dateNO">Date (New - Old)</asp:ListItem>
                            <asp:ListItem Value="dateON">Date (Old - New)</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-7 text-left text-md-right pt-md-0 pt-3" style="padding-left:0 !important;">
                        <label for="ddlSort" class="mt-1" style="padding-left:0 !important; padding-right:0 !important">Show:</label>
                    </div>
                    <div class="col-md-2 pl-md-3 pl-0" style="padding-right:0 !important;">
                        <asp:DropDownList ID="ddlShow" runat="server" CssClass="jets-control form-control custom-select" AutoPostBack="True" OnSelectedIndexChanged="ddlShow_SelectedIndexChanged">
                            <asp:ListItem Selected="true" Value="default">20</asp:ListItem>
                            <asp:ListItem Value="show25">25</asp:ListItem>
                            <asp:ListItem Value="show35">35</asp:ListItem>
                            <asp:ListItem Value="show50">50</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="album py-5 bg-white" style="padding-top:0 !important; padding-bottom:0 !important;">
                <div class="container">
                    <div class="row">
                        <asp:ListView ID="imageListView" runat="server" DataSourceID="SqlDataSource1">
                            <ItemTemplate>
                                <div class="col-md-3">
                                    <div class="card mb-4 box-shadow">
                                        <div class="imgContainer img-hover-zoom">
                                            <img class="card-img-top" style="height:150px;" src='/Images/<%# DataBinder.Eval(Container.DataItem, "imageLocation") %>' alt="Single Image">
                                            <a href="SingleImage.aspx?id=<%#Eval(" imageID ")%>">
                                                <div class="imgOverlay"><span class="imgText"><i class="fa fa-search"></i></span></div>
                                            </a>
                                        </div>
                                        <div class="card-body" style="padding-top: 15px !important;padding-bottom: 15px;">
                                            <div class="product-name" style="font-size:20px;line-height: 0.8;margin-bottom: 0;">
                                                <a href="SingleImage.aspx?id=<%#Eval(" imageID ")%>"><asp:Label ID="lblName" runat="server" Text='<%# Eval("imageName") %>' CssClass="font-weight-bold text-uppercase"></asp:Label></a>
                                            </div>
                                            <p class="m-0 pb-0">
                                                <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("imageDesc") %>' CssClass="card-text" ForeColor="#999999"></asp:Label>
                                            </p>
                                            <hr style="margin: 0.7rem 0;">
                                            <div class="price">
                                                <div class="price-card" style="float: left">
                                                    <asp:Label ID="lblPrice" runat="server" Text='<%# String.Format("RM{0:N2}", Eval("imagePrice")) %>' CssClass="price-new-style2 small-font"></asp:Label>
                                                </div>
                                                <div class="image-type" style="float: right">
                                                    <asp:Label ID="lblType" runat="server" Text='<%# Eval("imageType") %>' CssClass="card-text" ForeColor="#999999"></asp:Label>
                                                </div>
                                            </div>
                                            
                                    </div>
                                </div>
                    </div>
                    </ItemTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Image] ORDER BY imageDateUploaded DESC"></asp:SqlDataSource>
                </div>
            </div>
            </div>
            <div class="container bg-secondary pt-2 pb-2 jets-box mb-4" style="background-color:#f8f9fa !important; border-radius:4px;">
                <div class="row justify-content-center">
                    <asp:DataPager ID="Pager" runat="server" PageSize="20" PagedControlID="imageListView">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="mr-3 btn btn-link noDeco btn-sm" PreviousPageText="&laquo;" />
                            <asp:NumericPagerField NumericButtonCssClass="pagerColor mr-1 ml-1" ButtonCount="4" CurrentPageLabelCssClass="mr-1 ml-1" />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="ml-3 btn btn-link noDeco btn-sm" NextPageText="&raquo;" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
        </main>

    <Recent:RecentlyViewed ID="recentItem" runat="server" />
    </asp:Content>