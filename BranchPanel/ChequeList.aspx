<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="ChequeList.aspx.cs" Inherits="BranchPanel_ChequeList"
    EnableEventValidation="false" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        #mask {
            position: fixed;
            left: 0px;
            top: 0px;
            z-index: 9000000;
            opacity: 1;
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=90000)"; /* first!*/
            filter: alpha(opacity=90000); /* second!*/
            background-color: gray;
            display: none;
            width: 100%;
            height: 100%;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function ShowPopup() {
            $('#mask').show();
            $('#<%=pnlpopup.ClientID %>').show();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#<%=pnlpopup.ClientID %>').hide();
        }
        $(".btnClose").live('click', function () {
            HidePopup();
        });
    </script>
    <style type="text/css">
        .active23 {
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

        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 355px;
        }
    </style>
    <%--<div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat;
                padding-left: 21px;">Home</a></li>
            <li><a href="#">Fee Management</a></li>
            <li style="background: none;"><a class="active" href="#">Cheque List</a></li>
        </ul>
    </div>--%>
    <div class="clear">
    </div>
    <%-- <asp:UpdatePanel runat="server" ID="upd1">
        <ContentTemplate>--%>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div class="containerHeadline" style="padding-top: 0px;">
            List of Cheques
            <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="true"
                CausesValidation="false" OnClick="ImageButton1_Click" Height="20px"
                CssClass="excel" ToolTip="Click here to download Excel sheet" />
            <asp:ImageButton ID="img_pdffile" ImageUrl="../../images/download.jpg" Height="20px"
                runat="server" CssClass="excel" Style="right: 0px" />
        </div>

        <div class="for_sigle_row_form">
            <label>
                Select Cheque Status<span style="color: #ff0066">*</span></label>
            <asp:DropDownList ID="ddlCheque" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="ddlCheque_SelectedIndexChanged">
                <asp:ListItem Value="0">Select Cheque Status</asp:ListItem>
                <asp:ListItem Value="1">Pending</asp:ListItem>
                <asp:ListItem Value="2">Cleared</asp:ListItem>
                <asp:ListItem Value="3">Bounced</asp:ListItem>
                <asp:ListItem Value="4">All</asp:ListItem>
            </asp:DropDownList>
        </div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" id="GridBatch">
            <tr>
                <td align="left" colspan="10" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Height="225px" Width="350px"
                        Style="z-index: 111; background-color: White; position: absolute; left: 35%; top: 12%; border: outset 2px gray; padding: 5px; display: none">
                        <table style="width: 100%; height: 100%;" cellpadding="0" cellspacing="5">
                            <tr style="background-color: #47BFEF">
                                <td colspan="3" style="color: White; font-weight: bold; font-size: 1.2em; padding: 3px"
                                    align="center">Cheque Options <a id="closebtn" style="color: white; float: right; text-decoration: none"
                                        class="btnClose" href="#">X</a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="width: 100%; text-align: center;">
                                    <asp:Label ID="LabelValidate" runat="server" Text="Do you want to clear this cheque or bounce?" />
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" align="center" style="width: 33.33%; text-align: center;">
                                    <asp:Button ID="btnClear" CssClass="button_save" runat="server" Text="Clear" OnClick="btnClear_Click" />
                                </td>
                                <td valign="top" align="center" style="width: 33.34%; text-align: center;">
                                    <asp:Button ID="btnBounce" Text="Bounce" CssClass="button_save" OnClick="btnBounce_Click"
                                        runat="server" />
                                </td>
                                <td valign="top" align="center" style="width: 33.33%; text-align: center;">
                                    <asp:Button ID="Button1" CssClass="button_save" class="btnClose" runat="server" Text="Cancel" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:GridView runat="server" ID="gvdetails" AllowPaging="true" PageSize="20" AutoGenerateColumns="false"
                        Width="100.3%" CssClass="stm" GridLines="None" OnRowCommand="gvdetails_RowCommand"
                        EmptyDataText="No entry for cheque found." OnRowDataBound="gvdetails_RowDataBound"
                        OnPageIndexChanging="gvdetails_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="name" HeaderText="Student Name" ItemStyle-Width="12.5%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="coursename" HeaderText="Course" ItemStyle-Width="12.5%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField HeaderText="Cheque Amount ( ₹)">
                                <ItemTemplate>
                                    <asp:Label ID="lblDate2" runat="server" Text='<%# Eval("paidamount","{0:0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="refrenceno" HeaderText="Cheque Number" ItemStyle-Width="10%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="date" HeaderText="Cheque Date" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="bankname" HeaderText="Bank Name" ItemStyle-Width="10%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:HiddenField runat="server" ID="hf1" Value='<%#Eval("sid") %>' />
                                    <%--  <asp:Label ID="lblDate" runat="server" Text='<%# Eval("status") %>'></asp:Label>--%>
                                    <asp:LinkButton ID="lnkbtn" runat="server" Text='<%# Eval("status") %>' CommandName="ShowPopup"
                                        CommandArgument='<%# Bind("sid") %>'></asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <%--      <asp:TemplateField HeaderText="Clear">
                                        <ItemTemplate>
                                            <asp:linkbutton id="lnkClear" runat="server" commandargument='<%# Eval("sid") %>'
                                                commandname="Clear" text="Clear" tooltip="Click here to clear this cheque." forecolor="Chocolate"
                                                onclientclick="return confirm('Do you want to clear this cheque?');" xmlns:asp="#unknown">
                                            </asp:linkbutton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cheque Bounced?">
                                        <ItemTemplate>
                                            <asp:HiddenField runat="server" ID="hf1" Value='<%#Eval("sid") %>' />
                                            <asp:LinkButton ID="lnkClear12" runat="server" CommandArgument='<%# Eval("sid") %>'
                                                CommandName="Clear2" Text="Bounce" ToolTip="Click here if this cheque has bounced."
                                                ForeColor="Chocolate">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>--%>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
            <%-- <tr>
                <td>
                </td>
            </tr>--%>
        </table>
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>