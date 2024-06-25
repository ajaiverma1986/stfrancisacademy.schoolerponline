<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="UpdateReceiptDate.aspx.cs" Inherits="BranchPanel_Fee_Management_UpdateReceiptDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        $(document).ready(function () {
            var d = new Date();
            var y = d.getFullYear();
            $("#txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:' + y,
                dateFormat: "d MM yy"
            });
        })
    </script>

    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading" style="margin-bottom:15px">
                <h2>Update Receipt Date</h2>
                
            </div> 
            <div class="col-md-3" style="margin-top:25px">

            </div>
             <div class="col-md-3 text-right">
                 Receipt Number:
            </div>
             <div class="col-md-3">
                 <asp:TextBox runat="server" ID="txtReceiptNum" />
            </div>
             <div class="col-md-3">

            </div>
            <div class="clearfix" ></div>
            
             <div class="col-md-3" style="margin-top:25px">

            </div>
             <div class="col-md-3 text-right">
                 Receipt Date:
            </div>
             <div class="col-md-3">
                 <asp:TextBox runat="server" ID="txtDate"  ClientIDMode="Static"/>
            </div>
             <div class="col-md-3">

            </div>
            </div>
        <div class="clearfix"></div><br />
        <div style="text-align:center">
            <asp:Button runat="server" ID="btnSave" Text="Update" CssClass="btn btn-success" OnClick="btnSave_Click"/><br />
        <asp:Label ID="lblmsg" runat="server" Font-Bold="true"></asp:Label>
        </div>
        
        </div>
</asp:Content>

