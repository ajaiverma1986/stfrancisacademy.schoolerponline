<%@ Page Title="Student Fee Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="studentfees.aspx.cs" Inherits="BranchPanel_studentfees" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../js/1.8-jquery-ui.min.js"></script>
    <style>
        .active7 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .stm_head {
            background: none repeat scroll 0 0 #bebebe;
            border-bottom: 1px solid #0d6b7e;
            border-top: 1px solid #0d6b7e;
            color: #3a3a3a !important;
            font-weight: bold;
            line-height: 36px;
            padding-left: 10px;
        }

        body {
            font: 70% Arial, Helvetica, sans-serif;
            color: #063774;
        }

        table {
            border: 2px #2CA8C2 solid;
            border-collapse: collapse;
        }

        th {
            padding: 10px 18px;
            text-align: left;
        }

        td {
            padding: 10px 18px;
        }

        .cscfeepay {
            outline: 0;
            height: 25px;
            width: 275px;
        }

        /*.stm td {
    border-bottom: 1px solid #DDDDDD;
    color: #333333;
    line-height: 35px;
    padding-left: 0;
    padding-right: 29px;
}*/
    </style>

    <script type="text/javascript">
        $(document).ready(function () {

            var ddlzone = "";
            var ddlarea = "";
            var ddlbus = "";
            var ddlstopage = "", transmode = "transportnottaken";
            var montname = "", totalamt = 0, montname2 = "", feename2 = "", amt = 0, totalamt = 0, newamt = 0, money = 0, feename = "";
            $('.grid_remove').click(function () {
                var id;
                id = $(this).closest("td").find("[id*=lblrid]").text();
                window.location.replace("studentpayfee.aspx?adid=" + id);
                return false;

            });
            var monthname = "", montname2 = "", feename = "", feename2, money = "", amt = 0, newamt = 0, totalamt = 0, newtotal = 0, count = 1;
            $(".ops").live('click', function () {
                var trfee = "", devfee = "", tufee = "", allfee = "";

                if (count == 1) {
                    totalamt = parseFloat($("#ctl00_ctl00_ContentPlaceHolder1_txtpayablefee").val());
                    count = parseInt(count) + 1;
                }
                if ($(this).is(':checked')) {
                    monthname = $(this).closest('tr').find('td:eq(1) span:first-child').text();

                    //alert($(this).closest('tr').find('td:eq(1) span:first-child').text());

                    $("#grdfeestructure tr:has(td)").each(function () {
                        $(this).closest('tr').find('td:contains(' + monthname + ')').css("background-color", "#ffe8a1");

                        monthname2 = $(this).closest('tr').find('td:eq(0) span:first-child').text();
                        feename2 = $(this).closest('tr').find('td:eq(1) span:first-child').text();

                        if (monthname == monthname2) {
                            //alert($(this).closest('tr').find('td:eq(1)').text());
                            money = $(this).closest('tr').find('td:eq(2) span:first-child').text();
                            $("#grdpay tr:has(td)").each(function () {
                                feename = $(this).closest('tr').find('td:eq(0) span:first-child').text();

                                if (feename2 == "Quarterly-Development Charges" && feename == "Development Charges") {
                                    //$("#showfeeheads").text('Development Charges');
                                    amt = $(this).closest('tr').find('td:eq(1) input').val();

                                    newamt = parseFloat(money) + parseFloat(amt);
                                    totalamt = parseFloat(money) + parseFloat(totalamt);

                                    //$("#ctl00_ctl00_ContentPlaceHolder1_txtpayablefee").val(newamt);
                                    $(this).closest('tr').find('td:eq(1) input').val(newamt);
                                    if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                        $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                                    }
                                    $(this).closest('tr').find('td:eq(1) input').css("background-color", "#ffe8a1");
                                }

                                else if (feename2 == "Monthly-Tution Fee" && feename == "Tution Fee") {
                                    $("#showfeeheads").text('Tution Fee');
                                    amt = $(this).closest('tr').find('td:eq(1) input').val();
                                    newamt = parseFloat(money) + parseFloat(amt);

                                    totalamt = parseFloat(money) + parseFloat(totalamt);

                                    $(this).closest('tr').find('td:eq(1) input').val(newamt);
                                    $(this).closest('tr').find('td:eq(1) input').css("background-color", "#ffe8a1");
                                    if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                        $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                                    }
                                }
                                else if (feename2 == "Monthly-Transport Fee" && feename == "Transport Fee") {
                                    $("#showfeeheads").text('Transport Fee');
                                    amt = $(this).closest('tr').find('td:eq(1) input').val();
                                    newamt = parseFloat(amt) + parseFloat(money);
                                    totalamt = parseFloat(money) + parseFloat(totalamt);

                                    $(this).closest('tr').find('td:eq(1) input').val(newamt);
                                    if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                        $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                                    }
                                    $(this).closest('tr').find('td:eq(1) input').css("background-color", "#ffe8a1");
                                }

                                else if (feename2 == "Half Yearly-Examination Fee" && feename == "Examination Fee") {
                                    amt = $(this).closest('tr').find('td:eq(1) input').val();
                                    newamt = parseFloat(amt) + parseFloat(money);
                                    totalamt = parseFloat(money) + parseFloat(totalamt);

                                    $(this).closest('tr').find('td:eq(1) input').val(newamt);
                                    if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                        $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                                    }
                                    $(this).closest('tr').find('td:eq(1) input').css("background-color", "#ffe8a1");
                                }
                            });
                        }
                    });
                    //totalamt = parseFloat(totalamt) + parseFloat($("#sp1").html());
                    $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamt);
                    $('#grdfeestructure').css("display", "block");
                    count = 1;
                }
                else {
                    monthname = $(this).closest('tr').find('td:eq(1) span:first-child').text();
                    // alert(monthname);
                    //alert($(this).closest('tr').find('td:eq(1) span:first-child').text());
                    //$('#divfeestructure').css("display", "n");
                    $("#grdfeestructure tr:has(td)").each(function () {
                        $(this).closest('tr').find('td:contains(' + monthname + ')').css("background-color", "white");

                        monthname2 = $(this).closest('tr').find('td:eq(0) span:first-child').text();
                        feename2 = $(this).closest('tr').find('td:eq(1) span:first-child').text();

                        if (monthname == monthname2) {
                            //alert($(this).closest('tr').find('td:eq(2)').text());
                            money = $(this).closest('tr').find('td:eq(2) span:first-child').text();

                            $("#grdpay tr:has(td)").each(function () {
                                feename = $(this).closest('tr').find('td:eq(0) span:first-child').text();

                                if (feename2 == "Quarterly-Development Charges" && feename == "Development Charges") {
                                    amt = $(this).closest('tr').find('td:eq(1) input').val();

                                    newamt = parseFloat(amt) - parseFloat(money);
                                    totalamt = parseFloat(totalamt) - parseFloat(money);
                                    $(this).closest('tr').find('td:eq(1) input').val(newamt);
                                    $(this).closest('tr').find('td:eq(1) input').css("background-color", "none");
                                    if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                        $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                                    }
                                }

                                else if (feename2 == "Monthly-Tution Fee" && feename == "Tution Fee") {
                                    amt = $(this).closest('tr').find('td:eq(1) input').val();

                                    newamt = parseFloat(amt) - parseFloat(money);
                                    // alert(totalamt);
                                    totalamt = parseFloat(totalamt) - parseFloat(money);

                                    $(this).closest('tr').find('td:eq(1) input').val(newamt);
                                    $(this).closest('tr').find('td:eq(1) input').css("background-color", "none");
                                    if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                        $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                                    }
                                }

                                else if (feename2 == "Monthly-Transport Fee" && feename == "Transport Fee") {
                                    amt = $(this).closest('tr').find('td:eq(1) input').val();
                                    newamt = parseFloat(amt) - parseFloat(money);
                                    totalamt = parseFloat(totalamt) - parseFloat(money);
                                    $(this).closest('tr').find('td:eq(1) input').val(newamt);
                                    $(this).closest('tr').find('td:eq(1) input').css("background-color", "none");
                                    if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                        $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                                    }
                                }

                                else if (feename2 == "Half Yearly-Examination Fee" && feename == "Examination Fee") {
                                    amt = $(this).closest('tr').find('td:eq(1) input').val();
                                    newamt = parseFloat(amt) - parseFloat(money);
                                    totalamt = parseFloat(totalamt) - parseFloat(money);
                                    $(this).closest('tr').find('td:eq(1) input').val(newamt);
                                    $(this).closest('tr').find('td:eq(1) input').css("background-color", "none");
                                    if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                        $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                                    }
                                }
                            });
                        }
                    });

                    $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamt);
                    $('#grdfeestructure').css("display", "block");
                    count = 1;
                }
            });
            $("#ctl00_ContentPlaceHolder1_ddlMonth").change(function () {
                var totalamoutfeeheds1 = 0, t1newamt1 = 0, feebyamt1 = 0, perheadfee1 = 0;
                var mid = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;
                var discode = $("#ctl00_ContentPlaceHolder1_txtdiscountcode").val();
                $('#Container').html("");
                $('#payfeebind').html("");
                $('#divfeestructure').html("");
                $("#ctl00_ContentPlaceHolder1_ddlMonth").css("border", "1px solid #cccccc");
                //$("#ctl00_ctl00_ContentPlaceHolder1_ddlDate").prop('disabled', false);

                $.ajax({
                    type: "POST",
                    url: "admission-form.asmx/monthdays",
                    data: "{'mid':'" + mid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $('#ctl00_ContentPlaceHolder1_ddlDate').children('option:not(:first)').remove();
                        // $("#ctl00_ctl00_ContentPlaceHolder1_ddlDate").html("");
                        for (var i = 1; i <= data.d; i++) {

                            if (i < 10) {
                                $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option></option>").val(i).html("0" + i.toString()));
                            }
                            else
                                $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option></option>").val(i).html(i));
                            // $("#ctl00_ctl00_ContentPlaceHolder1_ddlDate").append($("<option />").text(i));
                        }
                    }
                });

                var transportvalue = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
                var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;
                var monthid = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;
                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                if (monthid == 0) {
                    $('#Container').html("");
                    $('#payfeebind').html("");
                    $('#divfeestructure').html("");
                }

                var clasname = "";
                var clasid1 = "";

                var fname1 = "";

                var smname1 = "";
                var slname1 = "";
                var sdob1 = "1900-01-01 00:00:00.000";

                var sfname1 = "";
                var sfmname1 = "";
                var sflname1 = "";
                var smfname1 = "";
                var smmname1 = "";
                var smlname1 = "";

                var contactno = "";

                if (sid != 0 && monthid != 0) {
                    $('#grdfeestructure').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                    setTimeout(function () {
                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/getfeeheads",
                            data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table id="grdpay" class="stm"><thead class="stm_head"><tr><th>Fee Name</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';

                                    row += '<td><span class="csspayfee1">' + data.d[i].feename + '</span>:</td>';

                                    ////if (data.d[i].feename == "Album" || data.d[i].feename == "Annual Charges" || data.d[i].feename == "Students Kit" || data.d[i].feename == "Admission Fee" || data.d[i].feename == "Examination Fee" ) {
                                    totalamoutfeeheds1 = parseFloat(totalamoutfeeheds1) + parseFloat(data.d[i].fees);
                                    //    $("#ctl00_ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds1);
                                    //    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees).toFixed(2) + '"></td>';
                                    //}
                                    //else {
                                    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees) + '"></td>';
                                    //}

                                    row += '</tr><br />';

                                    table += row;
                                }

                                table += '</tbody></table>';

                                $('#Container').html(table);
                            }
                        });

                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/getmonthwithfee",
                            data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table id="gridviewpay" width="100%" class="stm"><thead class="stm_head"><tr><th></th><th>Month</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';
                                    row += '<td><span class="csspayfee"><input type="checkbox"  id="chkclass1" class="ops" ></span></td>';
                                    //row += '<td>' + data.d[i].month + '<span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    if ((data.d[i].month).length > 20) {
                                        row += '<td width="50%"><span title=' + (data.d[i].month) + ' class="monthname" style="display:block;">' + (data.d[i].month).substring(0, 20) + "..." + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    else {
                                        row += '<td width="50%"><span  class="monthname" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }

                                    row += '<td>' + data.d[i].fees + '</td>';

                                    row += '</tr>';

                                    table += row;
                                }

                                table += '</tbody>  </table>';

                                $('#payfeebind').html(table);
                                $("#gridviewpay tr:first-child td span input:first").attr("checked", "checked");
                            }
                        });

                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/Bindfeestructure",
                            data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table width="50%" style="margin-top:40px" id="grdfeestructure"  class="stm"><thead class="stm_head" HorizontalAlign="Center"><tr><th>Month</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';
                                    //row += '<td><span class="monthname" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    //row += '<td>'  + data.d[i].month + '<span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';

                                    //row += '<td><span class="monthname1" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass1" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    if ((data.d[i].month).length > 20) {
                                        row += '<td><span class="monthname1" style="display:block;">' + (data.d[i].month).substring(0, 20) + "..." + '</span><span class="monthidclass1" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    else {
                                        row += '<td><span class="monthname1" style="display:block;">' + (data.d[i].month) + '</span><span class="monthidclass1" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }

                                    row += '<td><span class="abc">' + data.d[i].feename + '<span></td>';
                                    row += '<td><span class="fee">' + data.d[i].fees + '</span></td>';

                                    row += '</tr>';

                                    table += row;
                                }

                                table += '</tbody>  </table>';

                                $('#divfeestructure').html(table);
                                $("#gridviewpay tr:first-child td span input:first").attr("checked", "checked");
                                $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds1);
                                //$("#gridviewpay tr:first-child td span input:first").attr("checked", "checked");
                                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                                $('#grdfeestructure').css("display", "block");
                            }
                        });
                    }, 1000);
                }
                else {
                    $('#Container').html("");
                    $('#payfeebind').html("");
                    $('#divfeestructure').html("");
                }
            });

            $("#ctl00_ContentPlaceHolder1_ddl_Course").change(function (e) {
                $("#ctl00_ContentPlaceHolder1_txtClassSec").val('');
                $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(0);
                var discode = $("#ctl00_ContentPlaceHolder1_txtdiscountcode").val();
                var transportvalue = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
                var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;
                var monthid = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;
                var clasname = "";
                var clasid1 = "";

                var fname1 = "";

                var smname1 = "";
                var slname1 = "";
                var sdob1 = "1900-01-01 00:00:00.000";

                var sfname1 = "";
                var sfmname1 = "";
                var sflname1 = "";
                var smfname1 = "";
                var smmname1 = "";
                var smlname1 = "";

                var contactno = "";

                //if ($("#ctl00_ContentPlaceHolder1_txtRegNo").val() != "") {
                //    if (sid != clasid1) {
                //        $("#ctl00_ContentPlaceHolder1_ddl_Course").prop('selectedIndex', 0);
                //        $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                //        $("#ctl00_ContentPlaceHolder1_lbclmsg").css("display", "block");
                //        $("#ctl00_ContentPlaceHolder1_lbclmsg").text("Please Select Class " + clasname + "");
                //        return false;
                //    }
                //}
                $("#ctl00_ContentPlaceHolder1_lbclmsg").css("display", "none");

                if (sid != 0) {
                    var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "admission-form.asmx/bindsection",
                        data: "{'sid':'" + sid + "'}",
                        dataType: "json",
                        success: function (data) {
                            $("#ctl00_ContentPlaceHolder1_ddlssection").html("");
                            $.each(data.d, function (key, value) {
                                $("#ctl00_ContentPlaceHolder1_ddlssection").append($("<option></option>").val(value.SID).html(value.sectionname));
                            });
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                }
                var totalamoutfeeheds = 0;
                $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                setTimeout(function () {
                    if (sid != 0 && monthid != '--Month--') {
                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/getfeeheads",
                            data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table id="grdpay" class="stm"><thead class="stm_head"><tr><th>Fee Name</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';

                                    row += '<td><span class="csspayfee1">' + data.d[i].feename + '</span>:</td>';

                                    //if (data.d[i].feename == "Album" || data.d[i].feename == "Annual Charges" || data.d[i].feename == "Students Kit" || data.d[i].feename == "Admission Fee" || data.d[i].feename == "Examination Fee") {
                                    //if (monthid ==6) {
                                    //    if (data.d[i].feename == "Examination Fee") {
                                    //        totalamoutfeeheds = parseFloat(totalamoutfeeheds) + (parseFloat(data.d[i].fees) * 2);
                                    //    }
                                    //    else {
                                    //        totalamoutfeeheds = parseFloat(totalamoutfeeheds) + (parseFloat(data.d[i].fees) * 2);
                                    //    }
                                    //}
                                    //else {
                                    totalamoutfeeheds = parseFloat(totalamoutfeeheds) + parseFloat(data.d[i].fees);
                                    //}

                                    //    $("#ctl00_ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds);
                                    //    //alert(totalamoutfeeheds);
                                    //    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees).toFixed(2) + '"></td>';
                                    //}
                                    //else {
                                    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees) + '"></td>';
                                    //}

                                    row += '</tr><br />';

                                    table += row;
                                }

                                table += '</tbody></table>';

                                //alert($("#ctl00_ctl00_ContentPlaceHolder1_txtpayablefee").val());
                                //$('#sp1').html(totalamoutfeeheds);
                                $('#Container').html(table);
                            }
                        });

                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/getmonthwithfee",
                            data: "{'classid':'" + sid + "','transport':'" + parseInt(transportvalue) + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table id="gridviewpay" width="100%" class="stm"><thead class="stm_head"><tr><th></th><th>Month</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';
                                    row += '<td width="30%"><span class="csspayfee"><input type="checkbox"  id="chkclass1" class="ops"  ></span></td>';
                                    //row += '<td>' + data.d[i].month + '<span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    //row += '<td width="50%"><span  class="monthname" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';

                                    if ((data.d[i].month).length > 20) {
                                        row += '<td width="50%"><span title=' + (data.d[i].month) + ' class="monthname" style="display:block;">' + (data.d[i].month).substring(0, 20) + "..." + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    else {
                                        row += '<td width="50%"><span  class="monthname" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    row += '<td width="20%">' + data.d[i].fees + '</td>';

                                    row += '</tr>';

                                    table += row;
                                }

                                table += '</tbody>  </table>';

                                $('#payfeebind').html(table);
                                $("#gridviewpay tr:first-child td span input:first").attr("checked", "checked");
                                //alert($("#gridviewpay tr:first-child td:first").html());
                            }
                        });

                        var feebyamt = 0
                        var t1newamt = 0;
                        var perheadfee = 0;
                        //alert(t1newamt);
                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/Bindfeestructure",
                            data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table width="50%" style="margin-top:40px" id="grdfeestructure"  class="stm"><thead class="stm_head" HorizontalAlign="Center"><tr><th>Month</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';
                                    //row += '<td><span class="monthname" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    //row += '<td>'  + data.d[i].month + '<span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    if ((data.d[i].month).length > 20) {
                                        row += '<td><span class="monthname1" style="display:block;">' + (data.d[i].month).substring(0, 20) + "..." + '</span><span class="monthidclass1" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    else {
                                        row += '<td><span class="monthname1" style="display:block;">' + (data.d[i].month) + '</span><span class="monthidclass1" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    row += '<td><span class="abc">' + (data.d[i].feename) + '<span></td>';

                                    row += '<td><span class="fee">' + data.d[i].fees + '</span></td>';

                                    row += '</tr>';

                                    table += row;
                                }

                                table += '</tbody>  </table>';

                                $('#divfeestructure').html(table);

                                $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds);
                                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                //$('#grdfeestructure').css("display", "none");
                            }
                        });
                    }
                    else {
                        $('#Container').html("");
                        $('#payfeebind').html("");
                        $('#divfeestructure').html("");
                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                    }
                }, 1000);
            });
            $('[id*=rtransportation] input').unbind().click(function (e) {
                // $("#ctl00_ctl00_ContentPlaceHolder1_ddl_Course").html('');
                // $("#ctl00_ctl00_ContentPlaceHolder1_ddl_Course").prop("disabled", false);
                $('#Container').html("");
                $('#payfeebind').html("");
                $('#divfeestructure').html("");

                var discode = $("#ctl00_ContentPlaceHolder1_txtdiscountcode").val();
                var transportvalue = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
                var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;
                var monthid = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;
                var clasname = $("#ctl00_ContentPlaceHolder1_lbclssname").text();
                var clasid1 = $("#ctl00_ContentPlaceHolder1_lbclassname").text();

                var fname1 = $("#ctl00_ContentPlaceHolder1_txtName").val();

                var smname1 = $("#ctl00_ContentPlaceHolder1_txtmidname").val();
                var slname1 = $("#ctl00_ContentPlaceHolder1_txtLName").val();
                var sdob1 = $("#ctl00_ContentPlaceHolder1_txtToDate").val();

                var sfname1 = $("#ctl00_ContentPlaceHolder1_txtFname").val();
                var sfmname1 = $("#ctl00_ContentPlaceHolder1_txtmidname1").val();
                var sflname1 = $("#ctl00_ContentPlaceHolder1_txtlastname1").val();
                var smfname1 = $("#ctl00_ContentPlaceHolder1_txtmother").val();
                var smmname1 = $("#ctl00_ContentPlaceHolder1_txtmidname2").val();
                var smlname1 = $("#ctl00_ContentPlaceHolder1_txtlastname2").val();

                var contactno = $("#ctl00_ContentPlaceHolder1_txtmob").val();

                var ckseat = "";
                var areaid = "";
                var discode = $("#ctl00_ContentPlaceHolder1_txtdiscountcode").val();
                $("#ctl00_ContentPlaceHolder1_btn_later").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_button7").css("display", "block");

                if ($(this).val() == 1) {
                    $("#ctl00_ContentPlaceHolder1_DropDownList1").val('');
                    $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_DropDownList2").empty();
                    $("#ctl00_ContentPlaceHolder1_DropDownList3").empty();
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').empty();

                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                    $('#ctl00_ContentPlaceHolder1_popup2').css("display", "block");

                    $(this).closest('tr').find('td:eq(0)').removeAttr("border-style").removeAttr("border-color");
                    $('.maindivpopup').css("display", "block");
                } else {
                    // $("#ctl00_ctl00_ContentPlaceHolder1_DropDownList1").val(0);
                    $("#ctl00_ContentPlaceHolder1_DropDownList2").html('');
                    $("#ctl00_ContentPlaceHolder1_DropDownList3").html('');
                    $("#ctl00_ContentPlaceHolder1_DropDownList4").html('');
                    $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "none");
                    transmode = "transportnottaken";
                }

                var totalamoutfeeheds = 0;
                $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                setTimeout(function () {
                    if (sid != 0 && monthid != '--Month--') {
                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/getfeeheads",
                            data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table id="grdpay" class="stm"><thead class="stm_head"><tr><th>Fee Name</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';

                                    row += '<td><span class="csspayfee1">' + data.d[i].feename + '</span>:</td>';

                                    //if (data.d[i].feename == "Album" || data.d[i].feename == "Annual Charges" || data.d[i].feename == "Students Kit" || data.d[i].feename == "Admission Fee" || data.d[i].feename == "Examination Fee") {
                                    //if (monthid ==6) {
                                    //    if (data.d[i].feename == "Examination Fee") {
                                    //        totalamoutfeeheds = parseFloat(totalamoutfeeheds) + (parseFloat(data.d[i].fees) * 2);
                                    //    }
                                    //    else {
                                    //        totalamoutfeeheds = parseFloat(totalamoutfeeheds) + (parseFloat(data.d[i].fees) * 2);
                                    //    }
                                    //}
                                    //else {
                                    totalamoutfeeheds = parseFloat(totalamoutfeeheds) + parseFloat(data.d[i].fees);
                                    //}

                                    //    $("#ctl00_ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds);
                                    //    //alert(totalamoutfeeheds);
                                    //    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees).toFixed(2) + '"></td>';
                                    //}
                                    //else {
                                    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees) + '"></td>';
                                    //}

                                    row += '</tr><br />';

                                    table += row;
                                }

                                table += '</tbody></table>';

                                //alert($("#ctl00_ctl00_ContentPlaceHolder1_txtpayablefee").val());
                                //$('#sp1').html(totalamoutfeeheds);
                                $('#Container').html(table);
                            }
                        });

                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/getmonthwithfee",
                            data: "{'classid':'" + sid + "','transport':'" + parseInt(transportvalue) + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table id="gridviewpay" width="100%" class="stm"><thead class="stm_head"><tr><th></th><th>Month</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';
                                    row += '<td width="30%"><span class="csspayfee"><input type="checkbox"  id="chkclass1" class="ops"  ></span></td>';
                                    //row += '<td>' + data.d[i].month + '<span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    //row += '<td width="50%"><span  class="monthname" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';

                                    if ((data.d[i].month).length > 20) {
                                        row += '<td width="50%"><span title=' + (data.d[i].month) + ' class="monthname" style="display:block;">' + (data.d[i].month).substring(0, 20) + "..." + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    else {
                                        row += '<td width="50%"><span  class="monthname" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    row += '<td width="20%">' + data.d[i].fees + '</td>';

                                    row += '</tr>';

                                    table += row;
                                }

                                table += '</tbody>  </table>';

                                $('#payfeebind').html(table);
                                $("#gridviewpay tr:first-child td span input:first").attr("checked", "checked");
                                //alert($("#gridviewpay tr:first-child td:first").html());
                            }
                        });

                        var feebyamt = 0
                        var t1newamt = 0;
                        var perheadfee = 0;
                        //alert(t1newamt);
                        $.ajax({
                            type: "POST",
                            url: "admission-form.asmx/Bindfeestructure",
                            data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "','discountcode':'" + discode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var table = '<table width="50%" style="margin-top:40px" id="grdfeestructure"  class="stm"><thead class="stm_head" HorizontalAlign="Center"><tr><th>Month</th><th>Amount</th></thead><tbody>';

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = '<tr">';
                                    //row += '<td><span class="monthname" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    //row += '<td>'  + data.d[i].month + '<span class="monthidclass" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    if ((data.d[i].month).length > 20) {
                                        row += '<td><span class="monthname1" style="display:block;">' + (data.d[i].month).substring(0, 20) + "..." + '</span><span class="monthidclass1" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    else {
                                        row += '<td><span class="monthname1" style="display:block;">' + (data.d[i].month) + '</span><span class="monthidclass1" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                                    }
                                    row += '<td><span class="abc">' + (data.d[i].feename) + '<span></td>';

                                    row += '<td><span class="fee">' + data.d[i].fees + '</span></td>';

                                    row += '</tr>';

                                    table += row;
                                }

                                table += '</tbody>  </table>';

                                $('#divfeestructure').html(table);

                                $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds);
                                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                //$('#grdfeestructure').css("display", "none");
                            }
                        });
                    }
                    else {
                        $('#Container').html("");
                        $('#payfeebind').html("");
                        $('#divfeestructure').html("");
                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                    }
                }, 1000);

            });

            $("#ctl00_ContentPlaceHolder1_DropDownList1").change(function () {
                //alert("ashuuuu");
                var zid = document.getElementById("ctl00_ContentPlaceHolder1_DropDownList1").value;
                if (zid == "0") {
                    $('#ctl00_ContentPlaceHolder1_DropDownList2').children('option:not(:first)').remove();
                    return;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_DropDownList2').children().remove();
                    $('#ctl00_ContentPlaceHolder1_DropDownList3').children().remove();
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').children().remove();
                    $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "none");
                }

                $.ajax(
                      {
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          // url: "addbusforsstudent.aspx/bindarea",
                          url: "admission-form.asmx/bindarea",
                          data: "{'ddlzoneid':'" + zid + "'}",
                          dataType: "json",
                          success: function (data) {
                              $("#ctl00_ContentPlaceHolder1_DropDownList2").html("");
                              $.each(data.d, function (key, value) {
                                  $("#ctl00_ContentPlaceHolder1_DropDownList2").append($("<option></option>").val(value.SID).html(value.statename));
                              });
                          },
                          error: function (result) {
                              alert("Error");
                          }
                      });
            });

            $("#ctl00_ContentPlaceHolder1_DropDownList2").change(function () {
                areaid = document.getElementById("ctl00_ctl00_ContentPlaceHolder1_DropDownList2").value;
                if (areaid == "0") {
                    $('#ctl00_ContentPlaceHolder1_DropDownList3').children('option:not(:first)').remove();
                    return;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_DropDownList3').children().remove();
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').children().remove();
                    $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "none");
                }

                $.ajax(
                      {
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          //url: "addbusforsstudent.aspx/bindbus",
                          url: "admission-form.asmx/bindbus",
                          data: "{'areaid':'" + areaid + "'}",
                          dataType: "json",
                          success: function (data) {
                              $("#ctl00_ContentPlaceHolder1_DropDownList3").html("");
                              $.each(data.d, function (key, value) {
                                  $("#ctl00_ContentPlaceHolder1_DropDownList3").append($("<option></option>").val(value.areaid).html(value.areaname));
                              });
                          },
                          error: function (result) {
                              alert("Error");
                          }
                      });
            });

            $("#ctl00_ContentPlaceHolder1_DropDownList3").change(function () {
                var bsid = document.getElementById("ctl00_ctl00_ContentPlaceHolder1_DropDownList3").value;
                var busid = $("#ctl00_ContentPlaceHolder1_DropDownList3 option:selected").text();
                //  alert(busid);
                if (busid == "0") {
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').children('option:not(:first)').remove();
                    return;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').children().remove();
                }

                $.ajax(
                      {
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          //url: "addbusforsstudent.aspx/binstopage",
                          url: "admission-form.asmx/binstopage",
                          data: "{'busid':'" + busid + "'}",
                          dataType: "json",
                          success: function (data) {
                              $("#ctl00_ContentPlaceHolder1_DropDownList4").html("");
                              $.each(data.d, function (key, value) {
                                  $("#ctl00_ContentPlaceHolder1_DropDownList4").append($("<option></option>").val(value.stopid).html(value.stopname));
                              });
                          },
                          error: function (result) {
                              alert("Error");
                          }
                      });

                $.ajax(
               {
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   //url: "addbusforsstudent.aspx/findseat",
                   url: "admission-form.asmx/findseat",
                   data: "{'busid':'" + busid + "'}",
                   dataType: "json",
                   success: function (data) {
                       ckseat = data.d
                       $("#ctl00_ContentPlaceHolder1_lbmssg").text(data.d + ' ' + "seats are available!");
                       $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "block");
                       $("#ctl00_ContentPlaceHolder1_lbmssg").css("color", "red");
                       if (ckseat == 0) {
                           $("#ctl00_ContentPlaceHolder1_DropDownList3").html('');
                           $("#ctl00_ContentPlaceHolder1_lbmssg").text(data.d + ' ' + "seats are available!!Please change bus!!");

                           $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        //url: "addbusforsstudent.aspx/bindbus",
                        url: "admission-form.asmx/bindbus",
                        data: "{'areaid':'" + areaid + "'}",
                        dataType: "json",
                        success: function (data) {
                            $("#ctl00_ContentPlaceHolder1_DropDownList3").html("");
                            $.each(data.d, function (key, value) {
                                $("#ctl00_ContentPlaceHolder1_DropDownList3").append($("<option></option>").val(value.areaid).html(value.areaname));
                            });
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

                           // return false;
                       }
                       //ckseat=$("#ctl00_ctl00_ContentPlaceHolder1_lbseatmsg").text(data.d);
                   },
                   error: function (result) {
                       alert("Error");
                   }
               });
            });

            $("#ctl00_ContentPlaceHolder1_btnok").click(function (e) {
                ddlzone = $("#ctl00_ContentPlaceHolder1_DropDownList1").val();
                ddlarea = $("#ctl00_ContentPlaceHolder1_DropDownList2").val();
                ddlbus = $("#ctl00_ContentPlaceHolder1_DropDownList3").val();
                ddlstopage = $("#ctl00_ContentPlaceHolder1_DropDownList4").val();
                transmode = "addwithbus";

                $('.editlnk').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_popup2').css("display", "none");

                $('.maindivpopup').css("display", "none");
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_button8').click(function () {
                $('#ctl00_ContentPlaceHolder1_popup2').css("display", "none");

                $('.maindivpopup').css("display", "none");
                $('.editlnk').css("display", "block");
                transmode = "transport_yes_butNot_addwithbus";
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_btn_later').click(function () {
                transmode = "transport_yes_butNot_addwithbus";
                $('#ctl00_ContentPlaceHolder1_popup2').css("display", "none");

                $('.maindivpopup').css("display", "none");
                $('.editlnk').css("display", "block");
                return false;
            });

            $('.editlnk').click(function (e) {
                var ckseat = "";
                var areaid = "";
                $('.editlnk').css("display", "none");

                $("#ctl00_ContentPlaceHolder1_btn_later").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_button7").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_DropDownList1").val(ddlzone);
                $("#ctl00_ContentPlaceHolder1_DropDownList2").val(ddlarea);
                $("#ctl00_ContentPlaceHolder1_DropDownList3").val(ddlbus);
                $("#ctl00_ContentPlaceHolder1_DropDownList4").val(ddlstopage);
                $("#ctl00_ContentPlaceHolder1_DropDownList1").attr('selectedIndex', true);
                $("#ctl00_ContentPlaceHolder1_DropDownList2").attr('selectedIndex', true);
                $("#ctl00_ContentPlaceHolder1_DropDownList3").attr('selectedIndex', true);
                $("#ctl00_ContentPlaceHolder1_DropDownList4").attr('selectedIndex', true);

                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                $('#ctl00_ContentPlaceHolder1_popup2').css("display", "block");

                $(this).closest('tr').find('td:eq(0)').removeAttr("border-style").removeAttr("border-color");
                $('.maindivpopup').css("display", "block");

                return false;
            });

            $("#ctl00_ContentPlaceHolder1_ddlreadmisn").change(function () {
                var year = document.getElementById("ctl00_ContentPlaceHolder1_ddlreadmisn").value;
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        // url: "addbusforsstudent.aspx/bindarea",
                        url: "admission-form.asmx/setfyear",
                        data: "{'ddlfyid':'" + year + "'}",
                        dataType: "json",
                        success: function (data) {
                            $("#ctl00_ContentPlaceHolder1_ddlYear").html("");
                            $.each(data.d, function (key, value) {
                                $("#ctl00_ContentPlaceHolder1_ddlYear").append($("<option></option>").val(value.SID).html(value.statename));
                            });
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

            });

            $("#ctl00_ContentPlaceHolder1_btnAdd").click(function () {
                var year1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlreadmisn").value;
                if ($("#ctl00_ContentPlaceHolder1_ddlreadmisn").val() == "0") {
                    alert("Please select financial year.");
                    return false;
                }

                if ($("#ctl00_ContentPlaceHolder1_ddlMonth").val() == "--Month--") {
                    alert("Please select month.");
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_ddlDate").val() == "--Date--") {
                    alert("Please select Date.");
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_ddlYear").val() == "--Year--") {
                    alert("Please select year.");
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_ddl_Course").val() == "--Select Class--") {
                    alert("Please select class.");
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_ddlssection").val() == "0") {
                    alert("Please select section.");
                    return false;
                }

                $.ajax(
                   {
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       // url: "addbusforsstudent.aspx/bindarea",
                       url: "studentfees.aspx/checkadmission",
                       data: "{'ddlfyid':'" + year1 + "'}",
                       dataType: "json",
                       success: function (data) {
                           if (data.d == "1") {
                               alert("student admission already taken in this financial year.");
                               $("#feedetails").css("display", "none");
                               $("#ctl00_ContentPlaceHolder1_divall").css("display", "block");
                               $("#ctl00_ContentPlaceHolder1_divtop1").css("display", "none");
                               $("#ctl00_ContentPlaceHolder1_btnadmission").css("display", "none");
                               return false;
                           }

                           else {
                               $("#feedetails").css("display", "block");
                               $("#ctl00_ContentPlaceHolder1_divall").css("display", "none");
                               return false;
                           }
                       },
                       error: function (result) {
                           alert("Error");
                       }

                   });
                return false;

            });

            $("#ctl00_ContentPlaceHolder1_Button4").click(function () {
                $("#feedetails").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_divall").css("display", "block");
                return false;

            });

            $("#ctl00_ContentPlaceHolder1_btnadmission").click(function () {
                $("#ctl00_ContentPlaceHolder1_divall").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_divtop1").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_btnadmission").css("display", "none");
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_Button2").click(function () {
                var fyid = $("#ctl00_ContentPlaceHolder1_ddlreadmisn").val();
                var tranType = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
                //alert($("#ctl00_ContentPlaceHolder1_rtransportation :checked").val());

                var scourse = $("#ctl00_ContentPlaceHolder1_ddl_Course option:selected").text();

                var sclassid = $("#ctl00_ContentPlaceHolder1_ddl_Course").val();
                var ssecnme = $("#ctl00_ContentPlaceHolder1_ddlssection option:selected").text();
                var ssecid = $("#ctl00_ContentPlaceHolder1_ddlssection").val()

                var paidamount = $("#ctl00_ContentPlaceHolder1_txtpayablefee").val();
                var payable = $("#ctl00_ContentPlaceHolder1_txtpaimat").val();
                var payableFeeamount = $("#gridviewpay tr:first-child td:last").html();
                // alert($("#gridviewpay tr:first-child td:last").html());

                if (parseFloat(paidamount) < parseFloat(payableFeeamount)) {
                    alert("Please pay full fee of April.");
                    return false;
                }
                var modeid = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;

                if (modeid == "1") {
                    var bankname = "";
                    var checkno = "";
                    var bankbranch = "";
                    var draftdate = "1900-01-01 00:00:00.000";
                }
                else if (modeid == "2") {
                    var bankname = $("#ctl00_ContentPlaceHolder1_txtBankName").val();
                    var checkno = $("#ctl00_ContentPlaceHolder1_txtCheque").val();
                    var bankbranch = $("#ctl00_ContentPlaceHolder1_txtbranch").val();
                }

                else if (modeid == "3") {
                    var bankname = $("#ctl00_ContentPlaceHolder1_txtBankName").val();
                    var checkno = $("ctl00_ContentPlaceHolder1_txtCheque").val();
                }

                var pymode = $("#ctl00_ContentPlaceHolder1_ddlPayMode option:selected").text();

                var draftdate = $("#ctl00_ContentPlaceHolder1_txtDate").val();
                var month = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;
                if (month < 10) {
                    month = "0" + month;
                }
                var dte = $("#ctl00_ContentPlaceHolder1_ddlDate option:selected").text();
                var year = $("#ctl00_ContentPlaceHolder1_ddlYear option:selected").text();
                var discountrefno = $("#ctl00_ContentPlaceHolder1_txtdiscountcode").val();

                var admdate = month + "-" + year + "-" + dte;
                var admissionmonth = "";
                var busno = "";
                var busid = "";
                var zoneid = "";
                var areaid = "";
                var stopageid = "";
                var myData = {};

                myData.paymodeid = modeid;   // fee paymode
                myData.tranType = tranType;
                myData.fyid = fyid;
                myData.discountrefno = discountrefno;
                myData.transmode = transmode;
                if (myData.tranType == "1") {
                    if (transmode == "addwithbus") {
                        busno = $('#ctl00_ContentPlaceHolder1_DropDownList3 :selected').text();
                        busid = $("#ctl00_ContentPlaceHolder1_DropDownList3").val();
                        zoneid = $("#ctl00_ContentPlaceHolder1_DropDownList1").val();
                        areaid = $("#ctl00_ContentPlaceHolder1_DropDownList2").val();
                        stopageid = $("#ctl00_ContentPlaceHolder1_DropDownList4").val();
                        myData.busno = busno;
                        myData.busid = busid;
                        myData.zoneid = zoneid;
                        myData.areaid = areaid;
                        myData.stopageid = stopageid;
                    }
                }
                else {
                    myData.busno = "";
                    myData.busid = 0;
                    myData.zoneid = 0;
                    myData.areaid = 0;
                    myData.stopageid = 0;
                }

                if (modeid == "1") {           // cash
                    myData.bankname = "";
                    myData.checkno = "";
                    myData.bankbranch = "";
                }
                else if (modeid == "2") {      // Draft
                    myData.bankname = bankname;
                    myData.checkno = checkno;
                    myData.bankbranch = bankbranch;
                }
                else if (modeid == "3") {           // Checkno
                    myData.bankname = bankname;
                    myData.checkno = checkno;
                    myData.bankbranch = bankbranch;
                }
                if (draftdate != "") {
                    myData.draftdate = draftdate
                }
                else {
                    myData.draftdate = "1900-01-01 00:00:00.000";
                }
                myData.admissionmonth = month;
                myData.payableamount = payable;      // fee payable amount
                myData.paynowamount = paidamount;
                // enter paybale amount

                var paymonthids = "";

                $("#gridviewpay tr:has(td)").find("input:checkbox").each(function () {
                    if ($(this).is(':checked')) {
                        var amt1 = $(this).closest('tr').find('td:eq(1) span:last-child').text();
                        paymonthids = paymonthids + "," + amt1;
                    }
                });

                if (paymonthids.length == 0) {
                    alert("Please select month.");

                    return false;
                }
                paymonthids = paymonthids.substring(1, paymonthids.length);

                myData.cpaymonthids = paymonthids;

                myData.apclass = scourse;

                myData.classid = sclassid;
                myData.section = ssecnme;
                myData.sectionid = ssecid;
                myData.admissiondate = admdate;

                $("#ctl00_ContentPlaceHolder1_Button1").attr('disabled', 'disabled');
                var DTO = { 'theData': myData };
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "studentfees.aspx/insertdata",
                    data: JSON.stringify(DTO),
                    success: function (data) {
                        //alert(response.d);

                        if (data.d[0] != "Error during admission") {
                            //alert(response.d);

                            window.location.href = data.d;
                        }

                        else if (data.d[0] == "Error during admission") {
                            //alert(response.d);
                            window.location.href = data.d[0];
                        }
                    },
                    error: function () {
                        alert("Error during admission.");
                        return false;
                    }
                });
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {
                $("#ctl00_ContentPlaceHolder1_divall").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_divtop1").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_btnadmission").css("display", "block");
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_Button3").click(function () {
                $("#feedetails").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_divall").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_divtop1").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_btnadmission").css("display", "none");
                return false;
            });

        });
    </script>

    <div class="content_top">

        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active" href="#">View Admission Fee</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div class="clear">
    </div>

    <asp:UpdatePanel ID="updnewadmission" runat="server">
        <ContentTemplate>
            <div class="content_pane_cont input_content" id="contentPane" style="border-bottom: medium none;">
                <My:stu runat="server" ID="Stu1" />
                &nbsp;&nbsp;
              <%--  <asp:Button runat="server" ID="btnAdd" Text="New Admission" CssClass="button_save"
                    OnClick="btnAdd_Click" ToolTip="Click here to add this student to selected courses." />--%>
                <asp:Button ID="btnadmission" runat="server" Text="Re-Admission" CssClass="button_save" />
                <br />

                <asp:HiddenField ID="paymonthsidshide" runat="server" />
                <asp:HiddenField ID="lblfeeid1" runat="server" />
                <%--<asp:Label ID="lblfeeid1" runat="server"></asp:Label>--%>
                <asp:HiddenField ID="lblfeename1" runat="server" />
                <asp:HiddenField ID="lblfeeamout1" runat="server" />
                <asp:HiddenField ID="lbldis1" runat="server" />
                <asp:HiddenField ID="lblcheck1" runat="server" />
                <asp:HiddenField ID="hdate" runat="server" />
                <asp:HiddenField ID="lblangid" runat="server" />
                <asp:HiddenField ID="hiddenvaluefordraft" runat="server" />
                <asp:HiddenField ID="admissionyear" runat="server" />
                <asp:HiddenField ID="transid" runat="server" />

                <div id="divall" runat="server" style="display: none;">

                    <div class="for_sigle_row_form">
                        <label>
                            Enter Discount Code</label>
                        <asp:TextBox ID="txtdiscountcode" runat="server"></asp:TextBox>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Select Financial Year<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddlreadmisn" runat="server">
                            <%-- <asp:ListItem Value="0" Selected="True">--Select Financial Year--</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form ">
                        <label>
                            Transportation:</label>
                        <asp:RadioButtonList runat="server" ID="rtransportation" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                            <asp:ListItem Value="1">Yes</asp:ListItem>
                            <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:LinkButton ID="lnk1" runat="server" Text="Change" Style="display: none; margin-left: 436px; margin-top: -25px" CssClass="editlnk"> </asp:LinkButton>
                    </div>

                    <%--   <div class="for_sigle_row_form ">
                            <label>
                                Day Care:</label>
                            <asp:RadioButtonList runat="server" ID="radiodaycare" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>--%>

                    <div class="for_sigle_row_form">
                        <label>
                            Admission Date<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddlMonth" runat="server" Width="113px">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlDate" runat="server" Width="96px">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlYear" runat="server" Width="105px">
                            <%--   <asp:ListItem Value="1">2015</asp:ListItem>
                                <asp:ListItem Value="2">2016</asp:ListItem>
                                <asp:ListItem Value="3">2017</asp:ListItem>
                                <asp:ListItem Value="4">2018</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Admission Sought<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddl_Course" runat="server"></asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Section<span style="color: Red"></span></label>
                        <asp:DropDownList ID="ddlssection" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                        </label>
                        <asp:Button ID="btnAdd" runat="server" Text="Make Payment" CssClass="button_save" />
                        <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="button_cancel" CausesValidation="false" />
                    </div>
                </div>

                <div id="divtop1" runat="server">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid"
                        style="border-top: 1px solid #ddd;">
                        <tr class="stm_head">
                            <td width="5.5%" rowspan="2" align="center" style="font-size: 13px; border-bottom: 1px solid #ddd;">S. No.
                            </td>
                            <td width="11.4%" rowspan="2" align="center" style="font-size: 13px; border-bottom: 1px solid #ddd;">Class Name
                            </td>
                            <%--  <td width="12.05%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd;
                            border-bottom: 1px solid #ddd;">
                            Section
                        </td>--%>
                            <td width="13.60%" rowspan="2" align="center" style="font-size: 13px; border-bottom: 1px solid #ddd;">Admission Date
                            </td>
                            <td width="15.60%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Academic Year
                            </td>

                            <td width="37%" colspan="6" align="center" style="font-size: 13px; border-bottom: 1px solid #ddd;">Fee
                            </td>
                        </tr>
                        <tr class="stm_head">
                            <td width="10%" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd">Total
                            </td>
                            <td width="10%" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Paid
                            </td>
                            <td width="10%" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Balance
                            </td>
                            <%--  <td width="10%" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; border-bottom: 1px solid #ddd;">Discount
                            </td>--%>
                        </tr>
                        <tr>
                            <td align="left" colspan="8" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                                <asp:GridView runat="server" ID="gvdetails" ShowHeader="false" AllowPaging="false"
                                    PageSize="5" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="coursename" runat="server" Text='<%#Eval("ApplyClass") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="admissionDAte" HeaderText="mobile" ItemStyle-Width="14%" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="FYName" HeaderText="mobile" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />

                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                ₹&nbsp;
                                            <asp:Label ID="lblTotalfee" runat="server" Text='<%#Eval("totalfee","{0:0.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                ₹&nbsp;
                                            <asp:Label ID="lblPaid" Text='<%#Eval("paid","{0:0.00}") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                ₹&nbsp;
                                            <asp:LinkButton ID="lblBal" runat="server" Text='<%#Eval("balance","{0:0.00}") %>' CssClass="grid_remove" Font-Underline="true"
                                                ForeColor="BurlyWood"></asp:LinkButton>
                                                <asp:Label ID="lblrid" runat="server" CssClass="ridcss" Text='<%# Bind("adid") %>' Style="display: none;"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>

                                        <%-- <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                ₹&nbsp;
                                            <asp:Label ID="lblbalance" Text='<%#Eval("Discount","{0:0.00}") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                                        </asp:TemplateField>--%>
                                    </Columns>
                                    <HeaderStyle CssClass="grdHeader" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="feedetails" style="display: none;" class="stm">

                    <%-- <span id="showfeeheads"></span>--%>
                    <div id="Container">
                    </div>

                    <div style="border: 2px #2CA8C2 solid; width: 44%">
                        <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">

                            <label>
                                Payment Mode:<span style="color: Red">*</span></label>

                            <asp:DropDownList ID="ddlPayMode" runat="server" Height="29px" Width="233px" Style="margin-left: -2px;">
                                <asp:ListItem Value="0">--Select Payment Mode--</asp:ListItem>
                                <asp:ListItem Value="1">Cash</asp:ListItem>
                                <asp:ListItem Value="2">Bank Draft</asp:ListItem>
                                <%--<asp:ListItem Value="3">Cheque</asp:ListItem>--%>
                            </asp:DropDownList>
                        </div>

                        <div class="clear"></div>

                        <div id="bankdetail" runat="server" style="display: none; margin-left: 20px;">
                            <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">
                                <label runat="server" id="ll1">
                                    Bank Name:<span style="color: Red;">*</span></label>
                                <asp:TextBox runat="server" ID="txtBankName" Height="29px" Width="226px" onkeypress="ValidateAlpha()" Style="padding: 2px; margin-left: -2px;"></asp:TextBox>
                            </div>
                            <div class="clear"></div>
                            <div class="for_sigle_row_form1" style="margin-left: 2%;">
                                <label runat="server" id="Label4">
                                    Bank Branch <span style="color: Red;">*</span></label>
                                <asp:TextBox runat="server" ID="txtbranch" Height="31px" Width="223px" Style="margin-left: 27px; padding: 2px;"></asp:TextBox>
                            </div>

                            <div id="Div3" runat="server" style="margin-left: -30px;">
                                <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">
                                    <label runat="server" id="ll2">
                                        Draft/Check NO:<span style="color: Red;">*</span></label>
                                    <asp:TextBox runat="server" Height="29px" Width="226px" ID="txtCheque" Style="padding: 2px;"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div id="Div1" runat="server" style="margin-left: -30px;">
                                <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">
                                    <label runat="server" id="Label1">
                                        Draft/Check Date:<span style="color: Red;">*</span></label>
                                    <asp:TextBox ID="txtDate" runat="server" Height="29px" Width="226px"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="clear"></div>

                        <div id="Div4" runat="server" style="margin-left: 17px;">
                            <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">
                                <label>Payable Fee:</label>
                                <asp:TextBox ID="txtpayablefee" runat="server" Height="29px" Width="220px" Enabled="false" Style="padding: 2px;">0.00</asp:TextBox>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <br />
                        <div id="Div5" runat="server" style="margin-left: 10px;">
                            <div class="for_sigle_row_form1" style="margin-left: 15%; padding-top: 0px;">
                                <label>Amount:<span style="color: Red">*</span></label>
                                <asp:TextBox ID="txtpaimat" runat="server" Height="29px" Width="226px" onkeypress="return noAlphabets(event)" Style="padding: 2px;">0.00</asp:TextBox>
                                <asp:Label runat="server" ID="lblremain" Style="display: none; margin-left: 59px; margin-top: 8px;" ForeColor="Red">Remaining Blanace:</asp:Label>
                                <asp:Label runat="server" ID="lblremainbal" ForeColor="Red" Style="display: none; margin-left: 178px; margin-top: -11px;"></asp:Label>
                            </div>
                        </div>
                        <div id="Div6" runat="server" style="margin-left: 106px;">
                            <div class="for_sigle_row_form1" style="margin-left: 7%;">
                                <label>
                                </label>
                                <asp:Button ID="Button2" runat="server" CssClass="button_save" Text="Submit" Style="height: 29px" />
                                <asp:Button ID="Button3" runat="server" CssClass="button_cancel" Text="Back" />
                            </div>
                        </div>
                    </div>
                    <div id="payfeebind" class="myclass" style="float: right; margin-top: -500px; margin-right: 200px;">
                    </div>
                    <div id="divfeestructure" style="display: none;">
                    </div>
                </div>

                <div id="p1" class="maindivpopup" style="display: none;">
                    <asp:Panel ID="popup2" runat="server" BackColor="White" Height="275px" Width="500px"
                        Style="z-index: 9000000; background-color: White; position: absolute; left: 20%; top: 15%; border: outset 2px #2CA8C2; padding: 5px; display: none;">
                        <table width="100%" style="width: 100%; height: 100%; border: 1px solid #2CA8C2;" cellpadding="0" cellspacing="5">
                            <tr style="background-color: #2CA8C2;">
                                <td colspan="2" style="color: White; font-weight: bold; font-size: 1.2em; padding: 3px"
                                    align="center">Add Student To Bus
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Select locality/Sector:
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList1" runat="server" Style="width: 130px; height: 24px;"
                                        AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Select Block/Socity:
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList2" runat="server" Style="width: 130px; height: 24px;"
                                        AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                    <asp:HiddenField ID="myhidden" runat="server" Value="" />
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Select Bus:
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList3" runat="server" Style="width: 130px; height: 24px;"
                                        AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                    <asp:Label ID="lbmssg" runat="server" Style="display: none;"></asp:Label>
                                    <asp:Label ID="lbseatmsg" runat="server" Style="display: none;"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Select Stoppage:
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList4" runat="server" Style="width: 130px; height: 24px;"
                                        AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td></td>
                                <td>
                                    <asp:Button ID="btnok" CssClass="button_save" Text="Ok" runat="server" />
                                    <asp:Button ID="button8" class="btnClose" Style="margin-left: 60px; margin-top: -35px;" CssClass="button_cancel" runat="server" Text="Cancel" />
                                    <asp:Button ID="btn_later" class="btnClose" CssClass="button_cancel" runat="server" tyle="margin-left: 60px;margin-top:-35px;" Text="Cancel" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>

                <br />
                <br />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>