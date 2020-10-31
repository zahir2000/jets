<%@ Page Title="Search Results - JETS" Language="C#" MasterPageFile="~/Artist/Artist.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="JETS.Artist.Search" %>

<asp:Content ID="search" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <script>
        function searchTerm(text) {
            document.getElementById('txtSearch').value = text;
        }
    </script>

    <div class="container" id="EmptySearch" runat="server" style="display: none !important;">
        <div class="empty-search">
            <img class="cat-img" src="../cat-cry.png" alt="Cat" />
            <h4 class="pt-1 pb-3">No results found for <span class="text-muted font-italic"><asp:Label ID="lblSearchTerm" runat="server"></asp:Label></span></h4>
            <div class="tips">
                <div style="text-align:left !important; font-weight: bolder;">Some Hints:</div>
                <div>
                    <ul>
                        <li>Make sure all words are spelled correctly.</li>
                        <li>Try different search terms.</li>
                        <li>Try more general search terms.</li>
                        <li>Try fewer search terms.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="container found-result" id="SearchResult" runat="server" style="display: none !important;">
        <h4 class="pt-1 pb-3">Search results for <span class="text-muted font-italic"><asp:Label ID="lblSearchTerm1" runat="server"></asp:Label></span></h4>
    </div>

    <div class="album py-5 bg-white" style="padding-top:0 !important; padding-bottom:0 !important;">
                <div class="container">
                    <div class="row">
                        <asp:ListView ID="imageListView" runat="server" DataSourceID="SqlDataSource1" OnDataBound="imageListView_DataBound">
                            <ItemTemplate>
                                <div class="col-md-3">
                                    <div class="card mb-4 box-shadow">
                                        <div class="imgContainer img-hover-zoom">
                                            <img class="card-img-top" style="height:150px;" src='/Images/<%# DataBinder.Eval(Container.DataItem, "imageLocation") %>' alt="Single Image">
                                            <a href="EditImage.aspx?id=<%#Eval(" imageID ")%>">
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
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Image] WHERE imageName LIKE '%' + @searchTerm + '%' AND Image.artistID = @artistID ORDER BY imageDateUploaded DESC">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="searchTerm" QueryStringField="id" />
                            <asp:SessionParameter Name="artistID" SessionField="artistID" />
                        </SelectParameters>
                        </asp:SqlDataSource>
                </div>
            </div>
            </div>
</asp:Content>