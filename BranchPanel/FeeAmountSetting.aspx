<%@ Page Title="Fee Amount Setting" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="FeeAmountSetting.aspx.cs" Inherits="BranchPanel_FeeAmountSetting" %>

<%@ Register Src="~/BranchPanel/feeset.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .active7 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        input {
            opacity: 1 !important;
            padding: 5px;
        }
    </style>

    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a href="#">Master Settings</a></li>
            <li><a href="#">Fee Settings</a></li>
            <li style="background: none;"><a class="active" href="#">Set Fee </a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <My:stu runat="server" ID="MyUserInfoBoxControl" />
                <%--    <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadlinenew">
            <span style="line-height: 40px;">Fee Setting </span>
        </div>--%>
                <br />
                <div class="for_sigle_row_form" runat="server" id="l1">
                    <label>
                        Branch</label>
                    <asp:DropDownList ID="DDlBranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDlBranch_SelectedIndexChanged">
                        <asp:ListItem Value="0" Selected="True">-- Select Branch --</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Select Branch"
                        ControlToValidate="DDlBranch" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Class</label>
                    <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                        <asp:ListItem Value="0" Selected="True">-- Select Class --</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Class"
                        ControlToValidate="ddlClass" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>

                <%--MAIN CONTENT TO BE DISPLAYED HERE--%>
                <div style="margin-top: 15px; border-bottom: 1px solid #ddd;" runat="server" id="divMain">
                    <table id="Table1" class="stm" cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important;" runat="server">
                        <tr style="background: linear-gradient(#858992, #989898) repeat scroll 0 0 rgba(0, 0, 0, 0); color: #fff; line-height: 36px;">
                            <td style="height: 25px; width: 7%; line-height: 36px; font-weight: bold; padding-left: 16px; color: #fff;">S.No.
                            </td>
                            <td style="height: 25px; font-weight: bold; width: 72%; padding-left: 16px; line-height: 25px; color: #fff;">
                                <asp:Label ID="lblhead" runat="server">Fee Name</asp:Label>
                            </td>
                            <td style="height: 25px; font-weight: bold; padding-left: 16px; line-height: 25px; color: #fff;">
                                <asp:Label ID="lblfees" runat="server">Fees</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" width="100%">
                                <asp:GridView ID="grdDetails" AutoGenerateColumns="false" ShowHeader="false" Width="104%" GridLines="None"
                                    CellPadding="0" CellSpacing="0" runat="server" BorderWidth="0" CssClass="stm" Style="margin-left: -22px;">

                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblsno" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="7%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblclass" runat="server" Text='<%# Bind("feename") %>'></asp:Label>
                                                <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("CFid") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="72%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                Rs.<asp:TextBox ID="txtfees" runat="server" Text='<%# Bind("fees","{0:f}") %>' ToolTip="Enter the fee you want to set"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="grdHeader" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <div class="for_sigle_row_form" runat="server" id="divButton" style="margin-left: 19%;">
                    <label>
                    </label>

                    <asp:Label ID="lblmsg" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
                    <asp:Button ID="ImageButton1" runat="server" Text="Update" CssClass="button_save" OnClick="ImageButton1_Click"
                        ToolTip="Click here to update the fee" />
                    <asp:Button ID="ImageButton2" runat="server" Text="Cancel" CssClass="button_save" OnClick="ImageButton2_Click"
                        ToolTip="Click here to cancel the changes made" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <asp:Label runat="server" ID="lblmsg1" ForeColor="Chocolate" EnableViewState="False"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>