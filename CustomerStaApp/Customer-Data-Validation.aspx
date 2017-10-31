<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customer-Data-Validation.aspx.cs" Inherits="CustomerStaApp.Customer_Data_Validation" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <h2 class="text-center">Customer Data Validation</h2>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            &nbsp;
        </div>
        <div class="col-md-8 form-inline">
            <div class="form-group">
                <label for="txtRecency">Recency:</label>
                <asp:TextBox runat="server" ID="txtRecency" CssClass="form-control" placeholder="Recency"></asp:TextBox>

            </div>
            <div class="form-group">
                <label for="txtFrequency">Frequency:</label>
                <asp:TextBox runat="server" ID="txtFrequency" CssClass="form-control" placeholder="Frequency"></asp:TextBox>

            </div>
            <div class="form-group">
                <label for="txtMonetary">Monetary:</label>
                <asp:TextBox runat="server" ID="txtMonetary" CssClass="form-control" placeholder="Monetary"></asp:TextBox>
            </div>
            <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-default" Text="Submit" OnClick="btnSubmit_OnClick" />
            <asp:LinkButton runat="server" ID="lnkSatisfationRateGeneration" OnClick="lnkSatisfationRateGeneration_OnClick">Satisfation Rate Generation</asp:LinkButton>
        </div>

    </div>
    <br />
    <br />
    <div class="row">
        <div class="col-md-2">
            &nbsp;
        </div>
        <div class="col-md-8">
            <asp:GridView runat="server" ID="grdValidData" AutoGenerateColumns="False" CssClass="table table-hover table-responsive table-condensed"
                GridLines="None" EmptyDataText="No records Found">
                <Columns>

                    <asp:BoundField DataField="Date" HeaderText="Date" />
                    <asp:BoundField DataField="Customer_Name" HeaderText="Customer Name" />
                    <asp:BoundField DataField="Age" HeaderText="Age" />
                    <asp:BoundField DataField="Product_Sub_Category" HeaderText="Product Sub-Category" />
                    <asp:BoundField DataField="Product_Name" HeaderText="Product Name" />
                    <asp:BoundField DataField="Order_Quantity" HeaderText="Order Quantity" />
                    <asp:BoundField DataField="Rating" HeaderText="Rating" />

                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
