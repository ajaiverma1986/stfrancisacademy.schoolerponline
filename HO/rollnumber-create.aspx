<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="rollnumber-create.aspx.cs" Inherits="HO_rollnumber_create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .for_sigle_row_form label {
            width: 220px;
        }
        .branchcode {
            -moz-appearance: none;
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            border-radius: 0;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 24px;
            line-height: 20px;
            outline: medium none;
            padding: 3px 6px;
            text-align: left;
            width: 150px;
        }
    </style>
    <script src="../../js/jquery.table2excel.js" type="text/javascript"></script>

    <div class="content_pane_cont input_content" id="contentPane">
        <div style="float: right; margin-right: 22px; margin-top: -5px;">
            <asp:Button ID="btnbatchcode" Visible="false" runat="server" Text="Batch Code" ToolTip="Click here to create batch code" CssClass="button_save" />
        </div>

        <div align="center" class="input_content" style="border: none; padding: 0px; margin-top: 0px;" id="divforrollnumber" runat="server">
            <div class="cheadline1" style="width: 100%; margin-left: 0px">
                <span style="float: left" class="spanheading">Setting Roll No. Pattern</span>
            </div>
            <div class="clear"></div>
            <table style="width: 100%" class="maintrforrollnumberadd">
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Roll No. Initials<span style="color: #ff0066"></span></label>
                            <input class="inputrollnumber" type="text" placeholder="Ex: AWS" style="width: 237px" />
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Financial Year<span style="color: #ff0066"></span></label>
                            <input class="inputfinicialyear" disabled="disabled" type="text" placeholder="Ex: 15-16" style="width: 237px" />
                            <input class="inputdateactivedeactive" type="checkbox" />
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Number of Digit in Roll No.<span style="color: #ff0066">*</span></label>
                            <input class="inputdigit" type="text" placeholder="Ex: 5" onkeypress="return noAlphabets(event)" style="width: 237px" />
                        </div>

                        <div style="background: #000000">
                            <div style="padding: 12px 0 0; height: auto; margin-left: 165px">
                                <label>Roll No. Pattern</label>
                                <label style="margin-left: 20px; width: 66px;">Universal</label><input type="radio" name="rntype" value="1" checked="checked" />
                                <label style="margin-left: 20px; width: 80px">Branch Wise</label><input type="radio" name="rntype" value="2" style="margin-left: 10px" />
                            </div>

                            <div id="rns" style="padding: 12px 0 0; height: auto; margin-left: 165px">
                                <label>Roll No. Sequence</label>
                                <label style="margin-left: 14px; width: 66px;">Universal</label><input type="radio" name="serialtype" value="1" checked="checked" />
                                <label style="margin-left: 20px; width: 80px">Branch Wise</label><input type="radio" name="serialtype" value="2" style="margin-left: 10px" />
                                <div class="df0" style="left: 480px;">
                                    <div class="df">
                                        <ul>
                                            <li>
                                                <img src="../images/questionmark.png" style="margin-left: -178px; margin-top: -47px;" />
                                                <ul>
                                                    <li>Roll No. Pattern and Sequence You can set only one time.</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div style="padding: 12px 0 0;" id="rollnumberview">
                            <span style="margin-left: 169px;">Preview:</span><label style="font-size: 15px; margin-left: 23px; font-weight: bold"></label>
                        </div>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <table id="getbranchlist" class="stm" style="width: 100%">
                <tr class="stm_head">
                    <th scope="col" style="width: 10px">S.No.</th>
                    <th scope="col" style="width: 73px">Branch Name (Admin Username)</th>
                    <th scope="col" style="width: 73px; display: none">Branch Code</th>
                    <th scope="col" style="width: 50px;">Branch Code</th>
                    <th scope="col" style="width: 50px; display: none">Financial Year</th>
                    <th scope="col" style="width: 90px; display: none">No. of Digit in Roll No.</th>
                    <th scope="col" style="width: 70px;">Preview</th>
                </tr>
            </table>
            <table style="width: 100%">
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label></label>
                            <input type="submit" class="button_save inputsubmitrollnumbaer" value="Update" />
                            <input type="submit" class="button2" value="Cancel" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div id="divProgressBar" class="progress"></div>
    </div>
    <script src="../../js/jquery-1.8.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        var digits = "", digits1 = "", brdigits = "", brcodebeforeupdate = "",
            status = 0, date = "", month, year, academinyear = "";
        $(document).ready(function () {
            $('#rollnumberview').hide()
            $("#ctl00_ContentPlaceHolder1_divforbatchcode").hide(500);
            date = new Date();
            month = date.getMonth()
            year = date.getFullYear() % 100;
            date = month + '' + year;
            academinyear = year + '-' + (year + 1);
            getrollnumber()
            createdigit();
            showrollnumber();

            //create roll number and validation for that
            $('.inputsubmitrollnumbaer').live('click', function () {
                status = 0;
                if ($(".inputdigit").val() == "") {
                    alertify.error('Please Enter Digit');
                    status = 1
                    return false;
                }
                if (parseInt(status) == 0) {
                    var roallnumins = $(".inputrollnumber").val()
                    var digit = $(".inputdigit").val()
                    var date = $(".inputdateactivedeactive").parent("div").find("input[type=checkbox]").is(":checked");
                    if (date == true) {
                        date = 1
                    }
                    else {
                        date = 0
                    }
                    if ($("input:radio[name=rntype]:checked").val() == 1) {
                        Save();
                        addrollnumberbranchwise(1);
                    }
                    else {
                        addrollnumberbranchwise(0);
                        return false;
                    }
                    getrollnumber()
                    getbranchnames()

                }
                return false;
            });
            $('.inputsubmitrollnumbaer1').live('click', function () {
                status = 0;
                if ($(".inputrollnumber1").val() == "") {
                    alertify.error('Please Enter RollNumber');
                    status = 1
                    return false;
                }
                if ($(".inputdigit1").val() == "") {
                    alertify.error('Please Enter Digit');
                    status = 1
                    return false;
                }
                if (parseInt(status) == 0) {
                    var roallnumins = $(".inputrollnumber1").val()
                    var digit = $(".inputdigit1").val()
                    var date = $(".inputdateactivedeactive1").parent("div").find("input[type=checkbox]").is(":checked");
                    if (date == true) {
                        date = 1
                    }
                    else {
                        date = 0
                    }
                    var brid = $(".inputbranchactivedeactive1").parent("div").find("input[type=checkbox]").is(":checked");
                    if (brid == true) {
                        brid = 1
                    }
                    else {
                        brid = 0
                    }
                    Save_Batchcode();
                }
                return false;
            });
            $("input:radio[name=rntype]").change(function () {

                if ($(this).val() == 1) {
                    $('#getbranchlist').hide();
                    $('.preview').html($('#rollnumberview').find('label').html()).attr('disabled', true);
                    $('.actdeactdate').attr('disabled', true);
                    if ($('.inputdateactivedeactive').parent('div').find('input[type=checkbox]').is(":checked") == true) {
                        $('.actdeactdate').attr('checked', true);
                    }
                    else {
                        $('.actdeactdate').attr('checked', false);
                    }
                    getnewrollnumberbranchwise()
                    $('#rns').hide();
                    $("input:radio[name=serialtype]:eq(0)").attr('checked', true);
                }
                else {
                    $('#rns').show();
                    $('#getbranchlist').show();
                    getbranchnames();
                    getnewrollnumberbranchwise();
                    //getnewrollnumberbranchwise()
                }
            })
            $('.inputrollnumber').blur(function () {
                if ($(this).val() == "") {
                    alertify.error('You did not enter anything for initials');
                }
                createdigit()
                showrollnumber()
                getnewrollnumberbranchwise()

            })
            $('.inputdigit').blur(function () {
                var val = $(this).val()
                createdigit()
                showrollnumber()
                getnewrollnumberbranchwise()

            })
            $('.inputdateactivedeactive').change(function () {
                createdigit()
                showrollnumber()

                if ($(this).is(":checked") == true) {
                    $('.inputfinicialyear').val(academinyear)
                    $('.finicialyear').val(academinyear)
                    $('.actdeactdate').parent('td').find('input[type=checkbox]').attr('checked', true);

                }
                else {
                    $('.inputfinicialyear').val('')
                    $('.finicialyear').val('')
                    $('.actdeactdate').parent('td').find('input[type=checkbox]').attr('checked', false);
                }

            })
            $('.branchcode').live("click", function () {
                brcodebeforeupdate = $(this).val()
            })
            $('.branchcode').blur(function () {
                var brcode = $(this).val()

                var index = $(this).parents('tr').index()
                if (brcodebeforeupdate != brcode) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "rollnumber-create.aspx/checkbrcode",
                        data: "{'brcode':'" + brcode + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d > 0) {
                                alertify.error('This Branch Code Already Exists');
                                $("#getbranchlist").find("tr:eq(" + index + ") td:eq(3)").find('input[type=text]').val(brcodebeforeupdate)
                                return false;
                            }
                            else {
                                createdigitforbranch(index)
                                showbranchrollnumber(index)
                            }
                        },
                        error: function (response) {
                        }
                    });
                    createdigitforbranch($(this).parents('tr').index())
                    showbranchrollnumber($(this).parents('tr').index())
                }

            })
            // Is finicial year added
            $('.actdeactdate').change(function () {
                if ($(this).is(":checked") == true) {

                    $(this).parents('tr').children('td:eq(4)').find('input').val(academinyear)
                }
                else {
                    $(this).parents('tr').children('td:eq(4)').find('input').val('')
                }
                createdigitforbranch($(this).parents('tr').index())
                showbranchrollnumber($(this).parents('tr').index())
            })
            //Number of digits in rollnumber
            $('.digit').blur(function () {
                createdigitforbranch($(this).parents('tr').index())
                showbranchrollnumber($(this).parents('tr').index())
            })

        });
        //get rollnumber branchwise
        function getnewrollnumberbranchwise() {
            call_progressbar('start')
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "rollnumber-create.aspx/getbranchwiserollnumberts",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 3 + ')').find('input[type=text]').val(data.d[i].initial)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 5 + ')').find('input[type=text]').val(data.d[i].noofdigits)
                            if (data.d[i].is_finicialyear == 1) {
                                $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=checkbox]').attr('checked', true)
                                $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=text]').val(academinyear)
                            }
                            else {
                                $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=checkbox]').attr('checked', false)
                                $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=text]').val('')
                            }
                            $('.digit').val($('.inputdigit').val())
                            call_progressbar('end')
                            createdigitforbranch((parseInt(i) + 1))
                            showbranchrollnumber((parseInt(i) + 1))
                        }
                    }
                    else {
                        call_progressbar('end');
                    }
                    $('.finicialyear').attr('disabled', false)
                    $('.digit').attr('disabled', false)
                    $('.actdeactdate').attr('disabled', false)

                },
                error: function (response) {
                }
            });
        }
        //save rollnumber from here
        function Save() {
            var roallnumins = $(".inputrollnumber").val()
            var digit = $(".inputdigit").val()
            var date = $(".inputdateactivedeactive").parent("div").find("input[type=checkbox]").is(":checked");
            if (date == true) {
                date = 1
            }
            else {
                date = 0
            }
            var rollnumbertype = $("input:radio[name=rntype]:checked").val()
            var serial = $("input:radio[name=serialtype]:checked").val()
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "rollnumber-create.aspx/updaterollnumber",
                data: "{'roallnumins':'" + roallnumins.split("'").join("~") + "','digit':'" + digit + "','date':'" + date + "','mode':'" + 4 + "','rollnumbertype':'" + rollnumbertype + "','serial':'" + serial + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        getrollnumber()
                        alertify.success("Pattern Updated Successfully")
                    }
                    else if (data.d == 2) {
                        getrollnumber()
                        alertify.error("You Can't update roll Pattern no because student is already added in this system.")
                    }
                },
                error: function (response) {
                }
            });
            return false;
        };
       
        //rollnumber from here
        function getrollnumber() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "rollnumber-create.aspx/getroollnumber",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    var roll = data.d.split("~")

                    $(".inputrollnumber").parent("div").find("input").val(roll[0])

                    $(".inputdigit").parent("div").find("input").val(roll[1])
                    $('.digit').val(roll[1])

                    if (roll[2] > 0) {
                        $(".inputdateactivedeactive").parent("div").find("input").attr('checked', true)
                        $(".actdeactdate").parent('td').find('input[type=checkbox]').attr('checked', true)
                        $('.inputfinicialyear').val(academinyear)
                        $('.finicialyear').val(academinyear)
                    }
                    else {
                        $(".inputdateactivedeactive").parent("div").find("input").attr('checked', false)
                        $(".actdeactdate").parent('td').find('input[type=checkbox]').attr('checked', false)
                        $('.finicialyear').val('')
                    }

                    if (roll[4] == 2) {
                        $("input:radio[name=rntype]:eq(1)").attr('checked', true)
                        $('#getbranchlist').show();
                        $('#rns').show();
                        getbranchnames();
                        getnewrollnumberbranchwise();
                        //return false

                    }
                    else {
                        $('#rns').hide();
                        $('#getbranchlist').hide();
                        $("input:radio[name=rntype]:eq(0)").attr('checked', true)
                    }

                    if (roll[5] == 2) {
                        $("input:radio[name=serialtype]:eq(1)").attr('checked', true)
                        return false
                    }
                    else {
                        $("input:radio[name=serialtype]:eq(0)").attr('checked', true)
                    }
                },
                error: function (response) {
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
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
        function createdigit() {
            digits = "";
            if ($('.inputdigit').val() > 0 && $('.inputdigit').val() < 8) {
                for (var i = 0; i < $('.inputdigit').val() - 1 ; i++) {
                    digits = digits + '0'
                }
            }
            else {
                alertify.error('Please Enter 1 Digit between 1-7')
                $('.inputdigit').val('')
                return false;
            }
            digits = digits + '1';
        }
        function showrollnumber() {

            $(".inputsubmitrollnumbaer").show(500)
            $("#rollnumberview").show(500);

            if ($(".inputdateactivedeactive").is(":checked") == true) {
                $("#rollnumberview").find("label").html($(".inputrollnumber").val() + '/' + academinyear + '/' + digits)
                status = 1
                $('.preview').html(($("#rollnumberview").find("label").html()))
                return false;
            }

            if ($(".inputdateactivedeactive").is(":checked") == false) {
                $("#rollnumberview").find("label").html($(".inputrollnumber").val() + '/' + digits)
                status = 1
                $('.preview').html(($("#rollnumberview").find("label").html()))
                return false;
            }
        }
        function getbranchnames() {
            var trforappend = "";
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "rollnumber-create.aspx/getbranchnames",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        {
                            for (var i = 0; i < data.d.length; i++) {
                                if (i % 2 != 0)
                                    trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].brname + ' (' + data.d[i].brcode + ')<input type="hidden" value=' + data.d[i].brid + '></td><td style="display:none"> ' + data.d[i].brcode + '</td><td><input type=text  maxlength=8 placeholder="EX:AWS" class="branchcode"  /><input type=text style="width:70px; height:20px; display:none" maxlength=8 placeholder="EX:AWS" class="inhials" disabled /></td ><td style="display:none"><input type=text style="width:70px; height:20px" class="finicialyear" placeholder="Ex: 15-16" disabled /><input class="actdeactdate" type="checkbox" disabled style="margin-left:3px;"></td><td style="display:none"><input type=text style="width:70px; height:20px" onkeypress="return noAlphabets(event)" class="digit" maxlength=5 placeholder="EX: 4" disabled /></td><td><span class="preview" /></td></tr>';
                                else
                                    trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].brname + ' (' + data.d[i].brcode + ')<input type="hidden" value=' + data.d[i].brid + '></td><td style="display:none"> ' + data.d[i].brcode + '</td><td><input type=text   maxlength=8 placeholder="EX:AWS" class="branchcode"  /><input type=text style="width:70px; height:20px; display:none" maxlength=8 placeholder="EX:AWS"  class="inhials" disabled /></td><td style="display:none"><input type=text style="width:70px; height:20px" class="finicialyear" placeholder="Ex: 15-16" disabled /><input class="actdeactdate" type="checkbox" disabled style="margin-left:3px;"></td><td style="display:none"><input type=text style="width:70px; height:20px" class="digit" onkeypress="return noAlphabets(event)" maxlength=5 placeholder="EX: 4" disabled /></td><td><span class="preview" /></td></tr>';
                                $('.stm').append(trforappend);
                                createdigitforbranch((parseInt(i) + 1))
                                showbranchrollnumber((parseInt(i) + 1))
                            }
                        }
                    }
                    getnewrollnumberbranchwise()

                },
                error: function (response) {
                }
            });
        }
        //Branch Wise Rollnumber Start from here
        function addrollnumberbranchwise(issave) {

            var brid = "";
            var inhial = "";
            var isfinicialyear = "";
            var noofdigit = "";
            var brcode = "";
            var rollnumbertype = $("input:radio[name=rntype]:checked").val()
            var serialtype = $("input:radio[name=serialtype]:checked").val()
            $('#getbranchlist tr:gt(0)').each(function () {
                brid = brid + ',' + $(this).find('input[type="hidden"]').val();
                inhial = inhial + ',' + $('.inputrollnumber').val();
                brcode = brcode + ',' + $(this).find('td:eq(3)').find('input').val();
                noofdigit = noofdigit + ',' + $(this).find('td:eq(5)').find('input').val();
                if ($(this).find('td:eq(4)').find('input[type="checkbox"]').is(":checked") == true) {
                    isfinicialyear = isfinicialyear + ', 1'
                }
                else {
                    isfinicialyear = isfinicialyear + ', 0'
                }
            })
            brid = brid.substring(1, brid.length);
            inhial = inhial.substring(1, inhial.length);
            noofdigit = noofdigit.substring(1, noofdigit.length);
            isfinicialyear = isfinicialyear.substring(1, isfinicialyear.length)
            brcode = brcode.substring(1, brcode.length);
            if (brid != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "rollnumber-create.aspx/updatebranchrollnumber",
                    data: "{'brid':'" + brid + "','inhial':'" + inhial.split("'").join("~") + "','noofdigit':'" + noofdigit + "','isfinicialyear':'" + isfinicialyear + "','brcode':'" + brcode + "','rollnumbertype':'" + rollnumbertype + "','serialtype':'" + serialtype + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d == 3) {
                            alertify.error("You Can't update roll Pattern no because student is already added in this system.")
                        }
                        else {
                            if (issave == 0) {
                                alertify.success('Rollnumber Pattern updated Successfully')
                            }
                            getrollnumber()
                            getbranchnames()
                        }
                    },
                    error: function (response) {
                    }
                });
            }
            return false
        }
        function showbranchrollnumber(tr) {
            call_progressbar('start')

            var inhial = $(".inputrollnumber").val()
            var chkstatus = $("#getbranchlist").find("tr:eq(" + tr + ") td:eq(4)").find('input[type=checkbox]').is(":checked")
            var brcode = $("#getbranchlist").find("tr:eq(" + tr + ") td:eq(3)").find('input[type=text]').val()

            if (inhial !== "") {
                inhial = inhial + '/'
            }
            if (chkstatus == true) {
                $("#getbranchlist").find("tr:eq(" + tr + ") td:eq(6)").find('span').html(inhial + '' + academinyear + '' + brdigits)
            }
            else {
                $("#getbranchlist").find("tr:eq(" + tr + ") td:eq(6)").find('span').html(inhial + '' + brdigits)
            }
            call_progressbar('end')
        }
        function createdigitforbranch(tr) {
            call_progressbar('start')
            brdigits = "";
            if ($("#getbranchlist").find("tr:eq(" + tr + ") td:eq(5)").find('input').val() != "") {
                var totaldigit = $("#getbranchlist").find("tr:eq(" + tr + ") td:eq(5)").find('input').val()
                var brcode = $("#getbranchlist").find("tr:eq(" + tr + ") td:eq(3)").find('input[type=text]').val()
                brdigits = brdigits + '' + brcode
                if (totaldigit > 0 && totaldigit < 8) {
                    for (var i = 0; i < totaldigit - 1 ; i++) {
                        brdigits = brdigits + '0'
                    }
                }
                else {
                    $("#getbranchlist").find("tr:eq(" + tr + ") td:eq(5)").find('input').val('')
                    return false;
                }
                var chkstatus = $("#getbranchlist").find("tr:eq(" + tr + ") td:eq(4)").find('input[type=checkbox]').is(":checked")
                if (chkstatus == true) {
                    brdigits = '/' + brdigits + '1';
                }
                else {
                    brdigits = brdigits + '1';
                }
            }
            call_progressbar('end')
        }
    </script>
</asp:Content>