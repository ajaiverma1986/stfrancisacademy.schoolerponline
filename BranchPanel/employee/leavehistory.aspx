<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="leavehistory.aspx.cs" Inherits="branchpanel_employee_leavehistory" %>

<%@ Register Src="~/BranchPanel/employee/leave-managment.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" media="all" />

    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style type="text/css">
        .important {
            color: white!important;
        }

        .leavehistory {
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

        var fname = "", datefirst = '', datesecond = '', leavetype = '', pagesize = 0, pageno = 1, fyid = "";

        function pageLoad() {

            document.title = 'Leave History';

            setleavestatus();

            $("#ContentPlaceHolder1_txtreferenceno").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2014:2016',
                dateFormat: "d MM yy",
            });
            $("#ContentPlaceHolder1_txtcontactno").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2014:2016',
                dateFormat: "d MM yy",
            });
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
        }
        function setleavestatus() {

            var gvDrv = document.getElementById("<%=gvdetails.ClientID %>");

            for (i = 1; i < gvDrv.rows.length; i++) {

                var leavestatus = $("#ContentPlaceHolder1_gvdetails tr:eq(" + i + ") td:eq(6)").find("span").text();
                if (leavestatus == "Approved") {
                    $("#ContentPlaceHolder1_gvdetails tr:eq(" + i + ") ").css("background", "#46B525");
                }
                if (leavestatus == "Cancel") {

                    $("#ContentPlaceHolder1_gvdetails tr:eq(" + i + ") ").css("background", "red");
                    $("#ContentPlaceHolder1_gvdetails tr:eq(" + i + ") td ").addClass("important");

                }

            }
        }

        $(document).ready(function () {
            $('#ContentPlaceHolder1_txtName').on('change keyup paste', function () {
                fname = $(this).val();
                BindGridMain();
                setleavestatus();
            });
            $('#ContentPlaceHolder1_txtreferenceno').on('change keyup paste', function () {
                datefirst = $(this).val();
                pageno = 1;
                BindGridMain();
                setleavestatus();
            });
            $('#ContentPlaceHolder1_txtcontactno').on('change keyup paste', function () {
                datesecond = $(this).val();
                pageno = 1;
                BindGridMain();
                setleavestatus();
            });
            $('#ContentPlaceHolder1_ddlleavetype').on('change', function () {
                leavetype = $(this).val();
                pageno = 1;
                BindGridMain();
                setleavestatus();
            });
            $("#ContentPlaceHolder1_ddlfinicialyear").on('change', function () {
                fyid = $(this).val();
                pageno = 1;
                BindGridMain();
                setleavestatus();
            });

            $('#ContentPlaceHolder1_txtempname').on('change keyup paste', function () {
                fname = $(this).val();
                BindGridhalfday();
            });

            $('#ContentPlaceHolder1_ddlhalfdaystatus').on('change', function () {
                leavetype = $(this).val();
                BindGridhalfday();

            });

            $("#btnfirst").click(function () {
                pageno = 1;
                $("#ContentPlaceHolder1_lblpage").html(pageno);
                BindGridMain();
            });
            $("#btnprev").click(function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $("#ContentPlaceHolder1_lblpage").html(pageno);
                    BindGridMain();
                }
            });
            $("#btnnext").click(function () {
                if (parseInt(pageno) <= parseInt(pagesize)) {
                    pageno = parseInt(pageno) + 1;
                    $("#ContentPlaceHolder1_lblpage").html(pageno);
                    BindGridMain();
                }

            });
            $("#btnlast").click(function () {
                pageno = pagesize;
                $("#ContentPlaceHolder1_lblpage").html(pageno);
                BindGridMain();
            });

        });

        function BindGridMain() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "leavehistory.aspx/BindDatatable",
                data: "{'fname':'" + fname + "','datefirst':'" + datefirst + "','datesecond':'" + datesecond + "','leavetype':'" + leavetype + "','pageno':'" + pageno + "','fyid':'" + fyid + "'}",
                dataType: "json",
                success: function (data) {
                    var j = 1;
                    if (data.d.length > 0) {
                        $("#ContentPlaceHolder1_gvdetails").show(500);
                        $("#footerpaging").css("display", "block");
                        $("[id*=gvdetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                            $("[id$=gvdetails]").append(row);
                            $(row).find('.index').html(data.d[i].rownumber);
                            $(row).find('.refNo').html(data.d[i].refNo);
                            $(row).find('.empname').html(data.d[i].name);
                            $(row).find('.Leave_Start_From').html(data.d[i].Leave_Start_From);
                            $(row).find('.Leave_Apply_Date').html(data.d[i].Leave_Apply_Date);
                            $(row).find('.Leave_Type').html(data.d[i].Leave_Type);
                            $(row).find('.leave_status').html(data.d[i].leave_status);
                            pagesize = data.d[i].pagecount;
                            if (pagesize == 1) {
                                $("#ContentPlaceHolder1_lblTotalPages").text("1");
                                $("#ContentPlaceHolder1_lblpage").text("1");
                            }
                            else {
                                $("#ContentPlaceHolder1_lblTotalPages").text(pagesize);
                                $("#ContentPlaceHolder1_lblpage").text(pageno);
                            }
                            j = j + 1;
                            setleavestatus();
                        }
                        $("[id*=gvdetails] tr").show();
                        $("[id*=gvdetails] tr:eq(1)").hide();
                    }
                    else {

                        alertify.error("There not any record related this this keyword");
                        $("#ContentPlaceHolder1_gvdetails").hide(500);
                        $("#footerpaging").css("display", "none");

                    }
                },
                error: function (result) {
                }
            });
        }
        function BindGridhalfday() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "leavehistory.aspx/BindDatatableforhalfday",
                data: "{'fname':'" + fname + "','leavetype':'" + leavetype + "'}",
                dataType: "json",
                success: function (data) {
                    var j = 1;
                    if (data.d.length > 0) {
                        $("#ContentPlaceHolder1_gvleavedetails").show(500);
                        $("#footerpaging").css("display", "block");
                        $("[id*=gvleavedetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvleavedetails] tr:eq(1)").clone(true);
                            $("[id$=gvleavedetails]").append(row);
                            $(row).find('.index').html(j);
                            $(row).find('.refNo').html(data.d[i].refNo);
                            $(row).find('.empname').html(data.d[i].name);
                            $(row).find('.hd_date').html(data.d[i].hd_date);
                            $(row).find('.halfday1').html(data.d[i].halfday);
                            //pagesize = data.d[i].pagecount;
                            //if (pagesize == 1) {
                            //    $("#ContentPlaceHolder1_lblTotalPages").text("1");
                            //    $("#ContentPlaceHolder1_lblpage").text("1");
                            //}
                            //else {
                            //    $("#ContentPlaceHolder1_lblTotalPages").text(pagesize);
                            //    $("#ContentPlaceHolder1_lblpage").text(pageno);
                            //}
                            j = j + 1;

                        }
                        $("[id*=gvleavedetails] tr").show();
                        $("[id*=gvleavedetails] tr:eq(1)").hide();
                    }
                    else {

                        alertify.error("There is not any record related this this keyword");
                        $("#ContentPlaceHolder1_gvleavedetails").hide(500);

                    }
                },
                error: function (result) {
                }
            });
        }
    </script>

    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li style="background: none;"><a title="Get New Leaves" href="requestleavelist.aspx">Leave Managment</a></li>
            <li style="background: none;"><a class="active" href="requestleavelist.aspx">Leave History</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="width: 100%; background: #016fa7; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
            <label id="leavdetailsbin">Leave History</label>
            <a href="requestleavelist.aspx" title="Get Leave List" style="cursor: pointer; display: none; color: #fff; float: right; margin-right: 20px;">Back</a>
        </div>
        <div id="griddetails" style="float: left; width: 100%;">
            <div class="containerHeadline" style="width: 100%">

                <div style="float: right; width: 1000px;">

                    <asp:DropDownList ID="ddlfinicialyear" runat="server" Width="95px" Style="float: right" Font-Size="12px"></asp:DropDownList>
                    <asp:DropDownList ID="ddlleavetype" runat="server" Width="95px" Style="float: right" Font-Size="12px"></asp:DropDownList>
                    <asp:TextBox ID="txtcontactno" runat="server" Width="120px" Font-Size="12px" Style="float: right" placeholder="Leave Applied"> </asp:TextBox>
                    <asp:TextBox ID="txtreferenceno" runat="server" Width="120px" Font-Size="12px" Style="float: right" placeholder="Leave From" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtName" runat="server" Width="120px" Font-Size="12px" placeholder="Emp Name" Style="float: right" Height="23px"> </asp:TextBox>
                </div>
            </div>

            <asp:GridView runat="server" ID="gvdetails" AllowPaging="true" EmptyDataText="No Leave Details."
                ShowFooter="false" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="sno" runat="server" Text='<%#Eval("RowNumber") %>' CssClass="index"> </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp ID">
                        <ItemTemplate>
                            <asp:Label ID="sno2" runat="server" Text='<%#Eval("refNo") %>' CssClass="refNo"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp Name">
                        <ItemTemplate>
                            <asp:Label ID="sno1" runat="server" Text='<%#Eval("name") %>' CssClass="empname"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave From">
                        <ItemTemplate>
                            <asp:Label ID="sno3" runat="server" Text='<%#Eval("Leave_Start_From","{0:dd/MM/yyyy}") %>' CssClass="Leave_Start_From"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave Applied">
                        <ItemTemplate>
                            <asp:Label ID="sno4" runat="server" Text='<%#Eval("Leave_Apply_Date","{0:dd/MM/yyyy}") %>' CssClass="Leave_Apply_Date"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave Type">
                        <ItemTemplate>
                            <asp:Label ID="sno5" runat="server" Text='<%#Eval("Leave_Type") %>' CssClass="Leave_Type"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="sno6" runat="server" Text='<%#Eval("leave_status") %>' CssClass="leave_status"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
            <div align="left" style="width: 1070px" class="containerHeadline" id="footerpaging">
                <div style="margin-left: 0px; float: left; width: 500px;">
                    <asp:Label ID="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                    <asp:Label ID="Label1" runat="server" Style="color: green; font-size: 11pt"></asp:Label>
                    Of
                <asp:Label ID="lblTotalPages" Text="1" Style="margin-left: 0px; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                    <span style="font-size: 11pt">Page</span>
                </div>

                <div style="margin-left: 0px; float: left; width: 500px;">
                    <img src="../../images/first.gif" id="btnfirst" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/previous.gif" id="btnprev" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/next.gif" id="btnnext" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/last.gif" id="btnlast" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                </div>
            </div>
            <br />
            <br />
            <div style="width: 100%; background: #016fa7; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
                <label id="Label2">Half Day History</label>
            </div>
            <div class="containerHeadline" style="width: 100%">

                <div style="float: right; width: 1000px;">
                    <asp:DropDownList ID="ddlhalfdaystatus" runat="server" Width="95px" Style="float: right" Font-Size="12px">
                        <asp:ListItem Value="2">--Status--</asp:ListItem>
                        <asp:ListItem Value="1">Approve</asp:ListItem>
                        <asp:ListItem Value="0">Cancel</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtempname" runat="server" Width="120px" Font-Size="12px" placeholder="Emp Name" Style="float: right" Height="23px"> </asp:TextBox>
                </div>
            </div>
            <asp:GridView runat="server" ID="gvleavedetails" AllowPaging="true" EmptyDataText="No Leaves taken yet."
                PageSize="50" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="sno" runat="server" CssClass="index" Text="<%#Container.DataItemIndex+1 %>">  </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp ID">
                        <ItemTemplate>
                            <asp:Label ID="sno2" runat="server" Text='<%#Eval("refNo") %>' CssClass="refNo"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp Name">
                        <ItemTemplate>
                            <asp:Label ID="sno1" runat="server" Text='<%#Eval("name") %>' CssClass="empname"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="sno3" runat="server" Text='<%#Eval("hd_date","{0:dd/MM/yyyy}") %>' CssClass="hd_date"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="When">
                        <ItemTemplate>
                            <asp:Label ID="sno4" runat="server" Text='<%#Eval("halfday") %>' CssClass="halfday1"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="sno4" runat="server" Text="Pending" CssClass="leavestatus"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
            <br />
            <br />
            <div style="float: left; margin-bottom: 10px;" id="getindicators">
                <div style="height: 15px; width: 53px; text-align: center; background: #FF0000; float: left; margin-left: 10Px; color: white; padding: 5px">Cancel</div>
                <div style="height: 15px; width: 53px; text-align: center; background: #46B525; float: left; margin-left: 10Px; color: white; padding: 5px">Approved</div>
            </div>
        </div>
    </div>
</asp:Content>