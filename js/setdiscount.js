/// <reference path="admissionform.js" />
/// <reference path="admissionform.js" />
/// <reference path="../BranchPanel/admission-form.asmx" />
var regno, actualovertotalfee = 0;
$(document).ready(function () {
    var actualamt = 0, taoatalamt = 0, dicountamt = 0, netamt = 0, count = 1, Fromdate = '', Todate = '', year = 2025;
    //Binding Of Class Code Start Here
    BindClass();
    $("#ctl00_ContentPlaceHolder1_txtDate,#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd MM yy',
        yearRange: '2000:' + year
    });
    //Change Event Of Class Start Here
    $("#ctl00_ContentPlaceHolder1_ddl_Course").change(function (e) {
        var transportvalue = 1;
        var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;
        var actualovertotalfee = 0;
        $("#spandiscount").html('0.00');
        $('#totalfee').html('0.00');
        $("#Span2").html('0.00');
        $('#Container').html('');
        if (sid != "0") {
            $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    url: "../admission-form.asmx/getfeeheadstotalwise",
                    data: "{'classid':'" + sid + "','transport':'" + transportvalue + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) { debugger
                        var table = '<table id="grdpay"  cellpadding="0" cellspacing="0" border="0" align="center"  style="margin-right:180px;" width="100%" class="stm"><thead class="stm_head"><tr><th>Fee Head</th><th>Fee Category</th><th>Actual Amount</th><th>Discount Type</th><th>Duration in Month</th><th>Discount Amount</th><th>Net Amount</th></thead><tbody>';
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                var row = '<tr class="clsmaintr">';
                                row += '<td><input type="hidden" id="hffeecatid" value=' + data.d[i].feecatgryId + ' /><input type="hidden" id="hffeecfid" value=' + data.d[i].cfid + ' /><span class="csspayfee1">' + data.d[i].feename + '</span>:</td>';
                                row += '<td><span>' + data.d[i].feecatgry + '</span> </td>';
                                row += '<td><input disabled="disabled" class="cscfeepay" type=text value="' + parseFloat(data.d[i].fees).toFixed(2) + '"></td>';
                                if (data.d[i].feecatgryId == "3" || data.d[i].feecatgryId == "4" || data.d[i].feecatgryId == "5") {
                                    row += '<td><select id="ddlshowmonth" runat="server" ><option value="1">One Time</option><option value="2">Recurring</option></select></td>';
                                }
                                else {
                                    row += '<td ><select id="ddlshowmonth" style="display:none;"><option value="1">One Time</option><option value="2">Recurring</option></select></td>';
                                }
                                if (data.d[i].feecatgryId == "5") {
                                    row += "<td ><div id='divbindmonthly' style='max-height: 150px;overflow:scroll;'><table id='tblbindmonthlyfee' style='width:196px;'><tbody></tbody></table></div></td>";
                                }
                                else if (data.d[i].feecatgryId == "4") {
                                    row += "<td ><div id='divbindquaterly' style='display:none'><table id='tblbindquaterlyfee' style='width:197px;'>" +
                                           "<tr><td><input type='checkbox' value='4'></td><td><span id='span1'>Ist</span></td></tr>" +
                                           "<tr><td><input type='checkbox' value='7'></td><td><span id='span2'>IInd</span></td></tr>" +
                                           "<tr><td><input type='checkbox' value='10'></td><td><span id='span3'>IIIrd</span></td></tr>" +
                                           "<tr><td><input type='checkbox' value='1'></td><td><span id='span4'>IVth</span></td></tr>" +
                                           "</table></div></td>";
                                }
                                else if (data.d[i].feecatgryId == "3") {
                                    row += "<td ><div id='divbindhalfyearly' style='display:none'><table id='tblbindhalfyearlyfee' style='width:197px;'>" +
                                           "<tr><td><input type='checkbox' value='4'></td><td><span id='span1'>Ist</span></td></tr>" +
                                           "<tr><td><input type='checkbox' value='10'></td><td><span id='span2'>IInd</span></td></tr>" +
                                           "</table></div></td>";
                                }
                                else {
                                    row += '<td ><select id="ddlfornothingforselect" style="display:none;"><option value="1">One Time</option><option value="2">Recurring</option></select></td>';
                                }
                                row += '<td class="tdtextboxofdiscountamount"><input id="txtdiscount" onkeypress="return noAlphabets(event)" class="txdiscount" type=text placeholder="' + parseFloat(0).toFixed(2) + '"></td>';
                                row += '<td class="tdlblforamountaftertax"><span class="spanpayableamountafterdiscount">' + parseFloat(data.d[i].fees).toFixed(2) + '</span></td>';
                                actualovertotalfee = parseFloat(actualovertotalfee) + parseFloat(data.d[i].fees);
                                row += '</tr><br/>';
                                table += row;
                            }
                        }
                        else {
                            table = '<tbody><tr><td><span style="color:red;font-weight:bold;margin-left:150px">Sorry.....!!! No Fee Type Added For The Selected Class.For More Details Contact To Admin.</span></td></tr>'
                        }
                        table += '</tbody></table>';
                        $("#spandiscount").html('0.00');
                        $('#totalfee').html(actualovertotalfee);
                        $("#Span2").html(actualovertotalfee);
                        $('#Container').html(table);
                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                        $("table tr th:first-child").css("border-left", "none");
                    }
                }, 1000);
            });
        }
    });

    $('#ddlshowmonth').live("change", function () {
        var trindex = 0, trforappend = '';
        trindex = $(this).parent('td').parent('tr').index();
        var distype = $(this).val();
        var feehead = $(this).closest('tr').find('td:eq(0) input[type="hidden"][id*="hffeecatid"]').val();
        if ($(this).val() == '1') {
            $(this).closest('tr').find('#divbindmonthly').css('display', 'none');
            $(this).closest('tr').find('#divbindquaterly').css('display', 'none');
            $(this).closest('tr').find('#divbindhalfyearly').css('display', 'none');
        }
        else if ($(this).val() == '2') {
            if (feehead == "5") {
                $('#grdpay').find('tbody').find('tr.clsmaintr:eq(' + trindex + ')').find('td:eq(4)').find('#divbindmonthly').find("table tr").remove();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../admission-form.asmx/bindmonth",
                    dataType: "json",
                    success: function (data) {
                        trforappend = trforappend + '' + "<tr class='realmonth'><th><input id='chkmnth' type='checkbox' class='chekallmanth'>Check For All Months</th></tr>"
                        $.each(data.d, function (key, value) {
                            trforappend = trforappend + '' + "<tr class='realmonth'><td><input type='checkbox' class='chkall' name='myhighlights' value='" + value.mid + "'>&nbsp;&nbsp;</input><label>" + value.monthname + "</label></td></tr>";
                        });
                        $('#grdpay').find('tbody').find('tr.clsmaintr:eq(' + trindex + ')').find('td:eq(4)').find('#divbindmonthly').find("table").html(trforappend);
                    }
                });
                $(this).parent('td').parent('tr.clsmaintr').find('td:eq(4)').find('#divbindmonthly').css('display', 'block');
            }
            else if (feehead == "4") {
                $(this).closest('tr').find('#divbindquaterly').css('display', 'block');
            }
            else if (feehead == "3") {
                $(this).closest('tr').find('#divbindhalfyearly').css('display', 'block');
            }
        }
    });

    $('.txdiscount').live('keyup change', function () {
        var netamountafterdiscount = 0
        if ($(this).val() == "") {
            discountamt = 0;
        }
        else {
            discountamt = parseFloat($(this).val()).toFixed(2);
        }
        actualamt = $(this).closest('tr').find('td:eq(2) input[type=text]:first-child').val();
        netamt = $(this).closest('tr').find('td.tdlblforamountaftertax span:first-child').text();
        if (parseFloat(actualamt) >= parseFloat(discountamt)) {
            netamt = parseFloat(actualamt) - parseFloat(discountamt);
            $("#Span2").html((parseFloat(netamountafterdiscount) - parseFloat(actualamt)) + parseFloat(netamt));
            $(this).closest('tr').find('td.tdlblforamountaftertax span:first-child').html(parseFloat(netamt).toFixed(2));
            $("#grdpay tr:has(td)").find('td.tdtextboxofdiscountamount input[type=text]').each(function () {
                if ($(this).val() == "") {
                    netamountafterdiscount = parseFloat(netamountafterdiscount) + parseFloat(0.00);
                }
                else {
                    netamountafterdiscount = parseFloat(netamountafterdiscount) + parseFloat($(this).val());
                }
            });
            $("#spandiscount").html(netamountafterdiscount);
            $("#totalfee").html();
            $("#Span2").html(parseFloat($("#totalfee").html()) - parseFloat($("#spandiscount").html()));
        }
        else {
            alert("Discount Amount can't exceed than actual amount.");
            $(this).val('');
            discountamt = 0.00;
            netamt = parseFloat(actualamt) - parseFloat(discountamt);
            $("#Span2").html((parseFloat(netamountafterdiscount) - parseFloat(actualamt)) + parseFloat(netamt));
            $(this).closest('tr').find('td.tdlblforamountaftertax span:first-child').html(parseFloat(netamt).toFixed(2));
            $("#grdpay tr:has(td)").find('td.tdtextboxofdiscountamount input[type=text]').each(function () {
                if ($(this).val() == "") {
                    netamountafterdiscount = parseFloat(netamountafterdiscount) + parseFloat(0.00);
                }
                else {
                    netamountafterdiscount = parseFloat(netamountafterdiscount) + parseFloat($(this).val());
                }
            });
            $("#spandiscount").html(netamountafterdiscount);
            $("#totalfee").html();
            $("#Span2").html(parseFloat($("#totalfee").html()) - parseFloat($("#spandiscount").html()));
        }
    });

    $("#ctl00_ContentPlaceHolder1_Button2").click(function () {
        if ($("#ctl00_ContentPlaceHolder1_txtName").val() == "") {
            alert("Please enter student first name.");
            $("#ctl00_ContentPlaceHolder1_txtName").focus();
            return false;
        }

        //else if ($("#ctl00_ContentPlaceHolder1_txtLName").val() == "") {
        //    alert("Please enter student last name.");
        //    $("#ctl00_ContentPlaceHolder1_txtLName").focus();
        //    return false;
        //}

        else if ($("#ctl00_ContentPlaceHolder1_txtToDate").val() == "") {
            alert("Please select date of birth.");
            $("#ctl00_ContentPlaceHolder1_txtToDate").focus();
            return false;
        }

        else if ($("#ctl00_ContentPlaceHolder1_txtFname").val() == "") {
            alert("Please enter parent first name.");
            $("#ctl00_ContentPlaceHolder1_txtFname").focus();
            return false;
        }
        //else if ($("#ctl00_ContentPlaceHolder1_txtPlastname").val() == "") {
        //    alert("Please enter parent last name.");
        //    $("#ctl00_ContentPlaceHolder1_txtlastname1").focus();
        //    return false;
        //}
        else if ($("#ctl00_ContentPlaceHolder1_txtPAddress").val() == "") {
            alert("Please enter parent address.");
            $("#ctl00_ContentPlaceHolder1_txtPAddress").focus();
            return false;
        }

        else if ($("#ctl00_ContentPlaceHolder1_txtmob").val() == "") {
            alert("Please enter parent mobile number.");
            $("#ctl00_ContentPlaceHolder1_txtmob").focus();
            return false;
        }
        var DiscounDate = $("#ctl00_ContentPlaceHolder1_txtDate").val();
        var Refno;
        if ($("#ctl00_ContentPlaceHolder1_txtRegNo").val() != '') {
          Refno = $("#ctl00_ContentPlaceHolder1_txtRegNo").val();
        }
        else if ($("#ctl00_ContentPlaceHolder1_txtadmissionno").val() != '') {
            Refno = $("#ctl00_ContentPlaceHolder1_txtadmissionno").val();
        }
        var Sfname = $("#ctl00_ContentPlaceHolder1_txtName").val();
        var Smname = $("#ctl00_ContentPlaceHolder1_txtmidname").val();
        var Slname = $("#ctl00_ContentPlaceHolder1_txtLName").val();
        var Sclassid = $("#ctl00_ContentPlaceHolder1_ddl_Course").val();
        var SDob = $("#ctl00_ContentPlaceHolder1_txtToDate").val();
        var Pfname = $("#ctl00_ContentPlaceHolder1_txtFname").val();
        var Pmname = $("#ctl00_ContentPlaceHolder1_txtPmidname").val();
        var Plname = $("#ctl00_ContentPlaceHolder1_txtPlastname").val();
        var Pmobileno = $("#ctl00_ContentPlaceHolder1_txtmob").val();
        var Paddress = $("#ctl00_ContentPlaceHolder1_txtPAddress").val();
        var Fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();
        var CommentORRemark = $("#ctl00_ContentPlaceHolder1_txtcommentorremark").val();
        //For Find Fee And Discount All That Start Here
        var FeeStructureOnTheBehlafOfCFID = '', CFID = '', FeeTypeId = '', DiscountAmount = 0.00, DiscountType = '', DiscountTypeId = '';
        $('#grdpay').find('tbody').find('tr.clsmaintr').each(function () {
            DiscountAmount = 0.00, DiscountType = '0', DiscountTypeId = '0';
            CFID = $(this).find('td:eq(0) input[type="hidden"][id*="hffeecfid"]').val();

            FeeTypeId = $(this).find('td:eq(0) input[type="hidden"][id*="hffeecatid"]').val();
            if (FeeTypeId == "1" || FeeTypeId == "2") {
                DiscountAmount = $(this).find('td.tdtextboxofdiscountamount').find('input[type="text"]').val();
                if (DiscountAmount == "")
                    DiscountAmount = 0.00;
            }
            else if (FeeTypeId == "3") {
                DiscountAmount = $(this).find('td.tdtextboxofdiscountamount').find('input[type="text"]').val();
                if (DiscountAmount == "")
                    DiscountAmount = 0.00;
                DiscountType = $(this).find('td:eq(3)').find('#ddlshowmonth').val();
                if (DiscountType == '2') {
                    $(this).find('#divbindhalfyearly').find('#tblbindhalfyearlyfee').find('tbody').find('tr').each(function () {
                        if ($(this).find('td').find('input[type="checkbox"]').prop('checked')) {
                            DiscountTypeId = DiscountTypeId + '@' + $(this).find('td').find('input[type="checkbox"]').val();
                        }
                    });
                }
                else {
                    DiscountTypeId = DiscountTypeId + '@' + '0';
                }
                DiscountTypeId = DiscountTypeId.slice(2, DiscountTypeId.length);
                if (parseInt(DiscountAmount) == 0)
                    DiscountTypeId = '0';
            }
            else if (FeeTypeId == "4") {
                DiscountAmount = $(this).find('td.tdtextboxofdiscountamount').find('input[type="text"]').val();
                if (DiscountAmount == "")
                    DiscountAmount = 0.00;
                DiscountType = $(this).find('td:eq(3)').find('#ddlshowmonth').val();
                if (DiscountType == '2') {
                    $(this).find('#divbindquaterly').find('#tblbindquaterlyfee').find('tbody').find('tr').each(function () {
                        if ($(this).find('td').find('input[type="checkbox"]').prop('checked')) {
                            DiscountTypeId = DiscountTypeId + '@' + $(this).find('td').find('input[type="checkbox"]').val();
                        }
                    });
                }
                else {
                    DiscountTypeId = DiscountTypeId + '@' + '0';
                }
                DiscountTypeId = DiscountTypeId.slice(2, DiscountTypeId.length);
                if (parseInt(DiscountAmount) == 0)
                    DiscountTypeId = '0';
            }
            else if (FeeTypeId == "5") {
                DiscountAmount = $(this).find('td.tdtextboxofdiscountamount').find('input[type="text"]').val();
                if (DiscountAmount == "")
                    DiscountAmount = 0.00;
                DiscountType = $(this).find('td:eq(3)').find('#ddlshowmonth').val();
                if (DiscountType == '2') {
                    $(this).find('#divbindmonthly').find('#tblbindmonthlyfee').find('tbody').find('tr').each(function () {
                        if ($(this).find('td').find('input[type="checkbox"]').prop('checked')) {
                            DiscountTypeId = DiscountTypeId + '@' + $(this).find('td').find('input[type="checkbox"]').val();
                        }
                    });
                }
                else {
                    DiscountTypeId = DiscountTypeId + '@' + '0';
                }
                DiscountTypeId = DiscountTypeId.slice(2, DiscountTypeId.length);
                if (parseInt(DiscountAmount) == 0)
                    DiscountTypeId = '0';
            }
            FeeStructureOnTheBehlafOfCFID = FeeStructureOnTheBehlafOfCFID + '~' + CFID + ',' + FeeTypeId + ',' + DiscountType + ',' + DiscountTypeId + ',' + DiscountAmount;
        });
        FeeStructureOnTheBehlafOfCFID = FeeStructureOnTheBehlafOfCFID.slice(1, FeeStructureOnTheBehlafOfCFID.length);
        var MyData = {};
        MyData.RegNo = Refno;
        MyData.Fyid = Fyid;
        MyData.Sfname = Sfname;
        MyData.Smname = Smname;
        MyData.Slname = Slname;
        MyData.Sdob = SDob;
        MyData.Applyclass = Sclassid;
        MyData.Pfname = Pfname;
        MyData.Pmname = Pmname;
        MyData.Plname = Plname;
        MyData.Address = Paddress;
        MyData.Mobile = Pmobileno;
        MyData.DiscountDate = DiscounDate;
        MyData.FeeStructure = FeeStructureOnTheBehlafOfCFID;
        MyData.CommentORRemark = CommentORRemark;
        var DTO = { 'theData': MyData };
        $.ajax({
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: "../admission-form.asmx/InsertDiscountData",
            data: JSON.stringify(DTO),
            success: function (data) {
                alert(data.d);
                ClearData();
                //window.location.replace("discount-list.aspx");               
            }
        });
        FeeStructureOnTheBehlafOfCFID = '', CFID = '', FeeTypeId = '', DiscountAmount = 0.00, DiscountType = '', DiscountTypeId = '';
        return false;
        //For Find Fee And Discount All That End Here
    })

    $('.chekallmanth').live("change", function () {
        $(this).parent('th').parent('tr').parent('tbody').parent('table').find('input[type="checkbox"]').prop('checked', $(this).prop('checked'));
    });

    $('#ctl00_ContentPlaceHolder1_txtRegNo,#ctl00_ContentPlaceHolder1_txtadmissionno').change(function () {
        var Registration_NoOrAdmissionNo = '';
        if ($('#ctl00_ContentPlaceHolder1_txtRegNo').val() != '') {
            Registration_NoOrAdmissionNo = $('#ctl00_ContentPlaceHolder1_txtRegNo').val();
            $('#ctl00_ContentPlaceHolder1_txtadmissionno').val('');
        }
        else if ($('#ctl00_ContentPlaceHolder1_txtadmissionno').val() != '') {
            Registration_NoOrAdmissionNo = $('#ctl00_ContentPlaceHolder1_txtadmissionno').val();
            $('#ctl00_ContentPlaceHolder1_txtRegNo').val('');
        }
        if ($(this).val() != '') {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "../admission-form.asmx/GetDetailsOnTheBehalfOfRegistrationNo",
                data: "{'Registration_No':'" + Registration_NoOrAdmissionNo + "'}",
                success: function (data) {
                    if (data.d != '<NewDataSet />') {
                        var xmlStudent = $.parseXML(data.d);
                        var xmlDoc = $(xmlStudent);
                        var TableStudent = xmlDoc.find("Table");
                        TableStudent.each(function () {
                            var CurrentTmerRow = $(this);
                            $("#ctl00_ContentPlaceHolder1_txtName").val(CurrentTmerRow.find("StudentFirstName").text());
                            $("#ctl00_ContentPlaceHolder1_txtmidname").val(CurrentTmerRow.find("StudentMiddleName").text());
                            $("#ctl00_ContentPlaceHolder1_txtLName").val(CurrentTmerRow.find("StudentLastName").text());
                            $("#ctl00_ContentPlaceHolder1_txtToDate").val(CurrentTmerRow.find("StudentDOB").text());
                            $("#ctl00_ContentPlaceHolder1_txtFname").val(CurrentTmerRow.find("PrimaryParentFirstName").text());
                            $("#ctl00_ContentPlaceHolder1_txtPmidname").val(CurrentTmerRow.find("PrimaryParentMiddleName").text());
                            $("#ctl00_ContentPlaceHolder1_txtPlastname").val(CurrentTmerRow.find("PrimaryParentLastName").text());
                            $("#ctl00_ContentPlaceHolder1_txtmob").val(CurrentTmerRow.find("PrimaryMobileNo").text());
                            $("#ctl00_ContentPlaceHolder1_txtPAddress").html(CurrentTmerRow.find("Address").text());
                            $("#ctl00_ContentPlaceHolder1_ddl_Course").val(CurrentTmerRow.find("ApplyingForClass").text());
                            $("#ctl00_ContentPlaceHolder1_ddl_Course").change();
                        });
                    }
                    else {
                        if ($('#ctl00_ContentPlaceHolder1_txtadmissionno').val() != '') {
                            alert('Sorry..!!!!! Invalid Admission No.');
                        }
                        else if ($('#ctl00_ContentPlaceHolder1_txtadmissionno').val() != '') {
                            alert('Sorry..!!!!! Invalid Registration No.');
                        }
                        $("#ctl00_ContentPlaceHolder1_ddl_Course").val('0');
                        $("#ctl00_ContentPlaceHolder1_ddl_Course").change();
                        ClearData();
                    }
                }
            });
        }
    });
});

