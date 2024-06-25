<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="email-login-details.aspx.cs" Inherits="branchpanel_employee_send_login_details" %>

<%@ Register Src="~/BranchPanel/employee/sms_email_loginDetail.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <script type="text/javascript">
        var name = "", mobileno = "", emailid = "", loginid = "", deptartment = "", designation = "", NoOfSend = 0;
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_ddldept').change(function () {
                FillField();
                filldisig();
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddldesignation').change(function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtName').on('change keyup', function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtloginid').blur(function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_txtemailid").keyup(function () {
                FillField();
                BindGridAfterSearch();
            });

            $('#ctl00_ContentPlaceHolder1_btnmail').click(function () {
                var empid = "";
                var trlength = $("#ctl00_ContentPlaceHolder1_gridforsendmailorsms tr").length;
                if (parseInt(trlength) > 0) {
                    alertify.confirm("Are you sure you want to send the email to checked employee:", function (e) {
                        if (e) {
                            for (var i = 1; i < trlength; i++) {
                                var chkchecked = $("#ctl00_ContentPlaceHolder1_gridforsendmailorsms tr:eq(" + i + ") td:eq(5) input").prop("checked");
                                if (chkchecked == true) {
                                    var hdval = $("#ctl00_ContentPlaceHolder1_gridforsendmailorsms tr:eq(" + i + ") td:eq(0) span").html();
                                    empid = empid + "," + hdval;
                                    NoOfSend = NoOfSend + 1;
                                }
                            }
                            empid = empid.slice(1);
                            if (empid == "") {
                                alertify.error("No employee selected.");
                                return false;
                            }
                            GetDetilsAndSendSmsOrEmail(empid, "2");
                        }
                        else {
                            alertify.error("You've clicked Cancel");
                            return false;
                        }
                    });
                }
                return false;
            });
        });

        function filldisig() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "monthly-sallery-report.aspx/binddesignation",
                     data: "{'did':'" + deptartment + "'}",
                     dataType: "json",
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddldesignation").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddldesignation").append($("<option></option>").val(value.desigid).html(value.designame));
                         });
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                         return false;

                     }
                 });
        }
        function CheckemailAllEmp(Checkbox) {
            var chstatus = $("#ctl00_ContentPlaceHolder1_gridforsendmailorsms_chkboxemailSelectAll").prop("checked");
            var GridVwHeaderChckbox = document.getElementById("<%=gridforsendmailorsms.ClientID %>");
            for (i = 1; i < GridVwHeaderChckbox.rows.length; i++) {
                if (chstatus == true) {
                    $(".chkallforemail").find("input[type='checkbox']").prop("checked", true);
                }
                if (chstatus == false) {
                    $(".chkallforemail").find("input[type='checkbox']").prop("checked", false);
                }
            }
        }

        function GetDetilsAndSendSmsOrEmail(seletedemployee, mode) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "email-login-details.aspx/GetDetilsByEid",
                data: "{'allselectedeid':'" + seletedemployee + "','mode':'" + mode + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == "sms") {
                        alertify.success("Sms Send sucessfully To [" + NoOfSend + "  ]employee.");
                        $(".chkallforsms").find("input[type='checkbox']").prop("checked", false);
                        NoOfSend = 0;
                    }
                    else if (data.d == "email") {
                        alertify.success("Email Send sucessfully To  [" + NoOfSend + " ]employee.");
                        $(".chkallforemail").find("input[type='checkbox']").prop("checked", false);
                        NoOfSend = 0;
                    }
                    else if (data.d == "true") {
                        alertify.error("Server Error.");
                    }
                    call_progressbar("end");
                }
            });
        }

        function FillField() {

            name = $('#ctl00_ContentPlaceHolder1_txtName').val();

            deptartment = $('#ctl00_ContentPlaceHolder1_ddldept').val();

            designation = $('#ctl00_ContentPlaceHolder1_ddldesignation').val();

            mobileno = '';

            emailid = $('#ctl00_ContentPlaceHolder1_txtemailid').val();

            loginid = $('#ctl00_ContentPlaceHolder1_txtloginid').val();

        }

        function BindGridAfterSearch() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "email-login-details.aspx/BindGridByJs",
                data: "{'name':'" + name + "','mobileno':'" + mobileno + "','emailid':'" + emailid + "','loginid':'" + loginid + "','deptartment':'" + deptartment + "','designation':'" + designation + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#ctl00_ContentPlaceHolder1_btnmail').css("display", "block");
                        $("[id*=gridforsendmailorsms] tr").show();
                        $('#trnorecordfound').css("display", "none");
                        $("[id*=gridforsendmailorsms] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gridforsendmailorsms] tr:eq(1)").clone(true);
                            $("[id$=gridforsendmailorsms]").append(row);
                            $(row).find('.eid').html(data.d[i].eid);
                            $(row).find('.Name').html(data.d[i].Name);
                            $(row).find('.username').html(data.d[i].username);
                            $(row).find('.password').html(data.d[i].password);
                            $(row).find('.emailID').html(data.d[i].emailID);
                            $(row).find('.mobile').html(data.d[i].mobile);
                        }
                        $("[id*=gridforsendmailorsms] tr").show();
                        $("[id*=gridforsendmailorsms] tr:eq(1)").hide();
                    }
                    else {
                        $("[id*=gridforsendmailorsms] tr").hide();
                        $('#trnorecordfound').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_btnmail').css("display", "none");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }
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
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>E-mail Center</a></li>
            <li style="background: none;"><a class="active" href="#">Email Login Details</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="Stu1" />
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3); margin-bottom: 20px !important;" class="stm">

            <tr>
                <td class="containerHeadline" style="width: 100%">
                    <div style="float: right; width: 100%;">
                        <asp:TextBox ID="txtName" runat="server" Width="100px" placeholder="Name" Height="23px"> </asp:TextBox>
                        <asp:TextBox ID="txtemailid" runat="server" Width="120px" placeholder="Email ID"> </asp:TextBox>
                        <asp:TextBox ID="txtloginid" runat="server" Width="120px" placeholder="Login ID"> </asp:TextBox>
                        <asp:DropDownList ID="ddldept" runat="server" Width="170px"></asp:DropDownList>
                        <asp:DropDownList ID="ddldesignation" runat="server" Width="170px"></asp:DropDownList>
                        <asp:Button ID="btnmail" runat="server" Text="EMAIL" CssClass="button2" Style="float: right !important; color: white !important; width: 70px !important; height: 30px !important;" />
                    </div>
                </td>
            </tr>
            <tr id="trnorecordfound" style="display: none !important;">
                <td>
                    <asp:Label ID="lblnorecord" runat="server" Text="No record found according to your searching." Style="margin-left: 100px; font-size: 15px !important; color: red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView ID="gridforsendmailorsms" AutoGenerateColumns="false" Width="100%" runat="server"
                        HeaderStyle-Height="30px" BorderWidth="0">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblserialno" Text='<%#Eval("eid") %>' runat="server" CssClass="eid"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                                <ItemTemplate>
                                    <asp:Label ID="lblname" Text='<%#Eval("Name") %>' runat="server" CssClass="Name"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Login-Id" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblloginid" Text='<%#Eval("username") %>' runat="server" CssClass="username"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Password" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblpassword" Text='<%# Eval("password") %>' runat="server" CssClass="password"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email-Id" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="250px">
                                <ItemTemplate>
                                    <asp:Label ID="lblemailid" Text='<%# Eval("emailID") %>' runat="server" CssClass="emailID"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkboxemailSelectAll" CssClass="chkboxemailSelectAlljquery" runat="server" Style="padding: 6px 3px 3px 30px;" onclick="CheckemailAllEmp(this);" />
                                    <asp:Label ID="lbltextforall" runat="server" Text="Check For Send Email" Style="margin-left: 7px ! important"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="checkboxemailrowwise" Style="display: block" runat="server" CssClass="checkboxemailjquery chkallforemail" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" Width="190px" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divProgressBar" class="progress"></div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>