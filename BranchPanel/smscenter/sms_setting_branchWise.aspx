<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="sms_setting_branchWise.aspx.cs" Inherits="BranchPanel_smscenter_sms_setting_branchWise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>SMS API Setting</h2>
        </div>
        <div id="apimaster">
            <div class="for_sigle_row_form" style="width: 100%">
                <label style="float: left">Transactional API</label>
                <textarea class="smsapi" type="text" placeholder="Enter Your Api" style="width: 500px;"></textarea>
                <label style="float: right; margin-right: 321px; margin-top: -50px;">
                    Active<input class="tranapiactivedeactive" style="margin-top: 8px;" type="checkbox" checked="checked" />
                </label>
            </div>
             <div id="Div1" runat="server" visible="false">
            <div class="for_sigle_row_form">
                <label>Promotional API</label>
                <textarea class="smsproapi" type="text" placeholder="Enter Your Api" style="width: 500px"></textarea>
                <label style="float: right; margin-right: 321px; margin-top: -50px;">
                    Active<input class="proapiactivedeactive" style="margin-top: 8px;" type="checkbox" checked="checked" />
                </label>
            </div>
                 </div>
            <div class="for_sigle_row_form">
                <label></label>
                <input type="submit" id="Buttoninputapi" class="button_save" value="Update" />
                <div class="content_buttom">
                    <p style="padding: 9px; text-align: left; margin-left: 160px; font-weight: 800">Note:Enter <u>1111111111</u>  at the place of <u>MOBILENO</u> and Enter <u>Dummy Text</u> at the place of <u>MESSAGE</u></p>
                </div>
            </div>
        </div>
        <div id="d" runat="server" visible="false">
        <div class="tbl-top-heading">
            <h2>SMS Content Settings</h2>
            <h2 style="float: right; cursor: pointer; color: #000"><i class="fa fa-save icon">
                <b class="bg-info"></b>
            </i><a class="anchorrestoreordefault">Restore Setting</a></h2>
        </div>
        <div align="center" class="input_content" style="border: none; padding: 0px; margin-top: 0px;" id="divsmsmasetr">
            <div class="clear"></div>
            <table style="width: 100%; display: block;" class="maintrformessageadd">
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>Module Name<span style="color: #ff0066"></span></label>
                            <span id="ContentMsg" style="font-weight: 900; width: 500px;"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>Action Name<span style="color: #ff0066"></span></label>
                            <span id="Span1" style="font-weight: 900; width: 500px;"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td id="addmessageinput">
                        <div class="smsradioforapi" style="padding: 12px 0 0; height: auto; margin-left: 165px; margin-top: 50px;">
                            <label style="text-align: left; font-weight: bold;">SMS Send by</label>
                            <label style="margin-left: 20px; width: 108px; text-align: left; font-weight: bold;">Transactional<input type="radio" style="margin-left: 10px" value="1" name="smsapi" /></label>
                            <label style="margin-left: 20px; width: 120px; text-align: left; font-weight: bold;">Promotional<input type="radio" style="margin-left: 10px" value="2" name="smsapi" /></label>
                        </div>
                        <div class="smsradiotype" style="padding: 12px 0 0; height: auto; margin-left: 165px; margin-top: 50px;">
                            <label style="text-align: left; font-weight: bold;">SMS Send to</label>
                           <%--<label style="margin-left: 20px; width: 80px; text-align: left; font-weight: bold;">Student<input type="radio" style="margin-left: 10px" value="1" checked="checked" name="smsstuandparents" /></label>--%>
                            <label style="margin-left: 20px; width: 100px; text-align: left; font-weight: bold;">Parents<input type="radio" style="margin-left: 10px" value="2" name="smsstuandparents" /></label>
                            <%--<label style="margin-left: 20px; width: 100px; text-align: left; font-weight: bold;">Both<input type="radio" style="margin-left: 10px" value="3" name="smsstuandparents" /></label>--%>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Message<span style="color: #ff0066">*</span></label>
                            <textarea class="inputname" type="text" placeholder="Enter Message please" rows="10" cols="3" style="height: 130px"></textarea>
                            <div style="width: 300px; float: right;">
                                <table class="stm tableforbindvariable" width="300px">
                                    <tr class="stm_head">
                                        <td>S.No.</td>
                                        <td>Variable Name</td>
                                        <td>Symbol</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div style="margin-left: 170px; display: none" id="messageview">
                            <p style="font-size: 15px;"></p>
                            <span id="DemomsgView" style="font-weight: 900; width: 500px;"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td id="autoduetable"></td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <input type="submit" class="button_save inputsubmitmessage" value="submit" style="margin-bottom: 10px;" />
                            <input type="submit" class="button2 inputcancelstatus" value="Cancel" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="showdata" runat="server"></div>
        <div id="divProgressBar" class="progress">
        </div>
            </div>
    </div>
    <script type="text/javascript">
        var actionid = 0, apitype = 0, apistatus = 0, sms_send_to = 0, checked = 0, apitypestatus = 0, TableForBind = '';
        var smsapi = '', status = '2', prosmsapi = '', proactive = '2', istransactinalapiworking = 2, ispromotionalapiworking = 2;
        $(document).ready(function () {
            $('.anchorrestoreordefault').live('click', function () {
                var confirmrestore = confirm('Are You Sure You Want To Restore Default Settings.Just Remember If You Restore Once Your All Settings Related To SMS Settings Will Restore.And Your Current Setting Will Be Lost.?')
                if (confirmrestore == true) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "sms-settings.aspx/RestoreSmsSetting",
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d > 0) {
                                alert('Your Setting Has Been Restored.It Will Take Fue Second.');
                                setTimeout(
                           function () {
                               window.location.reload();
                           }, 100);
                            }
                        }
                    });
                }
            });
            $('#autoduetable').find('input[type=checkbox]').live('change', function () {
                var Temp = 0;
                if ($(this).prop('checked') == true)
                    Temp = 1;
                $('#autoduetable').find('input[type=checkbox]').attr("checked", false);
                if (Temp == 1)
                    $(this).attr("checked", true);
            });
            //when we click on edit link of grid view
            $('.maintrformessageadd').hide(500);
            $('.editimage').live("click", function () {

                call_progressbar("start");
                actionid = $(this).closest('tr').find('input[type=hidden]').val();

                ////////////////////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@//////////////////////////
                if (actionid == 10 || actionid == 23) {
                    TableForBind = '<table border="1" style="width: 300px"><thead><tr><th></th><th>Send Auto Remainder</th></tr></thead><tbody>' +
                                   '<tr><td><input type="checkbox" value="1" /></td><td>Before One Day From Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="2" /></td><td>Before Two Day From Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="3" /></td><td>Before Three Day From Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-2" /></td><td>From Before Two Day To Till Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-3" /></td><td>From Before Three Day To Till Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-4" /></td><td>From Before Four Day To Till Due Date</td></tr></tbody></table>';
                }
                else if (actionid == 15) {
                    TableForBind = '<table border="1" style="width: 300px"><thead><tr><th></th><th>Send Auto Remainder</th></tr></thead><tbody>' +
                                   '<tr><td><input type="checkbox" value="1" /></td><td>After One Day From Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="2" /></td><td>After Two Day From Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="3" /></td><td>After Three Day From Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-2" /></td><td>Each Day Till Two Day From Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-3" /></td><td>Each Day Till Three Day From Due Date</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-4" /></td><td>Each Day Till Four Day From Due Date</td></tr></tbody></table>';
                }
                else if (actionid == 2) {
                    TableForBind = '<table border="1" style="width: 300px"><thead><tr><th></th><th>Send Auto Remainder</th></tr></thead><tbody>' +
                                   '<tr><td><input type="checkbox" value="5" /></td><td>Before Five Minute</td></tr>' +
                                   '<tr><td><input type="checkbox" value="10" /></td><td>Before Ten Minute</td></tr>' +
                                   '<tr><td><input type="checkbox" value="15" /></td><td>Before Fifteen Minute</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-5" /></td><td>After Five Minute</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-10" /></td><td>After Ten Minute</td></tr>' +
                                   '<tr><td><input type="checkbox" value="-15" /></td><td>After Fifteen Minute</td></tr></tbody></table>';
                }
                ///////////////////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@////////////////////////////
                $('.tableforbindvariable').find('tr:gt(0)').remove();
                // unselected all radio button by default start here----------------------------
                $("input:radio[name=smsapi]").attr('checked', false)
                $("input:radio[name=smsstuandparents]").attr('checked', false);
                $('#autoduetable').find('input[type=checkbox]').attr('checked', false);
                if (actionid != 10 && actionid != 15 && actionid != 2 && actionid != 23) {
                    $("#autoduetable").hide();
                    $("#autoduetable").html('');
                }
                else {
                    $("#autoduetable").html(TableForBind);
                    $("#autoduetable").show();
                }
                // unselected all radio button by default end here----------------------------
                // when edit sms setting in any module for any action

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "sms-settings.aspx/call_smssettings",
                    data: "{'actionid':'" + actionid + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#headwithbranch').hide(500);
                        $('.maintrformessageadd').show(500);
                        if (data.d.length > 0) {
                            $('.tableforbindvariable').append(data.d[0].DivForBindVariable)
                            var tbl = '';
                            $('#ContentMsg').html(data.d[0]["modulename"]);
                            $('#Span1').html(data.d[0]["actionname"]);
                            sms_send_to = data.d[0]["sms_send_to"];
                            if (data.d[0]["sms_send_to"] == -1) {
                                $('.smsradiotype').hide();
                            }
                            else {
                                $('.smsradiotype').show();
                                $('input:radio[name=smsstuandparents][value="' + data.d[0].sms_send_to + '"]').attr('checked', 'checked');
                            }
                            apitypestatus = data.d[0]["apitypestatus"];
                            $('.inputname').val(data.d[0]["smscontent"]);
                            $('input:radio[name=smsapi][value="' + data.d[0].apitype + '"]').attr('checked', 'checked');
                            $('#autoduetable').find('input[type=checkbox][value="' + data.d[0].AutoRemainderType + '"]').attr('checked', 'checked');
                        }
                        call_progressbar("end");
                    }
                });
                return false;
            });
            $('.inputcancelstatus').click(function () {
                $('.maintrformessageadd').hide(500);
                $('#headwithbranch').show(500);
                return false;
            });
            // when we click on submit to edit sms master settings
            $('.inputsubmitmessage').click(function () {
                call_progressbar("start");
                var AutoRemainderType = 0;
                if ($("#autoduetable input:checkbox:checked").val() >= -4) {
                    AutoRemainderType = $("#autoduetable input:checkbox:checked").val();
                }
                // when edit sms setting in any module for any action
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "sms-settings.aspx/set_smssettings",
                    data: "{'actionid':'" + actionid + "','msg':'" + $('.inputname').val().split("'").join("~") + "','apitype':'" + apistatus + "','sms_send_to':'" + sms_send_to + "','AutoRemainderType':'" + AutoRemainderType + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('.inputname').val('');
                        $('#headwithbranch').show(500);
                        $('.maintrformessageadd').hide(500);
                        if (data.d.length > 0) {
                            var tbl = '';
                            $('#autoduetable').find('input[type=checkbox]').attr("checked", false);
                            $('#headwithbranch').find('tr:gt(0)').remove();
                            var sno = 0;
                            for (var i = 0; i < data.d.length; i++) {
                                var cls;
                                if (i % 2 == 0) {
                                    cls = 'stm_dark';
                                }
                                else {
                                    cls = 'stm_light';
                                }
                                var rspn = 1;
                                var j1 = i;
                                var dis = "";
                                for (var j = 0; j < data.d[j1].rowspan; j++) {
                                    if (data.d[i].ApiTypeId == 0) {
                                        dis = "disabled";
                                    }
                                    else if (data.d[i].sms_send_to == 0) {
                                        dis = "disabled";
                                    }
                                    if (rspn == 1) {
                                        rspn = 0;
                                        sno++;
                                        tbl = "<tr><td rowspan='" + data.d[i].rowspan + "'>" + (sno) + "</td>" +
                                            "<td rowspan='" + data.d[i].rowspan + "'>" + data.d[i].modulename + "</td>" +
                                            "<td><input type='hidden' value='" + data.d[i].actionID + "'><span>" + data.d[i].actionname + "</span></td>" +
                                            "<td>" + data.d[i].apitype + "</td>" +
                                            "<td><span>" + data.d[i].smscontent + "</span></td>" +
                                            "<td><input class='editimage' type='image' style='height:15px;width:15px;border-width:0px;' alt='No Image' src='../images/edit.png' /></td>" +
                                            "<td><input type='checkbox' name='selST' class='apiactivedeactive' " + dis + "  " + data.d[i].smssendstatus + "></td></tr>";
                                        $('#headwithbranch').append(tbl);
                                        if (data.d[i].Fullaction.length > 25) {
                                            var k = i + 1;
                                            $('#headwithbranch').find('tr:eq(' + k + ')').find('td:eq(2)').find('span').attr("data-tooltip", data.d[i].Fullaction);
                                        }
                                        if (data.d[i].fullcontent.length > 20) {
                                            var k = i + 1;
                                            $('#headwithbranch').find('tr:eq(' + k + ')').find('td:eq(4)').find('span').attr("data-tooltip", data.d[i].fullcontent);
                                        }
                                    }
                                    else {
                                        tbl = "<tr><td><input type='hidden' value='" + data.d[i].actionID + "'><span>" + data.d[i].actionname + "</span></td>" +
                                            "<td>" + data.d[i].apitype + "</td>" +
                                            "<td><span>" + data.d[i].smscontent + "</span></td>" +
                                            "<td><input class='editimage' type='image' style='height:15px;width:15px;border-width:0px;' alt='No Image' src='../images/edit.png' /></td>" +
                                            "<td><input type='checkbox' name='selST' class='apiactivedeactive' " + dis + "  " + data.d[i].smssendstatus + "></td></tr>";
                                        $('#headwithbranch').append(tbl);
                                        if (data.d[i].Fullaction.length > 25) {
                                            var k = i + 1;
                                            $('#headwithbranch').find('tr:eq(' + k + ')').find('td:eq(0)').find('span').attr("data-tooltip", data.d[i].Fullaction);
                                        }
                                        if (data.d[i].fullcontent.length > 20) {
                                            var k = i + 1;
                                            $('#headwithbranch').find('tr:eq(' + k + ')').find('td:eq(2)').find('span').attr("data-tooltip", data.d[i].fullcontent);
                                        }
                                    }
                                    i++;
                                }
                                i = i - 1;
                            }
                        }
                        call_progressbar("end");
                    }
                });
                return false;
            });
            //when we select api type
            $("input:radio[name=smsapi]").live('change', function () {
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
                    apistatus = 1
                }
                else if (apitype == 2) {
                    apistatus = 2
                }
            });
            $("input:radio[name=smsstuandparents]").live('change', function () {
                sms_send_to = $(this).val();
                return false;
            });
            //when msg on/off button click
            $('.apiactivedeactive').live("change", function () {
                actionid = $(this).closest('tr').find('input[type=hidden]').val();
                if ($(this).prop('checked')) {
                    checked = 1;
                }
                else {
                    checked = 0;
                }
                updatesmsPermission();
                return false;
            })
            $('#Buttoninputapi').live('click', function () {
                var iscallsave = 0;
                if ($('.smsapi').val() == "" && $('.smsproapi').val() == "") {
                    alertify.error("Nothing For Save/Update.")
                }
                if ($('.smsapi').val() != "") {
                    if ($('.smsapi').val().indexOf('1111111111') > -1 && $('.smsapi').val().indexOf('Dummy Text') > -1) {
                        iscallsave = 1;
                        if ($(".apiactivedeactive").is(":checked")) {
                            checkapi($('.smsapi').val(), '1');
                        }
                        else {
                            istransactinalapiworking = 1;
                        }
                        if (parseInt(istransactinalapiworking) == 0) {
                            alertify.error("Transactional API Not Working.So It Will Not Save/Update");
                        }
                    }
                    else {
                        iscallsave = 0;
                        alertify.error("Enter The Transactional API In Proper Format.According To The Given Below NOTE.");
                        return false;
                    }
                    call_progressbar('end');
                }
                //if ($('.smsproapi').val() != "") {
                //    if ($('.smsproapi').val().indexOf('1111111111') > -1 && $('.smsproapi').val().indexOf('Dummy Text') > -1) {
                //        iscallsave = 1;
                //        if ($(".proapiactivedeactive").is(":checked")) {
                //            checkapi($('.smsproapi').val(), '2');
                //        }
                //        else {
                //            ispromotionalapiworking = 1;
                //        }
                //        if (parseInt(ispromotionalapiworking) == 0) {
                //            alertify.error("Promotional API Not Working.So It Will Not Save/Update");
                //        }
                //    }
                //    else {
                //        iscallsave = 0;
                //        alertify.error("Enter The Promotional API In Proper Format.According To The Given Below NOTE.");
                //        return false;
                //    }
                //    call_progressbar('end');
                //}
                //if (iscallsave == 1 && (parseInt(ispromotionalapiworking) != 0 && parseInt(istransactinalapiworking) != 0)) {
                //    Save();
                //}
                ispromotionalapiworking = 1;
                if (iscallsave == 1 && (parseInt(ispromotionalapiworking) != 0 && parseInt(istransactinalapiworking) != 0)) {
                    Save();
                }
                return false;
            });
            GetSmsApi();
        });
        function Save() {
            smsapi = '', status = '2', prosmsapi = '', proactive = '2';
            if (parseInt(istransactinalapiworking) == 1) {
                smsapi = $(".smsapi").val();
                smsapi = smsapi.replace("1111111111", "~");
                smsapi = smsapi.replace("Dummy Text", "~");
                var status = $(".tranapiactivedeactive").is(":checked");
                if (status == true) {
                    status = 1
                }
                else {
                    status = 0
                }
            }
            //if (parseInt(ispromotionalapiworking) == 1) {
            //    prosmsapi = $(".smsproapi").val();
            //    prosmsapi = prosmsapi.replace("1111111111", "~");
            //    prosmsapi = prosmsapi.replace("Dummy Text", "~");
            //    var proactive = $(".proapiactivedeactive").is(":checked");
            //    if (proactive == true) {
            //        proactive = 1
            //    }
            //    else {
            //        proactive = 0
            //    }
            //}
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms_setting_branchWise.aspx/updatesmsapi",
                data: "{'smsapi':'" + smsapi + "','active':'" + status + "','proapi':'" + prosmsapi + "','proactive':'" + proactive + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != 0) {
                        alertify.success("Sms API Updated Successfully.");
                    }
                    else {
                        alertify.success("Some Error Occur While API Is Updating.");
                    }
                    call_progressbar('end');
                },
                error: function (response) {
                    call_progressbar('end');
                }
            });
            return false;
        }
        function GetSmsApi() {
            call_progressbar('start')
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms_setting_branchWise.aspx/getsmsapi",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (parseInt(data.d[i].api_type) == 1) {
                                smsapi = data.d[i].smsapi;
                                smsapi = smsapi.replace("~", "1111111111");
                                smsapi = smsapi.replace("~", "Dummy Text");
                                $('.smsapi').val(smsapi);
                                if (parseInt(data.d[i].status) == 1)
                                    $('.tranapiactivedeactive').prop('checked', true);
                                else
                                    $('.tranapiactivedeactive').prop('checked', false);

                            }
                            if (parseInt(data.d[i].api_type) == 2) {
                                prosmsapi = data.d[i].smsapi;
                                prosmsapi = prosmsapi.replace("~", "1111111111");
                                prosmsapi = prosmsapi.replace("~", "Dummy Text");
                                $('.smsproapi').val(prosmsapi);
                                if (parseInt(data.d[i].status) == 1)
                                    $('.proapiactivedeactive').prop('checked', true);
                                else
                                    $('.proapiactivedeactive').prop('checked', false);
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
        function checkapi(api, type) {
            call_progressbar('start');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "sms-settings.aspx/sendsmsonmobile",
                data: "{'api':'" + api + "','type':'" + type + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (parseInt(type) == 1) {
                        istransactinalapiworking = data.d;
                    }
                    else {
                        ispromotionalapiworking = data.d;
                    }
                    return false;
                }
            });
        }
        function updatesmsPermission() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "sms-settings.aspx/checkApiStatus",
                data: "{'actionID':'" + actionid + "','sts':'" + checked + "'}",
                dataType: "json",
                success: function () {
                    call_progressbar("end");
                    alert("Status Update Sucessfully.");
                }
            });
            return false;
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
    </script>
</asp:Content>

