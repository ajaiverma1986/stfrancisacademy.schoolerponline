<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="set-weekly-holiday.aspx.cs" Inherits="BranchPanel_set_weekly_holiday" %>

<%@ Register Src="~/BranchPanel/employee/set-holiday.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .stm td {
            padding-left: 0px !important;
            padding-right: 0px !important;
            border-right: none !important;
            border-left: none !important;
            border-bottom: none !important;
            border-top: none !important;
        }

        .activeweeklyholiday {
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

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <script type="text/jscript">

        var shortlistedrid = "", Dayid = "", RemoveDayid = "0";
        function pageLoad() {
            document.title = 'Set Weekly Holiday';
        }

        $(document).ready(function () {
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $('.chkcheck').live("click", function () {
                var chkpaid = $(this).parent("td").find("input[type='checkbox']").attr('checked');
                if (chkpaid == "checked") {
                    $(this).parent('td').css("background-color", "green");
                    $(this).parent('td').css("color", "white");
                    $(this).parent('td').find('span').css("color", "white");
                }
                if (chkpaid == undefined) {
                    $(this).parent('td').css("background-color", "white");
                    $(this).parent('td').css("color", "black");
                    $(this).parent('td').find('span').css("color", "green");
                }
            });

            $('#ctl00_ContentPlaceHolder1_btnsetholiday').click(function () {

                var trlength = $("#ctl00_ContentPlaceHolder1_dlsponserad tr").length;
                reason = $('#ctl00_ContentPlaceHolder1_txtreason').text();
                alertify.confirm("Are You Sure You Want To Set The Weekly Off For Selected Day?", function (e) {
                    if (e) {
                        for (var i = 0; i < trlength; i++) {
                            for (var j = 0; j < 3; j++) {
                                var chkchecked = $("#ctl00_ContentPlaceHolder1_dlsponserad tr:eq(" + i + ") td:eq(" + j + ") input").prop("checked");
                                if (chkchecked == true) {
                                    shortlistedrid = shortlistedrid + ',' + $("#ctl00_ContentPlaceHolder1_dlsponserad tr:eq(" + i + ") td:eq(" + j + ")").find("input[type=hidden]").val();
                                }
                            }
                        }
                        shortlistedrid = shortlistedrid.slice(1);
                        if (shortlistedrid != "") {
                            SaveHoliday();
                            return false;
                        }
                        else {
                            alertify.error('No Day Are Selected For Weekly Off.');
                            return false;
                        }
                    } else {
                        return false;
                    }
                });
                return false;
            });

            $('.imgclick').click(function () {
                RemoveDayid = $(this).parent('div').find("input[type=hidden]").val();
                $('#ctl00_ContentPlaceHolder1_dlsponserad_lblchechday_' + parseInt(RemoveDayid - 1)).prop('checked', false);
                removeholiday();
                bindrepeater();
                return false;
            });

        });
        function SaveHoliday() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-weekly-holiday.aspx/InsertHoliday",
                data: "{'Dayid':'" + shortlistedrid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Weekly Off Set Sucessfully.");
                        shortlistedrid = "";
                        Dayid = "";
                        bindrepeater();
                        return;
                    }
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                }
            });
        }
        function bindrepeater() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-weekly-holiday.aspx/bindrepeater",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_trgrid').css("display", "block");
                    $("[id*=gvdetails] tr:gt(1)").remove();
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                            $("[id$=gvdetails]").append(row);
                            $(row).find(".Number").html(data.d[i].Number);
                            $(row).find(".dayname").html(data.d[i].dayname);
                            $(row).find("input[type=hidden]").val(data.d[i].wdid);
                        }
                        $('#ctl00_ContentPlaceHolder1_trmessage').css("display", "none");
                    }
                    else {
                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                        $("[id$=gvdetails]").append(row);
                        $(row).find(".Number").html("---");
                        $(row).find(".dayname").html("No Record Found.");
                        $(row).find("input[type=hidden]").val("0");
                        $('#ctl00_ContentPlaceHolder1_trmessage').css("display", "block");
                    }

                    $("[id*=gvdetails] tr").show();
                    $("[id*=gvdetails] tr:eq(1)").hide();
                },
                error: function (result) {
                    alert("Some Internal Error");
                }
            });
        }
        function removeholiday() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-weekly-holiday.aspx/removeholiday",
                data: "{'Dayid':'" + RemoveDayid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Weekly Off Removed Successfully.");
                        shortlistedrid = "";
                        RemoveDayid = "0";
                        return;
                    }
                },
                error: function (result) {
                    alert("Some Internal Error");
                }
            });
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Holiday Management</a></li>
            <li style="background: none;"><a class="active" href="#">Set Weekly Holiday</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div id="maindivforgriddemo" runat="server" style="margin-left: 100px !important">
            <table width="43%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
                <tr>
                    <td style="border: none">
                        <div style="width: 100%; background-color: #ddd">
                            <asp:Label ID="lblmonthname" runat="server" Text="Select Week Off Day" Style="font-size: 15px; margin-left: 5px !important; color: green"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 0px;">
                        <asp:DataList ID="dlsponserad" runat="server" RepeatColumns="3" CellPadding="2" RepeatDirection="Horizontal">
                            <ItemTemplate>
                                <asp:CheckBox ID="lblchechday" CssClass="chkcheck" runat="server"
                                    Style="width: 30px !important; float: left ! important; margin-top: 5px !important" />
                                <asp:Label ID="lbldayname" CssClass="lbldayname" runat="server" Text='<%#Eval("dayname")%>'
                                    Style="width: 100px !important; float: left ! important"></asp:Label>
                                <asp:HiddenField runat="server" ID="hfdayid" Value='<%# Eval("wdid") %>' />
                            </ItemTemplate>
                        </asp:DataList>
                    </td>
                </tr>
            </table>
            <table width="100%">
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <asp:Button ID="btnsetholiday" runat="server" Text="Set Holiday" CssClass="button_save" />
                        </div>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <div style="margin-left: 0px ! important; margin-bottom: 50px !important">
                <table width="43%" border="0" cellspacing="0" cellpadding="0">
                    <tr id="trmessage" runat="server" style="display: none">
                        <td>
                            <asp:Label ID="lblmessage" runat="server" Text="No Weekly Holiday Is Set." Style="color: red; font-size: 15px; margin-left: 150px;"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trgrid" runat="server">
                        <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="stm">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="S No" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAdType" Text='<%#Eval("Number") %>' runat="server" CssClass="Number"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Leave Day" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNoOfClicks" Text='<%#Eval("dayname") %>' runat="server" CssClass="dayname"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Remove Leave" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <div>
                                                <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/images/ic.png" CssClass="imgclick" OnClientClick="return confirm('Are you sure you want to remove weekly off.?');" />
                                                <asp:HiddenField runat="server" ID="hfdayidfordelete" Value='<%# Eval("wdid") %>' />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />
                                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>