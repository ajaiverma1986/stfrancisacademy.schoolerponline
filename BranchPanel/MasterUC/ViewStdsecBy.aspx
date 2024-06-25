<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="ViewStdsecBy.aspx.cs" Inherits="BranchPanel_MasterUC_ViewStdsecBy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .tr {
            font-size:16px;
            color:green;
            border-bottom:1px double;
        }
         .td {
            font-size:16px;
            height:40px;
            color:green;
            border-bottom:1px double;
            text-align: center;
        }
    </style>    
    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Student Details</h2>
            <asp:Label ID="Label1" runat="server" Text="No of Total Student" CssClass="label label-primary" Style="float: right; font-size:16px; margin-top: 5px; margin-right: 3px; color:black; background-color:white"></asp:Label>
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="button_save" PostBackUrl="~/BranchPanel/SectionAdd.aspx" Style="float: right; margin-top: 5px; margin-right: 3px">Back</asp:LinkButton>            
        </div>
    </div>
    <br />
    <div>
        <asp:Panel ID="Panel1" runat="server"></asp:Panel>
    </div>
</asp:Content>

