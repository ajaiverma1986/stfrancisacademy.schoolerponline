<%@ Page Title="Overdue List" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="OverDueList.aspx.cs" Inherits="BranchPanel_OverDueList"
    EnableEventValidation="false" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/1.4-query.min.js" type="text/javascript"></script>
    <script src="../js/1.8-jquery-ui.min.js" type="text/javascript"></script>
    <link href="../js/1.8-themes-base-jquery-ui.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var brid = 0;
        function pageLoad() {
            brid = '<%= Session["BrBrid"] %>'

            $("#<%=txtnamesearch.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/TimeTable.asmx/getstudentdashboard") %>',
                        data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.length > 0) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[0],
                                        val: item.split('-')[1],
                                        val1: item.split('-')[2]

                                    };
                                }))
                            }
                            else {
                                response([{ label: 'No results found.', val: -1 }]);
                            }

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (e, i) {

                },
                minLength: 1
            });

            $("#<%=txtadmission.ClientID %>").autocomplete({
                source: function (request, response) {

                    $.ajax({
                        url: '<%=ResolveUrl("~/TimeTable.asmx/admissionsearch") %>',
                        data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.length > 0) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[0],
                                        val: item.split('-')[1],
                                        val1: item.split('-')[2]

                                    };
                                }))
                            }
                            else {
                                response([{ label: 'No results found.', val: -1 }]);
                            }

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (e, i) {

                },
                minLength: 1
            });

            $("#<%=txtclass.ClientID %>").autocomplete({
                source: function (request, response) {

                    $.ajax({
                        url: '<%=ResolveUrl("~/TimeTable.asmx/searchclass") %>',
                        data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.length > 0) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[0],
                                        val: item.split('-')[1],
                                        val1: item.split('-')[2]

                                    };
                                }))
                            }
                            else {
                                response([{ label: 'No results found.', val: -1 }]);
                            }

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (e, i) {

                    $("#<%=HiddenField1.ClientID %>").val(i.item.val);
                },
                minLength: 1
            });

            };
    </script>

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

    <style>
        .active66 {
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

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Fee Management</a></li>
            <li><a href="#">Fee Report</a></li>
            <li style="background: none;"><a class="active" href="#">OverDue List</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                    class="containerHeadline">
                    Overdue Fee List
            <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="false"
                CausesValidation="false" OnClick="ImageButton1_Click" Height="20px" CssClass="excel12"
                ToolTip="Click here to download Excel sheet" />
                </div>
                &nbsp;&nbsp;<asp:Label runat="server" ID="lblmsg" ForeColor="#0099FF" Font-Size="20px"
                    Visible="false"></asp:Label><br />
                <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" id="GridBatch">
                    <tr>
                        <td align="left" style="margin-left: 10px;">
                            <br />
                            <div>
                                <table style="width: 300px">
                                    <tr>
                                        <td valign="top" align="left">
                                            <div class="conductedlecture234" style="background: #C4E5F6; margin-left: 10px;">
                                                <asp:Label runat="server" ID="lbl1" Text="Total Overdue Entries" Font-Bold="true" ForeColor="#1198B8"></asp:Label><br />
                                                <asp:Label ID="lblConduted" runat="server" Text="0" ForeColor="#1198B8" Font-Bold="true"></asp:Label>
                                            </div>
                                        </td>
                                        <td valign="top" align="left">
                                            <div class="conductedlecture234" style="background: #F2DEDE; margin-left: 20px;">
                                                <asp:Label runat="server" ID="Label1" Text="Total Overdue Amount" Font-Bold="true" ForeColor="#C76F6E"></asp:Label><br />
                                                <asp:Label ID="Label2" runat="server" Text="₹" Font-Bold="true" ForeColor="#C76F6E"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblPresent" runat="server" Text="0" Font-Bold="true" ForeColor="#C76F6E"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </div>
                        </td>
                    </tr>

                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                        class="stm">
                        <tr>
                            <td colspan="10" class="containerHeadline">
                                <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px"
                                    Font-Size="11px" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="10"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="20"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="50"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="100"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="200"></asp:ListItem>
                                </asp:DropDownList>

                                <div style="float: right; width: 550px;">
                                    <asp:TextBox ID="txtclass" runat="server" placeholder="Enter class" Width="150px" Height="23px"> </asp:TextBox>
                                    <asp:TextBox ID="txtadmission" runat="server" Width="150px" Height="23px" placeholder="Enter Admission No"> </asp:TextBox>
                                    <asp:TextBox ID="txtnamesearch" runat="server" Width="150px" Height="23px" placeholder="Enter Name"> </asp:TextBox>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                    <asp:Button ID="Button1" runat="server" Text="Go" Height="23px" ToolTip="Click here to search items"
                                        CssClass="view-enquiry" OnClick="Button1_Click" />
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="false"
                                        OnClick="ImageButton1_Click" Height="20px" CssClass="excel" ToolTip="Click here to download Excel sheet" />
                                </div>
                            </td>
                        </tr>
                    </table>

                    <tr>

                        <td align="left" colspan="6" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView runat="server" ID="gvdetails" AutoGenerateColumns="false"
                                Width="100%" CssClass="stm" GridLines="None">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Name">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lbstu" CommandArgument='<%#Eval("adid") %>'
                                                Text='<%#Eval("name") %>' CommandName="gotop" ForeColor="#41BBEC" Font-Underline="true"
                                                ToolTip="Click here to pay fee for this student." Font-Bold="true" CssClass="name"></asp:LinkButton>
                                            <asp:Label ID="lblrid" runat="server" CssClass="ridcss" Text='<%# Bind("adid") %>' Style="display: none;"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="adno" HeaderText="Rollno" ItemStyle-Width="10%"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="applyclass" HeaderText="Class" ItemStyle-Width="10%"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <%--   <asp:TemplateField HeaderText="Due Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblDate2" runat="server" Text='<%# Eval("date") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Total Amount (₹)" Visible="false">
                                        <ItemTemplate>

                                            <asp:Label ID="lblDafddte23" runat="server" Font-Bold="true" Text='<%# Eval("actualfee","{0:0.00}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Due Amount (₹)">
                                        <ItemTemplate>

                                            <asp:Label ID="lblDate23" ForeColor="#C76F6E" runat="server" Font-Bold="true" Text='<%# Eval("payablefee","{0:0.00}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Fine Amount (₹)" Visible="false">
                                        <ItemTemplate>

                                            <asp:Label ID="lblDate23" ForeColor="Red" runat="server" Font-Bold="true" Text='<%# Eval("fine","{0:0.00}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Send Reminder">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lbsms" Text="Send SMS" Enabled="false" Font-Underline="true"
                                                ToolTip="Click here to send reminder for fee." CommandArgument='<%#Eval("adid") %>'
                                                ForeColor="#9EB57F" CommandName="sms"></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Actual Payable Amount">
                                <ItemTemplate>
                                    Rs
                                    <asp:Label ID="lblDate232" runat="server" Text='<%# Eval("payable","{0:0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>--%>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />
                                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>

                        <td colspan="10" class="containerHeadline pagingstrip" style="padding-left: 10px; padding-bottom: 5px;">
                            <asp:DropDownList ID="PageNo" runat="server" Width="85px" OnSelectedIndexChanged="PageNo_SelectedIndexChanged" AutoPostBack="true">
                            </asp:DropDownList>
                            <div style="float: right; width: 153px;">
                                <asp:ImageButton ID="firstpage" runat="server" CssClass="first-click" ImageUrl="~/images/first.gif" Width="25px" OnClick="firstpage_Click" />

                                <asp:ImageButton ID="previous" runat="server" CssClass="previous-click" ImageUrl="~/images/previous.gif" Width="25px" OnClick="previous_Click" />
                                <asp:ImageButton ID="next" runat="server" CssClass="next-click" ImageUrl="~/images/next.gif" Width="25px" OnClick="next_Click" />
                                <asp:ImageButton ID="last" runat="server" CssClass="last-click" ImageUrl="~/images/last.gif" Width="25px" OnClick="last_Click" />
                            </div>
                        </td>
                    </tr>
                </table>
                <%-- <tr>
                <td colspan="10" class="containerHeadline" style="padding-left: 10px; padding-bottom: 5px;">
                    <asp:DropDownList ID="PageNo" runat="server" Width="80px" style="float:left">
                    </asp:DropDownList>
                    <div style="margin-left: 350px; float: left; width: 300px;">
                        <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px" />
                        <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px" />
                        <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px" />
                        <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px" />
                    </div>
                </td>
            </tr>--%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>