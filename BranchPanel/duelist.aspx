<%@ Page Title="Due Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="duelist.aspx.cs" Inherits="BranchPanel_duelist" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/1.8-jquery-ui.min.js"></script>
    <style>
        .active696 {
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
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

            $('.name').click(function () {
                var id;
                id = $(this).closest("td").find("[id*=lblrid]").text();

                window.location.replace("studentpayfee.aspx?adid=" + id);
                return false;
            });

        });
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="">Fee Managment</a></li>
            <li><a href="">Fee Report</a></li>
            <li style="background: none;"><a class="active" href="">Cheque Report</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <asp:GridView ID="gridduelist" AutoGenerateColumns="false" ShowHeader="true" EmptyDataText="No data found !"
            Width="100%" CssClass="stm" GridLines="None" runat="server">

            <Columns>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:LinkButton ID="lblstudentname" Font-Bold="true" runat="server" CssClass="name" Text='<%#Eval("name") %>'></asp:LinkButton>
                        <asp:Label ID="lblrid" runat="server" CssClass="ridcss" Text='<%# Bind("studentid") %>' Style="display: none;"></asp:Label>
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
                <asp:TemplateField HeaderText="Month Name">
                    <ItemTemplate>
                        <asp:Label ID="lblmonthname" runat="server" Text='<%#Eval("monthname1") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="14%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Due Date">
                    <ItemTemplate>
                        <asp:Label ID="lbldate1" runat="server" Text='<%#Eval("paydate") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="14%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Next Balance">
                    <ItemTemplate>
                        <asp:Label ID="lblnextbalance" runat="server" Text='<%#Eval("nextbalance","{0:0.00}") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="15%" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
            <RowStyle CssClass="stm_light" />
            <AlternatingRowStyle CssClass="stm_dark" />
            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
        </asp:GridView>
    </div>
</asp:Content>