<%@ Page Title="Payment Failed - JETS" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Payment_Fail.aspx.cs" Inherits="JETS.Customer.Order.Payment_Fail" %>

<asp:Content ID="contentPaymentFail" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <link rel="stylesheet" href="/Customer/Order/Payment.css" />

    <div class="container pt-5">
        <div class="payment-success">
            <div class="payment-success-check">
                <i class="fa fa-times-circle"></i>
            </div>
        </div>
        
        <div class="payment-success-thanks">
            <h1>Payment Unsuccessful</h1>
            <p>Please ensure you have completed all necessary steps and/or you have sufficient balance.</p>
        </div>

        <div class="container">
            <div class="order-button mt-3 fail-btn">
                <input type="button" value="Continue Shopping" class="jets-btn order-btn fail-btn-style" onclick="location.href='/Customer/Gallery.aspx';" />
            </div>
        </div>
    </div>
</asp:Content>