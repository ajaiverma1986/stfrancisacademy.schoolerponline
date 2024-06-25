<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="emplist.aspx.cs" Inherits="BranchPanel_EmployeeList"
    EnableEventValidation="false" %>

<%@ Register Src="~/branchpanel/employee/employee-managemen.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .activeofferlist {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
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

    <link href="../css/tooltip1.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="../js/top-script.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../../css/softwares_style.css" rel="stylesheet" />

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Staff Manager</a></li>
            <li style="background: none;"><a class="active">Employee List</a></li>
        </ul>
        <div class="arrowt">
            <a href="CreateOfferLetter.aspx">
                <img src="../../images/back-button.png" /></a>
        </div>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 12px; padding-top: 0px;"
            class="containerHeadline">
            Employee List of
            <asp:Label runat="server" ID="lblBranch"></asp:Label>
            <div style="float: right; width: 360px;">
                <asp:Label runat="server" ID="lblcounting" Text="Total"></asp:Label>
                <asp:Label runat="server" ID="lcount"></asp:Label>
            </div>
        </div>
        <br />
        <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" id="GridBatch">
            <tr>
                <td colspan="10" class="containerHeadline" style="padding-left: 10px;">

                    <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px" AutoPostBack="true"
                        Font-Size="11px" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged">
                        <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text="50"></asp:ListItem>
                        <asp:ListItem Value="2" Text="80"></asp:ListItem>
                        <asp:ListItem Value="3" Text="100"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:TextBox runat="server" ID="txtDate" placeholder="Search By Date" onkeypress="return noAlphabets(event)"
                        Height="22px" OnTextChanged="txtDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                    <div style="float: right; width: 510px;">
                        <asp:DropDownList ID="ddlsearchoption" runat="server" Width="150px" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlsearchoption_SelectedIndexChanged">
                            <asp:ListItem Value="0">Search Items</asp:ListItem>

                            <asp:ListItem Value="1">Name</asp:ListItem>
                            <asp:ListItem Value="2">Mobile</asp:ListItem>
                            <asp:ListItem Value="3">Status</asp:ListItem>
                            <asp:ListItem Value="4">Department</asp:ListItem>
                            <asp:ListItem Value="5">Designation</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlempstatus" runat="server" Width="150px">
                        </asp:DropDownList>
                        <asp:TextBox ID="Textbox1" runat="server" Width="150px" Height="23px"> </asp:TextBox>
                        <asp:Button ID="Button1" runat="server" Text="Go" Height="22px" ToolTip="Click here to search for records."
                            CssClass="view-enquiry" OnClick="Button1_Click" />
                    </div>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="6" style="width: 100%; padding-left: 0px; padding-right: 0px;">

                    <asp:GridView runat="server" ID="gvDetails" EmptyDataText="No Record Found." AutoGenerateColumns="false"
                        Width="100%" ShowHeader="false" GridLines="None" OnRowCommand="gvDetails_RowCommand"
                        OnRowDataBound="gvDetails_RowDataBound" OnRowDeleting="gvDetails_RowDeleting">
                        <Columns>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <div class="student-photo_frame1">
                                        <div class="student-photo_frame_img">
                                            <asp:Image runat="server" ID="imgsource" ImageUrl='<%# Eval("photo") %>' />
                                            <asp:HiddenField ID="hfimage" runat="server" Value='<%# Eval("eid") %>' />
                                        </div>
                                        <div style="float: left;">
                                            <div class="user-deatils1">
                                                <asp:LinkButton ID="lblbraddress1" data-placement="right" ToolTip="Click here to see Profile." rel="tooltip" class="span2" CssClass="swet" runat="server" Text='<%# Eval("EmployeeName") %>'
                                                    CommandArgument='<%#
                                        Eval("eid") %>'
                                                    CommandName="emppofile"></asp:LinkButton>
                                            </div>
                                            <div class="clear">
                                            </div>
                                            <div class="user-deatils1">
                                                <dt>Mobile No.</dt>
                                                <cite>:</cite> <span>
                                                    <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("mobile") %>'></asp:Label>
                                                </span>
                                            </div>
                                            <div class="clear">
                                            </div>
                                            <div class="user-deatils1">
                                                <dt>Joining Date </dt>
                                                <cite>:</cite> <span>
                                                    <asp:Label runat="server" ID="lblJoinDate" Text='<%#Eval("Joindate") %>'></asp:Label>
                                                </span>
                                                <br />
                                                <dt>Status </dt>
                                                <cite>:</cite> <span>
                                                    <asp:Label runat="server" ID="Label1" Text='<%#Eval("status") %>'></asp:Label>
                                                </span>
                                                <div class="del-active">
                                                    <asp:LinkButton ID="lnkdel" runat="server" CommandArgument='<%# Eval("eid")%>' CommandName="delete" Text="Delete" ToolTip="Click here to delete this employee." Font-Underline="true"> </asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="10" class="containerHeadline" style="padding-left: 10px;">
                    <asp:DropDownList ID="PageNo" runat="server" Width="80px" AutoPostBack="true" Font-Size="11px"
                        OnSelectedIndexChanged="PageNo_SelectedIndexChanged">
                    </asp:DropDownList>
                    <div style="margin-left: 350px; float: left; width: 300px;">
                        <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px"
                            OnClick="firstpage_Click" />
                        <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px"
                            OnClick="previous_Click" />
                        <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px"
                            OnClick="next_Click" />
                        <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px"
                            OnClick="last_Click" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>