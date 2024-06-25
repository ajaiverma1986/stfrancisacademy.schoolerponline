<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="timetable-settings.aspx.cs" Inherits="BranchPanel_timetable_settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Set Timetable Structure</h2>
            <asp:Button runat="server" ID="btnaddsetting" CssClass="button_save" Text="Add Timetable Setting"
                    ToolTip="Click here to add new settings." Style="float: right; margin-top: 5px; margin-right: 3px" />
        </div>
        <div class="for_sigle_row_form" id="divforsearching" runat="server">
            <asp:DropDownList ID="ddlfinacialyearforsearching" runat="server" Style="width: 150px; margin-left: 5px">
            </asp:DropDownList>
        </div>
        <div id="divforshowperiod">
            <table class="stm showperiod" width="100%">
                <tr class="stm_head" align="center">
                    <th>S.No.</th>
                    <th>Class</th>
                    <th>No Of Period In Day</th>
                    <th>FromDate</th>
                    <th>ToDate</th>
                    <th>FromTime</th>
                    <th>ToTime</th>
                    <th>Edit</th>
                    <th>Rewised</th>
                    <th>View</th>
                </tr>
            </table>
        </div>
        <div  id="divforaddperiod" style="display:none">
        <div class="for_sigle_row_form">
            <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlfinancialyear" runat="server">
            </asp:DropDownList>
        </div>
            <div class="for_sigle_row_form">
                <label>Setting From Date<span style="font-weight: bold; color: red">*</span></label>
                <input id="txtfromdate" type="text" readonly="readonly" placeholder="Select From Date"/>
            </div>
            <div class="for_sigle_row_form">
                 <label>Setting To Date</label>
                <input id="txttodate" type="text" readonly="readonly" placeholder="Select To Date"/>
            </div>
            </div>
        <div class="divfortbl" style="display:none">
        <table class="tabforadd stm1" id="tblcourcesname" style="width: 100%">
            <tr class="stm_head">
                <th style="text-align: center">S.No.</th>
                <th style="text-align: center">Class</th>
                <th style="text-align: center">No Of Period</th>
                <th style="text-align: center">From Time</th>
                <th style="text-align: center">To Time</th>
                <th style="text-align: center">Set Structure</th>
            </tr>
        </table>
    </div>
    
        <div class="divforstructure" style="display:none">
            <table class="addtr">
                <tr class="for_sigle_row_form">
                    <td class="for_sigle_row_form">
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="TextBox1" placeholder="Enter Period Name"></asp:TextBox>
                        </td>
                    <td class="for_sigle_row_form">
                        <asp:DropDownList ID="ddlstarttime" CssClass="ddlstarttime" runat="server"></asp:DropDownList>
                            </td>
                    <td class="for_sigle_row_form">
                        <asp:DropDownList ID="ddlendtime" CssClass="ddlendtime" runat="server"></asp:DropDownList>
                         </td>
                </tr>
            </table>
            </div>
        <div class="for_sigle_row_form">
            <asp:Button ID="btnedit" runat="server" Text="Edit" Style="display:none" CssClass="button_save" />
            <asp:Button ID="btnCancel" runat="server" CssClass="button_cancel" Style="display:none" Text="Back" />
        </div>
        <div id="divforbutton" class="for_sigle_row_form" style="display: none">
            <asp:Button ID="btnsave" runat="server" CssClass="button_save" Text-="Save" />
            <asp:Button ID="btnback" runat="server" CssClass="button_cancel" Text="Back" />
            <asp:Button ID="btnclear" runat="server" CssClass="button_cancel" Text="Cancel" Style="display:none" />
        </div>
        </div>
    <script type="text/javascript">
        var year = 2050;
        var allclassid = '', allperiodname = '', allstarttime = '', allendtime = '', noperiod = '', fyid = '', classid = '', fromdate = '', todate = '', fromtime = '', totime = '', disable = 0, trlength = '', foredit = 0, rewised=0;

        $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').change(function () {
            BindListofPeriod();
        });
        $('#ctl00_ContentPlaceHolder1_btnsave').click(function () {
                if (checkvalidation()) {
                    getperiod();
                    fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
                    fromdate = $("#txtfromdate").val();
                    todate = $("#txttodate").val();
                    fromtime = $('.tabforadd').find('.ddlstarttime').val();
                    totime = $('.tabforadd').find('.ddlendtime').val();
                    addclassperiod();
                    reset();
                    if (rewised == 0) {
                        $('#divforaddperiod').hide();
                        $('#ctl00_ContentPlaceHolder1_btnaddsetting').show();
                        $('#divforshowperiod').show();
                        $('.divforstructure').hide();
                        $('#divforbutton').hide();
                        $('.addtr tr:gt(0)').remove();
                        $('.divfortbl').hide();
                        $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').show();
                        BindListofPeriod();
                    }
                }
                $('#txtfromdate').val('');
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_btnaddsetting').click(function () {
                $(this).hide();
                $('#divforshowperiod').hide();
                $('#divforaddperiod').show(500);
                $('#divforbutton').show();
                $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').hide();
                $('.divfortbl').show();
                classid = '';
                foredit = 0;
                rewised = 0;
                fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
                BindClass();
                return false;
            });
            $('.editimage').live('click', function () {
                classid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                $('#divforshowperiod').hide();
                $('#divforaddperiod').show(500);
                $('#divforbutton').show();
                $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').hide();
                $('.divfortbl').show();
                $('#ctl00_ContentPlaceHolder1_btnaddsetting').hide();
                foredit = 1;
                allclassid = classid;
                rewised = 0;
                fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
                BindClass();
                return false;
            });
            $('.rewisedimage').live('click', function () {
                classid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                $('#ctl00_ContentPlaceHolder1_btnaddsetting').hide();
                $('#divforshowperiod').hide();
                $('#divforaddperiod').show(500);
                $('#divforbutton').show();
                $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').hide();
                $('.divfortbl').show();
                foredit = 0;
                rewised = 1;
                fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
                BindClass();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnback').click(function () {
                $('#divforaddperiod').hide();
                $('#ctl00_ContentPlaceHolder1_btnaddsetting').show();
                $('#divforshowperiod').show();
                $('.divforstructure').hide();
                $('#divforbutton').hide();
                $('.addtr tr:gt(0)').remove();
                $('.divfortbl').hide();
                $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').show();
                $('#txtfromdate').val('');
                $('#txttodate').val('');
                return false;
            });

            $('.viewimage').live('click',function () {
                classid=$(this).parent('td').parent('tr').find('input[type=hidden]').val();
                $('#divforperioddetails').show();
                $('#divforshowperiod').hide();
                $('#ctl00_ContentPlaceHolder1_btnaddsetting').hide();
                $('#ctl00_ContentPlaceHolder1_btnback').show();
                //$('#divforbutton').show();
                $('.divforstructure').show();
                $('#ctl00_ContentPlaceHolder1_btnCancel').show();
                //$('#ctl00_ContentPlaceHolder1_btnedit').show();
                //showdetail();
                disable = 1;
                showperiod();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_btnCancel').click(function () {
                $(this).hide();
                $('#divforshowperiod').show();
                $('.divforstructure').hide();
                $('.addtr tr:gt(0)').remove();
                $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').attr("disabled", false);
                $('#ctl00_ContentPlaceHolder1_btnaddsetting').show();
                return false;
            });

            $('.radioset').live('change', function () {
                $('.tabforadd').find('.ddlstarttime').attr("disabled", "disabled");
                $('.tabforadd').find('.ddlendtime').attr("disabled", "disabled");
                $('.tabforadd').find('input[type=text]').attr("disabled", "disabled");
                $(this).parent('td').parent('tr').find('input[type=text]').prop('disabled', false);
                $(this).parent('td').parent('tr').find('.ddlendtime').attr("disabled", false);
                $(this).parent('td').parent('tr').find('.ddlstarttime').attr("disabled", false);
                totime = $(this).parent('td').parent('tr').find('.ddlendtime').val();
                fromtime = $(this).parent('td').parent('tr').find('.ddlstarttime').val();
                noperiod = $(this).parent('td').parent('tr').find('input[type=text]').val();
                classid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                allclassid = classid;
                disable = 0;
                if (rewised == 0 && foredit==0) {
                    var gettr = '<tr>' + $(this).parent('td').parent('tr').html() + '</tr>';
                    $('.tabforadd').find('tr:gt(0)').remove();
                    $('.tabforadd').append(gettr);
                    $('.tabforadd').find('input[type=radio]').attr("disabled", true);
                    $('#ctl00_ContentPlaceHolder1_btnclear').show();
                    $('#ctl00_ContentPlaceHolder1_btnback').hide();
                }
                if ($(this).parent('td').parent('tr').find('input[type=text]').val() > 0) {
                    showperiod();
                }
                else {
                    $('.addtr tr:gt(0)').remove();
                    $('.addtr').find('input[type=text]').val('');
                    $('.addtr').find('.ddlstarttime').val('8:30 AM');
                    $('.addtr').find('.ddlendtime').val('8:30 AM');
                    $('.divforstructure').hide();
                }
                if (rewised == 0 && foredit == 0) {
                    checkradio();
                }
            });
            $('.noofperiod').live('change paste', function () {
                trlength = $('.addtr tr').length;
                totime = $(this).parent('td').parent('tr').find('.ddlendtime').val();
                fromtime = $(this).parent('td').parent('tr').find('.ddlstarttime').val();
                noperiod = $(this).val();
                $('.divforstructure').show();
                $('html, body').animate({
                    scrollTop: $(".divforstructure").offset().top
                }, 500);
                if (noperiod > trlength) {
                    showdetail();
                }
                else {
                    for (var i = 0; i < trlength - noperiod; i++) {
                        $('.addtr').find('tr:last').remove();
                    }
                    $('.addtr').find('tr:first').find('.ddlstarttime').val(fromtime);
                    $('.addtr').find('tr:last').find('.ddlendtime').val(totime);
                    $('.addtr').find('tr:first').find('.ddlstarttime').attr("disabled", true);
                    $('.addtr').find('tr:last').find('.ddlendtime').attr("disabled", true);
                }
            })
            $('.tabforadd').find('.ddlstarttime').live('change', function () {
                fromtime = $(this).val();
                $('.addtr').find('tr:first').find('.ddlstarttime').val(fromtime);
            })
            $('.tabforadd').find('.ddlendtime').live('change', function () {
                totime = $(this).val();
                $('.addtr').find('tr:last').find('.ddlendtime').val(totime);
            })
        $("#txtfromdate,#txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:'+ year,
                dateFormat: 'dd MM yy'
        });
        $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
            $(this).hide();
            $('#ctl00_ContentPlaceHolder1_btnback').show();
            classid = '';
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            BindClass();
            $('.addtr tr:gt(0)').remove();
            $('.addtr').hide();
            return false;
        });
        function checkradio() {
            $('.tabforadd').find('tr:gt(0)').each(function () {
                if ($(this).find('input[type=radio]').is(':enabled'))
                    $(this).find('input[type=text]').val("0");
            })
        }
        function showdetail() {
            $('.addtr tr:gt(' + trlength + ')').remove();
            if (noperiod > 0) {
                var trforadd = $('.addtr').find('tr:eq(0)').prop('outerHTML');
                for (var i = 0; i < noperiod - trlength; i++) {
                    $('.addtr').append(trforadd);
                }
                $('.addtr').find('.ddlstarttime').attr("disabled", false);
                $('.addtr').find('.ddlendtime').attr("disabled", false);
                $('.addtr').find('input[type=text]').attr("disabled", false);
                $('.addtr').find('tr:first').find('.ddlstarttime').val(fromtime);
                $('.addtr').find('tr:last').find('.ddlendtime').val(totime);
                $('.addtr').find('tr:first').find('.ddlstarttime').attr("disabled", true);
                $('.addtr').find('tr:last').find('.ddlendtime').attr("disabled", true);
            }
            else {
                $('.divforstructure').hide();
            }
        }
          
            function getperiod() {
                $('.addtr').find('tr').each(function () {
                    allperiodname = allperiodname + ',' + $(this).find('input[type=text]').val();
                    allstarttime = allstarttime + ',' + $(this).find('#ctl00_ContentPlaceHolder1_ddlstarttime').val();
                    allendtime = allendtime + ',' + $(this).find('#ctl00_ContentPlaceHolder1_ddlendtime').val();
                });
                noperiod=$('.addtr').find('tr').length;
            }

            function BindClass() {
                var tdforfromtime = $('.addtr').find('tr:eq(0)').find('td:eq(1)').prop('outerHTML');
                var tdfortotime = $('.addtr').find('tr:eq(0)').find('td:eq(2)').prop('outerHTML');
                $('.tabforadd tr:gt(0)').remove();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "timetable-settings.aspx/BindPeriod",
                    data: "{'classid':'" + classid + "','fyid':'" + fyid + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                if (i % 2 != 0) {
                                    trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].classid + '>' + (i + 1) + '</td>' +
                                                '<td>' + data.d[i].Classname + '</td>' +
                                                '<td class="for_sigle_row_form"><input type=text style="width:100px; height:20px" value="' + data.d[i].NoOfPeriod + '" class="noofperiod" disabled onkeypress="return isNumberKey(event)"</td>' +
                                                tdforfromtime +
                                                tdfortotime +
                                                '<td><input type="radio" class="radioset" name="schedule"></td></tr>';
                                }
                                else {
                                    trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].classid + '>' + (i + 1) + '</td>' +
                                                '<td>' + data.d[i].Classname + '</td>' +
                                                '<td class="for_sigle_row_form"><input type=text style="width:100px; height:20px" value="' + data.d[i].NoOfPeriod + '" class="noofperiod" disabled onkeypress="return isNumberKey(event)"</td>' +
                                                tdforfromtime +
                                                tdfortotime +
                                                '<td><input type="radio" class="radioset" name="schedule"></td></tr>';
                                }
                                $('.tabforadd').append(trforappend);
                                if(foredit==0 && rewised==0){
                                    if ($('.tabforadd').find('tr:last').find('input[type=text]').val() > 0) {
                                        $('.tabforadd').find('tr:last').find('input[type=radio]').attr("disabled",true)
                                    }
                                }
                            }
                            $('.tabforadd').find('.ddlstarttime').attr("disabled", "disabled");
                            $('.tabforadd').find('.ddlendtime').attr("disabled", "disabled");
                            var rowCount = $('.tabforadd tr').length;
                          
                            for (var i = 1; i < rowCount; i++) {
                                $('.tabforadd').find('tr:eq(' + i + ')').find('#ctl00_ContentPlaceHolder1_ddlstarttime').val(data.d[i-1].FromTime);
                                $('.tabforadd').find('tr:eq(' + i + ')').find('#ctl00_ContentPlaceHolder1_ddlendtime').val(data.d[i-1].ToTime);
                            }
                            if (foredit == 1) {
                                $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val(data.d[0].fyid);
                                $('#txtfromdate').val(data.d[0].FromDate);
                                $('#txttodate').val(data.d[0].Todate);
                                $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').attr("disabled", true);
                                $('#txtfromdate').attr("disabled", true);
                                $('#txttodate').attr("disabled", true);
                            }
                            else {
                                $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').attr("disabled", false);
                                $('#txtfromdate').attr("disabled", false);
                                $('#txttodate').attr("disabled", false);
                            }
                        }
                        else {
                            alertify.error('No Record Found');
                        }
                    },
                    error: function (result) {
                       
                        alertify.error('Some Error occured during Binding.');
                    },
                });
            }
            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    alertify.error("Please Enter Only Numeric Value.");
                    return false;
                }
                else
                    return true;
            }
            function addclassperiod() {
               
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "timetable-settings.aspx/Addperiod",
                    data: "{'allclassid':'" + allclassid + "','allperiodname':'" + allperiodname.split("'").join("`") + "','allstarttime':'" + allstarttime + "','allendtime':'" + allendtime + "','noperiod':'" + noperiod + "','fyid':'" + fyid + "','fromdate':'" + fromdate + "','todate':'" + todate + "','fromtime':'" + fromtime + "','totime':'" + totime + "','rewised':'" + rewised + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d == 1) {
                            alert('Time Table Structure Created Successfully.');
                        }
                        if (data.d == 2) {
                            alert('From Date Should Be Greater than Current Date');
                        }
                        if (data.d == 3) {
                            alert('Period Details Updated');
                        }
                        if (data.d == 4) {
                            alert('Time Table Structure Rewised Successfully.');
                        }
                    }
                });
            }
            function checkvalidation() {
                var temp = 0,status=1;
                if ($('#txtfromdate').val() == '') {
                    alert('Please Select The From Date');
                    return false;
                }
                
                if (noperiod == 0 || noperiod == '') {
                    alert("Please Enter No. of Period of Selected Class");
                    return false;
                }
                if ($('.tabforadd').find('.ddlstarttime').val() == $('.tabforadd').find('.ddlendtime').val()) {
                    alert("From Time and To Time can not be same.");
                    return false;
                }
                $('.addtr').find('tr').each(function () {
                    if ($(this).find('input[type=text]').val() == '') {
                        alert("Please Enter Period Name");
                        $(this).find('input[type=text]').focus();
                        status = 0;
                        return false;
                    }
                    if ($(this).find('.ddlstarttime').val() == $(this).find('.ddlendtime').val()) {
                        alert("Period Start Time and End Time can not be same.");
                        status = 0;
                        return false;
                    }
                    //if ($(this).find('.ddlstarttime').val() > $(this).find('.ddlendtime').val()) {
                    //    alert("Period Start Time can not be Greater than End Time.");
                    //    status = 0;
                    //    return false;
                    //}
                   
                });
                if (status == 1)
                    return true;
                else
                    return false;
            }
            function reset() {
                allclassid = '';
                allperiodname = '';
                allstarttime = '';
                allendtime = '';
                noperiod = '';
                fyid = '';
            }

            function BindListofPeriod() {
                $('.showperiod tr:gt(0)').remove();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "timetable-settings.aspx/PeriodScheduleList",
                    data: "{'fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                      
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                if (i % 2 != 0) {
                                    trforappend = '<tr class="stm_dark"><td><input type=hidden value=' + data.d[i].classid + '>' + (i + 1) + '</td>' +
                                                '<td>' + data.d[i].Classname + '</td>' +
                                                '<td><span>' + data.d[i].NoOfPeriod + '</span></td>' +
                                                '<td>' + data.d[i].FromDate + '</td>' +
                                                 '<td>' + data.d[i].ToDate + '</td>' +
                                                  '<td>' + data.d[i].FromTime + '</td>' +
                                                   '<td>' + data.d[i].ToTime + '</td>' +
                                                    '<td><input class=editimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/edit.png /></td>' +
                                                    '<td><input class=rewisedimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/rewised.png /></td>' +
                                                '<td><input class=viewimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/viewquestion.png /></td></tr>';
                                }
                                else {
                                    trforappend = '<tr class="stm_ligth"><td><input type=hidden value=' + data.d[i].classid + '>' + (i + 1) + '</td>' +
                                                '<td>' + data.d[i].Classname + '</td>' +
                                                '<td><span>' + data.d[i].NoOfPeriod + '</span></td>' +
                                                '<td>' + data.d[i].FromDate + '</td>' +
                                                 '<td>' + data.d[i].ToDate + '</td>' +
                                                  '<td>' + data.d[i].FromTime + '</td>' +
                                                   '<td>' + data.d[i].ToTime + '</td>' +
                                                    '<td><input class=editimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/edit.png /></td>' +
                                                    '<td><input class=rewisedimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/rewised.png /></td>' +
                                                '<td><input class=viewimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/viewquestion.png /></td></tr>';
                                }
                                $('.showperiod').append(trforappend);
                               
                            }
                            //call_progressbar("end");
                        }
                        else {
                            //call_progressbar("end");
                            alertify.error('No Record Found');
                        }
                    },
                    error: function (result) {
                       // call_progressbar("end");
                        alertify.error('Some Error occured during Binding Student.');
                    }
                });
            }

            function showperiod() {
                $('.addtr tr:gt(0)').remove();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "timetable-settings.aspx/showPeriodDetail",
                    data: "{'classid':'" + classid + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        var trforadd = $('.addtr').find('tr:eq(0)').prop('outerHTML');
                        if (data.d.length > 0) {
                            $('.divforstructure').show();
                            for (var i = 0; i < data.d.length-1; i++) {
                                $('.addtr').append(trforadd);
                            }
                            for (var i = 0; i < data.d.length ; i++) {
                                $('.addtr').find('tr:eq(' + i + ')').find('input[type=text]').val(data.d[i].Periodname);
                                $('.addtr').find('tr:eq(' + i + ')').find('.ddlstarttime').val(data.d[i].StartTime);
                                $('.addtr').find('tr:eq(' + i + ')').find('.ddlendtime').val(data.d[i].EndTime);
                            }
                            if (disable == 1) {
                                $('.addtr').find('input[type=text]').attr("disabled", true);
                                $('.addtr').find('.ddlstarttime').attr("disabled", true);
                                $('.addtr').find('.ddlendtime').attr("disabled", true);
                                $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').attr("disabled", true);
                            }
                            else {
                                $('.addtr').find('input[type=text]').attr("disabled", false);
                                $('.addtr').find('.ddlstarttime').attr("disabled", false);
                                $('.addtr').find('.ddlendtime').attr("disabled", false);
                                $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').attr("disabled", false);
                                $('.addtr').find('tr:first').find('.ddlstarttime').val(fromtime);
                                $('.addtr').find('tr:last').find('.ddlendtime').val(totime);
                                $('.addtr').find('tr:first').find('.ddlstarttime').attr("disabled", true);
                                $('.addtr').find('tr:last').find('.ddlendtime').attr("disabled", true);
                            }
                        }
                    }
                });
            }
            //BindClass();
            BindListofPeriod();
            //showdetail();
    </script>
</asp:Content>

