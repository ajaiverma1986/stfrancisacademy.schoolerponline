<%@ Page Title="Pay Fee" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true"
    CodeFile="PayFee.aspx.cs" Inherits="BranchPanel_PayFee" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
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
    </style>
    <script type="text/javascript">

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };

        function ValidateAlpha() {
            var keyCode = window.event.keyCode;
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32) {
                window.event.returnValue = false;
                alert("Enter only letters");
            }
        };
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Fee Management</a></li>
            <li style="background: none;"><a class="active" href="#">Pay Fee</a></li>
        </ul>
        <%-- <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>--%>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Pay Fee
        </div>
        <br />
        <table style="width: 100%">
            <tr>
                <td valign="top" align="left">

                    <div class="conductedlecture2345" style="background: #faf2cb; margin-left: 20px; margin-top: 10px; margin-bottom: 10px;">
                        <asp:Label runat="server" ID="Label2" Text="Total Annual Fee" Font-Bold="true" ForeColor="#A7875F"></asp:Label><br />
                        <asp:Label runat="server" ID="Label7" Text="" Font-Bold="true" ForeColor="#A7875F"></asp:Label>&nbsp;
                    </div>
                </td>
                <td valign="top" align="left">

                    <div class="conductedlecture2345" style="background: #C4E5F6; margin-left: 10px; margin-top: 10px; margin-bottom: 10px;">
                        <asp:Label runat="server" ID="Label9" Text="Total Paid" Font-Bold="true" ForeColor="#1198B8"></asp:Label><br />
                        <asp:Label runat="server" ID="Label10" Text="" Font-Bold="true" ForeColor="#1198B8"></asp:Label>&nbsp;
                    </div>
                </td>

                <td valign="top" align="left">

                    <div class="conductedlecture2345" style="background: #000000; margin-left: 10px; margin-top: 10px; margin-bottom: 10px;">
                        <asp:Label runat="server" ID="Label8" Text="Total Balance" Font-Bold="true" ForeColor="#1198B8"></asp:Label><br />
                        <asp:Label runat="server" ID="Label11" Text="" Font-Bold="true" ForeColor="#1198B8"></asp:Label>&nbsp;
                    </div>
                </td>
            </tr>
        </table>

        <div class="for_sigle_row_form">
            <label>
                <asp:Label runat="server" ID="lbl1" Text="Annual Fee"></asp:Label></label>
            <asp:Label runat="server" ID="lbl2" ForeColor="Black" Font-Size="17px"></asp:Label>
        </div>

        <div class="for_sigle_row_form">
            <label>
                <asp:Label runat="server" ID="Label3" Text="Paid Amount(Selected months):"></asp:Label></label>
            <asp:Label runat="server" ID="Label4" ForeColor="Black" Text="0.00" Font-Size="17px"></asp:Label>
        </div>
        <div class="for_sigle_row_form">
            <label>
                <asp:Label runat="server" ID="Label5" Text="Balance Amount(months):"></asp:Label></label>
            <asp:Label runat="server" ID="Label6" ForeColor="Black" Font-Size="17px"></asp:Label>
        </div>
        <div class="for_sigle_row_form">
            <label>
                <asp:Label runat="server" ID="lblMonth1" Text="Month"></asp:Label></label>
            <asp:Label runat="server" ID="lblMonthName" ForeColor="Black" Font-Size="17px"></asp:Label>
        </div>

        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Payment Mode</label>
                    <asp:DropDownList ID="ddlPayMode" runat="server" Height="28px" Width="313px" OnSelectedIndexChanged="ddlPaymode_SelectedIndexChanged"
                        AutoPostBack="true">
                        <asp:ListItem Value="0">--Select Payment Mode--</asp:ListItem>
                        <asp:ListItem Value="1">Cash</asp:ListItem>
                        <asp:ListItem Value="2">Bank Draft</asp:ListItem>
                        <asp:ListItem Value="3">Cheque</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlPayMode"
                              InitialValue="0" ErrorMessage="Please select a Payment Mode." SetFocusOnError="True"
                              CssClass="rqd"></asp:RequiredFieldValidator>
                </div>

                <div class="for_sigle_row_form">
                    <label runat="server" id="ll4">
                        Enter amount to be paid<span style="color: Red;">*</span></label>
                    <asp:TextBox runat="server" ID="txtAmount" AutoPostBack="true" onkeypress="return noAlphabets(event)"
                        OnTextChanged="txtAmount_TextChanged"></asp:TextBox>&nbsp;
                <asp:Label runat="server" ID="lblmsg" ForeColor="Red" CssClass="rqd"></asp:Label>
                    <asp:Label runat="server" ID="lblremain" ForeColor="Red" Visible="false">Remaining Blanace:</asp:Label>
                    <asp:Label runat="server" ID="lblremainbal" ForeColor="Red"></asp:Label>
                    <asp:RequiredFieldValidator ID="RD1" runat="server" ControlToValidate="txtAmount" CssClass="rqd" ErrorMessage="Please Enter amount to be paid"></asp:RequiredFieldValidator>
                    <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="rqd" ControlToValidate="txtAmount"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>&nbsp;--%>
                </div>

                <div class="for_sigle_row_form" visible="false" runat="server" id="ddlmonth">
                    <label>
                        select month for remaining amount</label>
                    <asp:DropDownList ID="ddlmonth1" runat="server" Height="28px" Width="313px" AutoPostBack="true" OnSelectedIndexChanged="ddlmonth1_SelectedIndexChanged">
                        <asp:ListItem Value="0">--Select month--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label runat="server" ID="Label1" ForeColor="Red"></asp:Label>
                </div>

                <div class="for_sigle_row_form">
                    <label runat="server" id="ll1">
                        Bank Name<span style="color: Red;">*</span></label>
                    <asp:TextBox runat="server" ID="txtBankName" onkeypress="ValidateAlpha()"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label runat="server" id="ll2">
                        <asp:Label runat="server" ID="lblCDd"></asp:Label><span style="color: Red;">*</span></label>
                    <asp:TextBox runat="server" ID="txtCheque"></asp:TextBox>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="for_sigle_row_form">
            <label></label>
            <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="button_save"
                OnClick="btnSubmit_Click" />
            <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="button_save" CausesValidation="false"
                OnClick="btnCancel_Click" />
        </div>
    </div>
</asp:Content>