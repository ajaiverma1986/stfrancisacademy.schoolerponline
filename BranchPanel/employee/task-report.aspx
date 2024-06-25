<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="task-report.aspx.cs" Inherits="branchpanel_employee_task_report" %>

<%@ Register Src="employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>

    <style type="text/css">
        .activetaskmanagement {
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

        #ctl00_ContentPlaceHolder1_gvdetails tr td {
            text-align: justify;
        }

        #ctl00_ContentPlaceHolder1_gvdetails tr td {
            text-align: justify;
        }

        .important {
            color: white!important;
        }

            .important a {
                color: white!important;
            }

        .importantuc {
            color: black!important;
        }

            .importantuc a {
                color: red!important;
            }
    </style>
    <script type="text/javascript">
        function pageLoad() {
            document.title = 'Task';

            settaskstatus();
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

        }
        function settaskstatus() {

            var gvDrv = document.getElementById("<%=gvdetails.ClientID %>");

            for (i = 1; i < gvDrv.rows.length; i++) {
                var taskstatus = $("#ctl00_ContentPlaceHolder1_gvdetails tr:eq(" + i + ") td:eq(6)").find("a").html();

                if (taskstatus == "Completed") {
                    $("#ctl00_ContentPlaceHolder1_gvdetails tr:eq(" + i + ") ").css("background", "#46B525");
                    $("#ctl00_ContentPlaceHolder1_gvdetails tr:eq(" + i + ") td ").addClass("important");
                }
                if (taskstatus == "Get Update") {

                    $("#ctl00_ContentPlaceHolder1_gvdetails tr:eq(" + i + ") ").css("background", "#C3C3C3");
                    $("#ctl00_ContentPlaceHolder1_gvdetails tr:eq(" + i + ") td ").addClass("importantuc");
                }

            }
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Task</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" id="GridBatch">
            <tr>
                <td align="left" colspan="6" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView runat="server" ID="gvdetails" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None" OnRowCommand="gvdetails_RowCommand" OnRowDataBound="gvdetails_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S.No." ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Task">
                                <ItemTemplate>
                                    <asp:Label ID="lblDate" runat="server" Text='<%# Eval("taskDescription") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="25%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Assigned On">
                                <ItemTemplate>
                                    <asp:Label ID="lblDate1" runat="server" Text='<%# Eval("assignedon") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Completion Time">
                                <ItemTemplate>
                                    <asp:Label ID="lnkStudents1" runat="server" Text='<%# Eval("range") %>' ForeColor="Black"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="19%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Accepted Date">
                                <ItemTemplate>
                                    <asp:Label ID="lnkStudents12" runat="server" Text='<%# Eval("task_accept_date") %>' ForeColor="Black"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Time">
                                <ItemTemplate>
                                    <asp:HiddenField runat="server" ID="hftaskid" Value='<%#Eval("taskid") %>'></asp:HiddenField>
                                    <asp:Label ID="lnkgettotaltime" runat="server" CssClass="totaltime" Text='<%# Eval("totaltime") %>' ForeColor="Black"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remark">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" CssClass="getstatus" ID="lkaccept" Text="Get Update" CommandArgument='<%# Eval("ename") + ","+Eval("taskid") %>' CommandName="accept"></asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="9%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
        </table>

        <asp:Label ID="lblmessage" runat="server" Style="color: red !important; font-size: 15px !important; margin-left: 50px !important; margin-bottom: 10px !important;">No Record Found.</asp:Label>
    </div>
</asp:Content>