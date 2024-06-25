var regno, discode, clsid, discode, monthid, transportion, totalamoutfeeheds = 0, mode1, nxtfyid = 0;
$(document).ready(function () {
    var ddlzone = "";
    var ddlarea = "";
    var ddlbus = "";
    var ddlstopage = "", transmode = "transportnottaken";
    $("form").bind("keypress", function (e) {
        if (e.keyCode == 13) return false;
    });
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        url: "admission-form.asmx/binclass",
        data: "{}",
        success: function (data) {
            $("#ctl00_ContentPlaceHolder1_ddl_Course").html("");
            $.each(data.d, function (key, value1) {
                $("#ctl00_ContentPlaceHolder1_ddl_Course").append($("<option></option>").val(value1.SID).html(value1.statename));
            });
        },
        error: function () {
            alert("Error calling the web service.");
        }
    });

    $('input[type="text"]').keyup(function (evt) {
        var txt = $(this).val();

        $(this).val(txt.replace(/^(.)|\s(.)/g, function ($1) { return $1.toUpperCase(); }));
    });

    $('[id*=rtransportation] input').unbind().click(function (e) {
        // $("#ctl00_ContentPlaceHolder1_ddl_Course").html('');
        // $("#ctl00_ContentPlaceHolder1_ddl_Course").prop("disabled", false);
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
        if (sdob1 == "") {
            sdob1 = "1900-01-01 00:00:00.000";
        }
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
            // $("#ctl00_ContentPlaceHolder1_DropDownList1").val(0);
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

                            //    $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds);
                            //    //alert(totalamoutfeeheds);
                            //    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees).toFixed(2) + '"></td>';
                            //}
                            //else {
                            row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees) + '"></td>';
                            //}

                            row += '</tr><br/>';

                            table += row;
                        }

                        table += '</tbody></table>';

                        //alert($("#ctl00_ContentPlaceHolder1_txtpayablefee").val());
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

        //$.ajax(
        //                       {
        //                           type: "POST",
        //                           contentType: "application/json; charset=utf-8",
        //                           url: "admission-form.asmx/binclass",
        //                           data: "{}",
        //                           dataType: "json",
        //                           success: function (data) {
        //                               $("#ctl00_ContentPlaceHolder1_ddl_Course").html("");
        //                               $.each(data.d, function (key, value1) {
        //                                   $("#ctl00_ContentPlaceHolder1_ddl_Course").append($("<option></option>").val(value1.SID).html(value1.statename));
        //                               });
        //                               // $('#ctl00_ContentPlaceHolder1_ddlCity1').val(value.cityid);
        //                           },
        //                           error: function (result) {
        //                               alert("Error");
        //                           }
        //                       });
    });

    $("#ctl00_ContentPlaceHolder1_ddl_Course").change(function (e) {
        $("#ctl00_ContentPlaceHolder1_txtClassSec").val('');
        $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(0);
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

        if (sdob1 == "") {
            sdob1 = "1900-01-01 00:00:00.000";
        }
        var sfname1 = $("#ctl00_ContentPlaceHolder1_txtFname").val();
        var sfmname1 = $("#ctl00_ContentPlaceHolder1_txtmidname1").val();
        var sflname1 = $("#ctl00_ContentPlaceHolder1_txtlastname1").val();
        var smfname1 = $("#ctl00_ContentPlaceHolder1_txtmother").val();
        var smmname1 = $("#ctl00_ContentPlaceHolder1_txtmidname2").val();
        var smlname1 = $("#ctl00_ContentPlaceHolder1_txtlastname2").val();

        var contactno = $("#ctl00_ContentPlaceHolder1_txtmob").val();

        if ($("#ctl00_ContentPlaceHolder1_txtRegNo").val() != "") {
            if (sid != clasid1) {
                $("#ctl00_ContentPlaceHolder1_ddl_Course").prop('selectedIndex', 0);
                $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                $("#ctl00_ContentPlaceHolder1_lbclmsg").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_lbclmsg").text("Please Select Class " + clasname + "");
                return false;
            }
        }
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
                    $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.SID).html(value.sectionname));
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

                            //    $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds);
                            //    //alert(totalamoutfeeheds);
                            //    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees).toFixed(2) + '"></td>';
                            //}
                            //else {
                            row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees) + '"></td>';
                            //}

                            row += '</tr><br/>';

                            table += row;
                        }

                        table += '</tbody></table>';

                        //alert($("#ctl00_ContentPlaceHolder1_txtpayablefee").val());
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

    var monthname = "", montname2 = "", feename = "", feename2, money = "", amt = 0, newamt = 0, totalamt = 0, newtotal = 0, count = 1;

    $(".ops").live('click', function () {
        var trfee = "", devfee = "", tufee = "", allfee = "";

        if (count == 1) {
            totalamt = parseFloat($("#ctl00_ContentPlaceHolder1_txtpayablefee").val());
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

                            //$("#ctl00_ContentPlaceHolder1_txtpayablefee").val(newamt);
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
        //$("#ctl00_ContentPlaceHolder1_ddlDate").prop('disabled', false);

        $.ajax({
            type: "POST",
            url: "admission-form.asmx/monthdays",
            data: "{'mid':'" + mid + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                $('#ctl00_ContentPlaceHolder1_ddlDate').children('option:not(:first)').remove();
                // $("#ctl00_ContentPlaceHolder1_ddlDate").html("");
                for (var i = 1; i <= data.d; i++) {
                    if (i < 10) {
                        $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option></option>").val(i).html("0" + i.toString()));
                    }
                    else
                        $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option></option>").val(i).html(i));
                    // $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option />").text(i));
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

        var clasname = $("#ctl00_ContentPlaceHolder1_lbclssname").text();
        var clasid1 = $("#ctl00_ContentPlaceHolder1_lbclassname").text();

        var fname1 = $("#ctl00_ContentPlaceHolder1_txtName").val();

        var smname1 = $("#ctl00_ContentPlaceHolder1_txtmidname").val();
        var slname1 = $("#ctl00_ContentPlaceHolder1_txtLName").val();
        var sdob1 = $("#ctl00_ContentPlaceHolder1_txtToDate").val();
        if (sdob1 == "") {
            sdob1 = "1900-01-01 00:00:00.000";
        }

        var sfname1 = $("#ctl00_ContentPlaceHolder1_txtFname").val();
        var sfmname1 = $("#ctl00_ContentPlaceHolder1_txtmidname1").val();
        var sflname1 = $("#ctl00_ContentPlaceHolder1_txtlastname1").val();
        var smfname1 = $("#ctl00_ContentPlaceHolder1_txtmother").val();
        var smmname1 = $("#ctl00_ContentPlaceHolder1_txtmidname2").val();
        var smlname1 = $("#ctl00_ContentPlaceHolder1_txtlastname2").val();

        var contactno = $("#ctl00_ContentPlaceHolder1_txtmob").val();

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
                            //    $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds1);
                            //    row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees).toFixed(2) + '"></td>';
                            //}
                            //else {
                            row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees) + '"></td>';
                            //}

                            row += '</tr><br/>';

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
    $("#ctl00_ContentPlaceHolder1_txtRegNo").on('change', function () {
        regno = $(this).val();
        discode = $("#ctl00_ContentPlaceHolder1_txtdiscountcode").val();
        if ($("#ctl00_ContentPlaceHolder1_txtRegNo").text != null) {
            FillDataOfAdmission("");
        }
    });

    //for discount change//

    $("#ctl00_ContentPlaceHolder1_txtdiscountcode").blur('change', function () {
        clsid = $("#ctl00_ContentPlaceHolder1_ddl_Course").val();
        discode = $("#ctl00_ContentPlaceHolder1_txtdiscountcode").val();
        monthid = $("#ctl00_ContentPlaceHolder1_ddlMonth").val();
        transportion = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
        //  var daycare = $("#ctl00_ContentPlaceHolder1_radiodaycare :checked").val();
        totalamoutfeeheds = 0;
        mode1 = "";
        nxtfyid = 0;
        $('#payfeebind').html('');
        $('#Container').html('');
        $('#divshowfeestucture').html('');

        if (discode != "") {
            Filldiscountdatadetails("");
        }
        else if (monthid != "--Month--" && discode == "" && clsid != "--Select Class--") {
            $('#Container').html('');

            $('#payfeebind').html('');
            $('#divshowfeestucture').html('');

            $.ajax({
                type: "POST",
                url: "admission-form.asmx/Bindfeestructure",
                data: "{'classid':'" + parseInt(clsid) + "','transport':'" + parseInt(transportion) + "','monthid':'" + parseInt(monthid) + "','discountcode':'" + discode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var table = '<table width="50%" style="margin-top:40px" id="grdfeebind"  class="stm"><thead class="stm_head" HorizontalAlign="Center"><tr><th>Month</th><th>Amount</th></thead><tbody>';

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

                    $('#divshowfeestucture').html(table);
                }
            });

            $.ajax({
                type: "POST",
                url: "admission-form.asmx/getmonthwithfee",
                data: "{'classid':'" + parseInt(clsid) + "','transport':'" + parseInt(transportion) + "','monthid':'" + parseInt(monthid) + "','discountcode':'" + discode + "','daycare':'" + parseInt(daycare) + "','mode1':'" + mode1 + "','nextfyid':'" + parseInt(nxtfyid) + "'}",

                //data: "{'classid':'" + sid + "','transport':'" + parseInt(transportvalue) + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "'}",
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
                    $("#gridviewpay tr:first-child td").css("background-color", "#bbf");
                    $("#gridviewpay tr:first-child td span input:first").attr("checked", "checked");
                    $("#gridviewpay tr:first-child td span input:first").attr('disabled', 'disabled');
                    //alert($("#gridviewpay tr:first-child td:first").html());
                }
            });

            $.ajax({
                type: "POST",
                url: "admission-form.asmx/getfeeheads",
                data: "{'classid':'" + parseInt(clsid) + "','trantype':'" + parseInt(transportion) + "','discountcode':'" + discode + "','monthid':'" + parseInt(monthid) + "','daycare':'" + parseInt(daycare) + "'}",
                //data: "{'classid':'" + classid + "','trantype':'" + parseInt(ar) + "','discountcode':'" + discountcode + "'}",
                //data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var table = '<table id="grdpay" class="stm"><thead class="stm_head"><tr><th>Fee Name</th><th>Amount</th></thead><tbody>';

                    for (var i = 0; i < data.d.length; i++) {
                        var row = '<tr">';

                        row += '<td><span class="csspayfee1">' + data.d[i].feename + '</span>:</td>';

                        totalamoutfeeheds = parseFloat(totalamoutfeeheds) + parseFloat(data.d[i].fees);

                        row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees) + '"></td>';

                        row += '</tr><br />';

                        table += row;
                    }

                    table += '</tbody></table>';
                    alert(totalamoutfeeheds);
                    $('#Container').html(table);
                    $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds);
                }
            });

            $("#ctl00_ContentPlaceHolder1_ddl_Course").removeAttr("disabled");
        }
    });

    $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").change(function () {
        var year1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlfinancialyear").value;
        var count1 = 0;
        $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                // url: "addbusforsstudent.aspx/bindarea",
                url: "admission-form.asmx/setfyear",
                data: "{'ddlfyid':'" + year1 + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlYear").html("");
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlYear").append($("<option></option>").val(count1).html(value.statename));
                        count1++;
                    });
                },
                error: function (result) {
                    alert("Error");
                }
            });
    });

    $("#ctl00_ContentPlaceHolder1_ddlSection").change(function () {
        var secid = document.getElementById("ctl00_ContentPlaceHolder1_ddlSection").value;

        if (secid != null) {
            var sectnme = ($("#ctl00_ContentPlaceHolder1_ddl_Course").find("option:selected").text() + " " + $("#ctl00_ContentPlaceHolder1_ddlSection").find("option:selected").text());

            $("#ctl00_ContentPlaceHolder1_txtClassSec").val(sectnme);
        }
    });

    $("#ctl00_ContentPlaceHolder1_txtToDate").on('change', function () {
        var DOB = $(this).val();

        var inputdob = DOB;

        if (inputdob == "") {
            alert("Enter date of Birth");

            document.getElementById('lblAge').innerHTML = '';

            return false;
        }

        var DOBDate = new Date(inputdob);

        var currentDate = new Date();

        var months = currentDate.getMonth() - DOBDate.getMonth();

        var years = currentDate.getFullYear() - DOBDate.getFullYear();

        var days = currentDate.getDate() - DOBDate.getDate();

        if (years < 0) {
            alert("Choose correct date of brith.");
            $('#ctl00_ContentPlaceHolder1_txtToDate').val('');
            document.getElementById('lblAge').innerHTML = '';
        }

        if (months < 0) {
            years = parseInt(years, 10) - 1;

            months = 12 + parseInt(months, 10);

            if (days < 0) {
                months = parseInt(months, 10) - 1;

                days = 30 + parseInt(days, 10);

                document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';
                $('#lblAge').css("color", "red");
            }

            else

                document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + (days) + ' Days';
            $('#lblAge').css("color", "red");
        }

        else {
            if (months == 0) {
                years = parseInt(years, 10);

                if (days < 0) {
                    dayDiff = 30 + parseInt(days, 10);

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + (-days) + ' Days';
                    $('#lblAge').css("color", "red");
                }

                else

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';
                $('#lblAge').css("color", "red");
            }

            else {
                if (days < 0) {
                    months = parseInt(months, 10) - 1;

                    days = 30 + parseInt(days, 10);

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';
                    $('#lblAge').css("color", "red");
                }

                else

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';
                $('#lblAge').css("color", "red");
            }
        }
    });
    $("#ctl00_ContentPlaceHolder1_ddlCountry1").change(function () {
        // alert("ashuuuu");
        var cid = document.getElementById("ctl00_ContentPlaceHolder1_ddlCountry1").value;
        if (cid == "0") {
            $('#ctl00_ContentPlaceHolder1_ddl_state').children('option:not(:first)').remove();
            $('#ctl00_ContentPlaceHolder1_ddlCity1').children('option:not(:first)').remove();

            return;
        }
        else {
            $('#ctl00_ContentPlaceHolder1_ddl_state').children().remove();
            $('#ctl00_ContentPlaceHolder1_ddlCity1').children().remove();
        }

        $.ajax(
           {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               url: "admission-form.asmx/bindstate",
               data: "{'cid':'" + cid + "'}",
               dataType: "json",
               success: function (data) {
                   $("#ctl00_ContentPlaceHolder1_ddl_state").html("");
                   $.each(data.d, function (key, value) {
                       $("#ctl00_ContentPlaceHolder1_ddl_state").append($("<option></option>").val(value.SID).html(value.statename));
                   });
               },
               error: function (result) {
                   alert("Error");
               }
           });
    });

    $("#ctl00_ContentPlaceHolder1_ddl_state").change(function () {
        var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_state").value;

        if (sid == "0") {
            $('#ctl00_ContentPlaceHolder1_ddlCity1').children('option:not(:first)').remove();

            return;
        }
        else {
            $('#ctl00_ContentPlaceHolder1_ddlCity1').children().remove();
        }

        $.ajax(
           {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               url: "admission-form.asmx/bindcity",
               data: "{'sid':'" + sid + "'}",
               dataType: "json",
               success: function (data) {
                   $("#ctl00_ContentPlaceHolder1_ddlCity1").html("");
                   $.each(data.d, function (key, value1) {
                       $("#ctl00_ContentPlaceHolder1_ddlCity1").append($("<option></option>").val(value1.CTID).html(value1.cityName));
                   });
               },
               error: function (result) {
                   alert("Error");
               }
           });
    });

    $("#ctl00_ContentPlaceHolder1_ddlPayMode").change(function () {
        var modeid = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;
        if (modeid == "0") {
            $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "none");
            return;
        }
        else if (modeid == "1") {
            $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "none");
            return;
        }
        else if (modeid == "2") {
            $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "block");
            return;
        }
    });

    $("#ctl00_ContentPlaceHolder1_Button4").click(function () {
        if (ddlzone == "") {
            $('.shadow2').css("display", "none");
        }

        else {
            $('.shadow2').css("display", "Block");
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlMonth").val() == "--Month--") {
            alert("Please select Month.");
            $("#ctl00_ContentPlaceHolder1_ddlMonth").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlDate").val() == "--Date--") {
            alert("Please select Date.");
            $("#ctl00_ContentPlaceHolder1_ddlDate").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlYear").val() == "--Year--") {
            alert("Please select Year.");
            $("#ctl00_ContentPlaceHolder1_ddlYear").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtName").val() == "") {
            alert("Please enter student first name.");
            $("#ctl00_ContentPlaceHolder1_txtName").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtLName").val() == "") {
            alert("Please enter student last name.");
            $("#ctl00_ContentPlaceHolder1_txtLName").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtToDate").val() == "") {
            alert("Please Enter Date of Birth.");
            $("#ctl00_ContentPlaceHolder1_txtToDate").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtFname").val() == "") {
            alert("Please enter father first name.");
            $("#ctl00_ContentPlaceHolder1_txtFname").focus();
            return false;
        }
        if ($("#ctl00_ContentPlaceHolder1_txtlastname1").val() == "") {
            alert("Please enter father last name.");
            $("#ctl00_ContentPlaceHolder1_txtlastname1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddl_Course").val() == 0) {
            alert("Please select class.");
            $("#ctl00_ContentPlaceHolder1_ddl_Course").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlSection").val() == 0) {
            alert("Please select Section.");
            $("#ctl00_ContentPlaceHolder1_ddlSection").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtPAddress").val() == "") {
            alert("Please enter address.");
            $("#ctl00_ContentPlaceHolder1_txtPAddress").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlCountry1").val() == 0) {
            alert("Please select Country.");
            $("#ctl00_ContentPlaceHolder1_ddlCountry1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddl_state").val() == 0) {
            alert("Please select State.");
            $("#ctl00_ContentPlaceHolder1_ddl_state").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlCity1").val() == 0) {
            alert("Please select city.");
            $("#ctl00_ContentPlaceHolder1_ddlCity1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtPZIP").val() == "") {
            alert("Please eneter pin code!");
            $("#ctl00_ContentPlaceHolder1_txtPZIP").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtmob").val() == "") {
            alert("Please enter mobile number.");
            $("#ctl00_ContentPlaceHolder1_txtmob").focus();
            return false;
        }

        $("#ctl00_ContentPlaceHolder1_regno1").text($("#ctl00_ContentPlaceHolder1_txtRegNo").val());
        $("#ctl00_ContentPlaceHolder1_lblappname1").text($("#ctl00_ContentPlaceHolder1_txtName").val() + " " + $("#ctl00_ContentPlaceHolder1_txtmidname").val() + " " + $("#ctl00_ContentPlaceHolder1_txtLName").val());

        $("#ctl00_ContentPlaceHolder1_lbldob1").text($("#ctl00_ContentPlaceHolder1_txtToDate").val());
        $("#ctl00_ContentPlaceHolder1_lblfather1").text($("#ctl00_ContentPlaceHolder1_txtFname").val() + " " + $("#ctl00_ContentPlaceHolder1_txtmidname1").val() + " " + $("#ctl00_ContentPlaceHolder1_txtlastname1").val());
        $("#ctl00_ContentPlaceHolder1_lblmother1").text($("#ctl00_ContentPlaceHolder1_txtmother").val() + " " + $("#ctl00_ContentPlaceHolder1_txtmidname2").val() + " " + $("#ctl00_ContentPlaceHolder1_txtlastname2").val());

        if ($("#ctl00_ContentPlaceHolder1_rbgender :checked").val() == 1) {
            $("#ctl00_ContentPlaceHolder1_lblgnder1").text('Mail');
        }
        else {
            $("#ctl00_ContentPlaceHolder1_lblgnder1").text('Femail');
        }

        $("#ctl00_ContentPlaceHolder1_lblclass1").text($("#ctl00_ContentPlaceHolder1_ddl_Course option:selected").text());
        $("#ctl00_ContentPlaceHolder1_lblsection1").text($("#ctl00_ContentPlaceHolder1_ddlSection option:selected").text());

        $("#ctl00_ContentPlaceHolder1_lbladdress1").text($("#ctl00_ContentPlaceHolder1_txtPAddress").val());
        $("#ctl00_ContentPlaceHolder1_lblcountry1").text($("#ctl00_ContentPlaceHolder1_ddlCountry1 option:selected").text());
        $("#ctl00_ContentPlaceHolder1_lblstate1").text($("#ctl00_ContentPlaceHolder1_ddl_state option:selected").text());
        $("#ctl00_ContentPlaceHolder1_lblcity1").text($("#ctl00_ContentPlaceHolder1_ddlCity1 option:selected").text());

        $("#ctl00_ContentPlaceHolder1_lblpincode1").text($("#ctl00_ContentPlaceHolder1_txtPZIP").val());
        $("#ctl00_ContentPlaceHolder1_lblmobile12").text($("#ctl00_ContentPlaceHolder1_txtmob").val());

        $("#ctl00_ContentPlaceHolder1_labledateadd").text($("#ctl00_ContentPlaceHolder1_ddlMonth option:selected").text() + " " + $("#ctl00_ContentPlaceHolder1_ddlDate option:selected").text() + " " + $("#ctl00_ContentPlaceHolder1_ddlYear option:selected").text());

        //$("#ctl00_ContentPlaceHolder1_lblsecclass1").text($("#ctl00_ContentPlaceHolder1_xtClassSec").val());
        // $("#ctl00_ContentPlaceHolder1_lblsecclass1").text("#ctl00_ContentPlaceHolder1_txtClassSec").val());
        // $("#ctl00_ContentPlaceHolder1_lbloffice1").text(("#ctl00_ContentPlaceHolder1_txtOfficer").val());
        $("#ctl00_ContentPlaceHolder1_lblzone").text($("#ctl00_ContentPlaceHolder1_DropDownList1 option:selected").text());
        $("#ctl00_ContentPlaceHolder1_lblarea").text($("#ctl00_ContentPlaceHolder1_DropDownList2 option:selected").text());
        $("#ctl00_ContentPlaceHolder1_lblbus").text($("#ctl00_ContentPlaceHolder1_DropDownList3 option:selected").text());
        $("#ctl00_ContentPlaceHolder1_lblstopage").text($("#ctl00_ContentPlaceHolder1_DropDownList4 option:selected").text());
        $('#ctl00_ContentPlaceHolder1_preview').css("display", "block");

        $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "none");
        $('#feedetails').css("display", "none");

        return false;
    });

    $("#ctl00_ContentPlaceHolder1_Button5").click(function () {
        $('#ctl00_ContentPlaceHolder1_preview').css("display", "none");

        $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "block");
        $('#feedetails').css("display", "none");
        return false;
    });
    $("#ctl00_ContentPlaceHolder1_Button2").click(function () {
        if ($("#ctl00_ContentPlaceHolder1_ddlMonth").val() == "--Month--") {
            alert("Please select Month.");
            $("#ctl00_ContentPlaceHolder1_ddlMonth").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlDate").val() == "--Date--") {
            alert("Please select Date.");
            $("#ctl00_ContentPlaceHolder1_ddlDate").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlYear").val() == "--Year--") {
            alert("Please select Year.");
            $("#ctl00_ContentPlaceHolder1_ddlYear").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtName").val() == "") {
            alert("Please enter student first name.");
            $("#ctl00_ContentPlaceHolder1_txtName").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtLName").val() == "") {
            alert("Please enter student last name.");
            $("#ctl00_ContentPlaceHolder1_txtLName").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtToDate").val() == "") {
            alert("Please Enter Date of Birth.");
            $("#ctl00_ContentPlaceHolder1_txtToDate").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtFname").val() == "") {
            alert("Please enter father first name.");
            $("#ctl00_ContentPlaceHolder1_txtFname").focus();
            return false;
        }
        if ($("#ctl00_ContentPlaceHolder1_txtlastname1").val() == "") {
            alert("Please enter father last name.");
            $("#ctl00_ContentPlaceHolder1_txtlastname1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddl_Course").val() == 0) {
            alert("Please select class.");
            $("#ctl00_ContentPlaceHolder1_ddl_Course").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlSection").val() == 0) {
            alert("Please select Section.");
            $("#ctl00_ContentPlaceHolder1_ddlSection").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtPAddress").val() == "") {
            alert("Please enter address.");
            $("#ctl00_ContentPlaceHolder1_txtPAddress").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlCountry1").val() == 0) {
            alert("Please select Country.");
            $("#ctl00_ContentPlaceHolder1_ddlCountry1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddl_state").val() == 0) {
            alert("Please select State.");
            $("#ctl00_ContentPlaceHolder1_ddl_state").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlCity1").val() == 0) {
            alert("Please select city.");
            $("#ctl00_ContentPlaceHolder1_ddlCity1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtPZIP").val() == "") {
            alert("Please eneter pin code!");
            $("#ctl00_ContentPlaceHolder1_txtPZIP").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtmob").val() == "") {
            alert("Please enter mobile number.");
            $("#ctl00_ContentPlaceHolder1_txtmob").focus();
            return false;
        }

        $('#ctl00_ContentPlaceHolder1_preview').css("display", "none");

        $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "none");
        $('#feedetails').css("display", "block");

        return false;
    });

    $("#ctl00_ContentPlaceHolder1_Button3").click(function () {
        $('#ctl00_ContentPlaceHolder1_preview').css("display", "none");

        $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "block");
        $('#feedetails').css("display", "none");
        return false;
    });

    $("#ctl00_ContentPlaceHolder1_Button6").click(function (e) {
        if ($("#ctl00_ContentPlaceHolder1_DropDownList1").val() == 0) {
            alert("Please Select Zone.");
            return false;
        }
        else if ($("#ctl00_ContentPlaceHolder1_DropDownList2").val() == 0) {
            alert("Please Select Area.");
            return false;
        }

        else if ($("#ctl00_ContentPlaceHolder1_DropDownList3").val() == 0) {
            alert("Please Select Bus.");
            return false;
        }
        else if ($("#ctl00_ContentPlaceHolder1_DropDownList4").val() == 0) {
            alert("Please Select stoppage.");
            return false;
        }

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

    $('#ctl00_ContentPlaceHolder1_button7').click(function () {
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
        areaid = document.getElementById("ctl00_ContentPlaceHolder1_DropDownList2").value;
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

    $("#ctl00_ContentPlaceHolder1_txtpaimat").on('change', function () {
        var amt1 = 0
        var amt = $("#ctl00_ContentPlaceHolder1_txtpaimat").val();
        var tamount = $("#ctl00_ContentPlaceHolder1_txtpayablefee").val();
        var firmontamount = $("#gridviewpay tr:first-child td :last").text();
        alert(amt);
        alert(firmontamount);
        if (parseFloat(amt) < parseFloat(firmontamount)) {
            alert("Amount should be greater or equal to first selected month fee amount.");
            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_txtpaimat").val(0);
            return false;
        }

        else if (parseFloat(amt) <= parseFloat(tamount)) {
            $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(tamount) - parseFloat(amt));
            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
            return;
        }
        else if (parseFloat(amt) > parseFloat(tamount)) {
            $("#ctl00_ContentPlaceHolder1_lblremainbal").text("amount can not be greater than payable fee amount.");
            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
            $("#ctl00_ContentPlaceHolder1_txtpaimat").val(0);
            return;
        }
    });

    $("#ctl00_ContentPlaceHolder1_DropDownList3").change(function () {
        var bsid = document.getElementById("ctl00_ContentPlaceHolder1_DropDownList3").value;
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
               //ckseat=$("#ctl00_ContentPlaceHolder1_lbseatmsg").text(data.d);
           },
           error: function (result) {
               alert("Error");
           }
       });
    });

    $("#ctl00_ContentPlaceHolder1_Button1").click(function () {
        if ($("#ctl00_ContentPlaceHolder1_ddlMonth").val() == "--Month--") {
            alert("Please select Month.");
            $("#ctl00_ContentPlaceHolder1_ddlMonth").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlDate").val() == "--Date--") {
            alert("Please select Date.");
            $("#ctl00_ContentPlaceHolder1_ddlDate").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlYear").val() == "--Year--") {
            alert("Please select Year.");
            $("#ctl00_ContentPlaceHolder1_ddlYear").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtName").val() == "") {
            alert("Please enter student first name.");
            $("#ctl00_ContentPlaceHolder1_txtName").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtLName").val() == "") {
            alert("Please enter student last name.");
            $("#ctl00_ContentPlaceHolder1_txtLName").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtToDate").val() == "") {
            alert("Please Enter Date of Birth.");
            $("#ctl00_ContentPlaceHolder1_txtToDate").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtFname").val() == "") {
            alert("Please enter father first name.");
            $("#ctl00_ContentPlaceHolder1_txtFname").focus();
            return false;
        }
        if ($("#ctl00_ContentPlaceHolder1_txtlastname1").val() == "") {
            alert("Please enter father last name.");
            $("#ctl00_ContentPlaceHolder1_txtlastname1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddl_Course").val() == 0) {
            alert("Please select class.");
            $("#ctl00_ContentPlaceHolder1_ddl_Course").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlSection").val() == 0) {
            alert("Please select Section.");
            $("#ctl00_ContentPlaceHolder1_ddlSection").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtPAddress").val() == "") {
            alert("Please enter address.");
            $("#ctl00_ContentPlaceHolder1_txtPAddress").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlCountry1").val() == 0) {
            alert("Please select Country.");
            $("#ctl00_ContentPlaceHolder1_ddlCountry1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddl_state").val() == 0) {
            alert("Please select State.");
            $("#ctl00_ContentPlaceHolder1_ddl_state").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlCity1").val() == 0) {
            alert("Please select city.");
            $("#ctl00_ContentPlaceHolder1_ddlCity1").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtPZIP").val() == "") {
            alert("Please eneter pin code!");
            $("#ctl00_ContentPlaceHolder1_txtPZIP").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtmob").val() == "") {
            alert("Please enter mobile number.");
            $("#ctl00_ContentPlaceHolder1_txtmob").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_ddlPayMode").val() == 0) {
            alert("Please select Payment mode.");
            $("#ctl00_ContentPlaceHolder1_ddlPayMode").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtpayablefee").val() == "") {
            alert("Please enter payable amount.");
            $("#ctl00_ContentPlaceHolder1_txtpayablefee").focus();
            return false;
        }

        if ($("#ctl00_ContentPlaceHolder1_txtpaimat").val() == "0.00") {
            alert("Please enter fee amount.");
            $("#ctl00_ContentPlaceHolder1_txtpaimat").focus();
            return false;
        }

        if ($('#ctl00_ContentPlaceHolder1_bankdetail').css('display') == 'block') {
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
                alert("Please enter Draft/Check Date.");
                $("#ctl00_ContentPlaceHolder1_txtCheque").focus();
                return false;
            }

            if ($("#ctl00_ContentPlaceHolder1_txtDate").val() == "") {
                alert("Please enter Draft Date.");
                $("#ctl00_ContentPlaceHolder1_txtDate").focus();
                return false;
            }
        }

        $('#ctl00_ContentPlaceHolder1_preview').css("display", "none");

        $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "none");
        $('#feedetails').css("display", "block");

        var tranType = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
        //alert($("#ctl00_ContentPlaceHolder1_rtransportation :checked").val());
        var fname = $("#ctl00_ContentPlaceHolder1_txtName").val();

        var smname = $("#ctl00_ContentPlaceHolder1_txtmidname").val();
        var slname = $("#ctl00_ContentPlaceHolder1_txtLName").val();
        var sdob = $("#ctl00_ContentPlaceHolder1_txtToDate").val();
        var sfname = $("#ctl00_ContentPlaceHolder1_txtFname").val();
        var sfmname = $("#ctl00_ContentPlaceHolder1_txtmidname1").val();
        var sflname = $("#ctl00_ContentPlaceHolder1_txtlastname1").val();
        var smfname = $("#ctl00_ContentPlaceHolder1_txtmother").val();
        var smmname = $("#ctl00_ContentPlaceHolder1_txtmidname2").val();
        var smlname = $("#ctl00_ContentPlaceHolder1_txtlastname2").val();

        var sgender = $("#ctl00_ContentPlaceHolder1_rbgender :checked").val();

        var scourse = $("#ctl00_ContentPlaceHolder1_ddl_Course option:selected").text();

        var sclassid = $("#ctl00_ContentPlaceHolder1_ddl_Course").val();
        var ssecnme = $("#ctl00_ContentPlaceHolder1_ddlSection option:selected").text();
        var ssecid = $("#ctl00_ContentPlaceHolder1_ddlSection").val()

        var saddress = $("#ctl00_ContentPlaceHolder1_txtPAddress").val();

        var scounty = $("#ctl00_ContentPlaceHolder1_ddlCountry1 option:selected").text();
        var scid = $("#ctl00_ContentPlaceHolder1_ddlCountry1").val()

        var sstate = $("#ctl00_ContentPlaceHolder1_ddl_state option:selected").text();
        var sstatid = $("#ctl00_ContentPlaceHolder1_ddl_state").val()

        var scity = $("#ctl00_ContentPlaceHolder1_ddlCity1 option:selected").text();
        var scityid = $("#ctl00_ContentPlaceHolder1_ddlCity1").val()

        var szipcod = $("#ctl00_ContentPlaceHolder1_txtPZIP").val();

        var smoble = $("#ctl00_ContentPlaceHolder1_txtmob").val();

        var paidamount = $("#ctl00_ContentPlaceHolder1_txtpaimat").val();
        var payable = $("#ctl00_ContentPlaceHolder1_txtpayablefee").val();
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
        var fyid = document.getElementById("ctl00_ContentPlaceHolder1_ddlfinancialyear").value;

        var discountrefno = $("#ctl00_ContentPlaceHolder1_txtdiscountcode").val();
        var admdate = month + "-" + year + "-" + dte;
        var admissionmonth = "";
        var busno = 0;
        var busid = 0;
        var zoneid = 0;
        var areaid = 0;
        var stopageid = 0;
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

        myData.fname = fname;

        myData.mname = smname;
        myData.lname = slname;
        myData.dob = sdob;
        myData.ffname = sfname;

        myData.fmname = sfmname;
        myData.flname = sflname;
        myData.Mnname = smfname;

        myData.mmname = smmname;
        myData.mlname = smlname;
        myData.gender = sgender;

        myData.apclass = scourse;

        myData.classid = sclassid;
        myData.section = ssecnme;

        myData.sectionid = ssecid;
        myData.address = saddress;
        myData.country = scounty;

        myData.countryid = scid;
        myData.state = sstate;
        myData.stateid = sstatid;

        myData.city = scity;

        myData.cityid = scityid;
        myData.pinzcode = szipcod;

        myData.mobile = smoble;

        myData.admissiondate = admdate;

        $("#ctl00_ContentPlaceHolder1_Button1").attr('disabled', 'disabled');
        var DTO = { 'theData': myData };
        $.ajax({
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: "admission-form.asmx/insertdata",
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
});

