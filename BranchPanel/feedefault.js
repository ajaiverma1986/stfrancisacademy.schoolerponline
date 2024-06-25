$(document).ready(function () {
    $("#ctl00_ContentPlaceHolder1_Button3").click(function () {
        var paymonthids = "";

        $("#ctl00_ContentPlaceHolder1_GridView1 tr:has(td)").find("input:checkbox").each(function () {
            if ($(this).is(':checked')) {
                var amt1 = $(this).closest('tr').find('td:eq(2) span:last-child').text();
                paymonthids = paymonthids + "," + amt1;
            }
        });

        if (paymonthids.length == 0) {
            alert("Please select month.");

            return false;
        }

        paymonthids = paymonthids.substring(1, paymonthids.length);
        $("#ctl00_ContentPlaceHolder1_Label3").val(paymonthids);
        $("#ctl00_ContentPlaceHolder1_label44").val(paymonthids);
        if ($("#ctl00_ContentPlaceHolder1_lblMonthName").val() == 0) {
            alert("Please select Month.");
            $("#ctl00_ContentPlaceHolder1_lblMonthName").focus();
            return false;
        }

        var rad = $('[id*=rfineadjust]').find('input:checked').val();
        var tamount = $("#ctl00_ContentPlaceHolder1_txtAmount").val();
        var payfine = $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val();
        if (rad == 1) {
            if (parseFloat(tamount) > parseFloat(payfine)) {
            }
            else {
                alert("Pay amount is greater than fine adjust amount");
                $("#ctl00_ContentPlaceHolder1_txtAmount").focus();
                return false;
            }
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlPayMode").val() == 0) {
            alert("Please Select Payment Mode.");
            $("#ctl00_ContentPlaceHolder1_ddlPayMode").focus();
            return false;
        }

        if ($("#cctl00_ContentPlaceHolder1_txtAmount").val() == "") {
            alert("Please enter amount.");
            $("#cctl00_ContentPlaceHolder1_txtAmount").focus();
            return false;
        }

        if ($('#ctl00_ContentPlaceHolder1_divbank').css('display') == 'block') {
            if ($("#ctl00_ContentPlaceHolder1_txtBankName").val() == "") {
                alert("Please enter Bank Name.");
                $("#ctl00_ContentPlaceHolder1_txtBankName").focus();
                return false;
            }

            if ($("#ctl00_ContentPlaceHolder1_txtbranch").val() == "") {
                alert("Please enter Bank Branch Name.");
                $("#ctl00_ContentPlaceHolder1_txtbranch").focus();
                return false;
            }

            if ($("#ctl00_ContentPlaceHolder1_txtCheque").val() == "") {
                alert("Please enter Draft number.");
                $("#ctl00_ContentPlaceHolder1_txtCheque").focus();
                return false;
            }

            if ($("#ctl00_ContentPlaceHolder1_txtDate").val() == "") {
                alert("Please enter Draft Date.");
                $("#ctl00_ContentPlaceHolder1_txtDate").focus();
                return false;
            }
        }
    });

    var classid1 = 0, trantype = 0, adid = 0;
    classid1 = $('#ctl00_ContentPlaceHolder1_hfclassid').val();
    trantype = $('#ctl00_ContentPlaceHolder1_hftransid').val();
    adid = $('#ctl00_ContentPlaceHolder1_hfadid').val();

    $("#ctl00_ContentPlaceHolder1_lbpainame").text("Paid");
    $('#feedetails').css("display", "none");
    $.ajax({
        type: "POST",
        url: "admission-form.asmx/getfeeheadsnew",
        // url: "admission-form.asmx/getfeeheads",
        data: "{'classid':'" + classid1 + "','transport':'" + trantype + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            var table = '<table id="grdpay"  class="stm"><thead class="stm_head"><tr><th>Fee Name</th><th>Amount</th></thead><tbody>';

            for (var i = 0; i < data.d.length; i++) {
                var row = '<tr">';

                if (data.d[i].feename != "Admission Fee") {
                    row += '<td><span class="csspayfee1">' + data.d[i].feename + '</span>:</td>';

                    if (data.d[i].feename == "Admission Fee" || data.d[i].feename == "Registration Fee" || data.d[i].feename == "Annual Charges" || data.d[i].feename == "Students Kit") {
                    }
                    else {
                        row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + 0 + '"></td>';
                    }

                    row += '</tr><br />';

                    table += row;
                }
            }
            // row += '<td><input disabled="disabled" class="cscfeepay" type=label value="' + 0 + '"></td>';
            table += '</tbody></table>';
            $('#Container1').html(table);
        }
    });

    var feebyamt = 0
    var t1newamt = 0;
    var perheadfee = 0;
    $.ajax({
        type: "POST",
        url: "admission-form.asmx/bindpaystructure",
        //  url: "http://localhost:2158/currentcode/BranchPanel/admission-form.asmx/bindpaystructure",
        data: "{'adid':'" + adid + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            var table = '<table width="50%" style="margin-top:40px" id="grdfeestructure"  class="stm"><thead class="stm_head" HorizontalAlign="Center"><tr><th>Month</th><th>Amount</th></thead><tbody>';
            $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
            for (var i = 0; i < data.d.length; i++) {
                var row = '<tr">';
                row += '<td><span class="monthname1" style="display:block;">' + data.d[i].month + '</span><span class="monthidclass1" style="display:none;">' + data.d[i].monthid + '</span> </td>';
                row += '<td><span class="abc">' + data.d[i].feename + '<span></td>';
                row += '<td><span class="fee">' + data.d[i].fees + '</span></td>';

                row += '</tr>';

                table += row;
            }

            table += '</tbody>  </table>';
            $('#divfeestructure').html(table);
        }
    });

    var monthname = "", montname2 = "", feename = "", feename2, money = "", amt = 0, newamt = 0, totalamt = 0, newtotal = 0, count = 1, checked = "";

    $(".ops").live('click', function () {
        if ($(this).is(':checked')) {
            $(this).closest('tr').css("background-color", "green");
            //if ($(this).is(':checked')) {
            monthname = $(this).closest('tr').find('td:eq(2) span:first-child').text();

            //alert($(this).closest('tr').find('td:eq(1) span:first-child').text());

            $("#grdfeestructure tr:has(td)").each(function () {
                $(this).closest('tr').find('td:contains(' + monthname + ')').css("background-color", "#ffe8a1");

                monthname2 = $(this).closest('tr').find('td:eq(0) span:first-child').text();
                feename2 = $(this).closest('tr').find('td:eq(1) span:first-child').text();

                if (monthname == monthname2) {
                    //alert($(this).closest('tr').find('td:eq(2)').text());
                    money = $(this).closest('tr').find('td:eq(2) span:first-child').text();
                    $("#grdpay tr:has(td)").each(function () {
                        feename = $(this).closest('tr').find('td:eq(0) span:first-child').text();

                        if (feename2 == "Quarterly-Development Charges" && feename == "Development Charges") {
                            amt = $(this).closest('tr').find('td:eq(1) input').val();

                            newamt = parseFloat(money) + parseFloat(amt);
                            totalamt = parseFloat(money) + parseFloat(totalamt);

                            //$("#ctl00_ContentPlaceHolder1_txtpayablefee").val(newamt);
                            $(this).closest('tr').find('td:eq(1) input').val(newamt);
                            if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                            }
                            $(this).closest('tr').find('td:eq(1) input').css("background-color", "#ffe8a1");
                        }

                        if (feename2 == "Half Yearly-Examination Fee" && feename == "Examination Fee") {
                            amt = $(this).closest('tr').find('td:eq(1) input').val();

                            newamt = parseFloat(money) + parseFloat(amt);
                            totalamt = parseFloat(money) + parseFloat(totalamt);

                            //$("#ctl00_ContentPlaceHolder1_txtpayablefee").val(newamt);
                            $(this).closest('tr').find('td:eq(1) input').val(newamt);
                            if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                            }
                            $(this).closest('tr').find('td:eq(1) input').css("background-color", "#ffe8a1");
                        }

                        else if (feename2 == "Monthly-Tution Fee" && feename == "Tution Fee") {
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
            //$('.lbltotal').val(totalamt);
            //totalamt = parseFloat(totalamt) + parseFloat($("#sp1").html());
            $('#ctl00_ContentPlaceHolder1_lblMonthName').val(totalamt);
            $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
            //$("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamt);
            $('#grdfeestructure').css("display", "block");
            count = 1;
        }
        else {
            monthname = $(this).closest('tr').find('td:eq(2) span:first-child').text();
            $(this).closest('tr').css("background-color", "white");
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

                        if (feename2 == "Half Yearly-Examination Fee" && feename == "Examination Fee") {
                            amt = $(this).closest('tr').find('td:eq(1) input').val();
                            newamt = parseFloat(amt) - parseFloat(money);
                            totalamt = parseFloat(totalamt) - parseFloat(money);

                            //$("#ctl00_ContentPlaceHolder1_txtpayablefee").val(newamt);
                            $(this).closest('tr').find('td:eq(1) input').val(newamt);
                            if ($(this).closest('tr').find('td:eq(1) input').val() == 0) {
                                $(this).closest('tr').find('td:eq(1) input').css("background-color", "white");
                            }
                            $(this).closest('tr').find('td:eq(1) input').css("background-color", "#ffe8a1");
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
                    });
                }
            });
            // parseFloat($('.lbltotal').val() - parseFloat(totalamt)) >= 0;
            $('#ctl00_ContentPlaceHolder1_lblMonthName').val(totalamt);
            $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
            $('#grdfeestructure').css("display", "block");
            count = 1;
        }
    });

    $('#ctl00_ContentPlaceHolder1_btnconfig').click(function () {
        $("#ctl00_ContentPlaceHolder1_gridenquiry").css("display", "none");
        $("#ctl00_ContentPlaceHolder1_divpay").css("display", "block");
        $('#feedetails').css("display", "block");
        $("#ctl00_ContentPlaceHolder1_btnconfig").css("display", "none");
        $("#ctl00_ContentPlaceHolder1_lbpainame").text("");
        $("#ctl00_ContentPlaceHolder1_paidtop").css("display", "none");
        $("#ctl00_ContentPlaceHolder1_uppaidt").css("display", "none");
        return false;
    });

    $('#ctl00_ContentPlaceHolder1_btnCancel').click(function () {
        $("#ctl00_ContentPlaceHolder1_gridenquiry").css("display", "block");
        $("#ctl00_ContentPlaceHolder1_divpay").css("display", "none");
        $("#ctl00_ContentPlaceHolder1_btnconfig").css("display", "block");
        $('#feedetails').css("display", "none");
        $("#ctl00_ContentPlaceHolder1_lbpainame").text("Paid");
        $("#ctl00_ContentPlaceHolder1_paidtop").css("display", "block");
        $("#ctl00_ContentPlaceHolder1_uppaidt").css("display", "block");

        return false;
    });

    $("#ctl00_ContentPlaceHolder1_ddlPayMode").change(function () {
        var mode = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;
        if (mode == 1) {
            $("#ctl00_ContentPlaceHolder1_divbank").css("display", "none");
        }

        else {
            $("#ctl00_ContentPlaceHolder1_divbank").css("display", "block");
        }
    });

    $("#ctl00_ContentPlaceHolder1_txtAmount").on('change', function () {
        var txtvalue = $("#ctl00_ContentPlaceHolder1_txtAmount").val();
        var payamt = $("#ctl00_ContentPlaceHolder1_lblMonthName").val();
        var amtwitfine = $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val();
        $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");

        var rad = $('[id*=rfineadjust]').find('input:checked').val();

        if (rad == 2) {
            if (txtvalue != "") {
                if (parseFloat(payamt) < parseFloat(txtvalue)) {
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").text("Amount to be paid is greater than balance amount!");
                    $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00")
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                    return;
                }
                else if (parseFloat(payamt) == parseFloat(txtvalue)) {
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(payamt) - parseFloat(txtvalue));
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                    return;
                }
                else if (parseFloat(payamt) > parseFloat(txtvalue)) {
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(payamt) - parseFloat(txtvalue));
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                    return;
                }
            }
        }
        if (rad == 1) {
            if (txtvalue != "") {
                if (parseFloat(amtwitfine) < parseFloat(txtvalue)) {
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").text("Amount to be paid is greater than balance amount!");
                    $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00")
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                    return;
                }

                else if (parseFloat(amtwitfine) == parseFloat(txtvalue)) {
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(amtwitfine) - parseFloat(txtvalue));
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                }
                else if (parseFloat(amtwitfine) > parseFloat(txtvalue)) {
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(amtwitfine) - parseFloat(txtvalue));
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                }
            }
        }

        else {
            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
        }
    });

    $('[id*=rfineadjust] input').unbind().click(function (e) {
        var rad = $('[id*=rfineadjust]').find('input:checked').val();

        if (rad == 1) {
            $("#ctl00_ContentPlaceHolder1_adjustfine").css("display", "block");
            $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00");
            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_divfee").css("display", "block");
            $("#ctl00_ContentPlaceHolder1_divfes").css("display", "none");
            // $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
            $("#ctl00_ContentPlaceHolder1_hd1").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
            $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
            $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val("0.00");

            //   $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val("0.00");
            //   $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val("0.00");
        }
        else if (rad == "2") {
            $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00");
            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_divfee").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_adjustfine").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_divfes").css("display", "block");
            $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val($("#ctl00_ContentPlaceHolder1_txtfine").val());
        }
    });

    $("#ctl00_ContentPlaceHolder1_txtpayfinehere").on('change', function () {
        var totalfine = parseFloat($("#ctl00_ContentPlaceHolder1_txtfine").val()).toFixed(0.00);
        var fine = parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()).toFixed(0.00);
        if (parseFloat(fine) <= parseFloat(totalfine)) {
            $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
            $("#ctl00_ContentPlaceHolder1_hd1").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
        }
        else {
            $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val($("#ctl00_ContentPlaceHolder1_lblMonthName").val());
            $("#ctl00_ContentPlaceHolder1_hd1").val(0);
            $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val(0);
            alert("adjust fine amount can not be greater than actual fine amount.");
            return;
        }
    });

    $('.stuname').click(function () {
        var mid, rno, sid;
        sid = $(this).closest("td").find("[id*=lblbt2]").text();
        mid = $(this).closest('tr').find('td:eq(2)').find("input[type='hidden']").val();
        rno = $(this).closest("td").find("[id*=lnkView]").text();
        window.open("receipt.aspx?sid=" + sid + "& monthid=" + mid + "& receiptno=" + rno, '_blank');
        return false;
    });
});