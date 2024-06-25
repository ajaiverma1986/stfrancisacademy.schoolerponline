<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="advance-leave.aspx.cs" Inherits="branchpanel_employee_today_leave" %>

<%@ Register Src="~/BranchPanel/employee/leave-managment.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <style>
        .todayleave {
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
    <script type="text/javascript">
        function pageLoad() {
            document.title = 'Advance Paid Leaves';
        }

        $(document).ready(function () {
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $(".getdetails").click(function () {

                var leaveid = $(this).parents("tr").find("input[type='hidden']").val();
                getleavesdetails(leaveid);

                $("#ContentPlaceHolder1_leaveid").val(leaveid);
                return false;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "requestleavelist.aspx/getleavedetails",
                    data: "{ 'leaveid':'" + leaveid + "'}",
                    dataType: "json",
                    success: function (data) {
                        $("#griddetails").css("display", "none");
                        $("#divpostreview").css("display", "block");
                        $("#getleavesgrid").css("display", "block");

                        $("#ContentPlaceHolder1_hfleaveid").val(leaveid);
                        $("#ContentPlaceHolder1_txtname").val(data.d[0].name);
                        $("#ContentPlaceHolder1_txtempid").val(data.d[0].empid);
                        $("#ContentPlaceHolder1_txtlastapply").val(data.d[0].lastleave);
                        $("#ContentPlaceHolder1_txtstartdate").val(data.d[0].leavefrom);
                        $("#ContentPlaceHolder1_txtenddate").val(data.d[0].leaveto);
                        $("#ContentPlaceHolder1_txtleavetype").val(data.d[0].leavetype);
                        $("#ContentPlaceHolder1_txtRemark").val(data.d[0].adminremark);
                        $("#ContentPlaceHolder1_txtapplydate").val(data.d[0].leaveapplydate);
                        $("#ContentPlaceHolder1_ddlStatus option:seleted").val(data.d[0].leavestatus);

                    },
                    error: function (result) {
                        alert('error');
                    },
                });

            });
            $("#getleavesgrid").click(function () {
                $("#griddetails").css("display", "block");
                $("#divpostreview").css("display", "none");
                $("#getleavesgrid").css("display", "none");

            });

            $("#ContentPlaceHolder1_btnback").click(function () {

            });

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

        });
    </script>

    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Leave Managment</a></li>
            <li style="background: none;"><a class="active" href="requestleavelist.aspx">Advance Paid Leaves</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div style="width: 100%; background: #016fa7; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
            <label id="leavdetailsbin">Advance Paid Leaves </label>
        </div>
        <div id="griddetails" style="float: left; width: 100%;">

            <asp:GridView runat="server" ID="gvleavedetails" AllowPaging="true" EmptyDataText="There is not any advance paid leave"
                PageSize="10" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp Name">
                        <ItemTemplate>
                            <asp:Label ID="sno2" runat="server" Text='<%#Eval("empname") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp Code">
                        <ItemTemplate>
                            <asp:Label ID="sno1" runat="server" Text='<%#Eval("empcode") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Advance Paid Leave">
                        <ItemTemplate>
                            <asp:Label ID="sno3" runat="server" Text='<%#Eval("totalleave") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>