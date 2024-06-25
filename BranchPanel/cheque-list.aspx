<%@ Page Title="Cheque List" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="cheque-list.aspx.cs" Inherits="BranchPanel_cheque_list" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .active695 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #15A1BF;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 13px;
            margin-top: 3px;
        }

        .ui-widget-content a {
            color: #222222;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="">Fee Managment</a></li>
            <li><a href="">Fee Report</a></li>
            <li style="background: none;"><a class="active" href="">Cheque List</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <asp:GridView ID="gridcheque" AutoGenerateColumns="false" ShowHeader="true" EmptyDataText="No data found !"
            Width="100%" CssClass="stm" GridLines="None" runat="server">

            <Columns>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label ID="lblstudentname" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="17%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Admission No">
                    <ItemTemplate>
                        <asp:Label ID="lbladno" runat="server" Text='<%#Eval("adno") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Class">
                    <ItemTemplate>
                        <asp:Label ID="lblclass" runat="server" Text='<%#Eval("applyclass") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="14%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Transaction Date">
                    <ItemTemplate>
                        <asp:Label ID="lbltransdate" runat="server" Text='<%#Eval("transaction_date") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="15%" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:Label ID="lblamount" runat="server" Text='<%#Eval("payfee","{0:0.00}") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Receipt No">
                    <ItemTemplate>
                        <asp:Label ID="lblrecept" runat="server" Font-Bold="true" Text='<%#Eval("receiptno") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Payment Mode">
                    <ItemTemplate>
                        <asp:LinkButton ID="lblpaymode" runat="server" Text='<%#Eval("paymode") %>'>
                        </asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
            <RowStyle CssClass="stm_light" />
            <AlternatingRowStyle CssClass="stm_dark" />
            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
        </asp:GridView>
    </div>
</asp:Content>