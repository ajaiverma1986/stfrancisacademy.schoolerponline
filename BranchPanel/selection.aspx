<%@ Page Title="Student Selection" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="selection.aspx.cs" Inherits="BranchPanel_selection" %>

<%@ Register Src="~/BranchPanel/shortlisting.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <link href="../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />

    <script type="text/javascript">
        function pageLoad() {

            BindDatePicker();
        }

        function BindDatePicker() {
            $(document).ready(function () {
                $("#ctl00_ContentPlaceHolder1_txtfromdate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd/mm/yy'
                });
                $("#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd/mm/yy'
                });
            });
        }

        var status = 0, ddlclassid = 0, ddlfromdate = "", ddltodate = "", ddlcast = "", ddlnationality = "", ddlparentstartsallery = 0, ddlparentendsallery = 0, ddlfatherqualification = "", ddlmotherqualification = "", txtsearchvalue = "", fyid = 2;

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_radiobuttonlistforautoandmanual_1").live('change', function () {
                BindGridAfterSearching();
                $(".chkboxSelectAlljquery").find("input[type='checkbox']").prop("checked", true);
                var GridVwHeaderChckbox = document.getElementById("<%=gridenquiry.ClientID %>");
                for (i = 1; i < GridVwHeaderChckbox.rows.length; i++) {
                    $(".chkall").find("input[type='checkbox']").prop("checked", true);
                }
                $('#ctl00_ContentPlaceHolder1_searstudent').css("display", "none");
            });

            $("#ctl00_ContentPlaceHolder1_radiobuttonlistforautoandmanual_0").live('change', function () {
                BindGridAfterSearching();
                $(".chkboxSelectAlljquery").find("input[type='checkbox']").prop("checked", false);
                var GridVwHeaderChckbox = document.getElementById("<%=gridenquiry.ClientID %>");
                for (i = 1; i < GridVwHeaderChckbox.rows.length; i++) {
                    $(".chkall").find("input[type='checkbox']").prop("checked", false);
                }
            });

            $("#ctl00_ContentPlaceHolder1_ddlclass").live('change', function () {
                $('#ctl00_ContentPlaceHolder1_radi12').css("display", "block");
                $(".radiobuttonlistauto").find("input[type='radio']").prop("checked", false);
                $('#ctl00_ContentPlaceHolder1_searstudent').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_btnmsg').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_btnwaiting').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_btnrejected').css("display", "none");
                ddlclassid = $.trim($(this).val());
            });

            $("#ctl00_ContentPlaceHolder1_txtfromdate").on('change keyup paste blur', function () {
                ddlfromdate = $.trim($(this).val());
                BindGridAfterSearching();
            });

            $("#ctl00_ContentPlaceHolder1_ddlfy").change(function () {
                fyid = $(this).val();
                BindGridAfterSearching();
            });

            $("#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste blur', function () {
                ddltodate = $.trim(this.value);
                BindGridAfterSearching();
            });

            $('#ctl00_ContentPlaceHolder1_ddlsearchbycast').live('change', function () {
                if ($.trim(this.value) == "0") {
                    ddlcast = "";
                }
                else {
                    ddlcast = $.trim(this.value);
                }
                BindGridAfterSearching();
            });

            $('#ctl00_ContentPlaceHolder1_ddlsearchbynationality').live('change', function () {

                if ($.trim(this.value) == "0") {
                    ddlnationality = "";
                }
                else {
                    ddlnationality = $.trim(this.value);
                }
                BindGridAfterSearching();
            });
            $('#ctl00_ContentPlaceHolder1_ddlsearchbyparentsallery').live('change', function () {
                var salleryvalue = 0;
                salleryvalue = $.trim(this.value);
                switch (parseInt(salleryvalue)) {
                    case 0:
                        ddlparentstartsallery = 0;
                        ddlparentendsallery = 0;
                        break;
                    case 1:
                        ddlparentstartsallery = 100000;
                        ddlparentendsallery = 300000;
                        break;
                    case 2:
                        ddlparentstartsallery = 300001;
                        ddlparentendsallery = 500000;
                        break;
                    case 3:
                        ddlparentstartsallery = 500001
                        ddlparentendsallery = 1000000
                        break;
                    case 4:
                        ddlparentstartsallery = 1000001
                        ddlparentendsallery = 2000000
                        break;
                    case 5:
                        ddlparentstartsallery = 2000001
                        ddlparentendsallery = 5000000
                        break;
                    case 6:
                        ddlparentstartsallery = 5000001
                        ddlparentendsallery = 7000000000
                        break;
                    case 7:
                        ddlparentstartsallery = 7000000001
                        ddlparentendsallery = 0
                        break;
                }

                BindGridAfterSearching();

            });

            $('#ctl00_ContentPlaceHolder1_ddlsearchbyparentqualification').live('change', function () {
                if ($.trim(this.value) == "0") {
                    ddlfatherqualification = "";
                }
                else {
                    ddlfatherqualification = $.trim(this.value);
                }
                BindGridAfterSearching();
            });

            $('#ctl00_ContentPlaceHolder1_ddlmotherqualification').live('change', function () {
                if ($.trim(this.value) == "0") {
                    ddlmotherqualification = "";
                }
                else {
                    ddlmotherqualification = $.trim(this.value);
                }
                BindGridAfterSearching();
            });

            $('#ctl00_ContentPlaceHolder1_txtnamesearch').keyup(function () {

                if ($.trim($(this).val()) == '') {
                    txtsearchvalue = "";
                }
                else {
                    txtsearchvalue = $.trim($(this).val());
                }
                BindGridAfterSearching();
            });

            $('#ctl00_ContentPlaceHolder1_btngoforsearch').click(function () {
                BindGridAfterSearching();
            });

            $('#ctl00_ContentPlaceHolder1_btnmsg').click(function () {
                var shortlistedrid = "";
                var trlength = $("#ctl00_ContentPlaceHolder1_gridenquiry tr").length;
                var statusforconfirm;
                var statusforconfirm = confirm("Are You Sure You Want To Send The Mail To Selected Student.");
                if (statusforconfirm == true) {
                    for (var i = 1; i < trlength; i++) {
                        var chkchecked = $("#ctl00_ContentPlaceHolder1_gridenquiry tr:eq(" + i + ") td:eq(0) input").prop("checked");
                        if (chkchecked == true) {
                            var hdval = $("#ctl00_ContentPlaceHolder1_gridenquiry tr:eq(" + i + ") td:eq(1) input").val();
                            shortlistedrid = shortlistedrid + "," + hdval;
                        }
                    }
                    shortlistedrid = shortlistedrid.slice(1);
                    if (shortlistedrid != "") {
                        status = 2;
                        updatestatus(shortlistedrid, status);
                    }

                    else {
                        alert('No Students Are Selected For Send Message.');
                    }

                }
                else {
                    return false;
                }

                BindGridAfterSearching();

            });

            $('#ctl00_ContentPlaceHolder1_btnrejected').click(function () {
                var shortlistedrid = "";
                var trlength = $("#ctl00_ContentPlaceHolder1_gridenquiry tr").length;
                var statusforconfirm;
                var statusforconfirm = confirm("Are You Sure You Want To Reject The Selected Student.");
                if (statusforconfirm == true) {
                    for (var i = 1; i < trlength; i++) {
                        var chkchecked = $("#ctl00_ContentPlaceHolder1_gridenquiry tr:eq(" + i + ") td:eq(0) input").prop("checked");
                        if (chkchecked == true) {
                            var hdval = $("#ctl00_ContentPlaceHolder1_gridenquiry tr:eq(" + i + ") td:eq(1) input").val();
                            shortlistedrid = shortlistedrid + "," + hdval;
                        }
                    }
                    shortlistedrid = shortlistedrid.slice(1);
                    if (shortlistedrid != "") {
                        status = 3;
                        updatestatus(shortlistedrid, status);
                    }
                    else {
                        alert('No Students Are Selected For Reject.');
                    }

                }
                else {
                    return false;
                }

                BindGridAfterSearching();

            });

            $('#ctl00_ContentPlaceHolder1_btnwaiting').click(function () {
                var shortlistedrid = "";
                var trlength = $("#ctl00_ContentPlaceHolder1_gridenquiry tr").length;
                var statusforconfirm;
                var statusforconfirm = confirm("Are You Sure You Want To Add Selected Student in Waiting List.");
                if (statusforconfirm == true) {
                    for (var i = 1; i < trlength; i++) {
                        var chkchecked = $("#ctl00_ContentPlaceHolder1_gridenquiry tr:eq(" + i + ") td:eq(0) input").prop("checked");
                        if (chkchecked == true) {
                            var hdval = $("#ctl00_ContentPlaceHolder1_gridenquiry tr:eq(" + i + ") td:eq(1) input").val();
                            shortlistedrid = shortlistedrid + "," + hdval;
                        }
                    }
                    shortlistedrid = shortlistedrid.slice(1);
                    if (shortlistedrid != "") {
                        status = 5;
                        updatestatus(shortlistedrid, status);
                    }
                    else {
                        alert('No Students Are Selected For Reject.');
                    }

                }
                else {
                    return false;
                }

                BindGridAfterSearching();

            });

        });

        function updatestatus(shortlistedrid, status) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selection.aspx/GetEmailIdByRid",
                data: "{'allselectedrid':'" + shortlistedrid + "','status':'" + parseInt(status) + "'}",
                dataType: "json",
                success: function (data) {
                    if (parseInt(status) == 2) {
                        alert('Message Send Sucessfully To The Selected Student.');
                    }
                    else if (parseInt(status) == 3) {
                        alert('Selected Student Are Rejected Sucessfully.');
                    }
                }
            });
        }

        function BindGridAfterSearching() {
            $('#ctl00_ContentPlaceHolder1_searstudent').css("display", "block");
            $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "block");
            $('#ctl00_ContentPlaceHolder1_btnmsg').css("display", "block");
            $('#ctl00_ContentPlaceHolder1_btnrejected').css("display", "block");
            $('#ctl00_ContentPlaceHolder1_btnwaiting').css("display", "block");
            var row;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selection.aspx/BindDatatable",
                data: "{'classid':'" + ddlclassid + "','ddlfromdate':'" + ddlfromdate + "','ddltodate':'" + ddltodate + "','ddlcast':'" + ddlcast + "','ddlnationality':'" + ddlnationality + "','ddlparentstartsallery':'" + parseFloat(ddlparentstartsallery) + "','ddlparentendsallery':'" + parseFloat(ddlparentendsallery) + "','ddlfatherqualification':'" + ddlfatherqualification + "','ddlmotherqualification':'" + ddlmotherqualification + "','txtsearchtext':'" + txtsearchvalue + "','fyid1':'" + fyid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('.checkboxjquery').css("display", "block");
                        $('.lblnorecordfound').css("display", "none");
                        var row = $("[id*=gridenquiry] tr:last-child").clone(true);
                        $("[id*=gridenquiry] tr").not($("[id*=gridenquiry] tr:first-child")).remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=gridenquiry] tr:last-child").clone(true);
                            }
                            $("[id$=gridenquiry]").append(row);
                            $(row).find('.registrationno').html(data.d[i].Registrationno);
                            $(row).find('.nameforjquery').html(data.d[i].name);
                            $(row).find('.fnameforjquery').html(data.d[i].Fname);
                            $(row).find("input[type=hidden]").val(data.d[i].rid);
                            $(row).find('.registrationclass').html(data.d[i].registrationdate);
                        }
                        $("[id*=gridenquiry] tr").show();
                        $("[id*=gridenquiry] tr:first-child").show();
                    }

                    else {
                        $('.checkboxjquery').css("display", "none");
                        $('.lblnorecordfound').css("display", "block");
                        var row = $("[id*=gridenquiry] tr:last-child").clone(true);
                        $("[id*=gridenquiry] tr").not($("[id*=gridenquiry] tr:first-child")).remove();
                        $("[id$=gridenquiry]").append(row);
                        $(row).find('.registrationno').html('');
                        $(row).find('.nameforjquery').html('No Record Found');
                        $(row).find('.fnameforjquery').html('');
                        $(row).find("input[type=hidden]").val('');
                        $(row).find('.registrationclass').html('');
                    }
                    $("[id*=gridenquiry] tr").show();
                    $("[id*=gridenquiry] tr:first-child").show();
                },
                error: function (result) {
                    alert("Some Internal Error");
                }

            });
        }
    </script>

    <script type="text/javascript" language="javascript">
        function CheckAllEmp(Checkbox) {
            var chstatus = $("#ctl00_ContentPlaceHolder1_gridenquiry_ctl01_chkboxSelectAll").prop("checked");
            var GridVwHeaderChckbox = document.getElementById("<%=gridenquiry.ClientID %>");
            for (i = 1; i < GridVwHeaderChckbox.rows.length; i++) {
                if (chstatus == true) {
                    $(".chkall").find("input[type='checkbox']").prop("checked", true);
                }
                if (chstatus == false) {
                    $(".chkall").find("input[type='checkbox']").prop("checked", false);
                }
            }
        }
    </script>

    <style type="text/css">
        .aciveselection {
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

        .radiobuttonlistauto label {
            font-family: Arial;
            font-size: 16px;
            font-style: italic;
            margin-left: 3px !important;
        }

        .radiobuttonlistauto input {
            margin-left: 10px !important;
        }

        input {
            opacity: 1 !important;
            margin-top: -2px;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Student Administration</a></li>
            <li><a>Shorlisting</a></li>
            <li style="background: none;"><a class="active" href="#">Selection</a></li>
        </ul>
        <div class="arrowt">
            <a href="selection.aspx">
                <img src="../images/back-button.png" alt="backbutton" /></a>
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <br />
        <asp:UpdatePanel ID="upd22" runat="server">
            <ContentTemplate>
                <div id="radi13" runat="server" style="display: block">
                    <asp:DropDownList ID="ddlclass" runat="server" Width="160px" Height="26px" Style="border-radius: 5px; margin-left: 34%;"></asp:DropDownList>
                    <div id="radi12" runat="server" style="display: none">
                        <tr>
                            <td colspan="10" class="containerHeadline">
                                <div style="width: 550px; margin-top: -2%; margin-bottom: 2%; margin-left: 54%;">
                                    <asp:RadioButtonList ID="radiobuttonlistforautoandmanual" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" CssClass="radiobuttonlistauto">
                                        <asp:ListItem Text="Manual" Value="Manual"></asp:ListItem>
                                        <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </td>
                        </tr>
                    </div>
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="display: none; margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                    class="stm" runat="server" id="searstudent">
                    <tr>
                        <td colspan="10" class="containerHeadline">
                            <div style="width: 800px; float: left">
                                <asp:TextBox ID="txtfromdate" runat="server" Width="150px" Height="23px" placeholder="From  Date"> </asp:TextBox>
                                <asp:TextBox ID="txttodate" runat="server" Width="150px" Height="23px" placeholder="To  Date"> </asp:TextBox>
                                <asp:DropDownList ID="ddlsearchbycast" runat="server" Width="140px">
                                    <asp:ListItem Value="0">Search By Cast</asp:ListItem>
                                    <asp:ListItem Value="GENERAL">General</asp:ListItem>
                                    <asp:ListItem Value="OBC">OBC</asp:ListItem>
                                    <asp:ListItem Value="ST">ST</asp:ListItem>
                                    <asp:ListItem Value="SC">SC</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlsearchbynationality" runat="server" Width="165px">
                                    <asp:ListItem Value="0">Search By Nationality</asp:ListItem>
                                    <asp:ListItem Value="Indian">Indian</asp:ListItem>
                                    <asp:ListItem Value="Other">Other</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlsearchbyparentsallery" runat="server" Width="185px" Style="margin-top: 5px !important; margin-bottom: 3px !important">
                                    <asp:ListItem Value="0">Search By Parent Sallery</asp:ListItem>
                                    <asp:ListItem Value="1">100000 - 300000</asp:ListItem>
                                    <asp:ListItem Value="2">300001 - 500000</asp:ListItem>
                                    <asp:ListItem Value="3">500001 - 1000000</asp:ListItem>
                                    <asp:ListItem Value="4">1000001 - 2000000</asp:ListItem>
                                    <asp:ListItem Value="5">2000001 - 5000000</asp:ListItem>
                                    <asp:ListItem Value="6">5000001 - 7000000000</asp:ListItem>
                                    <asp:ListItem Value="7">More Than 7000000000</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlsearchbyparentqualification" runat="server" Width="220px" Style="margin-top: 5px !important; margin-bottom: 3px !important">
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlmotherqualification" runat="server" Width="220px" Style="margin-top: 5px !important; margin-bottom: 3px !important">
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlfy" runat="server" Width="110px"></asp:DropDownList>
                            </div>
                            <div style="width: 248px; float: right">
                                <asp:TextBox ID="txtnamesearch" runat="server" Width="150px" Height="23px" placeholder="Search By Student Name" Style="margin-top: 15px"> </asp:TextBox>
                                <asp:Button ID="btngoforsearch" runat="server" Text="Go" ToolTip="Click here for Search"
                                    CssClass="view-enquiry" Height="23px" OnClientClick="return false" Style="margin-top: 15px" />
                            </div>
                        </td>
                    </tr>
                </table>
                <table id="tablemaingrid" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0" style="display: block">
                    <tr>
                        <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView runat="server" ID="gridenquiry"
                                GridLines="None"
                                AutoGenerateColumns="false" Width="100%" CssClass="stm">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkboxSelectAll" CssClass="chkboxSelectAlljquery" runat="server" Style="padding: 6px 3px 3px 30px;" onclick="CheckAllEmp(this);" />
                                            <asp:Label ID="lbltextforall" runat="server" Text="Check For Select All" Style="margin-left: 7px ! important"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="checkboxrowwise" Style="display: block" runat="server" CssClass="checkboxjquery chkall" />
                                            <asp:Label ID="lblalternate" runat="server" Style="display: none" CssClass="lblnorecordfound" Text=""></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Right" Width="280px" />
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Registration No" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton CssClass="registrationno" ID="lbRegNo" runat="server" Text='<%# Bind("Registrationno") %>' Font-Underline="true" Style="text-decoration: none" ToolTip="Click here to see the registration slip" CommandName="RegSlip" CommandArgument='<%#Bind("Rid") %>'></asp:LinkButton>
                                            <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("rid") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" Width="100px" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Registration Date" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="registrationdate" runat="server" CssClass="registrationclass" Text='<%# Eval("registrationdate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" Width="200px" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Student Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblname" CssClass="nameforjquery" Text='<%# Eval("name") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="300px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Father Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblfathername" CssClass="fnameforjquery" Text='<%# Eval("Fname") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="300px" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" />
                                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <div class="for_sigle_row_form">
                    <label style="width: 155px !important;">
                        <asp:Button ID="btnmsg" runat="server" Text="Select & Send Message" CssClass="button_save" OnClientClick="return false" Style="border-radius: 0px !important; display: none; float: left" />
                    </label>
                    <label style="width: 75px !important;">
                        <asp:Button ID="btnrejected" runat="server" Text="Reject" CssClass="button_save" OnClientClick="return false" Style="border-radius: 0px !important; display: none; margin-bottom: 10px !important; float: left" />
                    </label>

                    <label style="width: 75px !important;">
                        <asp:Button ID="btnwaiting" runat="server" Text="Waiting" CssClass="button_save" OnClientClick="return false" Style="border-radius: 0px !important; display: none; margin-bottom: 10px !important; float: left" />
                    </label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>