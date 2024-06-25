<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="halfday-list.aspx.cs" Inherits="branchpanel_employee_halfday_list" %>
<%@ Register Src="~/BranchPanel/employee/empdetails.ascx" TagName="employee" TagPrefix="UC" %>
<%@ Register Src="~/BranchPanel/employee/leave-managment.ascx" TagName="emp" TagPrefix="UC1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style type="text/css">
        .halfday {
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

        .showpopup {
            opacity: 1;
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #2CA8C2;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: 336px;
            left: 65%;
            overflow: scroll;
            position: fixed;
            top: 65%;
            width: 878px;
            z-index: 2147483647;
        }

        #divMessage table td {
            padding: 7px;
        }

        #ctl00_ContentPlaceHolder1_radioapproveunapprove td label {
            padding: 5px;
        }

        #ctl00_ContentPlaceHolder1_radioapproveunapprove td input {
            padding: 5px;
        }

        #ctl00_ContentPlaceHolder1_radiopaidunpaid td label {
            padding: 5px;
        }

        #ctl00_ContentPlaceHolder1_radiopaidunpaid td input {
            padding: 5px;
        }
    </style>
    <script type="text/javascript">
        var halfdayid = "", eid = "", employeecode = "", date = "", half = "", isapprove = "", ispaid = "0";
        function pageLoad() {
            document.title = 'Applied Half Days';
        }

        $(document).ready(function () {
            BindGridMain();
            $("#linkleave").attr("href", "requestleavelist.aspx"); //set url for webmethod in applied leave
            $("#imgheaderlogo").attr('src', '../../images/logo.png');//set path for logo
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');//call webmethod from page to new applied leave

            $(".getdetails").click(function () {
                halfdayid = $(this).parents("tr").children("td:eq(5)").find("input[type='hidden']").val();
                eid = $(this).parents("tr").children("td:eq(0)").find("input[type='hidden']").val();
                employeecode = $(this).parents("tr").children("td:eq(1)").find("span").text();
                date = $(this).parents("tr").children("td:eq(3)").find("span").text();
                half = $(this).parents("tr").children("td:eq(4)").find("span").text();
                gettotalleave(employeecode);
                $("#empcode").html(employeecode);
                $("#hddate").html(date);
                $("#gethalf").html(half);
                $("#divMessage").show(500);
            });
            $("#tdClosepopup").click(function () {
                $("#divMessage").hide(500);
            });

            $("#ctl00_ContentPlaceHolder1_radioapproveunapprove").change(function () {
                isapprove = $(this).find(":checked").val();
                if (isapprove == 1) {
                    $("#ispaid").show(500);
                }
                if (isapprove == 2) {
                    $("#ispaid").hide(500);
                }

            });
            $("#ctl00_ContentPlaceHolder1_radiopaidunpaid").change(function () {
                ispaid = $(this).find(":checked").val();
                if (ispaid == 1) {
                    ispaid = 1;
                }
                if (isapprove == 2) {
                    ispaid = 0;
                }

            });
            function getvalidate() {
                var status = 1;
                if ($("[id$=radioapproveunapprove]").find("input:checked").length == 0) {
                    alertify.error('Please select Approve/Reject.');
                    status = 0
                    return false;

                }
                if (isapprove == 1) {

                    if ($("[id$=radiopaidunpaid]").find("input:checked").length == 0) {
                        alertify.error('Please select Paid/Unpaid.');
                        status = 0
                        return false;

                    }
                }

                if (status = 0) {
                    return false;
                }
                else {
                    return true;
                };

            }
            $("#ctl00_ContentPlaceHolder1_btnsethalf").click(function () {

                var isvalidate = getvalidate();
                if (isvalidate == false) {
                    return false;
                }
                if (isvalidate == true) {

                    if (isapprove == 2) {
                        isapprove = 0;
                    }
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "halfday-list.aspx/addhalfday",
                        data: "{'hdid':'" + halfdayid + "', 'ispaid':'" + ispaid + "', 'isapprove':'" + isapprove + "'}",
                        dataType: "json",
                        success: function (data) {
                            alertify.success("Half Day addded..");
                            $("#ispaid").hide(500);
                            $("#divMessage").hide(500);

                            $("table[id$=radioapproveunapprove] input:radio").each(function (i, x) {
                                if ($(x).is(":checked")) {
                                    $(x).removeAttr("checked");
                                }
                            });
                            $("table[id$=radiopaidunpaid] input:radio").each(function (i, x) {
                                if ($(x).is(":checked")) {
                                    $(x).removeAttr("checked");
                                }
                            });
                            BindGridMain();
                        },
                        error: function (result) {
                            alertify.error("error");
                        }
                    });

                }
                return false;
            });
        });

        function gettotalleave(employeecode) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/gettotalleave",
                data: "{ 'empcode':'" + employeecode + "'}",
                dataType: "json",
                success: function (data) {
                    $("#totaltaklenleave").html(data.d[0].totalleave);
                    $("#totalpaid").html(data.d[0].totalpaid);
                    $("#totalunpaid").html(data.d[0].totalunpaid);
                    $("#lblreject").html(data.d[0].totalreject);
                    $("#available").html(data.d[0].Available);
                    $("#lblearnpaid").html(data.d[0].Earnpaid);
                    $("#emailid").html(data.d[0].emailid);
                },
                error: function (result) {
                }
            });
        }

        function BindGridMain() {
            $("#ctl00_ContentPlaceHolder1_gvleavedetails").show(500);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "halfday-list.aspx/BindDatatable",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    var j = 1;
                    if (data.d.length > 0) {
                        $("[id*=gvleavedetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvleavedetails] tr:eq(1)").clone(true);
                            $("[id$=gvleavedetails]").append(row);
                            $(row).find('.index').html(j);
                            $(row).find('.refNo').html(data.d[i].refNo);
                            $(row).find('.name').html(data.d[i].name);
                            $(row).find('.hd_date').html(data.d[i].hd_date);
                            $(row).find('.halfday1').html(data.d[i].halfday);
                            $(row).find("input[type=hidden][id*=hfid]").val(data.d[i].hdid);
                            $(row).find("input[type=hidden][id*=userid]").val(data.d[i].eid);
                            j = j + 1;
                        }
                        $("[id*=gvleavedetails] tr").show(500);
                        $("[id*=gvleavedetails] tr:eq(1)").hide(500);
                    }
                    else {
                        $("[id*=gvleavedetails] tr").hide(500);
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
            <li><a>Leave Managment</a></li>
            <li style="background: none;"><a class="active" href="requestleavelist.aspx">Applied Half Days</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        div id="usercontrol">
            <UC1:emp runat="server" ID="empuser" />
            <UC:employee runat="server" ID="userctl" />
        </div>
        <div style="width: 100%; background: #016fa7; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
            <label id="leavdetailsbin">Half Day Request </label>
        </div>

        <asp:GridView runat="server" ID="gvleavedetails" AllowPaging="true" EmptyDataText="No Leaves taken yet."
            PageSize="50" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
            <Columns>
                <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:HiddenField runat="server" ID="userid" Value='<%# Eval("eid") %>' />
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
                        <asp:Label ID="sno1" runat="server" Text='<%#Eval("name") %>' CssClass="name"> </asp:Label>
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
                <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Action">
                    <ItemTemplate>
                        <asp:HiddenField ID="hfid" runat="server" Value='<%#Eval("hdid")%>' />
                        <a class="getdetails" title="Click here to get details" style="cursor: pointer; color: #000;">Get Details</a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
            <RowStyle CssClass="stm_light" />
            <AlternatingRowStyle CssClass="stm_dark" />
            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
        </asp:GridView>

        <div id="divMessage" class="showpopup" style="text-align: center; display: none">

            <div style="text-align: right;">
                <a id="tdClosepopup" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
            </div>

            <div id="tab1">
                <div style="float: left;" id="getindicators">
                    <div style="height: 15px; text-align: center; width: 140px; background: #F0953F; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                        Max Paid/Year:<label id="available"></label>
                    </div>
                    <br />

                    <div style="height: 15px; text-align: center; width: 140px; background: #433DAA; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">Earned  Paid:<label id="lblearnpaid"></label></div>
                    <br />
                    <div style="text-align: center; height: 15px; width: 140px; background: #0DB3BD; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                        Total Leave Taken:
                    <label id="totaltaklenleave"></label>
                    </div>
                    <br />
                    <div style="height: 15px; text-align: center; width: 140px; background: #46B525; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                        Total Paid Taken:
                    <label id="totalpaid"></label>
                    </div>
                    <br />
                    <div style="height: 15px; text-align: center; width: 140px; background: #607B8B; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                        Total Unpaid:
                    <label id="totalunpaid"></label>
                    </div>
                    <br />
                    <div style="height: 15px; text-align: center; width: 140px; background: #FF0000; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                        Total Reject:
                    <label id="lblreject"></label>
                    </div>
                </div>

                <table style="width: 40%; margin-left: 35% !important">
                    <tr>
                        <td colspan="2" style="background: #2CA8C2">Set Half Day
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left">Employee Code</td>
                        <td style="text-align: left">
                            <label id="empcode"></label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left">Date</td>
                        <td style="text-align: left">
                            <label id="hddate"></label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left">When</td>
                        <td style="text-align: left">
                            <label id="gethalf"></label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left">Action</td>
                        <td style="text-align: left">
                            <asp:RadioButtonList runat="server" ID="radioapproveunapprove" CssClass="approve" RepeatDirection="Horizontal">
                                <asp:ListItem Value="1">Approve</asp:ListItem>
                                <asp:ListItem Value="2">Reject</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr id="ispaid" style="display: none">
                        <td style="text-align: left">IS PAID</td>
                        <td style="text-align: left">
                            <asp:RadioButtonList runat="server" ID="radiopaidunpaid" CssClass="paid" RepeatDirection="Horizontal">
                                <asp:ListItem Value="1">Paid</asp:ListItem>
                                <asp:ListItem Value="2">Unpaid</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <asp:Button runat="server" ID="btnsethalf" CssClass="button_save" Text="Save" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>