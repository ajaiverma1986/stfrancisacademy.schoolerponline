<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="shortlisted-candidates-list.aspx.cs" Inherits="branchpanel_employee_shortlisted_candidates_list" %>

<%@ Register Src="~/branchpanel/employee/shortlist-management.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>

    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style type="clas">
        .activeshortlistlist {
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

        #loader {
            position: relative;
            top: 10%;
        }

        .progress {
            display: none;
        }

        .progressAdd {
            display: block;
            position: fixed;
            background-color: #FAFAFA;
            z-index: 2147483647 !important;
            opacity: 0.8;
            overflow: hidden;
            text-align: center;
            top: 0;
            left: 0;
            height: 100%;
            vertical-align: middle;
            width: 100%;
            padding-top: 20%;
        }

        .lblMessage {
            color: #FF5217;
            font-style: italic;
            font-size: 20px;
            font-family: sans-serif;
        }

        .t1 {
            height: 30px;
            padding-top: 5px;
            color: black;
            font-size: 14px !important;
            padding-left: 25px;
            text-align: left !important;
            border: 1px solid #CCCCCC;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 13px !important;
            text-align: left !important;
            border: 1px solid #CCCCCC;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 14px !important;
            padding-left: 10px;
            text-align: left !important;
            border: 1px solid #CCCCCC;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 13px !important;
            text-align: left !important;
            border: 1px solid #CCCCCC;
        }

        .tblHeading {
            border-bottom: 1px solid #ddd !important;
            width: 95%;
            color: #493f3f;
            font-weight: bold;
            font-size: 17px;
            vertical-align: top;
            text-align: left;
            height: 30px;
            padding-bottom: 2px;
            padding-left: 15px;
            padding-top: 4px;
        }

        .showpopup {
            background: none repeat scroll 0 0 #fff;
            border: 15px solid #8cbf26;
            border-radius: 17px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: auto;
            left: 13%;
            opacity: 1;
            padding-bottom: 20px;
            position: fixed;
            top: 2%;
            width: 76%;
            z-index: 2147483647;
        }

            .showpopup td {
                vertical-align: top;
                color: #666666;
            }

        .showpopup2 {
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

        .texthover {
            border: solid 1px red !important;
        }
    </style>
    <script type="text/javascript">
        var a = jQuery.noConflict();

        function pageLoad() {

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
            pagecount = $("#ctl00_ContentPlaceHolder1_hfpages").val();
            $("#ctl00_ContentPlaceHolder1_lblpage").html(1);
            $("#ctl00_ContentPlaceHolder1_lblTotalPages").html(pagecount);

            document.title = 'Shortlisted Candidates List';
        }

        var shortlistedid = "", name = "", mobile = "", designationid = "", deptid = "", pageno = 1, pagecount = 1, pagesize = 15, msg = "", subject = "", emailid = "";

        a(document).ready(function () {

            //code is  for counting characters in sms text box
            var totalChars = 160; //Total characters allowed in textarea
            var countTextBox = $('#ctl00_ContentPlaceHolder1_txtmsgformobile') // Textarea input box
            var charsCountEl = $('#ctl00_ContentPlaceHolder1_lblremain'); // Remaining chars count will be displayed here

            charsCountEl.text("Total characters : " + totalChars); //initial value of countchars element
            countTextBox.on("keyup keypress paste", function () { //user releases a key on the keyboard

                var thisChars = this.value.replace(/{.*}/g, '').length; //get chars count in textarea

                var per = thisChars * 100;
                var value = (per / totalChars); // total percent complete

                if (thisChars > totalChars) //if we have more chars than it should be
                {
                    var CharsToDel = (thisChars - totalChars); // total extra chars to delete
                    this.value = this.value.substring(0, this.value.length - CharsToDel); //remove excess chars from textarea
                }
                else if (thisChars == 0) {
                    charsCountEl.text("Total characters : " + totalChars);
                }
                else {
                    var finchar = totalChars - thisChars;
                    charsCountEl.text("Remaining characters : " + finchar); //count remaining chars

                }
            });

            //code is  for counting characters in sms text box end here

            a("#tdClosepopup").click(function () {
                $("#divMessage").hide(600);

            });

            a("#btclose").click(function () {
                $("#divforemail").hide(600);

            });
            a("#btclose1").click(function () {
                $("#divformobile").hide(600);
                $('#ctl00_ContentPlaceHolder1_txtmsgformobile').val('');
                $('#ctl00_ContentPlaceHolder1_lblremain').text("Total characters : " + 160);

            });
            $("#ctl00_ContentPlaceHolder1_txtsubject").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtsubject").removeClass("texthover");
            });
            $("#ctl00_ContentPlaceHolder1_txtmesg").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtmesg").removeClass("texthover");
            });

            $("#ctl00_ContentPlaceHolder1_txtmsgformobile").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtmsgformobile").removeClass("texthover");
            });

            a(document).on("click", "[id*=grdforshortlistedemp] [id*=imgEdit]", function () {

                var id, statusid = "";
                id = $(this).parent('div').find('.id').text();

                if (id != "0") {
                    window.location.href = "add-new-shortlist-candidates.aspx?id=" + id;
                }

                return false;
            });

            a(document).on("click", "[id*=grdforshortlistedemp] [id*=imgappoint]", function () {
                var id, statusid = "";
                id = $(this).parent('div').find('.id').text();
                if (id != "0") {
                    window.location.href = "create-new-offer-letter.aspx?shortlistcandidateid=" + id;
                }
                return false;
            });

            a(document).on("click", "[id*=grdforshortlistedemp] [id*=lblempName]", function () {

                pageno = 1;
                shortlistedid = $(this).parent('div').find('.id').text();

                if (shortlistedid != "0") {
                    $("#divMessage").show(500);
                    getemplist(shortlistedid);
                }
                return false;
            });

            a(document).on("click", "[id*=grdforshortlistedemp] [id*=lnkemailid]", function () {

                emailid = $(this).parent('div').find('.emailid').text();
                shortlistedid = $(this).parent('div').find('.id').text();
                $("#divforemail").show(500);
                $("#ctl00_ContentPlaceHolder1_lblemaild").text(emailid);

                return false;
            });

            a(document).on("click", "[id*=grdforshortlistedemp] [id*=lnkContactno2]", function () {

                mobile = $(this).parent('div').find('.mobile').text();
                shortlistedid = $(this).parent('div').find('.id').text();
                $("#divformobile").show(500);
                $("#ctl00_ContentPlaceHolder1_lblmobile").text(mobile);
                return false;
            });

            a("#ctl00_ContentPlaceHolder1_btnsend").click(function () {
                subject = $("#ctl00_ContentPlaceHolder1_txtsubject").val();
                msg = $("#ctl00_ContentPlaceHolder1_txtmesg").val();
                SendingEmail();
                return false;
            });
            a("#ctl00_ContentPlaceHolder1_btnsendformobile").click(function () {
                msg = $("#ctl00_ContentPlaceHolder1_txtmsgformobile").val();
                sendsms();
                return false;
            });

            a('#ctl00_ContentPlaceHolder1_txtName').on('keyup', function () {
                fill_allfield();
                getshorlistedemp();
            });

            a('#ctl00_ContentPlaceHolder1_txtcontactno').on('change', function () {
                fill_allfield();
                getshorlistedemp();

            });

            a('#ctl00_ContentPlaceHolder1_ddldept').on('change', function () {
                fill_allfield();
                designationid = "";
                getshorlistedemp();
                filldisig();

            });

            a('#ctl00_ContentPlaceHolder1_ddldesignation').on('change', function () {
                fill_allfield();
                getshorlistedemp();

            });

            a('#ctl00_ContentPlaceHolder1_txtemailid').on('change', function () {
                fill_allfield();
                getshorlistedemp();
            });

            function fill_allfield() {
                pageno = 1;
                deptid = $('#ctl00_ContentPlaceHolder1_ddldept').val();
                designationid = $("#ctl00_ContentPlaceHolder1_ddldesignation").val();
                name = $('#ctl00_ContentPlaceHolder1_txtName').val();
                emailid = $('#ctl00_ContentPlaceHolder1_txtemailid').val();
                mobile = $('#ctl00_ContentPlaceHolder1_txtcontactno').val().trim();
            }

            //@@@@@@@@@@@@ code for paging @@@@@@@@@@@

            var noofclick = 0, noofclickforfirst = 0;

            $("#btnfirst").click(function () {
                if (parseInt(noofclickforfirst) >= parseInt(pageno)) {
                    alertify.success("You are already on the first page.");
                }
                else {
                    pageno = 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    getshorlistedemp();
                    noofclickforfirst = parseInt(noofclickforfirst) + parseInt(pageno);
                }
                noofclick = 0;

            });
            $("#btnprev").click(function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    noofclickforfirst = parseInt(pageno);
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    getshorlistedemp();
                }

                else {
                    alertify.success("You are already on the first page.");

                }
                noofclick = 0;
            });
            $("#btnnext").click(function () {
                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    noofclick = parseInt(noofclick) + parseInt(pageno);
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    getshorlistedemp();
                }
                else {
                    alertify.success("You are already on the last page.");
                }
                noofclickforfirst = 0;
            });

            $("#btnlast").click(function () {
                if (parseInt(noofclick) == parseInt(pagecount)) {
                    alertify.success("You are already on the last page.");
                }
                else {
                    pageno = pagecount;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    getshorlistedemp();
                    noofclick = parseInt(noofclick) + parseInt(pageno);

                }
                noofclickforfirst = 0;
            });

        });

        function filldisig() {
            call_progressbar("start");
            $.ajax(
             {
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "create-new-offer-letter.aspx/binddesignation",
                 data: "{'did':'" + deptid + "'}",
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

        function getshorlistedemp() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                url: "shortlisted-candidates-list.aspx/GetShortlistedEmp",
                data: "{'name':'" + name + "','mobile':'" + mobile + "','designationid':'" + designationid + "','deptid':'" + deptid + "','shortlistedid':'" + shortlistedid + "','emailid':'" + emailid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var srno = 1;
                    $("[id*=grdforshortlistedemp] tr:gt(1)").remove();

                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=grdforshortlistedemp] tr:eq(1)").clone(true);
                            $("[id$=grdforshortlistedemp]").append(row);

                            $(row).find(".Row_num").html(data.d[i].RowNumber);
                            $(row).find(".id").html(data.d[i].shortlistedid);
                            $(row).find(".Name").html(data.d[i].name);
                            $(row).find(".department").html(data.d[i].department);
                            $(row).find(".mobile").html(data.d[i].contact_no);
                            $(row).find(".emailid").html(data.d[i].email_id);
                            $(row).find(".date").html(data.d[i].shortlisted_day);
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
                        $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_trforpagging").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_grdforshortlistedemp").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_grdforshortlistedemp").css("width", "1072px");

                    }
                    else {
                        var row = $("[id*=grdforshortlistedemp] tr:eq(1)").clone(true);
                        $("[id$=grdforshortlistedemp]").append(row);

                        $(row).find(".id").css("display", "none");
                        $(row).find(".Row_num").css("display", "none");
                        $(row).find(".emailid").css("display", "none");

                        $(row).find(".Name").css("display", "none");
                        $(row).find(".department").css("display", "none");
                        $(row).find(".date").css("display", "none");
                        $(row).find(".designation").css("display", "none");
                        $(row).find(".mobile").css("display", "none");
                        $(row).find(".edit").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_grdforshortlistedemp").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_trforpagging").css("display", "none");
                    }

                    $("[id*=grdforshortlistedemp] tr").show();
                    $("[id*=grdforshortlistedemp] tr:eq(1)").hide();

                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;

                }

            });
        }

        function getemplist(id) {
            call_progressbar("start");

            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "shortlisted-candidates-list.aspx/GetShortlistedEmp",
                data: "{'name':'" + name + "','mobile':'" + mobile + "','designationid':'" + designationid + "','deptid':'" + deptid + "','shortlistedid':'" + shortlistedid + "','emailid':'" + emailid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        OnSuccessReturn(data);
                        shortlistedid = "", name = "", mobile = "", designationid = "", deptid = "", pageno = 1, pagecount = 1, pagesize = 15, msg = "", subject = "", emailid = "";
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                    call_progressbar("end");
                    return false;

                }
            });
        }

        function SendingEmail() {
            if (document.getElementById('<%=txtsubject.ClientID %>').value == 0) {
                document.getElementById('<%= txtsubject.ClientID %>').className = "texthover";
                return false;
            }

            if (document.getElementById('<%=txtmesg.ClientID %>').value == 0) {
                document.getElementById('<%= txtmesg.ClientID %>').className = "texthover";
                return false;
            }

            alertify.confirm("Are you sure you want to send this E-mail?", function (e) {
                if (e) {
                    $('#ctl00_ContentPlaceHolder1_btnsend').prop('disabled', true);
                    $('#ctl00_ContentPlaceHolder1_btnsend').val('Wait..');

                    call_progressbar("start");

                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "shortlisted-candidates-list.aspx/SendMail",
                        data: "{'emailid':'" + emailid + "','subject':'" + subject + "','msg':'" + msg + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (parseInt(data.d) == 1) {
                                insert_sms_history(parseInt(shortlistedid), "", mobile, emailid, msg, subject, "Shortlist", 2, parseInt(shortlistedid));
                                alertify.success("Mail has been sent successfully.");
                                $('#ctl00_ContentPlaceHolder1_btnsend').prop('disabled', false);
                                $('#ctl00_ContentPlaceHolder1_btnsend').val('Send');
                                $('#ctl00_ContentPlaceHolder1_txtsubject').val('');
                                $('#ctl00_ContentPlaceHolder1_txtmesg').val('');
                                $("#divforemail").hide(600);

                            }
                            else {
                                $('#ctl00_ContentPlaceHolder1_btnsend').prop('disabled', false);
                                $('#ctl00_ContentPlaceHolder1_btnsend').val('Send');

                                alertify.error("Some internal error has been occured by host.");

                            }
                            call_progressbar("end");
                            return false;
                        },
                        error: function (response) {
                            call_progressbar("end");
                            return false;

                        }
                    });
                }
            });

            return false;
        }

        function sendsms() {
            if (document.getElementById('<%=txtmsgformobile.ClientID %>').value == 0) {
            document.getElementById('<%= txtmsgformobile.ClientID %>').className = "texthover";
            return false;
        }
        alertify.confirm("Are you sure you want to send this message?", function (e) {
            if (e) {
                $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', true);
                $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Wait..');
                call_progressbar("start");
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "offered-employer-list.aspx/sendsmsonmobile",
                    data: "{'mobile':'" + mobile + "','msg':'" + msg + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ctl00_ContentPlaceHolder1_txtmsgformobile').val('');

                        if (parseInt(data.d) == 1) {
                            insert_sms_history(parseInt(shortlistedid), "", mobile, emailid, msg, subject, "Shortlist", 1, parseInt(shortlistedid));
                            $("#divformobile").hide(600);
                            $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', false);
                            $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Send');
                            alertify.success("Message has been sent successfully");

                        }
                        else {
                            alertify.error("Mobile number is not valid.");
                            $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', false);
                            $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Send');

                        }
                        $('#ctl00_ContentPlaceHolder1_lblremain').text("Total characters : " + 160);
                        call_progressbar("end");
                        return false;

                    },
                    error: function (response) {
                        call_progressbar("end");
                        return false;

                    }
                });
            }
        });
        return false;
    }

    function insert_sms_history(eid, Refno, MobileNo, email_id, msg, subject, MessageModule, mode, shortlist_id) {
        $.ajax({
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: "../Comman.aspx/Maintain_Sms_Email_Log",
            data: "{'eid':'" + eid + "','Refno':'" + Refno + "','MobileNo':'" + MobileNo + "','email_id':'" + email_id + "','msg':'" + msg + "','subject':'" + subject + "','MessageModule':'" + MessageModule + "','mode':'" + mode + "','shortlist_id':'" + shortlist_id + "'}",
            dataType: "json",
            success: function (data) {
                if (parseInt(data.d) == 1) {
                    alertify.success("This SMS history has been maintained");

                }
                if (parseInt(data.d) == 2) {
                    alertify.success("This mail history has been maintained");

                }

                id = "";
                refNo = "";
                mobile = "";
                emailid = "";
                subject = "";
                msg = "";
            }
        });

    }

    function OnSuccessReturn(data) {
        $.each(data.d, function (key, value) {

            $("#lblName").text(value.name);
            $("#lblphone").text(value.contact_no);
            $("#lblEmail").text(value.email_id);

            $("#lblCountry").text(value.country);
            $("#lblState").text(value.state);
            $("#lblCity").text(value.city);
            $("#lblAddress").text(value.address);
            $("#lblPinCode").text(value.pinCode);
            $("#lblGender").text(value.gender);

            $("#annualCTC").text(value.current_ctc_per_annum);
            $("#lblDept").text(value.department);
            $("#lblShortlisteddate").text(value.shortlisted_day);

            $("#lblYears").text(value.experience_year);
            $("#lblMonths").text(value.experience_month);
            $("#remark").text(value.remak);
            $("#ctcappliedfrom").text(value.expected_ctc_per_annum);

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
            <li><a>HR Managment</a></li>
            <li><a>Shortlisted Candidates </a></li>
            <li style="background: none;"><a class="active">Shortlisted Candidates List</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
    </div>
    <table border="0" cellspacing="0" cellpadding="0" style="width: 1072px!important; margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">

        <tr>
            <td class="containerHeadline" style="width: 100%">

                <div style="float: right; width: 100%;">

                    <asp:TextBox ID="txtName" runat="server" Width="100px" placeholder="Name" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtcontactno" runat="server" Width="120px" placeholder="Contact No."> </asp:TextBox>
                    <asp:TextBox ID="txtemailid" runat="server" Width="120px" placeholder="Email ID"> </asp:TextBox>
                    <asp:DropDownList ID="ddldept" runat="server" Width="170px"></asp:DropDownList>
                    <asp:DropDownList ID="ddldesignation" runat="server" Width="170px"></asp:DropDownList>
                </div>
            </td>
        </tr>
        <asp:HiddenField ID="hfpages" runat="server" />
        <tr style="display: block; width: 1072px !important">
            <td align="left" style="width: 1072px !important; padding-left: 0px; padding-right: 0px;">
                <asp:GridView ID="grdforshortlistedemp" AutoGenerateColumns="false" Style="width: 1072px!important" runat="server"
                    HeaderStyle-Height="30px" BorderWidth="0">

                    <Columns>
                        <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="70px">
                            <ItemTemplate>
                                <asp:Label ID="lblSNo" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="Row_num"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lbldateofinterview" Text='<%# Eval("shortlisted_day","{0:dd/MM/yy}") %>' runat="server" CssClass="date"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="left" HeaderStyle-Width="500px">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblempName" Text='<%# Eval("name2") %>' Style="color: black; float: left; margin-left: -15px" runat="server" CssClass="Name" ToolTip="click here for show complete details."></asp:LinkButton>
                                    <asp:Label ID="lblempid" runat="server" Text='<%#Eval("shortcanid") %>' CssClass="id" Style="display: none"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Designation/Department" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="500px">
                            <ItemTemplate>
                                <asp:Label ID="lbldepartment" Text='<%# Eval("deptName") %>' runat="server" CssClass="department"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Contact No." ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lnkContactno2" Text='<%# Eval("contact_no") %>' Style="color: black" runat="server" CssClass="mobile" ToolTip="click here for send sms."></asp:LinkButton>
                                    <asp:Label ID="lblsrtlistidforhistory" runat="server" Text='<%#Eval("shortcanid") %>' CssClass="id" Style="display: none"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email ID" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lnkemailid" Text='<%# Eval("email_id") %>' Style="color: black" runat="server" CssClass="emailid" ToolTip="click here for send email."></asp:LinkButton>
                                    <asp:Label ID="lblsrtlistidforhistory2" runat="server" Text='<%#Eval("shortcanid") %>' CssClass="id" Style="display: none"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                            <ItemTemplate>
                                <div>
                                    <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/images/edit.gif" CssClass="edit" CausesValidation="false" />
                                    <asp:Label ID="lblidforedit" runat="server" Text='<%#Eval("shortcanid") %>' CssClass="id" Style="display: none"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Offer" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                            <ItemTemplate>
                                <div>
                                    <asp:ImageButton ID="imgappoint" runat="server" ImageUrl="~/images/offerjobnow.png" Width="25px" ToolTip="Click here to offer this candidate. " CssClass="edit" CausesValidation="false" />
                                    <asp:Label ID="lbleditforappoint" runat="server" Text='<%#Eval("shortcanid") %>' CssClass="id" Style="display: none"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_dark" />
                    <HeaderStyle CssClass="stm_head" />
                </asp:GridView>
                <asp:Label ID="lblmsg" runat="server" Text="Currently, shortlisted employee list is not available." Style="display: none; margin-left: 10px" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr id="trforpagging" runat="server" style="width: 100%; display: none">
            <td align="left" style="width: 40%" class="containerHeadline">

                <div style="margin-left: 0px; float: left; width: 400px;">
                    <asp:Label ID="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                    <asp:Label ID="Label1" runat="server" Style="color: green; font-size: 11pt"></asp:Label>
                    of
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
                <div id="divMessage" class="showpopup" style="text-align: center; display: none">

                    <div style="text-align: right;">
                        <div style="width: 50px; height: 33px; float: right; text-align: center; margin: 4px 21px 0px 0px; margin-right: 36px">
                            <a id="tdClosepopup" style="color: white; cursor: pointer; font-size: 15px; text-decoration: none" class="button2">Close</a>
                        </div>
                    </div>

                    <div id="content">
                        <div id="tab1">
                            <table style="background-color: white; vertical-align: top; width: 98%;">
                                <tr>
                                    <td colspan="4" class="tblHeading">Personal Details</td>
                                </tr>

                                <tr>
                                    <td style="width: 20%" class="t1"><span>Full Name:</span></td>
                                    <td style="width: 40%" class="t2">
                                        <label id="lblName"></label>
                                    </td>
                                    <td style="width: 10%" class="t3"><span>Mobile No:</span></td>
                                    <td style="width: 35%" class="t4">
                                        <label id="lblphone"></label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1"><span>Email ID:</span></td>
                                    <td class="t2">
                                        <label id="lblEmail"></label>
                                    </td>
                                    <td class="t3"><span>Shortlisted Date:</span></td>
                                    <td class="t4">
                                        <label id="lblShortlisteddate"></label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1"><span>Gender:</span></td>
                                    <td class="t2">
                                        <label id="lblGender"></label>
                                    </td>

                                    <td class="t1"><span>City:</span></td>
                                    <td class="t2">
                                        <label id="lblCity"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t3"><span>State:</span></td>
                                    <td class="t4">
                                        <label id="lblState"></label>
                                    </td>

                                    <td class="t1"><span>Country:</span></td>
                                    <td class="t2">
                                        <label id="lblCountry"></label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t3"><span>Address:</span></td>
                                    <td class="t4">
                                        <label id="lblAddress"></label>
                                    </td>
                                    <td class="t1"><span>Pin Code:</span></td>
                                    <td class="t2" colspan="3">
                                        <label id="lblPinCode"></label>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="4" class="tblHeading">Employement Details</td>
                                </tr>
                                <tr>
                                    <td class="t1"><span>Experience:</span></td>
                                    <td class="t2">
                                        <table>
                                            <tr>
                                                <td><b>Years</b></td>
                                                <td><b>Months</b></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label id="lblYears"></label>
                                                </td>
                                                <td>
                                                    <label id="lblMonths"></label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                    <td class="t1"><span>Designation/Department:</span></td>
                                    <td class="t2">
                                        <label id="lblDept"></label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1"><span>Expected CTC(Per Annum): </span></td>
                                    <td class="t2">
                                        <label id="ctcappliedfrom"></label>
                                    </td>
                                    <td class="t1"><span>Current CTC(Per Annum):</span></td>
                                    <td class="t2">
                                        <label id="annualCTC"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t1"><span>Remark: </span></td>
                                    <td class="t2" colspan="3">
                                        <label id="remark"></label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="divforemail" style="text-align: center; display: none;">
                    <div style="width: 95%; margin: 10px;">
                        <table class="showpopup2" style="background-color: white; vertical-align: top">
                            <tr>
                                <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 5px;" id="td1"><a id="btclose">Close</a></td>
                            </tr>

                            <tr>
                                <td class="t1"><span>To:</span></td>
                                <td class="t2" style="padding-bottom: 5px">
                                    <asp:Label ID="lblemaild" Style="height: 24px; width: 250px;" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="t1" id="tdforsubject"><span>Subject:</span></td>
                                <td class="t2" id="tdforsubject1">
                                    <asp:TextBox ID="txtsubject" Style="height: 24px; width: 250px;" runat="server"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td class="t1" valign="top"><span>Message:</span></td>
                                <td class="t2">
                                    <asp:TextBox ID="txtmesg" runat="server" Style="height: 100px; width: 251px" TextMode="MultiLine"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td colspan="3" style="padding-top: 10px!important">
                                    <asp:Button ID="btnsend" runat="server" Text="Send" CssClass="button2" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div id="divformobile" style="text-align: center; display: none;">
                    <div style="width: 95%; margin: 10px;">
                        <table class="showpopup2" style="background-color: white; vertical-align: top">
                            <tr>
                                <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 5px;" id="td2"><a id="btclose1">Close</a></td>
                            </tr>

                            <tr>
                                <td class="t1"><span>To:</span></td>
                                <td class="t2" style="padding-bottom: 5px">
                                    <asp:Label ID="lblmobile" Enabled="false" Style="height: 24px; width: 250px;" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="t1" valign="top"><span>Message:</span></td>
                                <td class="t2">
                                    <div>
                                        <div style="float: left; height: 15px; width: 300px; margin-left: 2px; margin-top: -8px;">
                                            <asp:Label ID="lblremain" runat="server" Style="color: #878484; font-size: 11px"></asp:Label>
                                        </div>
                                        <br />
                                        <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                            <asp:TextBox ID="txtmsgformobile" runat="server" Style="height: 100px; width: 251px" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                            </tr>

                            <tr>
                                <td colspan="3" style="padding-top: 10px!important">
                                    <asp:Button ID="btnsendformobile" runat="server" Text="Send" CssClass="button2" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="divProgressBar" class="progress"></div>
            </td>
        </tr>
    </table>
</asp:Content>