function FillDataOfAdmission(querystring) {
    if (querystring != "") {
        regno = querystring;
        $('#ctl00_ContentPlaceHolder1_txtRegNo').val(regno);
    }
    if (regno != "") {
        $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "admission-form.asmx/checkregitartion",
        data: "{'regist':'" + regno + "'}",
        dataType: "json",
        success: function (data) {
            if (parseInt(data.d) == parseInt(1)) {
                $('#ctl00_ContentPlaceHolder1_lblmsg').text('');
                $('#ctl00_ContentPlaceHolder1_lblmsg').css("display", "none");

                $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                setTimeout(function () {
                    $.ajax({
                        type: "POST",
                        url: "admission-form.asmx/BindStudentdetail",
                        data: "{'classid':'" + regno + "'}",
                        dataType: 'json',
                        contentType: 'application/json',
                        success: function (data) {
                            $.each(data.d, function (key, value) {
                                var c = jQuery.parseJSON(data);
                                $('#ctl00_ContentPlaceHolder1_txtName').val(value.firstname);
                                $('#ctl00_ContentPlaceHolder1_txtmidname').val(value.middlename);
                                $('#ctl00_ContentPlaceHolder1_txtLName').val(value.lastname);
                                $('#ctl00_ContentPlaceHolder1_txtToDate').val(value.dateofbirth);
                                $('#ctl00_ContentPlaceHolder1_txtFname').val(value.ffirstname);
                                $('#ctl00_ContentPlaceHolder1_txtmidname1').val(value.fmiddlename);
                                $('#ctl00_ContentPlaceHolder1_txtlastname1').val(value.flastname);
                                $('#ctl00_ContentPlaceHolder1_txtmother').val(value.mfirstname);
                                $('#ctl00_ContentPlaceHolder1_txtmidname2').val(value.MmiddleName);
                                $('#ctl00_ContentPlaceHolder1_txtlastname2').val(value.mlastname);
                                $('#ctl00_ContentPlaceHolder1_ddl_Course').val(value.classid);
                                $('#ctl00_ContentPlaceHolder1_lbclassname').text(value.classid);
                                $('#ctl00_ContentPlaceHolder1_txtPZIP').val(value.pincode);
                                $('#ctl00_ContentPlaceHolder1_txtmob').val(value.Fmobileno);
                                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                $("#ctl00_ContentPlaceHolder1_lbclssname").text($("#ctl00_ContentPlaceHolder1_ddl_Course option:selected").text());
                                if (value.classid != "") {
                                    var sid2 = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;
                                    $.ajax({
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "admission-form.asmx/bindsection",
                                        data: "{'sid':'" + sid2 + "'}",
                                        dataType: "json",
                                        success: function (data) {
                                            $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                                            $.each(data.d, function (key, value) {
                                                $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.SID).html(value.sectionname));
                                            });
                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });
                                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                }
                            });
                        }
                    });
                }, 1000);
            }
            else {
                $('#ctl00_ContentPlaceHolder1_lblmsg').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_lblmsg').text('No record found.');
                $('#ctl00_ContentPlaceHolder1_txtName').val('');
                $('#ctl00_ContentPlaceHolder1_txtmidname').val('');
                $('#ctl00_ContentPlaceHolder1_txtLName').val('');
                $('#ctl00_ContentPlaceHolder1_txtToDate').val('');
                $('#ctl00_ContentPlaceHolder1_txtFname').val('');
                $('#ctl00_ContentPlaceHolder1_txtmidname1').val('');
                $('#ctl00_ContentPlaceHolder1_txtlastname1').val('');
                $('#ctl00_ContentPlaceHolder1_txtmother').val('');
                $('#ctl00_ContentPlaceHolder1_txtmidname2').val('');
                $('#ctl00_ContentPlaceHolder1_txtlastname2').val('');
                $('#ctl00_ContentPlaceHolder1_ddl_Course').find('option:first').attr('selected', 'selected');
                $('#ctl00_ContentPlaceHolder1_ddlSection').html('');
                $('#ctl00_ContentPlaceHolder1_txtPAddress').val('');
                $('#ctl00_ContentPlaceHolder1_txtPZIP').val('');
                $('#ctl00_ContentPlaceHolder1_txtmob').val('');
                $('#ctl00_ContentPlaceHolder1_txtClassSec').val('');
                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                return false;
            }
        },
        error: function (result) {
            alert("Error");
        }
    });
    }
}

