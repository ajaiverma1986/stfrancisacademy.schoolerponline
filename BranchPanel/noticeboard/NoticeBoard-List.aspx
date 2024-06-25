<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="NoticeBoard-List.aspx.cs" Inherits="BranchPanel_commonpage_NoticeBoard_List" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Moxiecode.TinyMCE" Namespace="Moxiecode.TinyMCE.Web" TagPrefix="tinymce" %>
<%@ Register TagPrefix="ce" Namespace="CuteEditor" Assembly="CuteEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .radio, .checkbox label {
            min-height: 20px;
            float: left;
            width: 23px !important;
            margin-top: 12px;
        }

        .student-photo_frame {
            height: auto;
            width: 100%;
            background: #F4F1F1;
            border: 1px solid #ccc;
            margin-bottom: 30px;
        }

        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
        }

        .for_sigle_row_form label {
            float: left;
            text-align: right;
            width: 220px;
            margin-right: 20px;
            color: #616161;
            font-size: 14px;
            margin-top: -6px;
        }

        .user_phot_frame {
            position: absolute;
            left: 73%;
            margin-top: -62px;
        }

        .texthover {
            border: dotted 1px white !important;
            background-color: #FD3018 !important;
            color: white !important;
        }

        .stm td {
            border-bottom: 1px solid #dddddd;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#" class="active">Notice Board List</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div style="margin-bottom: -3px; margin-top: 10.5px;">
        <a style="cursor: pointer" id="txsettings" class="active3">Notice List</a>
        <a style="cursor: pointer" class="sgpt1 active7" id="btnaddnewtax">Add New Notice</a>
    </div>
    <br />

    <%--div for show notice list satrt--%>
    <div class="main-div-tbl" id="divfornotice">
        <div class="clear"></div>
        <div class="content_pane_cont input_content">
            <div class="clear"></div>
            <table class="stm" width="100%">
                <tr class="stm_head" align="center">
                    <th style="width: 3%">S.No.</th>
                    <th style="width: 10%">Type of Notice</th>
                    <th>Notice Content</th>
                    <th style="width: 10%">From Date</th>
                    <th style="width: 10%">To Date</th>
                    <th style="width: 10%">Status</th>
                    <th style="width: 5%">Edit</th>
                    <th style="width: 5%">Delete</th>
                </tr>
            </table>
        </div>
    </div>
    <%--div for show notice list end--%>

    <%--div for add notice start--%>
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="for_sigle_row_form">
            <label>
                Notice for:<span style="color: #ff0066">*</span></label>
            <asp:DropDownList ID="noticetype" runat="server">
            </asp:DropDownList>&nbsp;
        </div>
        <div class="for_sigle_row_form" id="diffclass" style="display: none">
            <label>
                Select Class:<span style="color: #ff0066">*</span></label>
            <asp:DropDownList ID="classtype" runat="server">
            </asp:DropDownList>&nbsp;
        </div>
        <div class="for_sigle_row_form" id="divforlist">
            <asp:TextBox ID="txtsearchname" runat="server" placeholder="Enter Name Please" Style="margin-left: 240px" Width="248px"></asp:TextBox>
            <asp:ImageButton ID="btnclear" CssClass="restsearch" Width="35px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." Style="margin-bottom: -13px" />
            <br />
            <label id="lbllist"><span style="color: #ff0066">*</span></label>
            <div class="divfortbl" style="max-height: 500px; width: 351px; position: relative; border: 1px solid #ddd; overflow-x: hidden; overflow-y: auto; clear: right">
                <table class="stm1" id="tblcourcesname" style="width: 100%">
                    <tr class="stm_head">
                        <th style="text-align: center">S.No.</th>
                        <th style="text-align: center">Name</th>
                        <th>
                            <input type="checkbox" id="msgcheck" />
                            Check All</th>
                    </tr>
                </table>
            </div>
        </div>
        <%--  <div class="for_sigle_row_form">
            <label>
                Message:<span style="color: #ff0066">*</span>
            </label>
            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" MaxLength="160" placeholder="Please Write Message"></asp:TextBox>&nbsp;
        </div>--%>


        <div class="for_sigle_row_form" style="margin-top: 5px;">
            <label>
                Message:<span style="color: #ff0066">*</span></label>
            <asp:Label runat="server" ID="lbBid" Style="display: none" Text=""></asp:Label>
            <asp:Label runat="server" ID="lbType" Style="display: none" Text=""></asp:Label>
            <ce:editor id="txtMessage" runat="server" style="height: 500px;"></ce:editor>
        </div>


        <div class="for_sigle_row_form">
            <label>
                Notice Show from Date:<span style="color: #ff0066">*</span>
            </label>
            <asp:HiddenField ID="hdfromdate" runat="server" />
            <asp:TextBox ID="txtfromdate" runat="server" placeholder="Please Enter Date" onkeypress="return false"></asp:TextBox>&nbsp;
        </div>
        <div class="for_sigle_row_form">
            <label>
                Notice Show to Date:<span style="color: #ff0066">*</span>
            </label>
            <asp:HiddenField ID="hdtodate" runat="server" />
            <asp:TextBox ID="txttodate" runat="server" placeholder="Please Enter Date" onkeypress="return false"></asp:TextBox>&nbsp;
        </div>
        <div class="for_sigle_row_form">
            <label id="lblactive">
                Active:
            </label>
            <input type="checkbox" id="checkactive" />
        </div>
        <div class="for_sigle_row_form">
            <label id="lblmail" style="display: none">
                Send Mail:
            </label>
            <input type="checkbox" id="checkmail" style="display: none" />
        </div>
        <div class="for_sigle_row_form">
            <label id="lblmessage" style="display: none">
                Send Message:
            </label>
            <input type="checkbox" id="checkmessage" style="display: none" />
        </div>
        <div class="for_sigle_row_form">
            <label id="Label1" style="display: none">
                Show Panel:
            </label>
            <input type="checkbox" id="checkpanel" style="display: none" />
        </div>
        <div class="for_sigle_row_form">
            <button id="sendnotice" class="button_save" title="Click Here To Submit " style="margin-left: 370px">Submit</button>
            <button id="btnupdate" class="button_save" title="Click Here To Update " style="margin-left: 360px">Update</button>
            <button id="btnback" class="button_cancel" title="Click Here To Back">Back</button>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <%-- div for add notice end--%>

    <%--div for popup start--%>
    <div id="divforaddnotice" style="text-align: center; display: none;" class="">
        <div>

            <table class="showpopuptopic showpopup2" style="background-color: white; vertical-align: top">
                <tr>
                    <td colspan="2" class="pop-headng-sty">BroadCast
                            <a id="BtnCancelSend" title="Close this from here"
                                class="btnClose">
                                <img src="../../images/popupcross.png"></a>
                    </td>
                </tr>
                <%--<tr class="for_sigle_row_form">
                      <td>
                          <label style="visibility:hidden">Send Message</label>
                           <input type="checkbox" id="Checkforsms" style="visibility:hidden" />
                      </td>
                  </tr>
                  <tr class="for_sigle_row_form">
                      <td>
                          <label style="visibility:hidden">Send Email</label>
                          <input type="checkbox" id="Checkforemail" style="visibility:hidden" />
                      </td>
                  </tr>--%>
                <tr class="for_sigle_row_form">
                    <td>
                        <label>Show on Panel</label>
                        <input type="checkbox" id="Checkforpanel" />
                    </td>
                </tr>
                <tr class="for_sigle_row_form">
                    <td align="center">
                        <asp:Button ID="BtnSend" runat="server" Text="Send" CssClass="button_save" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <%--div for popup end--%>

    <script type="text/javascript">
        var nid = 0, mode = 0;
        BindNoticeType();
        $('#divforlist').hide();
        $('#ctl00_ContentPlaceHolder1_txtsearchname').hide();
        var noticeid = '', message = '', fromdate = '', todate = '', active = 0, broadcastsms = 0, broadcastemail = 0, tid = 0, alertmessage = '';
        var year = 2017, valuefortype = '', curntdate = '', studentname = '', ispanel = 0, checkstatus = 0, broadcastpanel = 0;
        var changepanelid = 0, noticetid = 0;
        $('#msgcheck').change(function () {
            if ($(this).is(':checked')) {
                $('.stm1').find('input[type=checkbox]').prop('checked', true);
            }
            else {
                $('.stm1').find('input[type=checkbox]').prop('checked', false);
            }
        });

        $("#ctl00_ContentPlaceHolder1_txtfromdate").datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: '1970:' + year,
            dateFormat: 'dd/mm/yy'
        });

        $("#ctl00_ContentPlaceHolder1_txttodate").datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: '1970:' + year,
            dateFormat: 'dd/mm/yy'
        });
        $('#ctl00_ContentPlaceHolder1_txtfromdate').change(function () {
            convertdate($(this).val());
        });
        $("#ctl00_ContentPlaceHolder1_txttodate").change(function () {
            convertenddate($(this).val());
        });
        function convertdate(inputdob) {
            var DOBDate = new Date(inputdob);
            var dateAr = inputdob.split('/');
            var newDate = dateAr[1] + '/' + dateAr[0] + '/' + dateAr[2];
            $("#ctl00_ContentPlaceHolder1_hdfromdate").val(newDate);
            return true;
        }
        function convertenddate(inputdob) {
            var DOBDate = new Date(inputdob);
            var dateAr = inputdob.split('/');
            var newDate = dateAr[1] + '/' + dateAr[0] + '/' + dateAr[2];
            $("#ctl00_ContentPlaceHolder1_hdtodate").val(newDate);
            return true;
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

        $("#ctl00_ContentPlaceHolder1_txtMessage").focus(function () { $("#ctl00_ContentPlaceHolder1_txtMessage").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_noticetype").focus(function () { $("#ctl00_ContentPlaceHolder1_noticetype").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txtfromdate").focus(function () { $("#ctl00_ContentPlaceHolder1_txtfromdate").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txttodate").focus(function () { $("#ctl00_ContentPlaceHolder1_txttodate").removeClass("texthover"); });

        $('#ctl00_ContentPlaceHolder1_txttodate').on('change', function () {
            fromdate = $('#ctl00_ContentPlaceHolder1_hdfromdate').val();
            todate = $('#ctl00_ContentPlaceHolder1_hdtodate').val();
            if (Date.parse(todate) < Date.parse(fromdate)) {
                alert('ToDate is less then FromDate ');
            }
        });

        $('#sendnotice').live('click', function () {
            if (checkvalidation()) {
                mode = 3;
                if ($('#checkactive').prop("checked") == false) {
                    active = 0;
                }
                else {
                    active = 1;
                }
                FillField();
                if (checkdate()) {
                    GetDetailofNotice();
                    if ($('#checkactive').is(':checked')) {
                        //checkforSmsEmailPanel();
                    }
                    else {
                        active = 0;
                        if ($('#checkmessage').is(':checked') || $('#checkmail').is(':checked') || $('#checkpanel').is(':checked')) {
                            alertify.error("Your Message is Not Active");
                        }
                    }
                }
                showlist();
            }
            return false;
        });

        $('.restsearch').live('click', function () {
            $('#ctl00_ContentPlaceHolder1_txtsearchname').val('');
            FillField();
            BindStudent();
            return false;
        });

        $('.statusedit').live('click', function () {
            changepanelid = $(this).parent('td').parent('tr').find('input[id*=idupdate]').val();
            noticetid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
            chngstatuspanel(changepanelid, noticetid)
            return false;
        });

        function checkvalidation() {
            var status = 1;
            var temp = 0;
            var i = 1;
            if ($('#divforlist').is(":visible")) {
                $('.stm1').find('tr:gt(0)').each(function () {
                    if ($('.stm1').find('tr:eq(' + i + ')').find('input[type=checkbox]').is(':checked')) {
                        temp = 1;
                        return false;
                    }
                    else {
                        temp = 0;
                    }
                    i++;
                });
                if (temp == 0) {
                    status = 0;
                    alert("Please check at least one checkbox from the table");
                }
            }
            if (document.getElementById('<%= txtMessage.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtMessage.ClientID %>').className = "texthover";
                status = 0;
            }
            if (document.getElementById('<%= noticetype.ClientID %>').value.trim() == "0") {
                document.getElementById('<%= noticetype.ClientID %>').className = "texthover";
                status = 0;
            }
            if (document.getElementById('<%= txtfromdate.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtfromdate.ClientID %>').className = "texthover";
                  status = 0;
              }
              if (document.getElementById('<%= txttodate.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txttodate.ClientID %>').className = "texthover";
                status = 0;
            }

            if (status == 1) {
                if (noticeid > 1) {
                    checkcheckbox();
                }
                else {
                    valuefortype = '';
                }
                return true;
            }
            if (status == 0) {
                return false;
            }

        }

        $('#ctl00_ContentPlaceHolder1_noticetype').change(function () {
            noticeid = $(this).val();
            if ($(this).val() > 1) {
                $('#diffclass').hide(500)
                $('#divforlist').show(500);
                $('#ctl00_ContentPlaceHolder1_txtsearchname').hide();
                $('#ctl00_ContentPlaceHolder1_btnclear').hide();
                if ($(this).val() == 2) {
                    $('#diffclass').hide(500)
                    $('#lbllist').html('Classes');
                    $('#ctl00_ContentPlaceHolder1_txtsearchname').hide();
                    $('#ctl00_ContentPlaceHolder1_btnclear').hide();
                    BindClasses();
                }
                if ($(this).val() == 3) {
                    $('#diffclass').show(500)
                    Bindclass()
                    $('#lbllist').html('Courses');
                    $('#ctl00_ContentPlaceHolder1_txtsearchname').hide();
                    $('#ctl00_ContentPlaceHolder1_btnclear').hide();
                    BindCourse();
                }
                if ($(this).val() == 4) {
                    $('#diffclass').hide(500)
                    $('#lbllist').html('Employee');
                    $('#ctl00_ContentPlaceHolder1_txtsearchname').hide();
                    $('#ctl00_ContentPlaceHolder1_btnclear').hide();
                    OtherEmployee();
                }
                if ($(this).val() == 5) {
                    $('#diffclass').hide(500)
                    $('#ctl00_ContentPlaceHolder1_txtsearchname').show();
                    $('#ctl00_ContentPlaceHolder1_btnclear').show();
                    $('#lbllist').html('Students');
                    BindStudent();
                }
            }
            else {
                $('#divforlist').hide();
            }
        });

        $('#checkactive').change(function () {
            if ($('#checkactive').is(':checked')) {
                active = 1;
            }
            else {
                active = 0;
            }
        });

        //$('#checkmessage').change(function () {
        //    if ($('#checkmessage').is(':checked')) {
        //        broadcastsms = 1;
        //    }
        //    else {
        //        broadcastsms = 0;
        //    }
        //});

        //$('#checkmail').change(function () {
        //    if ($('#checkmail').is(':checked')) {
        //        broadcastemail = 1;
        //    }
        //    else {
        //        broadcastemail = 0;
        //    }
        //});

        //$('#checkpanel').change(function () {
        //    if ($('#checkpanel').is(':checked')) {
        //        broadcastpanel = 1;
        //    }
        //    else {
        //        broadcastpanel = 0;
        //    }
        //});

        $('#ctl00_ContentPlaceHolder1_txtsearchname').on('keyup', function () {
            FillField();
            BindStudent();
        });

        function FillField() {
            var d = new Date();
            var n = d.getDate();
            var m = d.getMonth() + 1;
            var y = d.getFullYear();
            curntdate = m + '/' + n + '/' + y;
            noticeid = $('#ctl00_ContentPlaceHolder1_noticetype').val();
            // message = $('#ctl00_ContentPlaceHolder1_txtMessage').val();

            message = $('#CE_ctl00_ContentPlaceHolder1_txtMessage_ID_Frame').val();


            fromdate = $('#ctl00_ContentPlaceHolder1_hdfromdate').val();
            todate = $('#ctl00_ContentPlaceHolder1_hdtodate').val();
            studentname = $('#ctl00_ContentPlaceHolder1_txtsearchname').val();
        }

        function checkcheckbox() {
            tid = "";
            var i = 1;
            $('.stm1').find('tr:gt(0)').each(function () {
                if ($('.stm1').find('tr:eq(' + i + ')').find('input[type=checkbox]').is(':checked')) {
                    tid = tid + ',' + $('.stm1').find('tr:eq(' + i + ')').find('input[type=hidden]').val();
                }
                i = i + 1;
            });
            valuefortype = tid;
        }

        function BindNoticeType() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/NoticeType",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_noticetype").html("");
                    $("#ctl00_ContentPlaceHolder1_noticetype").append($("<option></option>").val('0').html('--Select Notice Type--'));
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_noticetype").append($("<option></option>").val(value.Id).html(value.NoticeType));
                    });
                },
                error: function (result) {
                    alertify.error('Some Network Issue.');
                },
            });
        }



        function Bindclass() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/ClassList",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_classtype").html("");
                    $("#ctl00_ContentPlaceHolder1_classtype").append($("<option></option>").val('0').html('--Select Class --'));
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_classtype").append($("<option></option>").val(value.classID).html(value.CLassname));
                    });
                },
                error: function (result) {
                    alertify.error('Some Network Issue.');
                },
            });
        }

        function chngstatuspanel(changepanelid, noticetid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/updatestatuspanel",
                data: "{'changepanelid':'" + changepanelid + "','noticetid':'" + noticetid + "'}",
                dataType: "json",
                asyn: false,
                success: function (data) {
                    call_progressbar("end");
                    BindListofNotice();
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error("Some Network Problem");
                    return false;
                }
            });
        }

        function BindClasses() {
            //call_progressbar("start");
            $('.stm1 tr:eq(0)').find('input[type=checkbox]').prop('checked', false);
            $('.stm1 tr:gt(0)').remove();
            $('.stm1 tr:eq(0)').find('input[type=checkbox]').prop('checked', false);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/ClassList",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].classID + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].CLassname + '</td>' +
                                            '<td><input type="checkbox" /></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].classID + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].CLassname + '</td>' +
                                            '<td><input type="checkbox" /></td></tr>';
                            }
                            $('.stm1').append(trforappend);
                        }
                        //call_progressbar("end");
                    }
                    else {
                        //call_progressbar("end");
                        alertify.error('No Record Found');
                    }
                },
                error: function (result) {
                    //call_progressbar("end");
                    alertify.error('Some Network Issue.');
                },
            });
        }

        function BindCourse() {
            call_progressbar("start");
            $('.stm1 tr:eq(0)').find('input[type=checkbox]').prop('checked', false);
            $('.stm1 tr:gt(0)').remove();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/CourseList",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].courseID + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].courseName + '</td>' +
                                            '<td><input type="checkbox" /></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].courseID + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].courseName + '</td>' +
                                            '<td><input type="checkbox" /></td></tr>';
                            }
                            $('.stm1').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    else {
                        call_progressbar("end");
                        alertify.error('No Record Found');
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error('Some Network Issue.');
                }
            });
        }

        function OtherEmployee() {
            //call_progressbar("start");
            $('.stm1 tr:eq(0)').find('input[type=checkbox]').prop('checked', false);
            $('.stm1 tr:gt(0)').remove();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/emplist",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].empid + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].empname + '</td>' +
                                            '<td><input type="checkbox" /></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].empid + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].empname + '</td>' +
                                            '<td><input type="checkbox" /></td></tr>';
                            }
                            $('.stm1').append(trforappend);
                        }
                        //call_progressbar("end");
                    }
                    else {
                        //call_progressbar("end");
                        alertify.error('No Record Found');
                    }
                },
                error: function (result) {
                    //call_progressbar("end");
                    alertify.error('Some Network Issue.');
                },
            });
        }

        function BindStudent() {
            call_progressbar("start");
            $('.stm1 tr:eq(0)').find('input[type=checkbox]').prop('checked', false);
            $('.stm1 tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/StudentList",
                data: "{'studentname':'" + studentname + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].StudentId + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].Name + '(' + data.d[i].Roll_No + ')' + '</td>' +
                                            '<td><input type="checkbox" /></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].StudentId + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].Name + '(' + data.d[i].Roll_No + ')' + '</td>' +
                                            '<td><input type="checkbox" /></td></tr>';
                            }
                            $('.stm1').append(trforappend);
                        }
                        call_progressbar("end");
                        studentname = '';
                    }
                    else {
                        call_progressbar("end");
                        alertify.error('No Record Found');
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error('Some Error occured during Binding Student.');
                },
            });
        }

        function GetDetailofNotice() {
            var editor1 = document.getElementById('<%= txtMessage.ClientID%>');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/SubmitNotice",
                data: "{'noticeid':'" + noticeid + "','message':'" + editor1.getHTML().split("'").join("~") + "','fromdate':'" + fromdate + "','todate':'" + todate + "','active':'" + active + "','broadcastsms':'" + broadcastsms + "','broadcastemail':'" + broadcastemail + "','valuefortype':'" + valuefortype + "','mode':'" + mode + "','nid':'" + nid + "','broadcastpanel':'" + broadcastpanel + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d > 0) {
                        if (mode == 3)
                            alertify.success('Notice Created Successfully.');
                        else
                            alertify.success('Notice Updated Successfully.');
                        active = 0;
                    }
                },
                error: function (response) {
                    alert("Some Error Occured.");
                }
            });
        }

        function getinfoforsms() {
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/Sendsms",
                data: "{'message':'" + message + "','valuefortype':'" + valuefortype + "','noticeid':'" + noticeid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 0) {
                        alertify.error("Sms permission is off from admin side.");
                    }
                    if (data.d == 1) {
                        broadcastsms = 1;
                        broadcastemail = 0;
                        ispanel = 0;
                        updatestatus();
                        BindListofNotice();
                        alertify.success('Information Send Sucessfully To The Selected Student.');
                    }
                    if (data.d == 2) {
                        alertify.error("Your message have more than 160 character.So You can not send Sms.");
                    }
                },
                error: function (response) {
                    alertify.error('Some Network Issue Occur While Send The Sms.');
                }
            });
        }

        function getinfoforemail() {
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/Sendemail",
                data: "{'message':'" + message + "','valuefortype':'" + valuefortype + "','noticeid':'" + noticeid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == "2") {
                        alertify.error("e-Mail permission is off from admin side.");
                        return;
                    }
                    if (data.d == "") {
                        broadcastemail = 1;
                        ispanel = 0;
                        broadcastsms = 0;
                        updatestatus();
                        BindListofNotice();
                        alertify.success('Information Send Sucessfully To The Selected Student.');
                    }
                },
                error: function (response) {
                    alertify.error('Some Network Issue Occur While Send The Email.');
                }
            });
        }

        function checkdate() {
            if (Date.parse(fromdate) == Date.parse(curntdate)) {
                broadcastpanel = 1;
                return true;
            }
            else if (Date.parse(fromdate) > Date.parse(curntdate)) {
                var ConfirmStatus = confirm('Date you are Entered is greater than Current date. Are You sure to create Notice.')
                return ConfirmStatus;
            }
            else if (Date.parse(fromdate) < Date.parse(curntdate)) {
                var ConfirmStatus = confirm('Date you are Entered is less than Current date. Are You sure to create Notice.')
                return ConfirmStatus;
            }
        }

        function checkforSmsEmailPanel() {
            //if ($('#checkmail').is(':checked')) {
            //    alertify.confirm("Are You sure to send the Email", function (e) {
            //        if (e) {
            //                getinfoforemail();
            //        }
            //        else {
            //            alertify.error("You've clicked Cancel");
            //        }
            //    });
            //}
            //if ($('#checkmessage').is(':checked')) {
            //    alertify.confirm("Are You sure to send the Sms", function (e) {
            //        if (e) {
            //                getinfoforsms();
            //        }
            //        else {
            //            alertify.error("You've clicked Cancel");
            //        }
            //    });
            //}
            if (Date.parse(fromdate) == Date.parse(curntdate)) {
                nid = 0;
                broadcastsms = 0;
                broadcastemail = 0;
                ispanel = 1;
                updatestatus();
                BindListofNotice();
            }
            //if ($('#checkpanel').is(':checked')) {
            //    alertify.confirm("Are You sure to show on Panel", function (e) {
            //        if (e) {
            //            nid = 0;
            //            broadcastsms = 0;
            //            broadcastemail = 0;
            //            ispanel = 1;
            //            updatestatus();
            //            BindListofNotice();
            //            alertify.success("You've clicked Ok");
            //        }
            //        else {
            //            alertify.error("You've clicked Cancel");
            //        }
            //    });
            //}
        }

        //script for show list and edit delete sart here

        BindListofNotice();
        $('#btnupdate').live('click', function () {
            mode = 4;
            FillField();
            GetDetailofNotice();
            showlist();
            $('#btnaddnewtax').html('Add New Notice');
            return false;
        });

        $('#contentPane').hide();

        $("#txsettings").click(function () {
            showlist();
            return false;
        });

        $("#btnaddnewtax").click(function () {
            $("#btnaddnewtax").addClass("active3").removeClass("sgpt1").removeClass("active7");;
            $("#txsettings").addClass("sgpt1").addClass("active7").removeClass("active3");
            $('#divfornotice').hide(500);
            $('#contentPane').show(500);
            $('#btnupdate').hide();
            $('#btnback').hide();
            $('#sendnotice').show();
            $('#lblactive').show();
            $('#checkactive').show();
            $(this).html('Add New Notice');
            $('#ctl00_ContentPlaceHolder1_noticetype').val('');
            $('#ctl00_ContentPlaceHolder1_txtMessage').val('');
            $('#ctl00_ContentPlaceHolder1_txtfromdate').val('');
            $('#ctl00_ContentPlaceHolder1_txttodate').val('');
            $('#ctl00_ContentPlaceHolder1_txtsearchname').val('');
            $('#divforlist').hide();
            $('#checkactive').prop('checked', false);
            $('#checkpanel').prop('checked', true);
            $("#ctl00_ContentPlaceHolder1_noticetype").prop("disabled", false);
            $("#ctl00_ContentPlaceHolder1_txtMessage").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_noticetype").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtfromdate").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txttodate").removeClass("texthover");

            return false;
        });

        function BindListofNotice() {
            call_progressbar("start");
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/NoticeList",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td style="width:100px"><input type=hidden value=' + data.d[i].Nid + '>' + (i + 1) + '</td>' +
                                            '<td style="width:100px">' + data.d[i].NoticeType + '</td>' +
                                            '<td><span>' + data.d[i].Message + '</span></td>' +
                                            '<td>' + data.d[i].fromdate + '</td>' +
                                            '<td>' + data.d[i].todate + '</td>' +
                                            '<td style="width:100px"><input id="idupdate"  type="hidden" value="' + data.d[i].panactid + '"><input style="width:14px;" type="image" alt=""  src="' + data.d[i].activepanel + '" />'+ ' '+'<a class="statusedit" style="cursor:pointer">' + data.d[i].PanelStatus + '</a></td>' +
                                            '<td style="width:100px"><input class=editimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/edit.png /></td>' +
                                            '<td style="width:100px"><input class=deleteimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/ic.png /></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_dark"><td style="width:100px"><input type=hidden value=' + data.d[i].Nid + '>' + (i + 1) + '</td>' +
                                            '<td style="width:120px">' + data.d[i].NoticeType + '</td>' +
                                            '<td><span>' + data.d[i].Message + '</span></td>' +
                                             '<td>' + data.d[i].fromdate + '</td>' +
                                            '<td>' + data.d[i].todate + '</td>' +
                                            '<td style="width:100px"><input id="idupdate"  type="hidden" value="' + data.d[i].panactid + '"><input style="width:14px;" type="image" alt=""  src="' + data.d[i].activepanel + '" />' + ' ' + '<a class="statusedit" style="cursor:pointer">' + data.d[i].PanelStatus + '</a></td>' +
                                            '<td style="width:100px"><input class=editimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/edit.png /></td>' +
                                            '<td style="width:100px"><input class=deleteimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/ic.png /></td></tr>';
                            }
                            $('.stm').append(trforappend);
                            if (data.d[i].FullMessage.length > 60) {
                                var j = i + 1;
                                $('.stm').find('tr:eq(' + j + ')').find('td:eq(2)').find('span').attr("data-tooltip", data.d[i].FullMessage);
                            }
                        }
                        call_progressbar("end");
                    }
                    else {
                        call_progressbar("end");
                        alertify.error('No Record Found');
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error('Some Error occured during Binding Student.');
                }
            });
        }

        $('.deleteimage').live('click', function () {
            nid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
            alertify.confirm('Are you sure to Delete', function (e) {
                if (e) {
                    deletenotice();
                    BindListofNotice();
                }
                else {
                    alertify.error("You've clicked Cancel");
                }
            })
            return false;
        });

        $('.editimage').live('click', function () {
            nid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
            $('#btnaddnewtax').addClass("active3").removeClass("sgpt1").removeClass("active7");;
            $("#txsettings").addClass("sgpt1").addClass("active7").removeClass("active3");
            $('#divfornotice').hide(500);
            $('#contentPane').show(500);
            $('#sendnotice').hide();
            $('#lblactive').hide();
            $('#checkactive').hide();
            $('#lblmail').hide();
            $('#Label1').hide();
            $('#checkmail').hide();
            $('#lblmessage').hide();
            $('#checkmessage').hide();
            $('#checkpanel').hide();
            $('#btnupdate').show();
            $('#btnback').show();
            $('#divforlist').hide();
            $("#ctl00_ContentPlaceHolder1_txtMessage").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_noticetype").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtfromdate").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txttodate").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_noticetype").prop("disabled", true);
            $('#btnaddnewtax').html('Edit Notice');
            fetchnoticedetail();
            return false;
        });

        $('#btnback').live('click', function () {
            $('#btnaddnewtax').html('Add New Notice');
            showlist();
            return false;
        });

        //$('.brodcastimage').live('click', function () {
        //    $(this).parent('td').parent('tr').css("background-color", "green");
        //    $('#divforaddnotice').css('display', 'block');
        //    $('#Checkforsms').prop('checked', false);
        //    $('#Checkforemail').prop('checked', false);
        //    $('#Checkforpanel').prop('checked', false);
        //    nid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
        //    return false;
        //});

        $("#BtnCancelSend").live('click', function () {
            $('.stm').find('tr').css("background-color", "");
            $('#divforaddnotice').css('display', 'none');
            return false;
        });

        $('#ctl00_ContentPlaceHolder1_BtnSend').live('click', function () {
            active = 1;
            if ($('#Checkforsms').is(':checked') || $('#Checkforemail').is(':checked') || $('#Checkforpanel').is(':checked')) {
                fetchdataforsend();
                checkstatusforsend();
            }
            else {
                alertify.error("No Option is selected");
            }
            $('.stm').find('tr').css("background-color", "");
            $('#divforaddnotice').css('display', 'none');
            return false;
        });

        function checkstatusforsend() {
            checkstatus = 0;
            if ($('#Checkforsms').is(':checked')) {
                if (broadcastsms == 1) {
                    alertify.confirm('Sms already Broadcasted.Are You Sure To Rebroadcast Sms', function (e) {
                        if (e) {
                            getinfoforsms();
                        }
                        else {
                            alertify.error("You've clicked Cancel");
                        }
                    });
                }
                else {
                    alertify.confirm("Are You Sure To Send Sms", function (e) {
                        if (e) {
                            getinfoforsms();
                            BindListofNotice();
                        }
                        else {
                            alertify.error("You've clicked Cancel");
                        }
                    });
                }
            }
            if ($('#Checkforemail').is(':checked')) {
                if (broadcastemail == 1) {
                    alertify.confirm('Email already Broadcasted.Are You Sure To Rebroadcast Email', function (e) {
                        if (e) {
                            getinfoforemail();
                        }
                        else {
                            alertify.error("You've clicked Cancel");
                        }
                    });
                }
                else {
                    alertify.confirm("Are You Sure To Send Email", function (e) {
                        if (e) {
                            getinfoforemail();
                            BindListofNotice();
                        }
                        else {
                            alertify.error("You've clicked Cancel");
                        }
                    });
                }
            }
            if ($('#Checkforpanel').is(':checked')) {
                if (ispanel == 1) {
                    alertify.error('Notice already Shown on Student Panel.');
                }
                else {
                    alertify.confirm('Are You Sure To Show On Panel', function (e) {
                        if (e) {
                            setvalue();
                        }
                        else {
                            alertify.error("You've clicked Cancel");
                        }
                    });
                }
            }
        }

        function setvalue() {
            fetchnoticedetail();
            broadcastemail = 0;
            ispanel = 1;
            broadcastsms = 0;
            updatestatus();
            BindListofNotice();
        }

        function updatestatus() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/UpdateNoticeStatus",
                data: "{'nid':'" + nid + "','broadcastsms':'" + broadcastsms + "','broadcastemail':'" + broadcastemail + "','ispanel':'" + ispanel + "','valuefortype':'" + valuefortype + "','noticeid':'" + noticeid + "','active':'" + active + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Status Updated Successfully and this Notice is shown on Student Panel');
                    }
                    if (data.d == 2) {
                        alertify.success("Sms Status Updated Successfully");
                    }
                    if (data.d == 3) {
                        alertify.success("Email Status Updated Successfully");
                    }
                },
                error: function () {
                    alertify.error('Some error occured during Status Updation');
                }
            });
        }

        function showlist() {
            $("#txsettings").addClass("active3").removeClass("sgpt1").removeClass("active7");;
            $("#btnaddnewtax").addClass("sgpt1").addClass("active7").removeClass("active3");
            $('#contentPane').hide(500);
            $('#divfornotice').show(500);
            BindListofNotice();
        }

        function fetchnoticedetail() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/GetNoticeList",
                data: "{'nid':'" + nid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#ctl00_ContentPlaceHolder1_noticetype').val(data.d[0].NoticeTypeid);
                        document.getElementById('<%= txtMessage.ClientID%>').setHTML(data.d[0].Message);
                        $('#ctl00_ContentPlaceHolder1_txtfromdate').val(data.d[0].ActiveFrom);
                        $('#ctl00_ContentPlaceHolder1_txttodate').val(data.d[0].ActiveTo);
                        valuefortype = ',' + data.d[0].valueforNoticetype;
                    }
                }
            });
        }

        function deletenotice() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/DeleteNoticeList",
                data: "{'nid':'" + nid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d > 0) {
                        alertify.success('Notice is Deleted Successfully');
                    }
                },
                error: function (result) {
                    alertify.error('Some Error.');
                }
            });
        }

        function fetchdataforsend() {
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "NoticeBoard-List.aspx/GetNoticeDetail",
                data: "{'nid':'" + nid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        message = data.d[0].Message;
                        valuefortype = ',' + data.d[0].valueforNoticetype;
                        noticeid = data.d[0].NoticeTypeid;
                        broadcastsms = data.d[0].IsBroadCastedSms;
                        broadcastemail = data.d[0].IsBroadCatedEmail;
                        ispanel = data.d[0].IsPanelShow;
                    }
                },
                error: function (result) {
                    alertify.error('Some Error occured.');
                }
            });
        }
    </script>
</asp:Content>
