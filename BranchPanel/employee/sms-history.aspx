<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="sms-history.aspx.cs" Inherits="branchpanel_employee_sms_history" %>


<%@ Register Src="~/BranchPanel/employee/employee_sms.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>

    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <script src="../../Calender/js/jquery-ui-1.8.19.custom.min.js"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <style type="text/css">        
        .t1 {
            height: 10px !important;
            padding-top: 0px !important;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 25px;
            text-align: left !important;
        }

        .t2 {
            padding-top: 0px !important;
            font-size: 12px !important;
            text-align: left !important;
        }

        .showpopup {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 15px solid #CD3B09;
            border-radius: 25px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 40%;
            left: 32%;
            opacity: 1;
            position: fixed;
            top: 15%;
            width: 38%;
            z-index: 2147483647;
        }
    </style>
    <script type="text/javascript">

        var refNo = "", mobile = "", datefrom = "", dateto = "", pageno = 1, pagecount = 1;

        function pageLoad() {
            pagecount = $("#ctl00_ContentPlaceHolder1_hfpages").val();
            $("#ctl00_ContentPlaceHolder1_lblpage").html(1);
            $("#ctl00_ContentPlaceHolder1_lblTotalPages").html(pagecount);
        }
        $(document).ready(function () {

            $('.mess').click(function () {
                $("#divformessage").show(500);
                $('#ctl00_ContentPlaceHolder1_lblshowmobile').html($(this).parent('td').find('.mobile_no').html());
                $('#ctl00_ContentPlaceHolder1_lblmessage').html($(this).parent('td').find('.sms_text').html());
                return false;
            });

            $("#btclose").click(function () {
                $("#divformessage").hide(600);
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_txtsmsdatefrom").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy',
            });

            $("#ctl00_ContentPlaceHolder1_txtsmsdateto").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy',
            });

            $('#ctl00_ContentPlaceHolder1_txtreferenceno').on('keyup', function () {
                refNo = $(this).val();

                get_smshistory();
            });
            $('#ctl00_ContentPlaceHolder1_txtcontactno').on('change keypress', function () {
                mobile = $(this).val();
                get_smshistory();
            });

            $("#ctl00_ContentPlaceHolder1_txtsmsdatefrom").on('change', function () {
                datefrom = $(this).val();
                get_smshistory();

            });
            $("#ctl00_ContentPlaceHolder1_txtsmsdateto").on('change', function () {
                dateto = $(this).val();
                get_smshistory();

            });
            //==============code for pagging================
            $("#btnfirst").click(function () {
                pageno = 1;
                $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                get_smshistory();

            });
            $("#btnprev").click(function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    get_smshistory();
                }

            });
            $("#btnnext").click(function () {
                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    get_smshistory();
                }

            });
            $("#btnlast").click(function () {
                pageno = pagecount;
                $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                get_smshistory();

            });
        });

        function get_smshistory() {
            call_progressbar("start");

            $.ajax({
                type: "POST",
                url: "../Comman.aspx/Get_sms_history",
                data: "{'refNo':'" + refNo + "','mobile':'" + mobile + "','datefrom':'" + datefrom + "','dateto':'" + dateto + "','pageno':'" + pageno + "'}",

                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $("[id*=gridforsmshistory] tr:gt(1)").remove();

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=gridforsmshistory] tr:eq(1)").clone(true);

                            $("[id$=gridforsmshistory]").append(row);

                            $(row).find(".RowNumber").html(data.d[i].RowNumber);
                            $(row).find(".nm").html(data.d[i].name);
                            $(row).find(".ref_no").html(data.d[i].ref_no);

                            $(row).find(".sms_date").html(data.d[i].sms_date);

                            $(row).find(".sms_time").html(data.d[i].sms_time);

                            $(row).find(".sms_text").html(data.d[i].sms_text);

                            $(row).find(".status").html(data.d[i].status);

                            $(row).find(".mobile_no").html(data.d[i].mobile_no);

                            $(row).find(".sub_mobile").html(data.d[i].sub_mobile);

                            pagecount = data.d[i].pagecount;

                            if (pagecount == 1) {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text("1");
                                $("#ctl00_ContentPlaceHolder1_lblpage").text("1");
                            }
                            else {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text(pagecount);
                                $("#ctl00_ContentPlaceHolder1_lblpage").text(pageno);
                            }

                        }
                        $("#ctl00_ContentPlaceHolder1_trforpagging").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_gridforsmshistory").css("display", "block");
                    }
                    else {
                        var row = $("[id*=gridforsmshistory] tr:eq(1)").clone(true);
                        $("[id$=gridforsmshistory]").append(row);

                        $(row).find(".RowNumber").css("display", "none");
                        $(row).find(".nm").css("display", "none");
                        $(row).find(".ref_no").css("display", "none");
                        $(row).find(".sub_mobile").css("display", "none");

                        $(row).find(".sms_date").css("display", "none");

                        $(row).find(".sms_time").css("display", "none");

                        $(row).find(".sms_text").css("display", "none");

                        $(row).find(".status").css("display", "none");

                        $(row).find(".mobile_no").css("display", "none");

                        $(row).find(".mess").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_trforpagging").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_gridforsmshistory").css("display", "none");
                    }

                    $("[id*=gridforsmshistory] tr").show();
                    $("[id*=gridforsmshistory] tr:eq(1)").hide();

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
            <li><a>SMS Center</a></li>
            <li style="background: none;"><a class="active" href="#">SMS History</a></li>
        </ul>
    </div>
     <div class="content_pane_cont input_content" id="contentPane12">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
    </div>   
    <div class="content_pane_cont input_content" id="contentPane">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
            <tr>
                <td class="containerHeadline" style="width: 100%">

                    <div style="float: right; width: 100%;">
                        <asp:TextBox ID="txtreferenceno" runat="server" Width="120px" placeholder="emp-code." Height="23px"> </asp:TextBox>
                        <asp:TextBox ID="txtcontactno" runat="server" Width="120px" placeholder="Contact No."> </asp:TextBox>
                        <asp:TextBox ID="txtsmsdatefrom" runat="server" Width="130px" placeholder="Date From"> </asp:TextBox>
                        <asp:TextBox ID="txtsmsdateto" runat="server" Width="130px" placeholder="Date To"> </asp:TextBox>
                    </div>
                </td>
            </tr>
            <asp:HiddenField ID="hfpages" runat="server" />
            <tr>
                <td align="left" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView ID="gridforsmshistory" AutoGenerateColumns="false" Width="100%" runat="server"
                        HeaderStyle-Height="30px" BorderWidth="0">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="RowNumber"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="emp-code." ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblRefno" Text='<%# Eval("ref_no") %>' runat="server" CssClass="ref_no" ToolTip="click here for see offerletter list."></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                                <ItemTemplate>
                                    <asp:Label ID="lblname" Text='<%# Eval("name") %>' runat="server" CssClass="nm" ToolTip="click here for see offerletter list."></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SMS Sent Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                                <ItemTemplate>
                                    <asp:Label ID="lblsmsdate" Text='<%# Eval("sms_date") %>' runat="server" CssClass="sms_date"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sent Time" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                                <ItemTemplate>
                                    <asp:Label ID="lblsmstime" Text='<%# Eval("sms_time","{0:hh:mm}") %>' runat="server" CssClass="sms_time"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sent Message" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                                <ItemTemplate>
                                    <asp:ImageButton ID="lnkbtnfortext" ImageUrl="~/images/message.png" Width="30" ToolTip="Click here for show message details." Height="30" runat="server" CssClass="mess"></asp:ImageButton>
                                    <asp:Label ID="lblforsubmobile" Text='<%# Eval("mobile_no") %>' Style="display: none" runat="server" CssClass="mobile_no"></asp:Label>
                                    <asp:Label ID="lblsmstext" Text='<%# Eval("sms_text") %>' Style="display: none" runat="server" CssClass="sms_text"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mobile No." ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                                <ItemTemplate>
                                    <asp:Label ID="lblmobilenumber" Text='<%# Eval("sub_mobile") %>' runat="server" CssClass="sub_mobile"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
                    <asp:Label ID="lblmsg" runat="server" Text="Currently, SMS history is not available." Style="display: none; margin-left: 10px" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr id="trforpagging" runat="server" style="width: 100%; display: none">
                <td align="left" style="width: 40%" class="containerHeadline">
                    <div style="margin-left: 0px; float: left; width: 400px;">
                        <asp:Label ID="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Style="color: green; font-size: 11pt"></asp:Label>
                        Of
                        <asp:Label ID="lblTotalPages" Style="margin-left: 0px; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                        <span style="font-size: 11pt">Page</span>
                    </div>
                    <div style="margin-left: 0px; float: left; width: 300px;">
                        <img src="../../images/first.gif" id="btnfirst" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/previous.gif" id="btnprev" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/next.gif" id="btnnext" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/last.gif" id="btnlast" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divProgressBar" class="progress"></div>
                </td>
            </tr>
        </table>
        <div id="divformessage" style="text-align: center; display: none;">
            <div style="width: 100%; margin: 10px;">
                <table class="showpopup" style="background-color: white; vertical-align: top;">
                    <tr>
                        <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 0px;" id="td2"><a id="btclose">Close</a></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 10px!important"></td>
                    </tr>
                    <tr>
                        <td class="t1" style="padding-top: 0px !important;"><span>To:</span></td>
                        <td class="t2">
                            <asp:Label ID="lblshowmobile" Style="height: 24px; width: 250px; padding-top: 20px !important; color: #007ACC; font-size: 18px; font-family: Arial" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="t1" style="padding-top: 0px !important;"><span>Message:</span></td>
                        <td class="t2">
                            <asp:Label ID="lblmessage" Style="height: 24px; width: 250px; padding-top: 20px !important; color: #007ACC; font-size: 18px; font-family: Arial" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 10px!important"></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 10px!important"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>