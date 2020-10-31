<%@ Page Title="Artwork - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="SingleImage.aspx.cs" Inherits="JETS.Customer.SingleImage" %>

<asp:Content ID="SingleImage" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <style>
        .qtyTextBox{
            width:17% !important;
            min-width:60px;
            border-radius: 0;
            border: 1px solid rgb(220, 220, 220) !important;
            box-shadow: none !important;
        }

        .qtyTextBox:focus {
            border: 1px solid #333 !important;
            outline: none !important;
        } 

        .jets-btn-cart{
            border-radius: 0 !important;
            font-size: 1rem;
            transition: .3s all ease;
        }

        .jets-btn-cart:hover{
            transition: .3s all ease;
            background: #007ecc !important;
        }

        .jets-btn-wishlist{
            border-radius: 0 !important;
            transition: .3s all ease;
        }

        .jets-img{
            cursor: default;
            border-radius: 0 !important;
            max-height: 400px;
        }
    </style>

    <script>
            function HideLabel() {
                document.getElementById('<%= messageWishlist.ClientID %>').style.display = "none";
            }
            setTimeout("HideLabel();", 3000);

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
    </script>

    <link rel="stylesheet" href="Image.css" type="text/css" runat="server" />

    <div class="container pt-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-light">
            <li class="breadcrumb-item"><a href="Gallery.aspx"><i class="fa fa-home breadcumb-color"></i></a></li>
              <li class="breadcrumb-item breadcumb-color"><a href="Gallery.aspx" class="dark-blue-color">Gallery</a></li>
            <li class="breadcrumb-item active" aria-current="page">Single Product</li>
          </ol>
        </nav>
    </div>
    <div class="container" style="padding-top: 20px;">
        <div class="container col-md-10">
        <div class="row">
            <div class="col-md-6 pt-2" style="text-align: center">
                <input type="image" class="singleImage img-thumbnail jets-img jets-box" id="img" runat="server" causesvalidation="false" disabled="disabled" />
            </div>
            <div class="col-md-6">
                <h2><asp:Label ID="lblName" runat="server"></asp:Label><br /></h2>
                
                <div class="container-fluid text-muted starSize" style="padding:0">
                    <i class="fa fa-star-o"></i>
                    <i class="fa fa-star-o"></i>
                    <i class="fa fa-star-o"></i>
                    <i class="fa fa-star-o"></i>
                    <i class="fa fa-star-o"></i>
                    <a href="#" class="pl-2">0 reviews</a>
                    <a href="#">Write a review</a>
                </div>
                <div class="container">
                    <div class="row hrLine pb-2">
                        <asp:Label ID="lblPrice" runat="server" CssClass="price-new-style2"></asp:Label>
                    </div>
                    <div class="row pt-3">
                        <span class="font-weight-bold">Painting Type:</span><a href="#" id="paintingType" runat="server" class="paintingType"><asp:Label ID="lblType" runat="server"></asp:Label></a>
                    </div>
                    <div class="row pt-2">
                        <span class="font-weight-bold">Painting ID:</span><asp:Label ID="lblID" runat="server" CssClass="paintingID"></asp:Label>
                    </div>
                    <div class="row pt-2 hrLine pb-3">
                        <span class="font-weight-bold">Availibility:</span><asp:Label ID="lblAvailibility" runat="server" CssClass="stockYes"></asp:Label>
                    </div>
                    <div class="row pt-3 pb-2 justify-content-between">
                            <asp:TextBox ID="txtQty" runat="server" TextMode="Number" CssClass="form-control qty qtyTextBox" Text="1"></asp:TextBox>
                            <asp:Button ID="btnCart" runat="server" CssClass="jets-btn-cart btn btn-success addToCartBtn" Text="Add to Cart" OnClick="btnCart_Click" Width="58%"  />
                            <asp:LinkButton runat="server" ID="btnWishlist" class="jets-btn-wishlist btn btn-danger" OnClick="btnWishlist_Click" Width="15%" CausesValidation="False">
	                            <i class="fa fa-heart" aria-hidden="true"></i>
                            </asp:LinkButton>
                    </div>
                </div>
                <div class="jets-box success-message" role="alert" id="messageWishlist" runat="server" style="display:none; margin: 0; margin-bottom: 5px">
                          <asp:Label ID="lblTest" runat="server" Text="Added to Wishlist"></asp:Label>
                </div>
                <div class="text-left">
                    <asp:RangeValidator ID="RangeValidatorQty" Width="100%" runat="server" CssClass="incorrect-message jets-box mb-0" ErrorMessage="Please enter within quantity range" ControlToValidate="txtQty" Type="Integer" MinimumValue="0"></asp:RangeValidator>
                </div>
            </div> 
        </div> 
            <div class="row hrLine pt-4">
                <h5 style="color: #008ecc">Description</h5>
            </div>
            <div class="row pt-1 pb-3">
                <asp:Label ID="lblDesc" runat="server"></asp:Label><br />         
            </div>
            <div class="row">
                <span class="font-weight-bold">Artist: </span><asp:Label ID="lblArtist" runat="server" Text="Artist Name" CssClass="fieldPadding"></asp:Label>
            </div>
            <div class="row hrLine pb-3">
                <span class="font-weight-bold">Date Uploaded: </span><asp:Label ID="lblDate" CssClass="fieldPadding" runat="server"></asp:Label>
            </div>
            <div class="row hrLine pt-5" style="padding-top:60px !important;">
                <h5 style="color: #008ecc">Leave a Review</h5>
            </div>
            <div class="row pt-3">
                <div class="jets-group" style="width: 100%">  
                    <input type="text" runat="server" class="jets-control fname" id="txtName" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 32" style="margin-bottom: 20px !important" />
                    <label for="txtName">Your Name</label>
                 </div>
            </div>
            <div class="row pt-2">
                <div class="jets-group" style="width: 100%">
                    <textarea runat="server" class="jets-control txtAdd" id="txtReview" style="margin-bottom: 0" />
                    <label for="txtReview">Your Review</label>
                </div>
            </div>
            <div class="row pt-1">
                <div class="rate">
                    <input type="radio" id="star5" name="rate" value="5" />
                    <label for="star5" title="5 stars!">5 stars</label>
                    <input type="radio" id="star4" name="rate" value="4" />
                    <label for="star4" title="4 stars">4 stars</label>
                    <input type="radio" id="star3" name="rate" value="3" />
                    <label for="star3" title="3 stars">3 stars</label>
                    <input type="radio" id="star2" name="rate" value="2" />
                    <label for="star2" title="2 stars">2 stars</label>
                    <input type="radio" id="star1" name="rate" value="1" />
                    <label for="star1" title="1 star">1 star</label>
                 </div>
                <div style="margin-left: auto">                
                    <asp:Button ID="btnSubmit" runat="server" causesvalidation="false" CssClass="jets-btn reviewBtn" Text="Submit Review" UseSubmitBehavior="False"></asp:Button>
                </div>
            </div>   
        </div> 
    </div>
</asp:Content>