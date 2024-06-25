<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="email-center.aspx.cs" Inherits="BranchPanel_EmailCenter_email_center" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Moxiecode.TinyMCE" Namespace="Moxiecode.TinyMCE.Web" TagPrefix="tinymce" %>
<%@ Register TagPrefix="ce" Namespace="CuteEditor" Assembly="CuteEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .popupinner-div input[type="radio"] {
            margin-left: 15px;
        }
        .submitsms {
            background-color: #49c0f0;
            background-image: linear-gradient(to bottom, #49c0f0, #2cafe3);
            border: 1px solid #15aeec;
            border-radius: 3px;
            color: #ffffff;
            cursor: pointer;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            padding: 5px 10px;
            text-decoration: none;
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0.3);
        }
        .cancelsms {
            background-color: #49c0f0;
            background-image: linear-gradient(to bottom, #49c0f0, #2cafe3);
            border: 1px solid #15aeec;
            border-radius: 3px;
            color: #ffffff;
            cursor: pointer;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            padding: 5px 10px;
            text-decoration: none;
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0.3);
        }
        .lable {
            width: 150px;
            height: 30px;
            margin-left: 10px;
        }
        .cheadline1 {
            line-height: 26px;
        }
    </style>
    <script src="scripts/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="scripts/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="scripts/jquery.uploadify.js"></script>
    <script type="text/javascript">
        $(window).load(
            function () {
                $("#<%=fluploadproduct.ClientID%>").fileUpload({
                    'uploader': 'Scripts/uploader.swf',
                    'cancelImg': '../../images/cancel.png',
                    'buttonText': 'Browse Files',
                    'script': 'Scripts/ExamUpload.ashx',
                    'folder': 'email_document',
                    'fileDesc': 'Image Files',
                    'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                    'multi': true,
                    'auto': false,
                });
            }
               );
    </script>
    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">Email Center</span>
    </div>
    <div class="clear"></div>
    <div style="margin-left: 300px; margin-top: 20px; margin-bottom: 10px;" id="divformessage" runat="server" visible="false">
        <asp:Label ID="lblmessage" runat="server" Text="Mail Sent to All Selected Email ID." Style="font-weight: bold; color: green"></asp:Label>
    </div>
    <div class="clear"></div>
    <div class="for_sigle_row_form" style="margin-left: 100px">
        <label style="font-size: 18px; margin-top: -4px">Select One</label>
        <div style="margin-left: 100px">
            <label style="margin-left: 10px; width: 100px; text-align: left;">Student<input type="radio" style="margin-left: 10px" value="2" checked="checked" name="emailtype" /></label>
            <label style="margin-left: 10px; width: 100px; text-align: left;">Faculty<input type="radio" style="margin-left: 10px" value="3" name="emailtype" /></label>
            <label style="margin-left: 10px; width: 100px; text-align: left;">Enquiry<input type="radio" style="margin-left: 10px" value="4" name="emailtype" /></label>
        </div>
    </div>
    <div class="clear"></div>
    <table style="width: 100%;">
        <tr>
            <td style="padding: 5px; background-color: #DEDCDC;" class="containerHeadline" colspan="10">
                <div style="float: left; width: 100%;">
                <asp:DropDownList ID="ddlstatus" runat="server" Width="120px" Height="25px">
                <asp:ListItem Value="0" Text="Select Status"></asp:ListItem>
                <asp:ListItem Value="1" Text="Registered"></asp:ListItem>
                <asp:ListItem Value="2" Text="Shortlisted"></asp:ListItem>
                <asp:ListItem Value="3" Text="Rejected"></asp:ListItem>
                <asp:ListItem Value="4" Text="Waiting"></asp:ListItem>
                <asp:ListItem Value="5" Text="Addmision"></asp:ListItem>
            </asp:DropDownList>

                    <asp:DropDownList ID="ddlfyear" runat="server" Width="102px" Height="25px">     
            </asp:DropDownList>
            <asp:DropDownList ID="ddlclass" runat="server" Width="120px" Height="25px">     
            </asp:DropDownList>

                    <asp:DropDownList runat="server" ID="ddlfacultydeptnstuname" Style="height: 25px; width: 166px; margin-left: 5px; display: none">
                    </asp:DropDownList>
                    <asp:DropDownList runat="server" ID="ddlstudesg" Style="height: 25px; width: 166px; margin-left: 5px; display: none">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlsearchingstatus" runat="server" Width="90px" Style="height: 25px; width: 166px; margin-left: 5px; display: none">
                        <asp:ListItem Text="-Status-" Value="0" />
                    </asp:DropDownList>
                    <input type="text" style="height: 25px; width: 100px; margin-left: 5px;" placeholder="Search by Name." id="names" />
                    <input type="text" style="height: 25px; width: 140px; margin-left: 5px;" placeholder="Search by Mobile." id="smob" onkeypress="if (WebForm_TextBoxKeyHandler(event) == false) return false;return noAlphabets(event)" />
                    <input type="text" style="height: 25px; width: 140px; margin-left: 5px;" placeholder="Search by Email." id="txtemail" />
                    <input type="text" style="height: 25px; width: 100px; margin-left: 5px; display: none" placeholder="From Date." id="txtfromdate" />
                    <input type="text" style="height: 25px; width: 100px; margin-left: 5px; display: none" placeholder="To Date." id="txttodate" />
                    <input id="btnclear" type="image" style="width: 25px; border-width: 0px; margin-left: 20px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
                    <a class="forcheckbox">Check/Uncheck All</a><input type="checkbox" class="checkoruncheckall" style="float: right; margin-top: 5px" checked="checked" />
                </div>
            </td>
        </tr>
    </table>
    <div class="clear"></div>
    <div class="divforstm">
        <table class="stm  stmforappend" style="width: 100%; margin-left: 0px;">
            <tr class="stm_head" align="center">
                <th align="center" scope="col"></th>
                <th align="center" scope="col"></th>
                <th align="center" scope="col"></th>
                <th align="center" scope="col"></th>
                <th align="center" scope="col"></th>
                <th align="center" scope="col"></th>
                <th align="center" scope="col"></th>
                <th align="center" scope="col"></th>
            </tr>
        </table>
    </div>
    <div class="for_sigle_row_form" style="margin-left: 100px">
        
    </div>
    <div id="divforenquiry" class="for_sigle_row_form" style="display: none; margin-top: -30px">
        <label style="font-size: 18px">No. Of Enquiry:<span id="noofenquiry">**</span></label>
    </div>

    <div class="clear"></div>
    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">Email Content Settings</span>
    </div>
    <div class="clear"></div>
    <div id="divadditionalinformation" runat="server">
        <div class="edit-prifile-righ-content" id="addlisting" runat="server">
            <div class="clear"></div>
            <div style="display: none">
                <asp:Label ID="session" runat="server"></asp:Label>
            </div>
            <div class="for_sigle_row_form" style="margin-top: 15px;">
                <label>Upload Picture</label>
                <asp:FileUpload ID="fluploadproduct" runat="server" />

                <a href="javascript:$('#<%=fluploadproduct.ClientID%>').fileUploadStart()"
                    style="text-decoration: underline !important; margin-left: 170px; margin-top: 15px; color: red; font-weight: bold">Click here for Start Upload</a>
                <div style="padding: 0px;" id="imagediv">
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="clear"></div>
    <div class="for_sigle_row_form" style="margin-top: 5px;">
        <label>
            Subject<span style="color: #ff0066">*</span></label>
        <asp:TextBox ID="txtmailsubject" runat="server" placeholder="Enter The Subject Please"></asp:TextBox>
    </div>
    <div class="for_sigle_row_form" style="margin-top: 5px;">
        <label>
            Create Mail<span style="color: #ff0066">*</span></label>
        <asp:Label runat="server" ID="lbBid" Style="display: none" Text=""></asp:Label>
        <asp:Label runat="server" ID="lbType" Style="display: none" Text=""></asp:Label>
        <ce:editor id="ftCreateMail" runat="server" height="500px"></ce:editor>
    </div>
    <div class="for_sigle_row_form" style="margin-top: 5px;">
        <label>
        </label>
        <asp:Button ID="btnsendmail" runat="server" Text="Submit" class="button_save submitemail" OnClick="btnsendmail_Click" />
        <input type="submit" class="button2" value="Cancel" />
    </div>
   
   
    <asp:HiddenField ID="hfforsendmail" runat="server" />
    <script type="text/javascript">
        var iscold = 0; var studentemail = "", parentsemail = "", changetype = 0, smssendtostuparents = "", i = 1, apitypestatus = 0;;
        var facultyname = "", facultymob = "", fromdate = "", todate = "", stunames = "", stumob = "", classid = 0, emailidforsearch = '';
        designation = 0, department = 0, studentstatus = 0, fyid = 0, globalsmstoall = '', noofemail = 0, enqstatus = '';
        $(document).ready(function () {
            Bindclassddl();
            $('.checkoruncheckall').change(function () {
                if ($(this).prop('checked') == true) {
                    $('.getcheckboxid').prop("checked", true);
                }
                else {
                    $('.getcheckboxid').prop("checked", false);
                }
                $('#ctl00_ContentPlaceHolder1_divformessage').hide();
            });
            $('#ctl00_ContentPlaceHolder1_ddlfyear').change(function () {
                Bindclassddl();
            });
            $('.submitemail').live('click', function () {
                IsFireEvent = 0;         
                var facultyemailid = $('input[name=emailtype]:checked').val();
                if ($('#ctl00_ContentPlaceHolder1_txtmailsubject').val() == "") {
                    alertify.error('Please Enter The Subject Please.');
                    $('#ctl00_ContentPlaceHolder1_txtmailsubject').focus();
                    return false;
                }
                else if ($('.CuteEditorTextArea').val() == "") {
                    alertify.error('Please Enter The Message For Send Mail.');
                    $('.CuteEditorTextArea').focus();
                    return false;
                }
                if (iscold == 3 || iscold == 2) {
                    studentParentemailid = '', globalsmstoall = '', noofemail = 0;
                    $(".divforstm").find('table tr:gt(0)').find('input[type="checkbox"]').each(function () {
                        if ($(this).is(':checked') == true) {
                            if (facultyemailid == 3) {
                                globalsmstoall = globalsmstoall + ',' + $(this).parent('td').find('input[id*=facultyno]').val();
                               
                            }                            
                            else {
                                
                                globalsmstoall = globalsmstoall + ',' + $(this).parent('td').find('input[id*=stuparentemail]').val();   
                            }
                        }
                    });                 
                    globalsmstoall = globalsmstoall.substring(1, globalsmstoall.length)                               
                    $('#ctl00_ContentPlaceHolder1_hfforsendmail').val(globalsmstoall);
                }
                else {
                    noofemail = $('#noofenquiry').text();
                    globalsmstoall = globalsmstoall.substring(1, globalsmstoall.length)
                    $('#ctl00_ContentPlaceHolder1_hfforsendmail').val(globalsmstoall);
                }
                return true;
            });
            $('#txtfromdate').change(function () {
                FillField();
                if (iscold == 2) {
                    BindGridforstudent();
                }
                if (iscold == 4) {
                    classid = 0;
                    //todate = "";
                    enqstatus = '';
                    getenquiry();
                }
                return false;
            })
            $('#txttodate').change(function () {
                FillField();
                if (iscold == 2) {
                    BindGridforstudent();
                }
                if (iscold == 4) {
                    classid = 0;
                    //fromdate = '';
                    enqstatus = '';
                    getenquiry();
                }
                return false;
            })
            $("#txtfromdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            //Event For Searching Start Here
            $('#ctl00_ContentPlaceHolder1_ddlstatus').change(function () {
                FillField();
                iscold == 2
                BindGridforstudent();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlfyear').change(function () {
                FillField();
                if (iscold == 2) {
                    BindGridforstudent();
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlclass').change(function () {
                FillField();
                if (iscold == 2) {
                    BindGridforstudent();
                }
                if (iscold == 4) {
                    fromdate = "";
                    todate = "";
                    enqstatus = '';
                    getenquiry();
                }
                return false;
            })
            $('#names').keyup(function () {
                FillField();
                if (iscold == 3) {
                    BindGridforfaculty();
                }
                else if (iscold == 2) {
                    BindGridforstudent();
                }
                return false;
            });
            $('#txtemail').keyup(function () {
                FillField();
                if (iscold == 3) {
                    BindGridforfaculty();
                }
                else if (iscold == 2) {
                    BindGridforstudent();
                }
                return false;
            });
            $('#smob').keyup(function () {
                FillField();
                if (iscold == 3) {
                    BindGridforfaculty();
                }
                else if (iscold == 2) {
                    BindGridforstudent();
                }
                return false;
            })
            $('#btnclear').click(function () {
                if (iscold == 2) {
                    $('#txtemail').val('');
                    $('#names').val('');
                    $('#smob').val('');
                   
                    $('#ctl00_ContentPlaceHolder1_ddlclass').val('0');
                    $('#ctl00_ContentPlaceHolder1_ddlstatus').val('0');
                    $('ctl00_ContentPlaceHolder1_ddlfyear').val('0');
                    FillField();
                    BindGridforstudent();
                    Bindclassddl();
                }
                if (iscold == 3) {
                    $('#txtemail').val('');
                    $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').val('0');
                    $('#ctl00_ContentPlaceHolder1_ddlstudesg').val('0');
                    $('#names').val('');
                    $('#smob').val('');
                    FillField();
                    BindGridforfaculty();
                }
                if (iscold == 4) {
                    $('#ctl00_ContentPlaceHolder1_ddlclass').val('0');
                    $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').val('0');
                    $('#txttodate').val('');
                    $('#txtfromdate').val('');
                    FillField();
                    getenquiry();
                    Bindclassddl();
                }
                $('#ctl00_ContentPlaceHolder1_divformessage').hide();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').change(function () {
                FillField();
                classid = 0;
                fromdate = "";
                todate = "";
                getenquiry();
            });
            $("#ctl00_ContentPlaceHolder1_ddlstudesg").change(function () {
                FillField();
                iscold == 3
                BindGridforfaculty()
                return false;
            });
            //Event For Searching End Here
            $("input:radio[name=emailtype]").change(function () {
                iscold = $(this).val();
                if (iscold == 2) {
                    $('#ctl00_ContentPlaceHolder1_ddlclass').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlfyear').css("display", "block");
                    $('#txtfromdate').css("display", "none");
                    $('#txttodate').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlstudesg').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlstatus').css("display", "block");
                    $(".smsradiotype").css("display", "block")
                    $('.inputsms').val('');
                    $('#divforenquiry').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').css("display", "none");
                    $('.stm').show();
                    $('#names').css("display", "block");
                    $('#smob').css("display", "block");
                    $('#txtemail').css("display", "block");
                    $('.checkoruncheckall').show();
                    $('.forcheckbox').show();
                    BindGridforstudent();
                }
                else if (iscold == 3) {
                    $(".smsradiotype").css("display", "none")
                    $('#ctl00_ContentPlaceHolder1_ddlclass').css("display", "none");
                    $('#txtfromdate').css("display", "none");
                    $('#txttodate').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlfyear').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlstudesg').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlstatus').css("display", "none");
                    $('#divforenquiry').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').css("display", "none");
                    $('.stm').show();
                    $('#names').css("display", "block");
                    $('#smob').css("display", "block");
                    $('#txtemail').css("display", "block");
                    $('.inputsms').val('');
                    $('.checkoruncheckall').show();
                    $('.forcheckbox').show();
                    BindGridforfaculty();
                }
                else if (iscold == 4) {
                    $(".smsradiotype").css("display", "none")
                    $('#ctl00_ContentPlaceHolder1_ddlclass').css("display", "block");
                    $('#txtfromdate').css("display", "block");
                    $('#txttodate').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlstudesg').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlstatus').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlfyear').css("display", "none");
                    $('#divforenquiry').css("display", "block");
                    $('.checkoruncheckall').hide();
                    $('#names').css("display", "none");
                    $('#smob').css("display", "none");
                    $('#txtemail').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').css("display", "block");
                    $('.forcheckbox').hide();
                    $('.stm').hide();
                    getenquiry();
                }
                $('#ctl00_ContentPlaceHolder1_divformessage').hide();
            });
            $("#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname").change(function () {
               
                FillField();
                iscold == 3
                BindGridforfaculty()
                return false;
            });          
            iscold = 2;
            BindGridforstudent();
        });
        function Bindclassddl() {
            $('#ctl00_ContentPlaceHolder1_ddlclass').html('');

            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "email-center.aspx/BindClassDDL",
                data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear').val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlclass').html('<option value="0">--Select Class--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlclass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                        }
                    }
                }
            });
        }
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../. ./images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }       
        function BindGridforstudent() {
            call_progressbar('start');
            var trforappend = "";
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "email-center.aspx/BindGridforstudent",
                data: "{'stunames':'" + stunames + "','stumob':'" + stumob + "','fromdate':'" + fromdate + "','todate':'" + todate + "','classid':'" + classid + "','studentstatus':'" + studentstatus + "','fyid':'" + fyid + "','emailidforsearch':'" + emailidforsearch + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length;) {
                            try {
                                 (data.d[i].Email == '') 
                                    trforappend = '<tr><td><input class="getcheckboxid" type="checkbox" checked/><input id=stuparentemail type="hidden" value="' + data.d[i].Email + '" /></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].Name + '(' + data.d[i].Email + ')">' + data.d[i].BindGridData + '</span></td>';                              
                                    i = i + 1;

                              
                                    trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked/><input id=stuparentemail type="hidden" value="' + data.d[i].Email + '" /></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].Name + '(' + data.d[i].Email + ')">' + data.d[i].BindGridData + '</span></td>';
                                    i = i + 1;
                               
                                    trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked/><input id=stuparentemail type="hidden" value="' + data.d[i].Email + '" /></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].Name + '(' + data.d[i].Email + ')">' + data.d[i].BindGridData + '</span></td>';
                                    i = i + 1;
                               
                                    trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked/><input id=stuparentemail type="hidden" value="' + data.d[i].Email + '" /></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].Name + '(' + data.d[i].Email + ')">' + data.d[i].BindGridData + '</span></td>';
                                    i = i + 1;
                                trforappend = trforappend + '</tr>'
                                $('.stm').append(trforappend);
                            }
                            catch (err) {
                                $('.stm').append(trforappend);
                            }
                        }
                    }
                    call_progressbar('end');
                },
                error: function (response) {
                    call_progressbar('end');
                }
            });
        }
        function BindGridforfaculty() {
            call_progressbar('start');
            var trforappend = "";
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "email-center.aspx/BindGridByJs",
                data: "{'facultyname':'" + facultyname + "','facultymob':'" + facultymob + "','department':'" + department + "','designation':'" + designation + "','emailidforsearch':'" + emailidforsearch + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length;) {
                            try {
                                trforappend = trforappend + '<tr><td><input class="getcheckboxid" type="checkbox" checked /><input id=facultyno type="hidden" value="' + data.d[i].EmailId + '" /></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].EmailId + '">' + data.d[i].DtatForBindGrid + '</span></td>';
                                i = i + 1;
                                trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=facultyno type="hidden" value="' + data.d[i].EmailId + '" /></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].EmailId + '">' + data.d[i].DtatForBindGrid + '</span></td>';
                                i = i + 1;
                                trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=facultyno type="hidden" value="' + data.d[i].EmailId + '" /></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].EmailId + '">' + data.d[i].DtatForBindGrid + '</span></td>';
                                i = i + 1;
                                trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=facultyno type="hidden" value="' + data.d[i].EmailId + '" /></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].EmailId + '">' + data.d[i].DtatForBindGrid + '</span></td>';
                                i = i + 1;
                                trforappend = trforappend + '</tr>'
                                $('.stm').append(trforappend);
                            }
                            catch (err) {
                                $('.stm').append(trforappend);
                            }
                        }
                    }
                    call_progressbar('end');
                },
                error: function (response) {
                    call_progressbar('end');
                }
            });
        }
        function FillField() {
            facultyname = $('#names').val();
            facultymob = $('#smob').val();
            fromdate = $('#txtfromdate').val();
            todate = $('#txttodate').val();
            stunames = $('#names').val();
            stumob = $('#smob').val();
            classid = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
            department = $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').val();
            designation = $('#ctl00_ContentPlaceHolder1_ddlstudesg').val();
            studentstatus = $('#ctl00_ContentPlaceHolder1_ddlstatus').val();
            enqstatus = $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').val();
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
            emailidforsearch = $('#txtemail').val();   
        }
        function getenquiry() {
            globalsmstoall = '';
            call_progressbar('start');
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "email-center.aspx/countenquiry",
                data: "{'classid':'" + classid + "','enqstatus':'" + enqstatus + "','fromdate':'" + fromdate + "','todate':'" + todate + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length >= 0) {
                        $('#noofenquiry').text(data.d[0].enquiry);     
                        globalsmstoall = data.d[0].email;
                        apitypestatus = data.d[0].checkapi;                        
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('Error');
                    call_progressbar("end");
                }
            });
        }
    </script>
     <div id="divProgressBar" class="progress"></div>
</asp:Content>