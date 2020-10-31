<%@ Page Title="Gallery - JETS" Language="C#" MasterPageFile="~/Artist/Artist.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="Gallery.aspx.cs" Inherits="JETS.Artist.Gallery" %>

<asp:Content ID="contentArtistGallery" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
        <script src="../ArtGallery.js" type="text/javascript"></script>

        <style>
            .editBtn {
                font-size: 80%;
                font-weight: 400;
                text-decoration: none;
            }
            
            .editBtn:hover {
                text-decoration: none;
            }

            .profileLink:hover{
                color:#cc0028;
            }
        </style>

        <main role="main">
            <section class="jumbotron text-center bg-white pb-5" style="padding-top:60px; padding-bottom:20px" id="artistHeader" runat="server">
                <div class="container">
                    <h1 class="jumbotron-heading"><i class="fa fa-upload"></i> My Uploads</h1>
                </div>
            </section>

            <div class="container" id="divSort" runat="server">
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

                        <asp:ListView ID="artistGalleryListView" runat="server" DataSourceID="SqlDataSourceArtistGallery" OnDataBound="artistGalleryListView_DataBound">
                            <ItemTemplate>
                                <div class="col-md-3">
                                    <div class="card mb-4 box-shadow">
                                        <div class="imgContainer img-hover-zoom">
                                            <img class="card-img-top" style="height:150px;" src='/Images/<%# DataBinder.Eval(Container.DataItem, "imageLocation") %>' alt="Artist Images">
                                            <a href="EditImage.aspx?id=<%#Eval(" imageID ")%>">
                                                <div class="imgOverlay"><span class="imgText"><i class="fa fa-edit"></i></span></div>
                                            </a>
                                        </div>
                                        <div class="card-body text-center" style="padding-top:10px !important">
                                            <div class="product-name" style="font-size:20px">
                                                <a href="EditImage.aspx?id=<%#Eval(" imageID ")%>"><asp:Label ID="lblName" runat="server" Text='<%# Eval("imageName") %>' CssClass="font-weight-bold"></asp:Label></a>
                                            </div>
                                            <div class="price text-center">
                                                <asp:Label ID="lblPrice" runat="server" Text='<%# String.Format("RM{0:N2}", Eval("imagePrice")) %>' CssClass="price-new-style2"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <div class="container pt-5 pb-3" id="emptyUploads" runat="server">
                                    <div class="row justify-content-center">
                                        <h1><i class="fa fa-upload text-danger"></i></h1>
                                    </div>
                                    <div class="row justify-content-center">
                                        <h3>Empty Uploads</h3>
                                    </div>
                                    <div class="row justify-content-center">
                                        <h6>Looks like you have not uploaded any artworks.</h6>
                                    </div>
                                    <div class="row justify-content-center">
                                        <h6>Click <a class="text-danger linkNoDeco" href="Upload.aspx">here</a> to start uploading your amazing artworks!</h6>
                                    </div>
                                </div>
                            </EmptyDataTemplate>
                        </asp:ListView>

                        <asp:SqlDataSource ID="SqlDataSourceArtistGallery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * from Image I, Artist A 
WHERE A.artistID = I.artistID AND I.artistID = @artistID
ORDER BY imageDateUploaded DESC">
                            <SelectParameters>
                                <asp:SessionParameter Name="artistID" SessionField="artistID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </div>
            <div class="container bg-secondary pt-2 pb-2 jets-box mb-4" style="background-color:#f8f9fa !important; border-radius:4px;" id="artistPager" runat="server">
                <div class="row justify-content-center">
                    <asp:DataPager ID="Pager" runat="server" PageSize="20" PagedControlID="artistGalleryListView">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="mr-3 btn btn-link noDeco btn-sm" PreviousPageText="&laquo;" />
                            <asp:NumericPagerField NumericButtonCssClass="pagerColor mr-1 ml-1" ButtonCount="4" CurrentPageLabelCssClass="mr-1 ml-1" />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="ml-3 btn btn-link noDeco btn-sm" NextPageText="&raquo;" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
        </main>
    </asp:Content>