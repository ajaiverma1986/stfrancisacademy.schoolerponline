<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="sms-center-branch.aspx.cs" Inherits="BranchPanel_sms_center_branch" %>

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
            margin-left: 5px;
        }
    </style>
    <div align="center" class="input_content" style="border: none; padding: 0px; margin-top: 0px;" id="divforrollnumber">
        <div class="cheadline1" style="width: 100%; margin-left: 0px">
            <span class="spanheading" style="float: left">SMS Center for Branch</span>
        </div>
        <div style="height: auto; margin-top: 11px;">
            <label style="font-size: 18px; margin-top: -4px">SMS Send to</label>
            <label style="margin-left: 20px; width: 100px; text-align: left; font-weight: bold;">Student<input type="radio" style="margin-left: 10px" value="2" checked="checked" name="smstype" /></label>
            <label style="margin-left: 20px; width: 100px; text-align: left; font-weight: bold;">Employee<input type="radio" style="margin-left: 10px" value="3" name="smstype" /></label>
         <%--   <label style="margin-left: 20px; width: 100px; text-align: left; font-weight: bold;">Enquiry<input type="radio" style="margin-left: 10px" value="4" name="smstype" /></label>--%>
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
                        <input type="text" style="height: 25px; width: 140px; margin-left: 5px;" placeholder="Search by Name" id="names" />
                        <input type="text" style="height: 25px; width: 140px; margin-left: 5px;" placeholder="Search by Mobile No." id="smob" onkeypress="if (WebForm_TextBoxKeyHandler(event) == false) return false;return noAlphabets(event)" />
                        <input type="text" style="height: 25px; width: 140px; margin-left: 5px; display: none" placeholder="From Date" id="txtfromdate" onkeypress="return false;" />
                        <input type="text" style="height: 25px; width: 140px; margin-left: 5px; display: none" placeholder="To Date" id="txttodate" onkeypress="return false;" />
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
        <div class="smsradiotype" style="height: auto; margin-left: -379px; margin-top: 11px;">
            
        </div>
        <div id="divforenquiry" class="for_sigle_row_form" style="display: none; margin-top: -16px">
            <label style="font-size: 18px">No. Of Enquiry:<span id="noofenquiry">**</span></label>
        </div>
        <div class="divforsmstype" style="height: auto; margin-right: 565px; margin-top: 30px; display: none">
            <label>Transactional SMS<input type="radio" style="margin-left: 10px" value="1" name="typeforsms" /></label>
            <label>Promotional SMS<input type="radio" style="margin-left: 10px" value="2" name="typeforsms" checked="checked" /></label>
        </div>
        <div class="for_sigle_row_form" style="width: 50%">
            <label>
                Message<span style="color: #ff0066">*</span></label>
            <textarea class="inputsms" maxlength="640" rows="3" cols="5" placeholder="Enter Message please" onkeyup="countChar(val)"></textarea>
            <br />
            <br />
            <input type="submit" class="button submitsms" value="Submit" style="margin-left: 150px" />
            <input type="submit" class="button2" value="Cancel" />
            <div id="charNum" style="margin-left: 152px"></div>
        </div>
        <div class="for_sigle_row_form" style="width: 65%">
        </div>
        <div id="divProgressBar" class="progress">
        </div>
    </div>
    <script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var iscold = 0; var mobile = "", PerTypeID=0, parentsmobile = "", changetype = 0, smssendtostuparents = "", apitypestatus = 0, apistatus = 0, apitype = 0, apiforsms = 0;
        var i = 1, mode = '';
        var facultyname = "", facultymob = "", fromdate = "", enqstatus = '', todate = "", stunames = "", stumob = "", courseid = 0, designation = 0, department = 0, checkcoursejoin = 0, fyid =1;
        $(document).ready(function () {
            Bindclassddl();
            var max = 160;
            $('.checkoruncheckall').change(function () {
                if ($(this).prop('checked') == true) {
                    $('.getcheckboxid').prop("checked", true);
                }
                else {
                    $('.getcheckboxid').prop("checked", false);
                }
            });
            $('.inputsms').keyup(function () {
                var char = 0;
                var len = $(this).val().length;
                if (i <= 3) {
                    if (len >= max) {
                        i++;
                        max = max + 160;
                        $('#charNum').text('Message ' + i + ' - ' + char + ' characters left');
                    }
                    else if ((i > 1) && (len % 160) == 0) {
                        i--;
                        max = max - 160;
                        $('#charNum').text('Message ' + i + ' - ' + char + ' characters left');
                    }
                    else {
                        var char = max - len;
                        $('#charNum').text('Message ' + i + ' - ' + char + ' characters left');
                    }
                }
                else {
                    if (len >= 640) {
                        alertify.error("No More Words.");
                    }
                    return false;
                }
            });
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

            $('#ctl00_ContentPlaceHolder1_ddlstatus').change(function () {
                FillField();
                iscold == 2
                BindGridforstudent();
                return false;
            });
           
            $('#txtfromdate').change(function () {
                FillField();
                if (iscold == 2) {
                    BindGridforstudent();
                }
                if (iscold == 4) {
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
                    getenquiry();
                }
                return false;
            })
            $('#ctl00_ContentPlaceHolder1_ddlclass').change(function () {
                FillField();
                if (iscold == 2) {
                    BindGridforstudent();
                }
                if (iscold == 4) {
                    getenquiry();
                }
                return false;
            })
            $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus,#ctl00_ContentPlaceHolder1_ddlfyear').change(function () {
                FillField();
                if (iscold == 2) {
                    BindGridforstudent();
                }
                if (iscold == 4) {
                    getenquiry();
                }
                return false;               
            });
            $("input:radio[name=smstype]").change(function () {
                iscold = $(this).val();
                if (iscold == 1) {
                }
                else if (iscold == 2) {
                    mode = 1;   
                    $('#ctl00_ContentPlaceHolder1_ddlclass').css("display", "block");
                    $('#txtfromdate').css("display", "none");
                    $('#txttodate').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlstudesg').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlstatus').css("display", "block");
                    $('#ddlbatch').css("display", "block");
                    $(".smsradiotype").css("display", "block")
                    $('#names').css("display", "block");
                    $('#smob').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlfyear').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlenqtype').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').css("display", "none");
                    $('#txtfromdate').css("display", "none");
                    $('#txttodate').css("display", "none");
                    $('#divforenquiry').css("display", "none");
                    $('.divforsmstype').css("display", "none");
                    $('.inputsms').val('');
                    $('.stm').show();
                    $('.checkoruncheckall').show();
                    $('.checkoruncheckall').attr('checked', true);
                    $('.forcheckbox').show();
                    BindGridforstudent();
                }
                else if (iscold == 3) {
                    $(".smsradiotype").css("display", "none")
                    $('#ctl00_ContentPlaceHolder1_ddlclass').css("display", "none");
                    $('#txtfromdate').css("display", "none");
                    $('#txttodate').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlstudesg').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlstatus').css("display", "none");
                    $('#ddlbatch').css("display", "none");
                    $('#names').css("display", "block");
                    $('#smob').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlenqtype').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').css("display", "none");
                    $('#txtfromdate').css("display", "none");
                    $('#txttodate').css("display", "none");
                    $('#divforenquiry').css("display", "none");
                    $('.divforsmstype').css("display", "none");
                    $('.inputsms').val('');
                    $('#ctl00_ContentPlaceHolder1_ddlfyear').css("display", "none");
                    $('.stm').show();
                    $('.checkoruncheckall').show();
                    $('.checkoruncheckall').attr('checked', true);
                    $('.forcheckbox').show();
                    BindGridforfaculty();
                }
                else if (iscold == 4) {
                    mode = 2;
                    $(".smsradiotype").css("display", "none")
                    $('#ctl00_ContentPlaceHolder1_ddlclass').css("display", "none");
                    $('#txtfromdate').css("display", "none");
                    $('#txttodate').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlstatus').css("display", "none");
                    $('#ddlbatch').css("display", "none");
                    $('#smob').css("display", "none");
                    $('#names').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlfyear').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlstudesg').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlenqtype').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').css("display", "block");
                    $('#txtfromdate').css("display", "block");
                    $('#txttodate').css("display", "block");
                    $('#divforenquiry').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_ddlclass').css("display", "block");
                    $('.divforsmstype').css("display", "block");
                    $('.stm').hide();
                    $('.checkoruncheckall').hide();
                    $('.forcheckbox').hide();
                    getenquiry();
                }
            });
            $(".button2").live('click', function () {
                $(".inputsms").val('')
                $('#charNum').text('Message ' + "1" + ' - ' + "160" + ' characters left');
                return false;
            })
            $("input:radio[name=typeforsms]").change(function () {
                apitype = $(this).val();
                apistatus = 0;
                if (apitypestatus == 0) {
                    alertify.error("You Don't Have The Any API Sorry.");
                    $(this).attr('checked', false);
                    apitype = 0;
                    return false;
                }
                else if (apitypestatus == 1 && apitype == 2) {
                    alertify.error("You Don't Have The Promotional API Sorry.");
                    $(this).attr('checked', false);
                    apitype = 0;
                    return false;
                }
                else if (apitypestatus == 2 && apitype == 1) {
                    alertify.error("You Don't Have The Transactional API Sorry.");
                    $(this).attr('checked', false);
                    apitype = 0;
                    return false;
                }
                if (apitype == 1) {
                    apiforsms = 0;
                    apistatus = 1
                }
                else if (apitype == 2) {
                    apiforsms = 1;
                    apistatus = 2
                }
            });



            $('.submitsms').live('click', function () {
                PerTypeID = $('input[name=smstype]:checked').val();
                var typeformobileno = $('input[name=smstype]:checked').val();
                var facultymobileno = $('input[name=smstype]:checked').val();
                apiforsms = $('input[name=typeforsms]:checked').val();
                if ($('.inputsms').val() == "") {
                    alertify.error('Please Enter The Message');
                    $('.inputsms').focus();
                    return false;
                }
                var noofmessage = 0
                if (iscold == 3 || iscold == 2) {
                    mobile = '', parentsmobile = '', globalsmstoall = '', noofmessage = 0, GlobalEID = '';
                    apiforsms = 1;
                    $(".divforstm").find('table tr').find('td input[type="checkbox"]').each(function () {
                        if ($(this).is(':checked') == true) {
                            if (facultymobileno == 3) {
                                if ($(this).parent('td').find('input[id*=facultyno]').val() != '') {
                                    if (globalsmstoall == '') {
                                        globalsmstoall = $(this).parent('td').find('input[id*=facultyno]').val();
                                    }
                                    else {
                                        globalsmstoall = globalsmstoall + ',' + $(this).parent('td').find('input[id*=facultyno]').val();
                                        noofmessage = noofmessage + 1
                                    }
                                }
                                else {
                                    globalsmstoall = globalsmstoall + ',';
                                }
                                if ($(this).parent('td').find('input[id*=FparentssmssendEID]').val() != '') {
                                    if (GlobalEID == '') {
                                        GlobalEID = $(this).parent('td').find('input[id*=FparentssmssendEID]').val();
                                    }
                                    else {
                                        GlobalEID = GlobalEID + ',' + $(this).parent('td').find('input[id*=FparentssmssendEID]').val();
                                    }
                                }
                                else {
                                    GlobalEID = GlobalEID + ',';
                                }
                            }
                            else if (typeformobileno == 2) {
                                if ($(this).parent('td').find('input[id*=parentssmssend]').val() != '') {
                                    if (globalsmstoall == '') {
                                        globalsmstoall = $(this).parent('td').find('input[id*=parentssmssend]').val();
                                    }
                                    else {
                                        globalsmstoall = globalsmstoall + ',' + $(this).parent('td').find('input[id*=parentssmssend]').val();
                                    }
                                    noofmessage = noofmessage + 1
                                }
                                else
                                {
                                    globalsmstoall = globalsmstoall + ',';
                                }
                                if ($(this).parent('td').find('input[id*=parentssmssendEID]').val() != '') {
                                    if (GlobalEID == '') {
                                        GlobalEID = $(this).parent('td').find('input[id*=parentssmssendEID]').val();
                                    }
                                    else {
                                        GlobalEID = GlobalEID + ',' + $(this).parent('td').find('input[id*=parentssmssendEID]').val();
                                    }
                                } else {
                                    GlobalEID = GlobalEID + ',';
                                }
                            }
                        }
                    })
                   
                    //parentsmobile = parentsmobile.substring(1, parentsmobile.length)
                   // globalsmstoall = globalsmstoall.slice(1, globalsmstoall.length);
                    noofmessage = noofmessage * i;
                }


                if (iscold == 4) {
                    noofmessage = $('#noofenquiry').text();
                }
                alertify.confirm("Total Number of Message " + noofmessage + " Are you sure want to send", function (e) {
                    if (e) {
                        smssend();
                        $('.inputsms').val('');
                        $('#charNum').text('Message ' + "1" + ' - ' + "160" + ' characters left');
                        return true;
                    }
                    else {
                        alertify.error("You've clicked Cancel");
                    }
                });
                return false;
            });



            $('.cancelsms').click(function () {
                $('.inputsms').val('');
                $('#charNum').text('Message ' + "1" + ' - ' + "160" + ' characters left');
                i = 1;
                max = 160;
                $('.inputsms').attr('readonly', false);
                return false;

            });
            iscold = 2;
            BindGridforstudent();

            $("#txtfromdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $('#ctl00_ContentPlaceHolder1_ddlfyear').change(function () {
                Bindclassddl();
            });
            $("#txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            
            $('#btnclear').click(function () {
              
                if (iscold == 2) {
                   
                    $('#names').val('');
                    $('#smob').val('');
                    $('#ctl00_ContentPlaceHolder1_ddlstatus').val('0');
                    $('#ctl00_ContentPlaceHolder1_ddlfyear').val('1');
                    $('#ctl00_ContentPlaceHolder1_ddlclass').val('0');
                    FillField();
                    BindGridforstudent();
                    Bindclassddl();
                }
                if (iscold == 3) {
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
                    $('#txtfromdate').val('');
                    $('#txttodate').val('');
                    FillField();
                    getenquiry();
                    Bindclassddl();
                }
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname").change(function () {
                FillField();
                iscold == 3
                BindGridforfaculty()
                return false;
            });          
            $("#ctl00_ContentPlaceHolder1_ddlstudesg").change(function () {
                
                FillField();
                iscold == 3
                BindGridforfaculty()
                return false;
            });
        });
        function Bindclassddl() {
            $('#ctl00_ContentPlaceHolder1_ddlclass').html('');
          
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "sms-center-branch.aspx/BindClassDDL",
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
        function FillField() {
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
            facultyname = $('#names').val();
            facultymob = $('#smob').val();
            fromdate = $('#txtfromdate').val();
            todate = $('#txttodate').val();
            stunames = $('#names').val();
            stumob = $('#smob').val();
            courseid = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
            department = $('#ctl00_ContentPlaceHolder1_ddlfacultydeptnstuname').val();
            designation = $('#ctl00_ContentPlaceHolder1_ddlstudesg').val();
            checkcoursejoin = $('#ctl00_ContentPlaceHolder1_ddlstatus').val();
            enqstatus = $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').val();

        }
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
        function countChar(val) {
            var len = val.value.length;
            if (len > 160) {
                val.value = val.value.substring(0, 160);
            } else {
                $('#charNum').text(160 - len);
            }
        };
        function ClearData() {
            mobile = "", parentsmobile = "", changetype = 0, smssendtostuparents = "",apistatus = 0,apitypestatus=0,apitype = 0, apiforsms = 0,i = 1, mode = 0;
            facultyname = "", facultymob = "", fromdate = "", enqstatus = '', todate = "", stunames = "", stumob = "", courseid = 0, designation = 0, department = 0, checkcoursejoin = 0;
        }
        function BindGridforfaculty() {           
            call_progressbar('start');
            var trforappend = "";
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms-center-branch.aspx/BindGridByJs",
                data: "{'facultyname':'" + facultyname + "','facultymob':'" + facultymob + "','department':'" + department + "','designation':'" + designation + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length;) {
                            $('#charNum').text('Message ' + "1" + ' - ' + "160" + ' characters left');
                            try {
                                trforappend = '<tr>';
                                if (parseInt(i) < parseInt(data.d.length)) {
                                    trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=facultyno type="hidden" value="' + data.d[i].mobilenum + '" /><input id=FparentssmssendEID type="hidden" value="' + data.d[i].facultyid + '"></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].mobilenum + '">' + data.d[i].BindGridDataforemp + '</span></td>';
                                    i = i + 1;
                                }
                                else {
                                    trforappend = trforappend + '</tr>'
                                    $('.stm').append(trforappend);
                                    break;
                                }
                                if (parseInt(i) < parseInt(data.d.length)) {
                                    trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=facultyno type="hidden" value="' + data.d[i].mobilenum + '" /><input id=FparentssmssendEID type="hidden" value="' + data.d[i].facultyid + '"></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].mobilenum + '">' + data.d[i].BindGridDataforemp + '</span></td>';
                                    i = i + 1;
                                }
                                else {
                                    trforappend = trforappend + '</tr>'
                                    $('.stm').append(trforappend);
                                    break;
                                }
                                if (parseInt(i) < parseInt(data.d.length)) {
                                    trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=facultyno type="hidden" value="' + data.d[i].mobilenum + '" /><input id=FparentssmssendEID type="hidden" value="' + data.d[i].facultyid + '"></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].mobilenum + '">' + data.d[i].BindGridDataforemp + '</span></td>';
                                    i = i + 1;
                                }
                                else {
                                    trforappend = trforappend + '</tr>'
                                    $('.stm').append(trforappend);
                                    break;
                                }
                                if (parseInt(i) < parseInt(data.d.length)) {
                                    trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=facultyno type="hidden" value="' + data.d[i].mobilenum + '" /><input id=FparentssmssendEID type="hidden" value="' + data.d[i].facultyid + '"></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].mobilenum + '">' + data.d[i].BindGridDataforemp + '</span></td>';
                                    i = i + 1;
                                }
                                else {
                                    trforappend = trforappend + '</tr>'
                                    $('.stm').append(trforappend);
                                    break;
                                }
                                trforappend = trforappend + '</tr>'
                                $('.stm').append(trforappend);
                            }
                            catch (err) {
                                alert('Some Error Occor While Binding The Table.');
                                call_progressbar('end');
                            }
                        }
                    }
                    call_progressbar('end');
                    ClearData();
                },
                error: function (response) {
                    ClearData();
                    call_progressbar('end');
                }
            });
        }
        function BindGridforstudent() {
           
            call_progressbar('start');
            var trforappend = "";
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms-center-branch.aspx/BindGridforstudent",
                data: "{'stunames':'" + stunames + "','stumob':'" + stumob + "','fromdate':'" + fromdate + "','todate':'" + todate + "','courseid':'" + courseid + "','checkcoursejoin':'" + checkcoursejoin + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length;) {
                            $('#charNum').text('Message ' + "1" + ' - ' + "160" + ' characters left');
                            try {
                                trforappend = '<tr><td><input class="getcheckboxid" type="checkbox" checked /><input id=parentssmssend type="hidden" value="' + data.d[i].GuardianPhone + '"><input id=parentssmssendEID type="hidden" value="' + data.d[i].studentId + '"></td><td style="text-align:left;font-weight:bold;"><span title="' + data.d[i].mobile + '">' + data.d[i].BindGridDataforstu + '</span></td>';
                                i = i + 1;
                                trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=parentssmssend type="hidden" value="' + data.d[i].GuardianPhone + '"><input id=parentssmssendEID type="hidden" value="' + data.d[i].studentId + '"></td><td style="text-align:left;font-weight:bold;">' + data.d[i].BindGridDataforstu + '</td>';
                                i = i + 1;
                                trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=parentssmssend type="hidden" value="' + data.d[i].GuardianPhone + '"><input id=parentssmssendEID type="hidden" value="' + data.d[i].studentId + '"></td><td style="text-align:left;font-weight:bold;">' + data.d[i].BindGridDataforstu + '</td>';
                                i = i + 1;
                                trforappend = trforappend + '<td><input class="getcheckboxid" type="checkbox" checked /><input id=parentssmssend type="hidden" value="' + data.d[i].GuardianPhone + '"><input id=parentssmssendEID type="hidden" value="' + data.d[i].studentId + '"></td><td style="text-align:left;font-weight:bold;">' + data.d[i].BindGridDataforstu + '</span></td>';
                                i = i + 1;
                                trforappend = trforappend + '</tr>'
                                $('.stm').append(trforappend);
                            }
                            catch (err) {
                                $('.stm').append(trforappend);
                            }
                        }
                        call_progressbar('end');
                    }
                    call_progressbar('end');
                    ClearData();

                },
                error: function (response) {
                    ClearData();
                    alertify.error("Error");
                    call_progressbar('end');
                }
            });
        }
        function smssend() {
            var message = $('.inputsms').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms-center-branch.aspx/smssendglobal",
                data: "{'PerTypeID':'" + PerTypeID + "','GlobalEID':'" + GlobalEID + "','globalsmstoall':'" + globalsmstoall + "','message':'" + message.split("'").join("~") + "','apiforsms':'" + apiforsms + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Sms Send Sucessfully.')
                    }
                    if (data.d == 2) {
                        alertify.error("SMS API is Not Available.");
                    }
                    if (data.d == 0) {
                        alertify.error("Some Error in SMS API.");
                    }
                },
                error: function (result) {
                }
            });
        }
        function getenquiry() {
            call_progressbar('start');
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms-center-branch.aspx/countenquiry",
                data: "{'courseid':'" + courseid + "','enqstatus':'" + enqstatus + "','fromdate':'" + fromdate + "','todate':'" + todate + "'}",
                dataType: "json",
                success: function (data) {
                    ClearData();
                    if (data.d.length >= 0) {
                        $('#noofenquiry').text(data.d[0].enquiry);
                        globalsmstoall = data.d[0].mobile;
                        apitypestatus = data.d[0].checkapi;

                    }                  
                    call_progressbar("end");
                },
                error: function (result) {
                    ClearData();
                    alertify.error('Error');
                    call_progressbar("end");
                }
            });
        }
        function designationfac(desigid) {
            call_progressbar('start');
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms-center-branch.aspx/getdegnitaion",
                data: "{ 'did':'" + desigid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                    }
                    $("#ctl00_ContentPlaceHolder1_ddlstudesg").html("");
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlstudesg").append($("<option></option>").val(value.desigid).html(value.desigName));
                        call_progressbar('end');
                    });
                    getemployee($("#ddlfacultydeptnstuname").val(), 0)
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error('error');
                },
            });
        }
        function getemployee(departmentid, designationid) {
           
            call_progressbar('start');
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms-center-branch.aspx/getemployeename",
                data: "{ 'degid':'" + designationid + "','did':'" + departmentid + "'}",
                dataType: "json",
                success: function (data) {

                    $("#getcheckboxid").html("");
                    $.each(data.d, function (key, value) {
                        $("#getcheckboxid").append($("<option></option>").val(value.eid).html(value.empname));
                        call_progressbar('end');
                    });

                },
                error: function (result) {
                    alertify.error('error');
                },
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
</asp:Content>