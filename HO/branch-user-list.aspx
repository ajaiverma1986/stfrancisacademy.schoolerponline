<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="branch-user-list.aspx.cs" Inherits="HO_branch_user_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        var Eid = 0, allselectedmoduleid = "", status = 0, userid = "", trindex = 0, Branchid = 0,
            Branchcode = '', Loginid = '', BranchName='';
        $(document).ready(function () {
            $('.edit').click(function () {
                var confirmedit = confirm("Are you sure? you want to edit the branch information.")
                if (confirmedit == true) {
                    Branchid = $(this).parent('td').parent('tr').find('td:eq(7) input[type=hidden]').val();
                    window.location.href = "add-new-branch.aspx?Branchid=" + Branchid;
                    return false;
                }
                else {
                    return false;
                }
            });
            $('.statusimage').click(function () {
                var deactivatestatus = "";
                if ($(this).attr("src") == '../images/yes.png') {
                    deactivatestatus = confirm("Are you sure? you want to deactivate the Branch.");
                    status = 0;
                }
                else if ($(this).attr("src") == '../images/no.png') {
                    deactivatestatus = confirm("Are you sure? you want to activate the user.");
                    status = 1;
                }
                else {
                    return false;
                }
                if (deactivatestatus == true) {
                    Branchid = $(this).parent('td').parent('tr').find('td:eq(7) input[type=hidden]').val();
                    ChangeStatus();
                    return false;
                }
                else {
                    return false;
                }
            });
            $('.userrights').click(function () {
                var userrightstatus = confirm('Are You sure? you want to Assign/Remove the menu right to/from branch ' + $(this).parent('td').parent('tr').find('td:eq(2) a').html());
                if (userrightstatus == true) {
                    trindex = $(this).closest("tr").index();
                    $(this).parent('td').parent('tr').find('td').css("background-color", "#def9de");
                    $(this).parent('td').parent('tr').find('td span').css("color", "#000");
                    Eid = $(this).parent('td').parent('tr').find('td:eq(0) input').val();
                    BindPermissionGrid();
                    GetGivenPermission();
                    $(".showpopup").show(500);
                    $(".showpopup").fadeIn();
                    return false;
                }
                else {
                    return false;
                }
            });

            $('.useractionrights').click(function () {
                var userrightstatus = confirm('Are You sure? you want to Assign/Remove the action right to/from branch ' + $(this).parent('td').parent('tr').find('td:eq(2) a').html());
                if (userrightstatus == true) {
                    trindex = $(this).closest("tr").index();
                    $(this).parent('td').parent('tr').find('td').css("background-color", "#def9de");
                    $(this).parent('td').parent('tr').find('td span').css("color", "#000");
                    Eid = $(this).parent('td').parent('tr').find('td:eq(0) input').val();
                    BindActionPermissionGrid();
                    GetGivenActionPermission();
                    $(".showpopup").show(500);
                    $(".showpopup").fadeIn();
                    return false;
                }
                else {
                    return false;
                }
            });

            $('.Btclose').live("click", function () {
                $('.showpopup').html('');
                $(".showpopup").hide(500);
                $(".showpopup").fadeOut();
                $('#ctl00_ContentPlaceHolder1_grduserlist').find('tr:eq(' + trindex + ')').find('td').css("background-color", "white");
                $('#ctl00_ContentPlaceHolder1_grduserlist').find('tr:eq(' + trindex + ')').find('td span').css("color", "black");
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ImageButton1').live("click", function () {
                var submitstatus = confirm('Are you sure? you want to update the menu rights.');
                if (submitstatus == true) {
                    allselectedmoduleid = "";
                    $('#ctl00_ContentPlaceHolder1_grdpermission tr').each(function () {
                        if ($(this).find('input[type=checkbox]').attr("checked") == "checked") {
                            allselectedmoduleid = allselectedmoduleid + ',' + $(this).find('input[type=hidden]').val();
                        }
                    });
                    allselectedmoduleid = allselectedmoduleid.substring(1, (allselectedmoduleid.length));
                    userid = Eid;
                    ChangeOrRemovePermissions();
                    return false;
                }
                else {
                    return false;
                }
            });

            $('#ctl00_ContentPlaceHolder1_ImageButtonActionPermission').live("click", function () {
                var submitstatus = confirm('Are you sure? you want to update the action rights.');
                if (submitstatus == true) {
                    allselectedmoduleid = "";
                    $('#ctl00_ContentPlaceHolder1_grdpermission tr').each(function () {
                        if ($(this).find('input[type=checkbox]').attr("checked") == "checked") {
                            allselectedmoduleid = allselectedmoduleid + ',' + $(this).find('input[type=hidden]').val();
                        }
                    });
                    allselectedmoduleid = allselectedmoduleid.substring(1, (allselectedmoduleid.length));
                    userid = Eid;
                    ChangeOrRemoveActionPermissions();
                    return false;
                }
                else {
                    return false;
                }
            });

            $('input[type=checkbox]').live("change", function () {
                if ($(this).attr("checked") == "checked") {
                    if ($(this).parent('td').find('span span').attr('class') == "for_cheackbox") {
                        var startrow = $(this).parent('td').parent('tr').index();
                        for (var i = (parseInt(startrow) + 1) ; i <= (parseInt(startrow) + 30) ; i++) {
                            if ($('#ctl00_ContentPlaceHolder1_grdpermission').find('tr:eq(' + i + ')').find('td').find('span span').attr('class') == "smrt") {
                                $('#ctl00_ContentPlaceHolder1_grdpermission').find('tr:eq(' + i + ')').find('td').find('input[type=checkbox]').attr("checked", true);
                            }
                            else {
                                break;
                            }
                        }
                    }
                    else {
                        var startrow = $(this).parent('td').parent('tr').index();
                        for (var i = parseInt(startrow) ; i >= 1 ; i--) {
                            if ($('#ctl00_ContentPlaceHolder1_grdpermission').find('tr:eq(' + i + ')').find('td').find('span span').attr('class') == "for_cheackbox") {
                                $('#ctl00_ContentPlaceHolder1_grdpermission').find('tr:eq(' + i + ')').find('td').find('input[type=checkbox]').attr("checked", true);
                                break;
                            }
                        }
                    }
                }
                else {
                    if ($(this).parent('td').find('span span').attr('class') == "for_cheackbox") {
                        var startrow = $(this).parent('td').parent('tr').index();
                        for (var i = (parseInt(startrow) + 1) ; i <= (parseInt(startrow) + 30) ; i++) {
                            if ($('#ctl00_ContentPlaceHolder1_grdpermission').find('tr:eq(' + i + ')').find('td').find('span span').attr('class') == "smrt") {
                                $('#ctl00_ContentPlaceHolder1_grdpermission').find('tr:eq(' + i + ')').find('td').find('input[type=checkbox]').attr("checked", false);
                            }
                            else {
                                break;
                            }
                        }
                    }
                }
            });
            $('#ctl00_ContentPlaceHolder1_txtbranchcode').change(function () {
                FillField();
                BindGrid();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtloginid').change(function () {
                FillField();
                BindGrid();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtbrname').change(function () {
                FillField();
                BindGrid();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_lbtnclear').click(function () {
                Clear();
                FillField();
                BindGrid();
                return false;
            });

            $('.BranchName').click(function () {
                var BridForLogin = '';
                BridForLogin = $(this).parent('td').parent('tr').find('td:eq(7)').find('input[type=hidden]').val();
                $(this).attr("href", "../Login.aspx?brid=" + BridForLogin);
                window.open($(this).attr('href'));
                return false;
            });

        });

        function GetGivenPermission() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "branch-user-list.aspx/BindGridByJsForPermission",
                data: "{'userid':'" + Eid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_grdpermission tr').each(function () {
                                if ($(this).find('td').find('input[type=hidden]').val() == data.d[i].Moduleid) {
                                    $(this).find('td').find('input[type=checkbox]').attr("checked", true);
                                }
                            });
                        }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function GetGivenActionPermission() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "branch-user-list.aspx/BindGridByJsForActionPermission",
                data: "{'userid':'" + Eid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_grdpermission tr').each(function () {
                                if ($(this).find('td').find('input[type=hidden]').val() == data.d[i].Id) {
                                    $(this).find('td').find('input[type=checkbox]').attr("checked", true);
                                }
                            });
                        }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function BindPermissionGrid() {
            var GridForBind = '<dd> <img src="../images/userrights.png" styyle="float:left;" /> <cite> Menu right </cite> <img src="../images/popupcross.png" class="Btclose" style="float:right; margin-right:10px; margin-top:2px; cursor:pointer;" /> </dd> <table id="ctl00_ContentPlaceHolder1_grdpermission" cellspacing="0" style="border-collapse:collapse;"><tbody>';
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "branch-user-list.aspx/BindGridByJsForBindPermission",
                data: "{'userid':'" + Eid + "'}",
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            GridForBind = GridForBind + '<tr><td align="center"><input type="checkbox" /><span class="ModuleName">' + data.d[i].ModuleName + '</span><input type="hidden" value=' + data.d[i].ModuleId + ' /></td></tr>'
                        }
                    }
                    GridForBind = GridForBind + '</tbody></table><div class="clear" style="margin-top:5px; border-top:1px solid #f1f1f1; padding-top:7px;"></div><asp:Button ID="ImageButton1" runat="server" Text="Submit" CssClass="button_save" style="margin-left:192px !important;" />'
                    $('.showpopup').html(GridForBind);
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function BindActionPermissionGrid() {
            var GridForBind = '<dd> <img src="../images/userrights.png" styyle="float:left;" /><cite>Action right </cite> <img src="../images/popupcross.png" class="Btclose" style="float:right; margin-right:10px; margin-top:2px; cursor:pointer;" /> </dd> <table id="ctl00_ContentPlaceHolder1_grdpermission" cellspacing="0" style="border-collapse:collapse;"><tbody>';
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "branch-user-list.aspx/BindGridByJsForBindActionPermission",
                data: "{'userid':'" + Eid + "'}",
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            GridForBind = GridForBind + '<tr><td align="center"><input type="checkbox" /><span class="ModuleName">' + data.d[i].Name + '</span><input type="hidden" value=' + data.d[i].Id + ' /></td></tr>'
                        }
                    }
                    GridForBind = GridForBind + '</tbody></table><div class="clear" style="margin-top:5px; border-top:1px solid #f1f1f1; padding-top:7px;"></div><asp:Button ID="ImageButtonActionPermission" runat="server" Text="Submit" CssClass="button_save" style="margin-left:192px !important;" />'
                    $('.showpopup').html(GridForBind);
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function BindGrid() {
            var row = "";
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "branch-user-list.aspx/BindGridByJs",
                data: "{'Branchcode':'" + Branchcode + "','Loginid':'" + Loginid + "','BranchName':'" + BranchName + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#ctl00_ContentPlaceHolder1_trnorecordfound').css("display", "none");
                        $("[id*=grduserlist] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                          
                            row = $("[id*=grduserlist] tr:eq(1)").clone(true);
                            $("[id$=grduserlist]").append(row);
                            $(row).find('input[type=hidden][id*=hfemployeeid]').val(data.d[i].Eid);
                            $(row).find('input[type=hidden][id*=hfbranchid]').val(data.d[i].Brid);
                            $(row).find('.RowNumber').html(data.d[i].RowNumber);
                            $(row).find('.BranchCode').html(data.d[i].BranchCode);
                            $(row).find('.BranchName').html(data.d[i].BranchName);
                            $(row).find('.BranchAdress').html(data.d[i].ShortBranchAdress);
                            $(row).find('.BranchAdress').attr("title", data.d[i].BranchAdress);
                            $(row).find('.UserName').html(data.d[i].UserName);
                            $(row).find('.Password').attr("title", data.d[i].Password);
                            $(row).find('.statusimage').attr("src", data.d[i].statusimage);
                            if (i % 2 == 0) {
                                $(row).removeClass();
                                $(row).addClass("stm_dark");
                            }
                            else {
                                $(row).removeClass();
                                $(row).addClass("stm_light");
                            }

                        }
                        $("[id*=grduserlist] tr").show();
                        $("[id*=grduserlist] tr:eq(1)").hide();
                        call_progressbar("end");
                    }
                    else {
                        $("[id*=grduserlist] tr").hide();
                        $('#ctl00_ContentPlaceHolder1_trnorecordfound').css("display", "block");
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function FillField() {
            Branchcode = $('#ctl00_ContentPlaceHolder1_txtbranchcode').val();
            Loginid = $('#ctl00_ContentPlaceHolder1_txtloginid').val();
            BranchName = $('#ctl00_ContentPlaceHolder1_txtbrname').val();
        }
        function Clear() {
            $('#ctl00_ContentPlaceHolder1_txtName').val('');
            $('#ctl00_ContentPlaceHolder1_txtcontactno').val('');
            $('#ctl00_ContentPlaceHolder1_txtemailid').val('');
            $('#ctl00_ContentPlaceHolder1_ddlrole').val('0');
            $('#ctl00_ContentPlaceHolder1_txtbranchcode').val('');
            $('#ctl00_ContentPlaceHolder1_txtloginid').val('');
            $('#ctl00_ContentPlaceHolder1_txtbrname').val('');
        }
        function ChangeStatus() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "branch-user-list.aspx/ChangeStatus",
                data: "{'Brid':'" + Branchid + "','Status':'" + status + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        if (status == 1 || status == 0) {
                            alertify.success('Status Updated Successfully.');
                        }
                        else {
                            alertify.error('User Deleted Successfully.');
                        }
                        call_progressbar("end");
                        status = 0, Branchid = 0;
                        FillField();
                        BindGrid();
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
        function ChangeOrRemovePermissions() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "branch-user-list.aspx/ChangePermission",
                data: "{'UserId':'" + userid + "','ModuleId':'" + allselectedmoduleid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Menu Right Updated Successfully.');
                        userid = "", allselectedmoduleid = "";
                        call_progressbar("end");
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function ChangeOrRemoveActionPermissions() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "branch-user-list.aspx/ChangeActionPermission",
                data: "{'UserId':'" + userid + "','ModuleId':'" + allselectedmoduleid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Action Right Updated Successfully.');
                        userid = "", allselectedmoduleid = "";
                        call_progressbar("end");
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
    </script>
    <style>
        .showpopup {
            background: none repeat scroll 0 0 #FFFFFF;
            color: #000000;
            font-family: sans-serif;
            left: 50%;
            opacity: 1;
            position: fixed;
            top: 50%;
            width: 500px;
            z-index: 2147483647;
            height: 400px !important;
            margin-top: -200px;
            margin-left: -250px;
            border: 1px solid #ffb400;
            padding-bottom: 10px;
            overflow: auto;
        }

            .showpopup dd {
                background: #ffb400;
                padding: 2px 0px;
                font-size: 16px;
                width: 485px;
                float: left;
                color: #fff;
                position: fixed;
            }

            .showpopup table {
                margin-top: 44px;
                display: block;
            }

            .showpopup dd img {
                float: left;
                margin-left: 10px;
            }

            .showpopup dd cite {
                float: left;
                line-height: 25px;
                font-style: normal;
            }

        #ctl00_ContentPlaceHolder1_grdpermission tr {
            float: left;
            display: block;
            width: 220px;
            padding-left: 20px;
        }

        .for_cheackbox {
            color: green;
            font-weight: bold;
            text-align: left;
        }

        .smrt {
            color: #333333 !important;
            font-size: 12px;
            font-weight: normal;
            padding: 0 0 0 10px !important;
            float: left !important;
            margin-left: 250px !important;
        }

        #ctl00_ContentPlaceHolder1_grdpermission tr td span {
            margin-left: 0px !important;
            float: left;
            padding-top: 1px;
        }

        #ctl00_ContentPlaceHolder1_grdpermission tr td input {
            float: left;
            margin-right: 10px;
        }

        #ctl00_ContentPlaceHolder1_grdpermission tr td {
            padding-bottom: 10px;
        }

        #ctl00_ContentPlaceHolder1_grdpermission_chkcheckforpermission_0 {
            border-bottom: 1px solid #ddd;
        }

        input[type="text"] {
            border: 1px solid #ccc;
            color: #676767;
            margin-bottom: 0;
            padding: 3px 5px;
        }
    </style>

    <div class="content_pane_cont input_content main-div-tbl" id="contentPane">

        <div class="cheadline1" style="width: 100%; margin-left: 0px">
            <span class="spanheading">Branch List</span>
        </div>

        <div class="inner-search-head for_sigle_row_form">
            <asp:Panel ID="PanelDefault" runat="server" DefaultButton="lbtnclear">
                <asp:TextBox ID="txtbranchcode" runat="server" Width="200px" placeholder="Branch Code" Height="23px" style="margin-left:10px"> </asp:TextBox>
                <asp:TextBox ID="txtloginid" runat="server" Width="200px" Height="23px" placeholder="Enter Login ID"> </asp:TextBox>
                <asp:TextBox ID="txtbrname" runat="server" Width="200px" Height="23px" placeholder="Enter Branch Name"> </asp:TextBox>
                <asp:LinkButton ID="lbtnclear" runat="server" Text="Clear" Style="text-decoration: none; font-size: 19px; float: right; font-weight: bold; margin-right: 20px"></asp:LinkButton>
            </asp:Panel>
        </div>

        <asp:HiddenField ID="hfpages" runat="server" />
        <div id="trnorecordfound" runat="server" style="display: none !important;">
            <div>
                <asp:Label ID="lblnorecord" runat="server" Text="No record found according to your searching." Style="margin-left: 100px; font-size: 15px !important; color: red"></asp:Label>
            </div>
        </div>

        <asp:GridView ID="grduserlist" AutoGenerateColumns="false" Style="width: 98% !important" runat="server" CssClass="stm"
            HeaderStyle-Height="30px" BorderWidth="0" GridLines="None">
            <Columns>
                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="70px">
                    <ItemTemplate>
                        <asp:Label ID="lblSNo" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="RowNumber"></asp:Label>
                        <asp:HiddenField ID="hfemployeeid" runat="server" Value='<%# Eval("Eid") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Branch Code" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Label ID="lblbranchcode" Text='<%# Eval("BranchCode") %>' runat="server" CssClass="BranchCode"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Branch Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lblbranchname" Text='<%# Eval("BranchName") %>' runat="server" CssClass="BranchName"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Branch Address" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Label ID="lblbranchaddress" ToolTip='<%# Eval("BranchAdress") %>' Text='<%# Eval("ShortBranchAdress") %>' runat="server" CssClass="BranchAdress"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Login ID" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Label ID="lblusername" Text='<%# Eval("UserName") %>' runat="server" CssClass="UserName"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Password" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblpassword" Text="*****" ToolTip='<%# Eval("Password") %>' runat="server" CssClass="Password"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                    <ItemTemplate>
                        <asp:ImageButton ID="imgedit" ImageUrl="~/images/edit.png" Height="15" Width="15" runat="server" AlternateText="No Image" CssClass="edit"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Active/Deactive" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                    <ItemTemplate>
                        <asp:ImageButton ID="imgdeactive" ImageUrl='<%# Eval("statusimage") %>' Height="15" Width="15" runat="server" AlternateText="No Image" CssClass="statusimage"></asp:ImageButton>
                        <asp:HiddenField ID="hfbranchid" runat="server" Value='<%# Eval("Brid") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Menu Rights" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                    <ItemTemplate>
                        <asp:ImageButton ID="imgrights" ImageUrl="~/images/userrights.png" Height="25" Width="25" runat="server" AlternateText="No Image" CssClass="userrights"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action Rights" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                    <ItemTemplate>
                        <asp:ImageButton ID="imgactionrights" ImageUrl="~/images/userrights.png" Height="25" Width="25" runat="server" AlternateText="No Image" CssClass="useractionrights"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
            <RowStyle CssClass="stm_dark" />
            <AlternatingRowStyle CssClass="stm_light" />
            <HeaderStyle CssClass="stm_head" />
        </asp:GridView>
        <asp:Label ID="lblmsg" runat="server" Text="Currently, shortlisted employee list is not available." Style="display: none; margin-left: 10px" ForeColor="Red"></asp:Label>
    </div>

    <div class="clear"></div>
    <div class="showpopup" style="display: none">
    </div>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>