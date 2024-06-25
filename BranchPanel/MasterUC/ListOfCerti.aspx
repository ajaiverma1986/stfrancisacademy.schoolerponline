<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="ListOfCerti.aspx.cs" Inherits="BranchPanel_MasterUC_ListOfCerti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Certificate List</h2>
            <asp:Button ID="Button1" runat="server" Text="BACK" PostBackUrl="#" CssClass="button_cancel" style="float:right; margin-right: 20px; margin-top: 5px; width:70px;" OnClick="Button1_Click" />                     
        </div>
        <br />
        <h2><a href="#" runat="server" id="Cert1">1) Bonafide Certificate</a></h2>
         <br />
        <h2><a href="#" runat="server" id="Cert2">2) Transfer Cerificate</a></h2>
          <br />
        <h2><a href="#" runat="server" id="Cert3">3) Character Cerificate</a></h2>
          <br />
        <h2><a href="#" runat="server" id="Cert4">4) TC Cerificate</a></h2>

          <br />
        <h2><a href="#" runat="server" id="Cert5">5) Character Cerificate New</a></h2>
    </div>
</asp:Content>

