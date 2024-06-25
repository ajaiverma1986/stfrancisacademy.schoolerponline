<%@ Page Title="User List" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="brmanageUser1.aspx.cs" Inherits="HO_manageUser" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    &nbsp;<style>
              #ctl00_ContentPlaceHolder1_CompareValidator1 {
                  margin-left: 578px;
                  left: 0;
                  margin-top: 5px;
                  position: absolute;
                  width: 184px;
              }

              .stm_head th {
                  border-top: 1px solid #DDDDDD;
                  color: #FFFFFF !important;
                  font-size: 13px;
                  padding-left: 5px;
              }
          </style><script type="text/javascript" charset="utf-8">
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
</script><script language="javascript" type="text/javascript">
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
          </script><div class="content_top">
              <ul>
                  <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
                  <li><a>User Manager</a></li>
                  <li style="background: none;"><a class="active" href="#">User List </a></li>
              </ul>
              <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;">
                  <%--<iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>--%>
              </div>
          </div>
    <div class="clear">
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 4px; border-top: medium none;"
            class="containerHeadlinenew">
            <span style="line-height: 40px;">User List</span>
        </div>

        <fieldset id="filed" runat="server" visible="false">
            <asp:ImageButton ID="btCreate" runat="server" CssClass="button_save" OnClick="Button1_Click"
                Text="Create" ImageUrl="~/images/but_add.gif" Style="height: 17px;" />&nbsp;
        <asp:Label ID="lblStatus" runat="server" CssClass="lblStatus" EnableViewState="False"
            Font-Bold="True" ForeColor="#33CC33"></asp:Label>
        </fieldset>
        <div id="rp1" class="content_pane_cont" runat="server">
            <asp:Repeater ID="rptCity" runat="server" OnItemCommand="StateGrid_ItemCommand" OnItemDataBound="StateGrid_ItemDataBound">
                <HeaderTemplate>
                    <table id="tblDataTables" cellpadding="0" cellspacing="0" class="display  stm"
                        style="width: 100%;">
                        <thead>
                            <tr class="stm_head">
                                <th>S. No.
                                </th>
                                <th>User Name
                                </th>
                                <th>Login ID
                                </th>
                                <th>Password
                                </th>
                                <th>Role
                                </th>
                                <%--   <th>
                                Mobile No.
                            </th>--%>
                                <th>Action
                                </th>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr class="<%= Utility.RepeaterCurrentRowCssClass %> input_noborder">
                        <td>
                            <%# Container.ItemIndex + 1 %>
                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("UserID") %>' />
                        </td>
                        <td>
                            <%# Eval("Name") %>
                        </td>
                        <td>
                            <%# Eval("UserName") %>
                        </td>
                        <td>
                            <asp:Label ID="pass" runat="server" Text="***" ToolTip='<%# Eval("Password") %>'></asp:Label>
                        </td>
                        <td>
                            <%# Eval("RoleName") %>
                        </td>
                        <%-- <td>
                        <asp:Label ID="lblmobile" runat="server" Text='<%# Eval("mobileno") %>'></asp:Label>
                    </td>--%>
                        <td>
                            <asp:LinkButton ID="Ed1" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Edit"
                                Text="Edit" />
                            |
                        <asp:LinkButton ID="DE1" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Deactivate"
                            Text="Deactivate" OnClientClick="return confirm('Are you sure you want to deactivate this record?');" />
                            <asp:LinkButton ID="A1" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Activate"
                                Text="Activate" OnClientClick="return confirm('Are you sure you want to Activate this record?');" />|
                        <asp:LinkButton ID="D1" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Delete"
                            Text="Delete" OnClientClick="return confirm('Are you sure you want to Delete this record?');" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="g1" />
        </div>
        <div align="center" id="FIELDSET1" runat="server" visible="false">
            <table style="width: 100%">
                <tr>
                    <td style="text-align: right; padding-right: 10px;">
                        <asp:DropDownList ID="dropUserGroup" runat="server" AutoPostBack="True" OnSelectedIndexChanged="dropUserGroup_SelectedIndexChanged"
                            Visible="false">
                            <asp:ListItem Value="0">-- Select User Group --</asp:ListItem>
                            <asp:ListItem Value="10101" Enabled="true">Back Office</asp:ListItem>
                            <asp:ListItem Value="101">Branch Office</asp:ListItem>
                            <%--<asp:ListItem Value="1001">FSO</asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <div class="user_phot_frame">
                                <asp:Image ID="imgStudent" runat="server" />
                            </div>
                            <label>
                                Login ID<span style="color: Red;">* </span>
                            </label>
                            <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>&nbsp&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatoruname" runat="server" ErrorMessage="Please Enter Login ID"
                            ControlToValidate="txtUserName" SetFocusOnError="true" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revlogid" runat="server" ControlToValidate="txtUserName"
                                ErrorMessage="Spaces Are Not Allowed!" ValidationGroup="g1" CssClass="rqd" ValidationExpression="[^\s]+" />
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
                            ControlToValidate="txtName" SetFocusOnError="true" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
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
                                Pin Code</label><asp:TextBox ID="txtPinCode" runat="server" CssClass="body" MaxLength="6"
                                    ValidationGroup="g1"></asp:TextBox>
                            &nbsp;
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                PhotoUpload
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
                            <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorpwd" runat="server" ErrorMessage="Please Enter Password"
                                ControlToValidate="txtPass" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Confirm Password<span style="color: Red;">*</span></label>
                            <asp:TextBox ID="txtRePass" runat="server" TextMode="Password"></asp:TextBox>&nbsp&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorconpwd" runat="server" ErrorMessage="Please Confirm Password"
                            ControlToValidate="txtRePass" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Both Password Should Be Same"
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorrole" runat="server" ErrorMessage="Please Select Role"
                            ControlToValidate="dropRole" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Active</label>
                            <asp:CheckBox ID="chkActive" runat="server" />
                        </div>
                    </td>
                </tr>
                <tr runat="server" visible="false" id="trRO" runat="server">
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
                    <td>
                        <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <asp:Button ID="btUpdate" runat="server" Text="Update" CssClass="button_save" OnClick="Button3_Click"
                                ValidationGroup="vg" />
                            <asp:Button ID="btSave" runat="server" Text="Save" CssClass="button_save" OnClick="btSave_Click"
                                ValidationGroup="vg" />
                            <asp:Button ID="Button4" runat="server" Text="Cancel" CssClass="button_save" OnClick="Button4_Click"
                                ValidationGroup="vg" CausesValidation="False" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="style9">
                        <asp:HiddenField ID="HfUid" runat="server" />
                        <asp:HiddenField ID="HfEID" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>