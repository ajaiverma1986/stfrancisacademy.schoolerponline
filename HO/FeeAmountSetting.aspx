<%@ Page Title="Fee Amount Setting" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FeeAmountSetting.aspx.cs" Inherits="HO_FeeAmountSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .txtfeeamount {
            -moz-appearance: none;
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            border-radius: 0;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 15px;
            line-height: 20px;
            outline: medium none;
            padding: 3px 6px;
            text-align: left;
            width: 100px;
        }
    </style>
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Fee Amount Settings</h2>
            <asp:Button ID="btnsummer" runat="server" Text="SummerCamp Fee Setting" CssClass="button_save" Style="float:right;margin-top: 5px; margin-right: 3px" PostBackUrl="~/HO/summercampfee-setting.aspx" />
        </div>
        <div class="for_sigle_row_form">
            <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlfinancialyear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Select Branch</label>
            <asp:DropDownList ID="DDlBranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDlBranch_SelectedIndexChanged">
                <asp:ListItem Value="0" Selected="True">-- Select Branch --</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Select Class</label>
            <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                <asp:ListItem Value="0" Selected="True">-- Select Class --</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div style="margin-top: 15px;" runat="server" id="divMain">
            <asp:GridView ID="grdDetails" AutoGenerateColumns="false" Style="width: 100% !important" runat="server" CssClass="stm"
            HeaderStyle-Height="30px" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderText="S.NO">
                        <ItemTemplate>
                            <asp:Label ID="lblsno" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="20%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fee Category">
                        <ItemTemplate>
                            <asp:Label ID="lblcategory" runat="server" Text='<%# Bind("Maintype") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="30%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fee Heads">
                        <ItemTemplate>
                            <asp:Label ID="lblclass" runat="server" Text='<%# Bind("feename") %>'></asp:Label>
                            <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("CFid") %>' />
                        </ItemTemplate>
                        <ItemStyle Width="30%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fee">
                        <ItemTemplate>
                            Rs.<asp:TextBox ID="txtfees" runat="server" Text='<%# Bind("fees","{0:f}") %>' ToolTip="Enter the fee you want to set" CssClass="txtfeeamount"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle CssClass="stm_light" />
                <RowStyle CssClass="stm_dark" />
                <HeaderStyle CssClass="stm_head"/>
            </asp:GridView>
        </div>
        <br />
        <div class="for_sigle_row_form" runat="server" id="divButton">
            <label>
            </label>
            <asp:Label ID="lblmsg" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
            <asp:Button ID="ImageButton1" runat="server" Text="Update" CssClass="button_save" OnClick="ImageButton1_Click"
                ToolTip="Click here to update the fee" />
            <asp:Button ID="ImageButton2" runat="server" Text="Cancel" CssClass="button2" OnClick="ImageButton2_Click"
                ToolTip="Click here to cancel the changes made" />
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Label runat="server" ID="lblmsg1" ForeColor="Red" EnableViewState="False"></asp:Label>
        </div>
    </div>
</asp:Content>