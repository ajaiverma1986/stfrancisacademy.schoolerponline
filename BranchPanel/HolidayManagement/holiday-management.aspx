<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="holiday-management.aspx.cs" Inherits="BranchPanel_commonpage_holiday_management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .stm td {
            padding-left: 8px !important;
            padding-right: 0px !important;
            border-right: none !important;
            border-left: none !important;
            border-top: none !important;
            border-bottom: none !important;
        }

        #ctl00_ContentPlaceHolder1_btnsetholiday {
            height: 28px !important;
            padding: 0px 6px !important;
            color: #fff !important;
        }
    </style>
    <script type="text/jscript">
        var monthid = 0, monthname = "",status = 0, shortlistedrid = "", year = "", reason = "", daysinmonth = "";
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
        $(document).ready(function () {
            monthid = document.getElementById("ctl00_ContentPlaceHolder1_ddlforstate").value;
            BindReapter();
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
            $('#ctl00_ContentPlaceHolder1_ddlforstate').change(function () {
                monthid = document.getElementById("ctl00_ContentPlaceHolder1_ddlforstate").value;
                if (monthid != "0") {
                    $('#ctl00_ContentPlaceHolder1_maindivforgriddemo').css("display", "block");
                    year = new Date().getFullYear();
                    monthname = $("#ctl00_ContentPlaceHolder1_ddlforstate option:selected").text();
                    BindReapter();
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_maindivforgriddemo').css("display", "none");
                }
            });
            $('.chkcheck').live("change", function () {
                var chkpaid = $(this).parent("td").find("input[type='checkbox']").attr('checked');
                if (chkpaid == "checked") {
                    status = 1;
                   
                    $(this).parent('td').css("background-color", "green");
                    $(this).parent('td').css("color", "white");
                    $(this).parent('td').find('span').css("color", "white");
                }
                if (chkpaid == undefined) {
                    status = 0;
                   
                    $(this).parent('td').css("background-color", "white");
                    $(this).parent('td').css("color", "black");
                    $(this).parent('td').find('span').css("color", "green");
                }
            });
            $('#ctl00_ContentPlaceHolder1_btnsetholiday').live('click', function () {
                if ($('#ctl00_ContentPlaceHolder1_txtreason').val() == "") {
                    alertify.error('Please enter the reason of leave.')
                    $('#ctl00_ContentPlaceHolder1_txtreason').focus();
                    return false;
                }
                var trlength = $("#ctl00_ContentPlaceHolder1_dlsponserad tr").length;
                reason = $('#ctl00_ContentPlaceHolder1_txtreason').text();
                if (reason = "") {
                    reason = "No reason mentioned";
                }
                alertify.confirm("Are you sure you want to set the holiday for selected date.If you set once you can not remove.", function (e) {
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
                            alertify.error('No day are selected for holiday.');
                            return false;
                        }
                        alertify.success("You've clicked OK");
                        return true;
                    } else {
                        alertify.error("You've clicked Cancel");
                        return false;
                    }
                });
                return false;
            });
        });
        function SaveHoliday() {
            call_progressbar("start");
            monthid = document.getElementById("ctl00_ContentPlaceHolder1_ddlforstate").value;
            year = new Date().getFullYear();      
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "holiday-management.aspx/InsertHoliday",
                data: "{'status':'" + status + "','year':'" + year + "','month':'" + monthid + "','day':'" + shortlistedrid + "','reason':'" + $('#ctl00_ContentPlaceHolder1_txtreason').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Holiday set sucessfully.");
                        monthid = 0, monthname = "", shortlistedrid = "", year = "";
                        call_progressbar("end");
                        return;
                    }
                    if (data.d == 2) {
                        alertify.error("Holiday can not be changed.");
                        monthid = 0, monthname = "", shortlistedrid = "", year = "";
                        call_progressbar("end");
                        return;
                    }
                },
                error: function (result) {
                    call_progressbar("end")
                    alertify.error("Some error occured");
                }
            });
        }

        function BindReapter() {
            call_progressbar("start");
            var daysinmonth, temp = "0";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "holiday-management.aspx/BindDatatable",
                data: "{'monthid':'" + monthid + "'}",
                dataType: "json",
                success: function (data) {
                    $("[id*=dlsponserad] tr:eq(0)").show();
                    $("[id*=dlsponserad] tr").not($("[id*=dlsponserad] tr:first-child")).remove();

                    for (var i = 0; i < data.d.length; i = i + 3) {
                        var row = $("[id*=dlsponserad] tr:last-child").clone(true);
                        $("[id$=dlsponserad]").append(row);
                        if (data.d[i].chkstatus == 0) {
                            $(row).find("td:eq(0)").find('input[type="checkbox"]').attr('checked', false);
                            $(row).find("td:eq(0)").attr("title", data.d[i].reason);
                        }
                        else if (data.d[i].chkstatus == 1) {
                           
                            $(row).find("td:eq(0)").find('input[type="checkbox"]').attr('checked', true);
                            $(row).find("td:eq(0)").attr("title", data.d[i].reason);
                            
                        }
                        $(row).find("td:eq(0) .lbldayname").html(data.d[i].Dayname);
                        $(row).find("td:eq(0) input[type=hidden]").val(data.d[i].Dayid);
                        $(row).find("td:eq(0) .lbldate").html(data.d[i].Date);

                        if (data.d.length == 31) {
                            if (i == 30) {
                                $(row).find("td:eq(1)").hide();
                                $(row).find("td:eq(1) .lbldayname").html("");
                                $(row).find("td:eq(1) input[type=hidden]").val("");
                                $(row).find("td:eq(1) .lbldate").html("");
                                $(row).find("td:eq(2)").hide();
                                $(row).find("td:eq(2) .lbldayname").html("");
                                $(row).find("td:eq(2) input[type=hidden]").val("");
                                $(row).find("td:eq(2) .lbldate").html("");
                                temp = "1";
                            }
                        }
                        if (data.d.length == 28) {
                            if (i == 27) {
                                $(row).find("td:eq(1)").hide();
                                $(row).find("td:eq(1) .lbldayname").html("");
                                $(row).find("td:eq(1) input[type=hidden]").val("");
                                $(row).find("td:eq(1) .lbldate").html("");
                                $(row).find("td:eq(2)").hide();
                                $(row).find("td:eq(2) .lbldayname").html("");
                                $(row).find("td:eq(2) input[type=hidden]").val("");
                                $(row).find("td:eq(2) .lbldate").html("");
                                temp = "1";
                            }
                        }
                        if (temp == "0") {

                            if (data.d[i + 1].chkstatus == 0) {
                                $(row).find("td:eq(1)").find('input[type="checkbox"]').attr('checked', false);
                                $(row).find("td:eq(1)").attr("title", data.d[i + 1].reason);
                            }
                            else if (data.d[i + 1].chkstatus == 1) {
                               
                                $(row).find("td:eq(1)").find('input[type="checkbox"]').attr('checked', true);
                                $(row).find("td:eq(1)").attr("title", data.d[i+1].reason);
                            }
                            $(row).find("td:eq(1) .lbldayname").html(data.d[i + 1].Dayname);
                            $(row).find("td:eq(1) input[type=hidden]").val(data.d[i + 1].Dayid);
                            $(row).find("td:eq(1) .lbldate").html(data.d[i + 1].Date);
                            if (data.d[i + 2].chkstatus == 0) {
                                $(row).find("td:eq(2)").find('input[type="checkbox"]').attr('checked', false);
                                $(row).find("td:eq(2)").attr("title", data.d[i + 2].reason);
                            }
                            else if (data.d[i + 2].chkstatus == 1) {
                                
                                $(row).find("td:eq(2)").find('input[type="checkbox"]').attr('checked', true);
                                $(row).find("td:eq(2)").attr("title", data.d[i+2].reason);
                            }
                            $(row).find("td:eq(2) .lbldayname").html(data.d[i + 2].Dayname);
                            $(row).find("td:eq(2) input[type=hidden]").val(data.d[i + 2].Dayid);
                            $(row).find("td:eq(2) .lbldate").html(data.d[i + 2].Date);
                            $("[id*=dlsponserad] tr:eq(0)").hide();
                        }
                    }
                    call_progressbar("end");
                    $('#ctl00_ContentPlaceHolder1_dlsponserad').find('tbody').find('input[type="checkbox"]').trigger('change');
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
    </script>

    <div class="clear"></div>
    <div class="content_pane_cont branch-div-tbl" id="contentPane">

        <div class="tbl-top-heading">
            <h2>Set Occassionally Holiday</h2>
        </div>

        <div class="containerHeadline searchbar">
            <asp:DropDownList ID="ddlforstate" runat="server" Style="width: 140px;">
                <asp:ListItem Value="4">April</asp:ListItem>
                <asp:ListItem Value="5">May</asp:ListItem>
                <asp:ListItem Value="6">June</asp:ListItem>
                <asp:ListItem Value="7">July</asp:ListItem>
                <asp:ListItem Value="8">August</asp:ListItem>
                <asp:ListItem Value="9">September</asp:ListItem>
                <asp:ListItem Value="10">October</asp:ListItem>
                <asp:ListItem Value="11">November</asp:ListItem>
                <asp:ListItem Value="12">December</asp:ListItem>
                <asp:ListItem Value="1">January</asp:ListItem>
                <asp:ListItem Value="2">February</asp:ListItem>
                <asp:ListItem Value="3">March</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="txtreason" runat="server" placeholder="Enter Leave Reason Please." Style="width: 200px !important;"></asp:TextBox>
            <asp:Button ID="btnsetholiday" runat="server" Text="Set Holiday" CssClass="button_save" />
        </div>

        <div class="clear"></div>

        <div class="responsive-grid-sty">

            <div id="maindivforgriddemo" runat="server">
                <div class="clear"></div>
                <div class="stm">

                    <asp:DataList ID="dlsponserad" CssClass="stm" runat="server" RepeatColumns="3" CellPadding="0" Width="100%" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <asp:CheckBox ID="lblchechday" CssClass="chkcheck" runat="server" Style="width: 30px !important; float: left ! important; margin-top: 5px !important" />
                            <asp:Label ID="lbldate" CssClass="lbldate" runat="server" Text='<%#Eval("Date","{0:MMM dd yyyy}")%>' Style="width: 100px !important; float: left ! important"></asp:Label>
                            <asp:Label ID="lbldayname" CssClass="lbldayname" runat="server" Text='<%#Eval("Dayname")%>' Style="width: 100px !important; float: left ! important"></asp:Label>
                            <asp:HiddenField runat="server" ID="hfsmcid" Value='<%# Eval("Dayid") %>' />
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>

        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>