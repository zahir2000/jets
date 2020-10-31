<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RecentlyViewed.ascx.cs" Inherits="JETS.Customer.RecentlyViewed" %>

<style>
    .newfont{
        font-size: 14px;
    }
</style>

<div class="album py-5 bg-white" style="padding-top:15px !important; padding-bottom:0 !important;" id="recent" runat="server">
                <div class="container" style="padding-top: 25px;">
                    <span style="color: #263238;font-weight: bold;font-size: 1.3rem;">Your Recently Viewed</span>
                    <div class="row" style="padding-top: 5px">
                        <asp:ListView ID="imageListView" runat="server">
                            <ItemTemplate>
                                <div class="col-md-2">
                                    <div class="card mb-4 box-shadow">
                                        <div class="imgContainer img-hover-zoom">
                                            <img class="card-img-top" style="height:110px;" src='/Images/<%# DataBinder.Eval(Container.DataItem, "imageLocation")/*  + "?" + DateTime.Now.Ticks.ToString()*/ %>' alt="Single Image">
                                            <a href="SingleImage.aspx?id=<%#Eval(" imageID ")%>">
                                                <div class="imgOverlay"><span class="imgText"><i class="fa fa-search"></i></span></div>
                                            </a>
                                        </div>
                                        <div class="card-body" style="padding-top:10px !important; text-align: center;">
                                            <div class="product-name" style="font-size:1rem !important; margin: 0">
                                                <a href="SingleImage.aspx?id=<%#Eval(" imageID ")%>" style="font-size: 1rem"><asp:Label ID="lblName" runat="server" Text='<%# Eval("imageName") %>' CssClass="font-weight-bold"></asp:Label></a>
                                            </div>
                                            <div class="price" style="padding-bottom: 0;">
                                                <asp:Label ID="lblPrice" runat="server" Text='<%# String.Format("RM{0:N2}", Eval("unitPrice")) %>' CssClass="price-new-style2 newfont"></asp:Label>
                                            </div>
                                    </div>
                                </div>
                    </div>
                    </ItemTemplate>
                    </asp:ListView>
                        <asp:DataPager ID="Pager" runat="server" PageSize="6" PagedControlID="imageListView"></asp:DataPager>
                </div>
            </div>
            </div>