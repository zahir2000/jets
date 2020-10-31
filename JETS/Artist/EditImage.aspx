<%@ Page Title="Edit Artwork - JETS" Language="C#" MasterPageFile="~/Artist/Artist.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="EditImage.aspx.cs" Inherits="JETS.Artist.EditImage" %>

<asp:Content ID="contentEditImage" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <script type="text/javascript">

        function ShowPreview(input) {
            if (input.files && input.files[0] && input.files[0].name.match(/\.(JPG|jpg|JPEG|jpeg|PNG|png|GIF|gif)$/)) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgPreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            } else {
                $('#imgPreview').attr('src', '/noimage.png');
            }
        }

        function checkState($formControl) {
            if ($formControl.val().length > 0) {
                $formControl.addClass('valid');
            } else {
                $formControl.removeClass('valid');
            }
          }


          $(function () {
            $('.jets-control').on('focusout', function(){
                checkState($(this));
            });
        
            //validation for copying/etc
            $('.jets-control').each(function(){
                checkState($(this));
            });
        });

        $(document).ready(function () {
            $('.txtPrice').keyup(function () {
                checkEmptyField($('.txtPrice').val(), $('.pricecheck'), $('.txtPrice'));
            });

            $('.txtQty').keyup(function () {
                checkEmptyField($('.txtQty').val(), $('.qtycheck'), $('.txtQty'));
            });


            $('.txtImageName').on('focusout', function () {
                checkEmptyField($('.txtImageName').val(), $('.namecheck'), $('.txtImageName'));
            });

            $('.txtDescription').on('focusout', function () {
                checkEmptyField($('.txtDescription').val(), $('.desccheck'), $('.txtDescription'));
            });

            $('.txtPrice').on('focusout', function () {
                checkEmptyField($('.txtPrice').val(), $('.pricecheck'), $('.txtPrice'));
            });

            $('.txtQty').on('focusout', function () {
                checkEmptyField($('.txtQty').val(), $('.qtycheck'), $('.txtQty'));
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
    </script>

    <style>
        .cpb-4{
            padding-bottom: 1.5rem!important;
        }

        .cmb-1{
            padding-bottom: 0.3rem!important;
        }

        .jets-control ~ label{
                line-height: 1.1em !important;
          }

        .jets-control:focus ~ label, .jets-control.valid ~ label{
            line-height: 1.2em !important;
        }

        .error-message-top{
            top: -5px;
        }

        .error-message-top2{
            top: -20px;
        }

        .error-message{
            top: -21px;
        }
    </style>
    
    <link rel="stylesheet" href="Image.css" type="text/css" runat="server" />
    <script src="ArtGallery.js" type="text/javascript"></script>
    
    <div class="container pt-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-light">
            <li class="breadcrumb-item"><a href="Gallery.aspx"><i class="fa fa-home dark-blue-color"></i></a></li>
              <li class="breadcrumb-item"><a href="Gallery.aspx" class="dark-blue-color">Art Works</a></li>
            <li class="breadcrumb-item active" aria-current="page">Edit Artwork</li>
          </ol>
        </nav>
    </div>

    <!--Testing-->

    <style>
        .cpb-4{
            padding-bottom: 1.5rem!important;
        }

        .cmb-1{
            padding-bottom: 0.3rem!important;
        }
        .auto-style1 {
            left: 0px;
            top: 0px;
        }
    </style>

    <div class="modal fade" style="top: 1.8rem" runat="server" id="regModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">        
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body text-center">
                            <h4><i class="fa fa-check text-success"></i></h4>
                            <span style="font-size: 1.3rem;">Edit Successful<br></span>
                            <span class="text-muted" style="font-size: 0.9rem;">  Please wait while we redirect you to gallery page </span>
                        </div>
                    </div> 
                </div>
            </div>

    <div class="container pt-4">
        <div class="row justify-content-center align-items-center">
            <div class="col-md-8 pr-md-5">

                <div class="cpb-4">
                    <div class="cmb-1">
                            Type<span class="default-color">*</span>
                            <span style="float: right"><i class="fa fa-question" style="color: #cabd80;" title="* Required Fields" data-toggle="tooltip"></i></span>
                    </div>
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="jets-control form-control custom-select" Height="50px">
                            <asp:ListItem Value="Acrylic" Text="Acrylic"></asp:ListItem>
                            <asp:ListItem Value="Digital" Text="Digital"></asp:ListItem>
                            <asp:ListItem Value="Encaustic" Text="Encaustic"></asp:ListItem>
                            <asp:ListItem Value="Fresco" Text="Fresco"></asp:ListItem>
                            <asp:ListItem Value="Gouache" Text="Gouache"></asp:ListItem>
                            <asp:ListItem Value="Ink" Text="Ink"></asp:ListItem>
                            <asp:ListItem Value="Oil" Text="Oil"></asp:ListItem>
                            <asp:ListItem Value="Pastel" Text="Pastel"></asp:ListItem>
                            <asp:ListItem Value="Tempera" Text="Tempera"></asp:ListItem>
                            <asp:ListItem Value="Watercolor" Text="Watercolor"></asp:ListItem>
                        </asp:DropDownList>
                </div>

                <div class="jets-group" style="padding-bottom: 5px;">
                    <input type="text" runat="server" class="jets-control txtImageName" id="txtImageName" maxlength="50" style="margin-bottom: 20px !important" />
                    <label for="txtImageName">Image Name</label>                    
                    <asp:RequiredFieldValidator ID="rvfName" runat="server" CssClass="error-message" ControlToValidate="txtImageName" ErrorMessage="Please enter the image name" Display="Dynamic" ForeColor="#CC0000" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    
                    <%--<span class="error-message error-message-top2 namecheck" id="namecheck" runat="server" style="display:none">Please enter the image name</span>--%>
                </div>

                <div class="jets-group" style="padding-bottom: 5px;">
                    <input type="text" runat="server" class="jets-control txtDescription" id="txtDescription" maxlength="200" style="margin-bottom: 20px !important" />
                    <label for="txtDescription">Description</label>
                    <asp:RequiredFieldValidator ID="rvfDesc" runat="server" ControlToValidate="txtDescription" CssClass="error-message" ErrorMessage="Please enter the image description" Display="Dynamic" ForeColor="#CC0000" ValidationGroup="Edit"></asp:RequiredFieldValidator>

                    <%--<span class="error-message error-message-top2 desccheck" id="desccheck" runat="server" style="display:none">Please enter the image description</span>--%>
                </div>
                
                <div class="row">
                    <div class="col-md">
                    <div class="jets-group">
                        <input type="text" runat="server" class="jets-control txtPrice" id="txtPrice" maxlength="7" onkeypress="return (!(event.keyCode>=65) && event.keyCode!=32);" style="margin-bottom: 5px !important" />
                        <label for="txtDescription">Price (RM)</label>
                        <asp:RequiredFieldValidator ID="rvfPrice" runat="server" CssClass="error-message value-validation" ControlToValidate="txtPrice" ErrorMessage="Please enter the price" Display="Dynamic" ForeColor="#CC0000" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rngPrice" runat="server" CssClass="error-message value-validation" ControlToValidate="txtPrice" ErrorMessage="Price must be more than 0 & less than 9999<br/>Value must be a integer or double" MaximumValue="9999" MinimumValue="1" Width="100%" ValidationGroup="Edit" Display="Dynamic" Type="Double"></asp:RangeValidator>

                        <%--<span class="error-message error-message-top pricecheck" id="pricecheck" runat="server" style="display:none">Please enter the price</span>--%>     
                    </div>
                </div>

                <div class="col-md">
                    <div class="jets-group">
                        <input type="text" runat="server" class="jets-control txtQty" id="txtQty" maxlength="3" onkeypress="return (!(event.keyCode>=65) && event.keyCode!=32 && !(event.keyCode >= 33 && event.keyCode <= 47));" style="margin-bottom: 5px !important" />
                        <label for="txtDescription">Quantity</label>
                        <asp:RequiredFieldValidator ID="rvfQty" runat="server" CssClass="error-message value-validation" ControlToValidate="txtQty" ErrorMessage="Please enter the quantity" Display="Dynamic" ForeColor="#CC0000" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rngQty" runat="server" CssClass="error-message value-validation" ControlToValidate="txtQty" ErrorMessage="Quantity must be more than 0 & less than 999<br/>Value must be an integer" MaximumValue="999" MinimumValue="1" Width="100%" ValidationGroup="Edit" Display="Dynamic" Type="Integer"></asp:RangeValidator>

                        <%--<span class="error-message error-message-top qtycheck" id="qtycheck" runat="server" style="display:none">Please enter the quantity</span>--%>
                    </div>
                </div>
                </div>
            </div>

            <style>
                .field-validation-error:before {
                    font-family: FontAwesome;
                    content: "\f06a\00a0";
                    position: absolute;
                    color: #ca1d1d;
                    font-size: 22px;
                    animation: blinker 1.5s linear infinite;
                }

                @keyframes blinker {
                    50%{
                        opacity: 0;
                    }
                }

                .value-validation{
                    top: -6px;
                }

                .white-space{
                    white-space: nowrap;
                }
            </style>

            <div class="col-md-4 pt-md-0 pt-5">
                <div class="card">
                    <img id="imgPreview" class="card-img-top" src="<%= getImageSource() + "?" + DateTime.Now.Ticks.ToString() %>" />
                    <div class="card-body">  
                        <asp:FileUpload ID="fuEditImage" runat="server" onchange="ShowPreview(this)" />
                    </div>
                    <div class="card-footer">
                        <div class="row" style="padding-right: 10px;">
                            <div class="col-sm-4" style="padding-right: 5px">     
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="100%" CssClass="jets-btn jets-artist-btn cancel-btn" PostBackUrl="~/Artist/Gallery.aspx" CausesValidation="False" UseSubmitBehavior="False" />
                            </div>
                            <div class="col-sm-8 pr-sm-0 pb-2 pb-sm-0" style="padding-left: 5px;">
                                <asp:Button ID="btnUpdate" runat="server" Text="Save" OnClick="btnUpdate_Click" CssClass="jets-btn jets-artist-btn submit-btn" ValidationGroup="Edit" />                  
                            </div>
                        </div>
                    </div>
                </div>     
                <div class="text-center incorrect-message jets-box mt-3" id="status" runat="server" style="display: none;">Please select the product image. <br />Allowed Image Types (<b>.jpg, .png, .jpeg, .gif</b>)</div>
            </div>
        </div>
    </div>
   
    <div class="container pt-4">
        <asp:Label ID="lblTest" CssClass="text-success" runat="server"></asp:Label>
    </div>
</asp:Content>