function BindClass() {
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        url: "../admission-form.asmx/binclass",
        data: "{}",
        success: function (data) {
            $("#ctl00_ContentPlaceHolder1_ddl_Course").html("");
            $.each(data.d, function (key, value1) {
                $("#ctl00_ContentPlaceHolder1_ddl_Course").append($("<option></option>").val(value1.SID).html(value1.statename));
            });
        }
    });
}

function ClearData() {
    $("#ctl00_ContentPlaceHolder1_txtDate").val('');
    $("#ctl00_ContentPlaceHolder1_txtRegNo").val('');
    $("#ctl00_ContentPlaceHolder1_txtName").val('');
    $("#ctl00_ContentPlaceHolder1_txtmidname").val('');
    $("#ctl00_ContentPlaceHolder1_txtLName").val('');
    $("#ctl00_ContentPlaceHolder1_ddl_Course").val('0');
    $("#ctl00_ContentPlaceHolder1_txtToDate").val('');
    $("#ctl00_ContentPlaceHolder1_txtFname").val('');
    $("#ctl00_ContentPlaceHolder1_txtPmidname").val('');
    $("#ctl00_ContentPlaceHolder1_txtPlastname").val('');
    $("#ctl00_ContentPlaceHolder1_txtmob").val('');
    $("#ctl00_ContentPlaceHolder1_txtPAddress").val('');
    $('#ctl00_ContentPlaceHolder1_txtadmissionno').val('');
}
function lettersOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
 ((evt.which) ? evt.which : 0));
    if (charCode > 32 && (charCode < 65 || charCode > 90) &&
 (charCode < 97 || charCode > 122)) {
        return false;
    }
    else
        return true;
};
function noAlphabets(event) {
    var charCode = (event.which) ? event.which : event.keyCode
    if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
         && (charCode <= 90))
        return false;
    return true;
};