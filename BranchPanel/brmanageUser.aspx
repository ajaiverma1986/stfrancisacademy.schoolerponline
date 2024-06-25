<%@ Page Title="Add User" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="brmanageUser.aspx.cs" Inherits="HO_manageUser" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #ctl00_ContentPlaceHolder1_CompareValidator1 {
            margin-left: 578px;
            left: 0;
            margin-top: 5px;
            position: absolute;
            width: 184px;
        }

        .for_sigle_row_form {
            margin-bottom: 0;
            margin-left: 17%;
            margin-right: auto;
            padding: 5px 0;
            width: 100%;
        }
    </style>
    <script type="text/javascript" charset="utf-8">
        jQuery.fn.dataTableExt.oSort['string-case-asc'] = function (x, y) {
            return ((x < y) ? -1 : ((x > y) ? 1 : 0));
        };

        jQuery.fn.dataTableExt.oSort['string-case-desc'] = function (x, y) {
            return ((x < y) ? 1 : ((x > y) ? -1 : 0));
        };

        $(document).ready(function () {
            hscroll = "useMinHeight";
            $('#tblDataTables').dataTable({
                "bJQueryUI": true,
                "bProcessing": true,
                "sPaginationType": "full_numbers",
                "aaSorting": [[0, 'asc']],
                "aoColumnDefs": [
						{ "sType": 'string-case', "aTargets": [4] }
                ],
                "aoColumns": [
                                null,
                                null,
                                null,
                                null,
                                null,
                                { "bSortable": false }
                ]
            });
        });
    </script>
    <script language="javascript" type="text/javascript">
        function IsNumeric() {
            var type = (document.getElementById('<%=txtmobile.ClientID %>').value);
            var ValidChars = "0123456789";
            var IsNumber = true;
            var Char, i;

            for (i = 0; i < type.length && IsNumber == true; i++) {
                Char = type.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                    alert("Please Enter numeric Value")
                    return;
                }
            }

            return IsNumber;

        }
    </script>
    <div class="content_pane_cont" id="contentPane">

        <div class="content_top">
            <ul>
                <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
                <li><a>User Manager</a></li>
                <li style="background: none;"><a class="active">Add User </a></li>
            </ul>
            <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
                <%--<iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>--%>
            </div>
        </div>
        <div class="clear">
        </div>
        <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 4px;"
                class="containerHeadline stripheading">
                Select User
            </div>
            <table style="width: 100%; border-right: 1px solid #DDDDDD;">
                <tr>
                    <td style="text-align: right; padding-right: 10px;">
                        <asp:DropDownList ID="dropUserGroup" runat="server" AutoPostBack="True" OnSelectedIndexChanged="dropUserGroup_SelectedIndexChanged"
                            Visible="false">
                            <asp:ListItem Value="0">-- Select User Group --</asp:ListItem>
                            <asp:ListItem Value="10101">Back Office</asp:ListItem>
                            <asp:ListItem Value="101" Selected="True">Branch Office</asp:ListItem>
                            <asp:ListItem Value="1001">FSO</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Login ID<span style="color: Red;">* </span>
                            </label>
                            <asp:TextBox ID="txtUserName" runat="server" Enabled="false"></asp:TextBox>&nbsp&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter login ID"
                            ControlToValidate="txtUserName" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                            <%-- <asp:RegularExpressionValidator ID="rev" runat="server" ControlToValidate="txtUserName"
                            ErrorMessage="Spaces are not allowed!" ValidationGroup="g1" ValidationExpression="[^\s]+" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                User Name<span style="color: Red;">*</span></label>
                            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>&nbsp&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter User Name"
                            ControlToValidate="txtName" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Phone No</label>
                            <asp:TextBox ID="txtphone" runat="server" MaxLength="10" onblur="javascript:return IsNumeric();"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Mobile No</label>
                            <asp:TextBox ID="txtmobile" runat="server" MaxLength="10" onblur="javascript:return IsNumeric();"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Email Id</label>
                            <asp:TextBox ID="txtmailid" runat="server"></asp:TextBox>
                        </div>
                        <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtmailid"
                            ErrorMessage="Invalid  Email Id"  ValidationGroup="g1" ValidationExpression="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"></asp:RegularExpressionValidator><span
                                style="font-size: 8pt"></span>--%>
                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Re-Enter Password" ValidationGroup="g1" ControlToValidate="txtRePass"><span style="color:Red;">*</span></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="Both password should be same" ControlToCompare="txtPass" ControlToValidate="txtRePass" ValidationGroup="g1">*</asp:CompareValidator>--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Permanent Address</label>
                            <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Country</label>
                            <asp:DropDownList ID="ddlcountry" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                                OnSelectedIndexChanged="ddlcountry_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="0">-Country-</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                State</label>
                            <asp:DropDownList ID="ddlState" runat="server" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"
                                AutoPostBack="True" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="0">-State-</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                City
                            </label>
                            <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="0">-City-</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Pin Code</label>
                            <asp:TextBox ID="txtPinCode" runat="server" CssClass="body" MaxLength="6" ValidationGroup="g1"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Photo Upload
                            </label>
                            <asp:FileUpload ID="fileupload1" runat="server" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Password<span style="color: Red;">*</span></label>
                            <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox>&nbsp&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1pass" runat="server" ErrorMessage="Please Enter Password"
                            ControlToValidate="txtPass" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Password"
                            ControlToValidate="txtPass" SetFocusOnError="True" ></asp:RequiredFieldValidator>--%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Confirm Password<span style="color: Red;">*</span></label>
                            <asp:TextBox ID="txtRePass" runat="server" TextMode="Password"></asp:TextBox>&nbsp&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter confirm Password"
                            ControlToValidate="txtRePass" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Both Password should be same"
                                ControlToCompare="txtPass" ControlToValidate="txtRePass" ValidationGroup="g1"
                                CssClass="rqd"></asp:CompareValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Role<span style="color: Red;">*</span></label>
                            <asp:DropDownList ID="dropRole" runat="server" OnSelectedIndexChanged="dropState_SelectedIndexChanged">
                            </asp:DropDownList>
                            &nbsp&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Select Role"
                            ControlToValidate="dropRole" SetFocusOnError="True" ValidationGroup="g1" InitialValue="0"
                            CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label style="padding-top: 1px;">
                                Active</label>
                            <asp:CheckBox ID="chkActive" runat="server" />
                        </div>
                    </td>
                </tr>
                <tr runat="server" visible="false" id="trRO">
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                RO</label>
                            <asp:DropDownList ID="dropRO" runat="server" OnDataBound="dropRO_DataBound">
                            </asp:DropDownList>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <asp:Button ID="btSave" runat="server" Text="Submit" CssClass="button_save" OnClick="btSave_Click"
                                ValidationGroup="g1" />
                            <asp:Button ID="Button4" runat="server" Text="Cancel" CssClass="button_save" OnClick="Button4_Click"
                                ValidationGroup="g1" CausesValidation="False" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="style9" colspan="6">
                        <asp:HiddenField ID="HfUid" runat="server" />
                        <asp:HiddenField ID="HfEID" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="content_pane_cont" id="contentPane" runat="server" visible="false">
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="false"
                ShowSummary="False" ValidationGroup="g1" />
        </div>
    </div>
</asp:Content>