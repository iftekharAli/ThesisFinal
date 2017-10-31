<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Satisfation_Rate_Generation.aspx.cs" Inherits="CustomerStaApp.Satisfation_Rate_Generation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <h2 class="text-center">Satisfation Rate Generation</h2>
        <p class="text-center" style="font-weight: bold">
            <asp:Label runat="server" ID="lblMsg" Visible="False"></asp:Label>
        </p>
    </div>
    <br />
    <div class="row">
        <div class="col-md-2">
            &nbsp;
        </div>

        <div class="col-md-8 form-inline">
            <div class="form-group">
                <label for="txtRating">Rating:</label>
                <asp:TextBox runat="server" ID="txtRating" CssClass="form-control" placeholder="Rating"></asp:TextBox>
            </div>
            <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary" Text="Submit" OnClick="btnSubmit_OnClick" />
            <asp:Button runat="server" ID="btnSave" CssClass="btn btn-success" Text="Save" OnClick="btnSave_OnClick" />
        </div>
    </div>

    <br />
    <br />
    <div class="row">
        <div class="col-md-6 col-sm-6 col-lg-6">
            <h2>Satisfation Rate Generation</h2>
            <asp:GridView runat="server" ID="grdSatisfation_Rate_Generation" AutoGenerateColumns="False" CssClass="table table-hover table-responsive table-condensed table-bordered"
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
        <div class="col-md-6 col-sm-6 col-lg-6">
            <h2>Disatisfation Rate Generation</h2>
            
            <asp:GridView runat="server" ID="grdDisSatisfation_Rate_Generation" AutoGenerateColumns="False" CssClass="table table-hover table-responsive table-condensed table-bordered"
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
