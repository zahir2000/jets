<%@ Page Title="Payment Success - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Payment_Success.aspx.cs" Inherits="JETS.Customer.Order.Payment_Success" %>

<asp:Content ID="contentPaymentSuccess" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <link rel="stylesheet" href="/Customer/Order/Payment.css" />

    <div class="container pt-5">
        <div class="payment-success">
            <div class="payment-success-check">
                <i class="fa fa-check-circle"></i>
            </div>
        </div>
        

        <div class="payment-success-thanks">
            <h1>Payment Successful</h1>
            <p>The order confirmation email with details of your order and a link to track its progress has been sent to your email address.</p>
        </div>

        <div class="payment-order-details">
            <div class="payment-order-id">
                <p>
                    <span class="payment-order-text">YOUR ORDER ID: <asp:Label ID="lblOrderID" CssClass="payment-order-no" runat="server" Text="12345"></asp:Label></span>
                </p>
            </div>
            <div class="payment-order-date">
                <p>
                    <span class="payment-order-date"><asp:Label ID="lblOrderDate" CssClass="payment-order-no" runat="server" Text="15th July 2019"></asp:Label></span>
                </p>
            </div>
        </div>

        <div class="payment-order-body">
            <div class="payment-order-body-left">
                <div class="payment-order-content address-width">
                    <div class="payment-order-shipping-address">
                        <div class="payment-order-body-title">
                            <strong class="payment-order-shipping-title"><i class="fa fa-home"></i> Shipping Address</strong>
                        </div>
                        <div class="payment-order-body-content">
                            <p class="payment-order-body-content-name"><asp:Label ID="lblName" runat="server" Text="Zahir Sher"></asp:Label></p>
                            <p class="payment-order-body-content-address"><asp:Label ID="lblAddress" runat="server" Text="Idaman C-4-1, IdamanC-4-1, IdamanC-4-1, IdamanC-4-1, Idaman"></asp:Label></p>
                            <p class="payment-order-body-content-phone"><b>Tel</b>: <asp:Label ID="lblPhoneNum" runat="server" Text="010-8003610"></asp:Label></p>
                        </div>
                    </div>
                </div>

                <div class="payment-order-content payment-order-content-bottom" style="margin-right: 10px;">
                    <div class="payment-order-shipping-address">
                        <div class="payment-order-body-title">
                            <strong class="payment-order-shipping-title"><i class="fa fa-truck"></i> Shipping Method</strong>
                        </div>
                        <div class="payment-order-body-content">
                            <p class="payment-order-body-content-shipmethod">Flat Rate - Fixed</p>
                        </div>
                    </div>
                </div>

                <div class="payment-order-content payment-order-content-bottom">
                    <div class="payment-order-shipping-address">
                        <div class="payment-order-body-title">
                            <strong class="payment-order-shipping-title"><i class="fa fa-credit-card"></i> Payment Method</strong>
                        </div>
                        <div class="payment-order-body-content">
                            <p class="payment-order-body-content-shipmethod">                                      
                                <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMzIiIHZpZXdCb3g9IjAgMCAyNCAzMiIgeG1sbnM9Imh0dHA6JiN4MkY7JiN4MkY7d3d3LnczLm9yZyYjeDJGOzIwMDAmI3gyRjtzdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiPjxwYXRoIGZpbGw9IiMwMDljZGUiIGQ9Ik0gMjAuOTA1IDkuNSBDIDIxLjE4NSA3LjQgMjAuOTA1IDYgMTkuNzgyIDQuNyBDIDE4LjU2NCAzLjMgMTYuNDExIDIuNiAxMy42OTcgMi42IEwgNS43MzkgMi42IEMgNS4yNzEgMi42IDQuNzEgMy4xIDQuNjE1IDMuNiBMIDEuMzM5IDI1LjggQyAxLjMzOSAyNi4yIDEuNjIgMjYuNyAyLjA4OCAyNi43IEwgNi45NTYgMjYuNyBMIDYuNjc1IDI4LjkgQyA2LjU4MSAyOS4zIDYuODYyIDI5LjYgNy4yMzYgMjkuNiBMIDExLjM1NiAyOS42IEMgMTEuODI1IDI5LjYgMTIuMjkyIDI5LjMgMTIuMzg2IDI4LjggTCAxMi4zODYgMjguNSBMIDEzLjIyOCAyMy4zIEwgMTMuMjI4IDIzLjEgQyAxMy4zMjIgMjIuNiAxMy43OSAyMi4yIDE0LjI1OCAyMi4yIEwgMTQuODIxIDIyLjIgQyAxOC44NDUgMjIuMiAyMS45MzUgMjAuNSAyMi44NzEgMTUuNSBDIDIzLjMzOSAxMy40IDIzLjE1MyAxMS43IDIyLjAyOSAxMC41IEMgMjEuNzQ4IDEwLjEgMjEuMjc5IDkuOCAyMC45MDUgOS41IEwgMjAuOTA1IDkuNSI+PC9wYXRoPjxwYXRoIGZpbGw9IiMwMTIxNjkiIGQ9Ik0gMjAuOTA1IDkuNSBDIDIxLjE4NSA3LjQgMjAuOTA1IDYgMTkuNzgyIDQuNyBDIDE4LjU2NCAzLjMgMTYuNDExIDIuNiAxMy42OTcgMi42IEwgNS43MzkgMi42IEMgNS4yNzEgMi42IDQuNzEgMy4xIDQuNjE1IDMuNiBMIDEuMzM5IDI1LjggQyAxLjMzOSAyNi4yIDEuNjIgMjYuNyAyLjA4OCAyNi43IEwgNi45NTYgMjYuNyBMIDguMjY3IDE4LjQgTCA4LjE3MyAxOC43IEMgOC4yNjcgMTguMSA4LjczNSAxNy43IDkuMjk2IDE3LjcgTCAxMS42MzYgMTcuNyBDIDE2LjIyNCAxNy43IDE5Ljc4MiAxNS43IDIwLjkwNSAxMC4xIEMgMjAuODEyIDkuOCAyMC45MDUgOS43IDIwLjkwNSA5LjUiPjwvcGF0aD48cGF0aCBmaWxsPSIjMDAzMDg3IiBkPSJNIDkuNDg1IDkuNSBDIDkuNTc3IDkuMiA5Ljc2NSA4LjkgMTAuMDQ2IDguNyBDIDEwLjIzMiA4LjcgMTAuMzI2IDguNiAxMC41MTMgOC42IEwgMTYuNjkyIDguNiBDIDE3LjQ0MiA4LjYgMTguMTg5IDguNyAxOC43NTMgOC44IEMgMTguOTM5IDguOCAxOS4xMjcgOC44IDE5LjMxNCA4LjkgQyAxOS41MDEgOSAxOS42ODggOSAxOS43ODIgOS4xIEMgMTkuODc1IDkuMSAxOS45NjggOS4xIDIwLjA2MyA5LjEgQyAyMC4zNDMgOS4yIDIwLjYyNCA5LjQgMjAuOTA1IDkuNSBDIDIxLjE4NSA3LjQgMjAuOTA1IDYgMTkuNzgyIDQuNiBDIDE4LjY1OCAzLjIgMTYuNTA2IDIuNiAxMy43OSAyLjYgTCA1LjczOSAyLjYgQyA1LjI3MSAyLjYgNC43MSAzIDQuNjE1IDMuNiBMIDEuMzM5IDI1LjggQyAxLjMzOSAyNi4yIDEuNjIgMjYuNyAyLjA4OCAyNi43IEwgNi45NTYgMjYuNyBMIDguMjY3IDE4LjQgTCA5LjQ4NSA5LjUgWiI+PC9wYXRoPjwvc3ZnPg==" class="paypal-logo">
                            PayPal</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="payment-order-body-right">
                <div class="payment-order-content order-details">
                    <div class="payment-order-shipping-address">
                        <div class="payment-order-body-title">
                            <strong class="payment-order-shipping-title"><i class="fa fa-info-circle"></i> Order Details</strong>
                        </div>
                        <div class="payment-order-body-content">
                            <asp:Repeater ID="itemRepeater" runat="server" >
                                <ItemTemplate>
                                    <div class="order-body">
                                        <div class="order-details-body">
                                        <div class="order-details-img">
                                            <img src='/Images/<%# DataBinder.Eval(Container.DataItem, "imageLocation") %>' alt="Product Image" />
                                        </div>
                                        
                                        <div class="order-details-body-content">
                                            <div class="some-items">
                                                <p class="item-name"><asp:Label ID="lblItemName" runat="server" Text='<%# Eval("imageName") %>'></asp:Label></p>
                                                <div class="some-item-inner">
                                                    <p class="item-price text-muted" style="color: #333;"><asp:Label ID="lblPrice" runat="server" Text='<%# String.Format("RM{0:N2}", Double.Parse(Eval("unitPrice").ToString()) * Int32.Parse(Eval("qty").ToString())) %>'></asp:Label></p>
                                                    <p class="item-qty text-muted">Qty: <asp:Label ID="lblQty" runat="server" Text='<%#Eval("qty")%>'></asp:Label></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="payment-order-footer">
                                    <span class="font-weight-bold" style="font-size: 1.2rem; float: left;">Total</span>
                                    <span style="float:right"><span class="text-muted align-items-center" style="font-size: 0.78em; color: #717171 !important; vertical-align: 0.2em; margin-right: 0.4em;">MYR</span>
                                    <asp:Label ID="lblTotal" runat="server" CssClass="h4" Text="RM7.00"></asp:Label>
                                </span>
                        </div>
                    </div>
                </div>
                <div class="order-button mt-3">
                    <input type="button" value="Continue Shopping" class="jets-btn order-btn" onclick="location.href='/Customer/Gallery.aspx';" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>