function Filldiscountdatadetails(qu) {
    if (qu != "") {
        discode = qu;
        $('#ctl00_ContentPlaceHolder1_txtdiscountcode').val(qu);
    }

    $.ajax(
           {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               url: "admission-form.asmx/checkdiscountcode",
               data: "{'discode':'" + discode + "'}",
               dataType: "json",
               success: function (data) {
                   if (parseInt(data.d) == parseInt(0)) {
                       alert(discode + " " + " Not Exist ");
                       $('#ctl00_ContentPlaceHolder1_txtdiscountcode').val('');
                       $('#Container').html('');
                       $("#ctl00_ContentPlaceHolder1_ddl_Course").removeAttr("disabled");
                       $("#ctl00_ContentPlaceHolder1_ddl_Course").val("0");
                   }
                   else {
                       $.ajax(
          {
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "admission-form.asmx/retrieveclassid",
              data: "{'discode':'" + discode + "'}",
              dataType: "json",
              success: function (data) {
                  if (data.d.length > 0) {
                      $.each(data.d, function (key, value) {
                          var c = jQuery.parseJSON(data);

                          $('#ctl00_ContentPlaceHolder1_txtName').val(value.firstname);
                          $('#ctl00_ContentPlaceHolder1_txtmidname').val(value.middlename);
                          $('#ctl00_ContentPlaceHolder1_txtLName').val(value.lastname);
                          $('#ctl00_ContentPlaceHolder1_txtToDate').val(value.dateofbirth);

                          $('#ctl00_ContentPlaceHolder1_txtFname').val(value.ffirstname);
                          $('#ctl00_ContentPlaceHolder1_txtmidname1').val(value.fmddname);
                          $('#ctl00_ContentPlaceHolder1_txtlastname1').val(value.flastname);
                          //$('#ctl00_ContentPlaceHolder1_txtfather').val(value.ffirstname);
                          $('#ctl00_ContentPlaceHolder1_txtmob').val(value.mobileno);
                          $('#ctl00_ContentPlaceHolder1_ddl_Course').val(value.classid);
                          $('#ctl00_ContentPlaceHolder1_txtRegNo').val(value.regno);
                          $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val(value.fyid);
                          if (value.fyid != "") {
                              var fyid = document.getElementById("ctl00_ContentPlaceHolder1_ddlfinancialyear").value;
                              var count1 = 0;
                              $.ajax(
                                  {
                                      type: "POST",
                                      contentType: "application/json; charset=utf-8",
                                      // url: "addbusforsstudent.aspx/bindarea",
                                      url: "admission-form.asmx/setfyear",
                                      data: "{'ddlfyid':'" + fyid + "'}",
                                      dataType: "json",
                                      success: function (data) {
                                          $("#ctl00_ContentPlaceHolder1_ddlYear").html("");
                                          $.each(data.d, function (key, value) {
                                              $("#ctl00_ContentPlaceHolder1_ddlYear").append($("<option></option>").val(count1).html(value.statename));
                                              count1++;
                                          });
                                      },
                                      error: function (result) {
                                          alert("Error");
                                      }
                                  });
                          }

                          if (value.classid != "") {
                              var sid2 = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;
                              $.ajax({
                                  type: "POST",
                                  contentType: "application/json; charset=utf-8",
                                  url: "admission-form.asmx/bindsection",
                                  data: "{'sid':'" + sid2 + "'}",
                                  dataType: "json",
                                  success: function (data) {
                                      $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                                      $.each(data.d, function (key, value) {
                                          $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.SID).html(value.sectionname));
                                      });
                                  },
                                  error: function (result) {
                                      alert("Error");
                                  }
                              });
                          }
                      });

                      // $('#ctl00_ContentPlaceHolder1_lbclassname').text(value.classid);

                      //if (parseInt(data.d) > parseInt(0)) {
                      //    $("#ctl00_ContentPlaceHolder1_ddlstclass").val(parseInt(data.d));
                      $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').attr('disabled', 'disabled');
                      $("#ctl00_ContentPlaceHolder1_ddl_Course").attr('disabled', 'disabled');
                      if (monthid != "--Month--" && discode != "") {
                          $.ajax({
                              type: "POST",
                              url: "admission-form.asmx/getfeeheads",
                              data: "{'classid':'" + parseInt(clsid) + "','trantype':'" + parseInt(transportion) + "','discountcode':'" + discode + "','monthid':'" + parseInt(monthid) + "','daycare':'" + parseInt(daycare) + "'}",
                              //data: "{'classid':'" + classid + "','trantype':'" + parseInt(ar) + "','discountcode':'" + discountcode + "'}",
                              //data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "'}",
                              contentType: "application/json; charset=utf-8",
                              dataType: "json",
                              success: function (data) {
                                  var table = '<table id="grdpay" class="stm"><thead class="stm_head"><tr><th>Fee Name</th><th>Amount</th></thead><tbody>';

                                  for (var i = 0; i < data.d.length; i++) {
                                      var row = '<tr">';

                                      row += '<td><span class="csspayfee1">' + data.d[i].feename + '</span>:</td>';

                                      totalamoutfeeheds = parseFloat(totalamoutfeeheds) + parseFloat(data.d[i].fees);

                                      row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees) + '"></td>';

                                      row += '</tr><br />';

                                      table += row;
                                  }

                                  table += '</tbody></table>';

                                  $('#Container').html(table);
                                  $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(totalamoutfeeheds);
                              }
                          });
                      }
                      if (monthid != "--Month--" && discode != "" && clsid != "--Select Class--") {
                          $.ajax({
                              type: "POST",
                              url: "admission-form.asmx/Bindfeestructure",
                              data: "{'classid':'" + parseInt(clsid) + "','transport':'" + parseInt(transportion) + "','monthid':'" + parseInt(monthid) + "','discountcode':'" + discode + "','daycare':'" + parseInt(daycare) + "'}",
                              contentType: "application/json; charset=utf-8",
                              dataType: "json",
                              success: function (data) {
                                  var table = '<table width="50%" style="margin-top:40px" id="grdfeebind"  class="stm"><thead class="stm_head" HorizontalAlign="Center"><tr><th>Month</th><th>Amount</th></thead><tbody>';

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

                                  $('#divshowfeestucture').html(table);
                              }
                          });

                          $.ajax({
                              type: "POST",
                              url: "admission-form.asmx/getmonthwithfee",
                              data: "{'classid':'" + parseInt(clsid) + "','transport':'" + parseInt(transportion) + "','monthid':'" + parseInt(monthid) + "','discountcode':'" + discode + "','daycare':'" + parseInt(daycare) + "','mode1':'" + mode1 + "','nextfyid':'" + parseInt(nxtfyid) + "'}",

                              //data: "{'classid':'" + sid + "','transport':'" + parseInt(transportvalue) + "','monthid':'" + monthid + "','sfname':'" + fname1 + "','smname':'" + smname1 + "','slname':'" + slname1 + "','sdob':'" + sdob1 + "','ffname':'" + sfname1 + "','ffmane':'" + sfmname1 + "','flname':'" + sflname1 + "','contactno':'" + contactno + "'}",
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
                                  $("#gridviewpay tr:first-child td").css("background-color", "#bbf");
                                  $("#gridviewpay tr:first-child td span input:first").attr("checked", "checked");
                                  $("#gridviewpay tr:first-child td span input:first").attr('disabled', 'disabled');
                                  //alert($("#gridviewpay tr:first-child td:first").html());
                              }
                          });
                      }
                  }
                  else {
                      $('#Container').html('');
                      $("#ctl00_ContentPlaceHolder1_ddl_Course").removeAttr("disabled");
                      return;
                  }
              },
              error: function (result) {
                  alert("Error");
              }
          });

                       return;
                   }
               },
               error: function (result) {
                   alert("Error");
               }
           });
}