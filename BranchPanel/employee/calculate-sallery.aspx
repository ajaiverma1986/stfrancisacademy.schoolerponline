<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="calculate-sallery.aspx.cs" Inherits="BranchPanel_calculate_sallery" %>

<%@ Register Src="employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />
    <style type="text/css">
        #divforprint {
            width: 800px;
            margin: auto;
            text-align: center;
        }

            #divforprint h3 {
                font-weight: normal;
                font-family: Verdana;
                font-size: 13px;
            }

            #divforprint table td {
                padding: 10px;
            }

        .activecalculatesallery {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .txttotaleffectiveday {
            border: dotted 0.05px;
            opacity: 1 !important;
            width: 43px !important;
            text-align: center !important;
        }

        #divcheque .for_sigle_row_form {
            margin-left: -27px !important;
        }

        #divadvancecheck .for_sigle_row_form {
            margin-left: -27px !important;
        }

        #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment {
            width: 100%;
        }

            #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment td {
                width: 50%;
            }

            #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment label {
                width: 44px !important;
                float: left !important;
                padding-top: 2px;
            }

        .paytable {
            width: 100%;
        }

            .paytable td {
                padding: 5px;
            }

        .btnadvanceback {
            cursor: pointer;
            margin-bottom: -132px;
            margin-left: 313px;
            margin-top: -40px;
            position: absolute !important;
        }

        #ctl00_ContentPlaceHolder1_gvdetails_ctl02_txteffectiveday {
            width: 35px !important;
        }

        .showpopup1 {
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #ddd;
            border-right: 0px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            left: 0%;
            /*margin-left: -550px;*/
            opacity: 1;
            padding-bottom: 20px;
            position: absolute;
            width: 1110px;
            z-index: 100;
            /* height: 550px; */
            top: 50%;
            margin-top: -200px;
        }

    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            document.title = 'Salary';

            $('#ctl00_ContentPlaceHolder1_btnsendmailsalaryslip').click(function () {
                alert('Not Activated Till Now');
            });

            $("#ctl00_ContentPlaceHolder1_btnprintforsalarystructure").live("click", function () {
                var divContents = $("#divforprint").html();
                var printWindow = window.open('', '', 'height=400,width=800');
                printWindow.document.write('<html><head><title>DIV Contents</title>');
                printWindow.document.write('</head><body >');
                printWindow.document.write(divContents);
                printWindow.document.write('</body></html>');
                printWindow.document.close();
                printWindow.print();
            });

            $('#ctl00_ContentPlaceHolder1_lbtnsalarystructure').click(function () {
                //$("#divMessage").show(500);
                $("#tab1").fadeIn();
                $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "none");
                $('#divpaynow').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_advancesalary').css("display", "none");
                $('.containerHeadline').css("display", "none");
                $(this).css("display", "none");
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_btnbackofsalarystructure').click(function () {
               // $("#divMessage").hide(1000);
                $("#tab1").fadeIn();
                $('#divpaynow').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "none");
                $('#divadvancepayment').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_lbtnsalarystructure').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_advancesalary').css("display", "block");
                $('.containerHeadline').css("display", "block");
                return false;
            });

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $('#ctl00_ContentPlaceHolder1_advancesalary').click(function () {
                $('#ctl00_ContentPlaceHolder1_lbtnsalarystructure').css("display", "none");
                $(this).css("display", "none");
                $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "none");
                $('#divpaynow').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "none");
                $('#divadvancepayment').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_btnadvancepay').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_btnadvanceback').addClass("btnadvanceback");
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_txtadvancecheckdate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });

            $("#ctl00_ContentPlaceHolder1_txtadvancepaymentdate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });

            $('#ctl00_ContentPlaceHolder1_btnadvanceback').click(function () {
                $('#divpaynow').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "none");
                $('#divadvancepayment').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_txtadvanceamount').val('');
                $('#ctl00_ContentPlaceHolder1_txtadvancepaymentdate').val('');
                $('#ctl00_ContentPlaceHolder1_ddladvancepaymentmode').val('');
                $('#ctl00_ContentPlaceHolder1_txtadvancedescription').val('');
                $('#ctl00_ContentPlaceHolder1_txtadvancebankname').val('');
                $('#ctl00_ContentPlaceHolder1_txtadvancecheckno').val('');
                $('#ctl00_ContentPlaceHolder1_txtadvancecheckdate').val('');
                $('#ctl00_ContentPlaceHolder1_lbtnsalarystructure').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_advancesalary').css("display", "block");
                BindMainGrid();
            });

            $("#ctl00_ContentPlaceHolder1_ddladvancepaymentmode").change(function () {
                var ddlvalue = $('#ctl00_ContentPlaceHolder1_ddladvancepaymentmode').val();
                if (ddlvalue == "2") {
                    $('#divadvancecheck').css("display", "block");
                }
                else {
                    $('#divadvancecheck').css("display", "none");
                }
            });

            $("#ctl00_ContentPlaceHolder1_btnadvancepay").click(function () {
                var state = validateadvancefield();
                if (state != false) {
                    InsertAdvanceSallery();
                    $(this).css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_btnadvanceback').removeClass("btnadvanceback");
                    return false;
                }
                else {
                    return false;
                }
            });
        });

        function InsertAdvanceSallery() {
            var advanceamount = "", advancedate = "", advancepaymentmode = "", advancedescription = "", advancebankname = "", advancecheckno = "", advancecheckdate = "";
            advanceamount = $('#ctl00_ContentPlaceHolder1_txtadvanceamount').val();
            advancedate = $('#ctl00_ContentPlaceHolder1_txtadvancepaymentdate').val();
            advancepaymentmode = $('#ctl00_ContentPlaceHolder1_ddladvancepaymentmode').val();
            advancedescription = $('#ctl00_ContentPlaceHolder1_txtadvancedescription').val();
            advancebankname = $('#ctl00_ContentPlaceHolder1_txtadvancebankname').val();
            advancecheckno = $('#ctl00_ContentPlaceHolder1_txtadvancecheckno').val();
            advancecheckdate = $('#ctl00_ContentPlaceHolder1_txtadvancecheckdate').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "calculate-sallery.aspx/InsertAdvanceSallery",
                data: "{'advanceamount':'" + advanceamount + "','advancedate':'" + advancedate + "','advancepaymentmode':'" + advancepaymentmode + "','payid':'" + payid + "','advancedescription':'" + advancedescription + "','advancebankname':'" + advancebankname + "','advancecheckno':'" + advancecheckno + "','advancecheckdate':'" + advancecheckdate + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alert("Advance payment sucessfull.");
                        return false;
                    }

                    else if (data.d == 2) {
                        alert("You can not give the more than monthly salary.");
                        return false;
                    }

                    else if (data.d == 3) {
                        alert("You can not give the advance sallery more than once in a month.");
                        return false;
                    }
                    else {
                        alert("Advance Payment unsucessfull");
                        return false;
                    }
                },
                error: function (result) {

                }
            });
        }

        function validateadvancefield() {
            if ($('#ctl00_ContentPlaceHolder1_txtadvanceamount').val() == "") {
                alert('Amount can not blank.');
                $('#ctl00_ContentPlaceHolder1_txtadvanceamount').focus();
                return false;
            }
            else if ($('#ctl00_ContentPlaceHolder1_txtadvancepaymentdate').val() == "") {
                alert('Payment date can not blank.');
                $('#ctl00_ContentPlaceHolder1_txtadvancepaymentdate').focus();
                return false;
            }

            else if ($('#ctl00_ContentPlaceHolder1_txtadvancedescription').val() == "") {
                alert('Enter description please.');
                $('#ctl00_ContentPlaceHolder1_txtadvancedescription').focus();
                return false;
            }

            else if ($('#ctl00_ContentPlaceHolder1_ddladvancepaymentmode').val() == "0") {
                alert('Select one of two payment mode either cash or cheque.');
                $('#ctl00_ContentPlaceHolder1_ddladvancepaymentmode').focus();
                return false;
            }

            if ($('#ctl00_ContentPlaceHolder1_ddladvancepaymentmode').val() == "2") {

                if ($('#ctl00_ContentPlaceHolder1_txtadvancebankname').val() == "") {
                    alert('Bank name can not blank.');
                    $('#ctl00_ContentPlaceHolder1_txtadvancebankname').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtadvancecheckno').val() == "") {
                    alert('Cheque number can not blank.');
                    $('#ctl00_ContentPlaceHolder1_txtadvancecheckno').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtadvancecheckdate').val() == "") {
                    alert('Cheque date can not blank.');
                    $('#ctl00_ContentPlaceHolder1_txtadvancecheckdate').focus();
                    return false;
                }
            }

        }
    </script>

    <script type="text/javascript">

        var Dayvalue = "0", payid = "0", maxeffectiveday = "0", changeeffectiveday = "0", row = "", payableamount = "0", empname = "0", adjusttableamount = "0",

            advanceamount = "0", typeofadjustment = "0", openingamount = "0", amounttobepaid = "0", paymentdate = "0", paymentmode = "0",

            bankname = "0", chequeno = "0", chequedate = "0", isclosed = "0", issavecahnge = "0", isconfirm = "0", amountforpaid = "0";

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_txtpaymentdate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });

            $('.Recalculate').click(function () {
                payid = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfrecalculatepayid]").val();
                isclosed = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfisclosed]").val();
                if (parseInt(isclosed) == parseInt(1)) {
                    $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "none");
                    BindGrid();
                    $('#ctl00_ContentPlaceHolder1_gvdetails').find('.makeunedit').find('input').attr("disabled", "disabled");
                    $('#ctl00_ContentPlaceHolder1_gvdetails_ctl02_imgminus').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_gvdetails_ctl02_imgplus').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_btnsavechange').css('display', "none");
                    $('#ctl00_ContentPlaceHolder1_btnpayamount').css('display', "none");
                    return false;
                }
                else {
                    BindMainGrid();
                    $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "none");
                    BindGrid();
                    return false;
                }
            });

            $('.Pay').click(function () {
                amountforpaid = $(this).parents("tr").find('.Recalculatedsalary').html();
                var isclosetemp = "0";
                $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "none");
                payid = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfimgbuttonpaynow]").val();
                isconfirm = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfconfirmpayid]").val();
                isclosetemp = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfisclosedsecond]").val();
                if (parseInt(isconfirm) == parseInt(1)) {
                    alert('You can not pay because you have already paid.')
                    return false;
                }
                else if (parseInt(isclosetemp) == parseInt(0)) {
                    alert('You can not pay because you did not lock the salary.')
                    return false;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "none");
                    $('#divpaynow').css("display", "block");
                    $('#divadvancereport').css("display", "block");
                    $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "none");
                    BindPayDetails(amountforpaid);
                    return false;
                }
            });

            $('#ctl00_ContentPlaceHolder1_btnbackforrecalculate').click(function () {
                $('#divpaynow').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "none");
                $('#divadvancereport').css("display", "none");
                BindMainGrid();
            });

            $('#ctl00_ContentPlaceHolder1_btnpayback').click(function () {
                $('#divpaynow').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_tablemaingrid').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "none");
                $('#divadvancereport').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_txtpayableamount').val('');
                $('#ctl00_ContentPlaceHolder1_txtamounttobepaid').val('');
                $('#ctl00_ContentPlaceHolder1_txtpaymentdate').val('');
                $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val('');
                $('#ctl00_ContentPlaceHolder1_txtbankname').val('');
                $('#ctl00_ContentPlaceHolder1_txtchequenumber').val('');
                $('#ctl00_ContentPlaceHolder1_txtchequedate').val('');
                BindMainGrid();
            });

            $('.txttotaleffectiveday').change(function () {
                var effectivetempsalary = 0.00;
                var textvalue = $(this).val();
                changeeffectiveday = textvalue;
                maxeffectiveday = $('#ctl00_ContentPlaceHolder1_gvdetails_ctl02_hiddennoofworkingdays').val();
                if (parseInt(textvalue) > parseInt(maxeffectiveday)) {
                    alert('Invalid effective days it can not more than the working day.');
                    $(this).val('1');
                    textvalue = "1";
                }
                if ($.isNumeric(textvalue) == false) {
                    alert('Enter only numiric value');
                    $(this).val('1');
                    textvalue = "1";
                }
                effectivetempsalary = $(this).parent("td").find("input[type=hidden][id*=hfsalaryperday]").val();
                effectivetempsalary = parseFloat(effectivetempsalary) * parseInt(textvalue);
                $('.lbltotalcalculatedsallery').html(effectivetempsalary.toFixed(2));
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_gvdetails_ctl02_imgminus').click(function () {
                var effectivetempsalary = 0.00;
                Dayvalue = $('.txttotaleffectiveday').val();
                Dayvalue = (parseFloat(Dayvalue) - 1);
                if (parseFloat(Dayvalue) < parseFloat(0.5)) {
                    Dayvalue = "0";
                    changeeffectiveday = "1";
                }
                else {
                    changeeffectiveday = Dayvalue;
                }
                $('.txttotaleffectiveday').val(Dayvalue);
                effectivetempsalary = $(this).parent("td").find("input[type=hidden][id*=hfsalaryperday]").val();
                effectivetempsalary = parseFloat(effectivetempsalary) * parseFloat(Dayvalue);
                $('.lbltotalcalculatedsallery').html(effectivetempsalary.toFixed(2));
            });

            $('#ctl00_ContentPlaceHolder1_gvdetails_ctl02_imgplus').click(function () {
                var effectivetempsalary = 0.00;
                Dayvalue = $('.txttotaleffectiveday').val();
                maxeffectiveday = $('#ctl00_ContentPlaceHolder1_gvdetails_ctl02_hiddennoofworkingdays').val();
                Dayvalue = (parseFloat(Dayvalue) + 1);
                if (parseInt(Dayvalue) > parseInt(maxeffectiveday)) {
                    Dayvalue = maxeffectiveday;
                }
                $('.txttotaleffectiveday').val(Dayvalue);
                changeeffectiveday = Dayvalue;
                effectivetempsalary = $(this).parent("td").find("input[type=hidden][id*=hfsalaryperday]").val();
                effectivetempsalary = parseFloat(effectivetempsalary) * parseFloat(Dayvalue);
                $('.lbltotalcalculatedsallery').html(effectivetempsalary.toFixed(2));
            });

            $('#ctl00_ContentPlaceHolder1_btnpayamount').click(function () {
                var status = confirm('Are you sure you want to lock salary.? if you lock once you can not recalculate.');
                if (status == true) {
                    isclosed = "1";
                    Lock_Salary();                    
                    $('#ctl00_ContentPlaceHolder1_gvdetails').find('.makeunedit').find('input').attr("disabled", "disabled");
                    $('#ctl00_ContentPlaceHolder1_gvdetails_ctl02_imgminus').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_gvdetails_ctl02_imgplus').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_btnsavechange').css('display', "none");
                    $('#ctl00_ContentPlaceHolder1_btnpayamount').css('display', "none");
                }
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_btnsavechange').click(function () {
                var savestatus = confirm('Are you sure you want to save changes.?');
                if (savestatus == true) {
                    issavecahnge = "1";
                    BindGrid();
                    alert('Your changes saved.');
                }
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_ddlpaymentmode").change(function () {
                var ddlvalue = $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val();
                if (ddlvalue == "2") {
                    $('#divcheque').css("display", "block");
                }
                else {
                    $('#divcheque').css("display", "none");
                }
            });

            $("#ctl00_ContentPlaceHolder1_btnpay").click(function () {
                //Method For validation

                var state = validatefield();
                if (state != false) {
                    //Initilze The Value
                    payableamount = $('#ctl00_ContentPlaceHolder1_txtpayableamount').val();
                    amounttobepaid = $('#ctl00_ContentPlaceHolder1_txtamounttobepaid').val();
                    paymentdate = $('#ctl00_ContentPlaceHolder1_txtpaymentdate').val();
                    paymentmode = $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val();
                    bankname = $('#ctl00_ContentPlaceHolder1_txtbankname').val();
                    chequeno = $('#ctl00_ContentPlaceHolder1_txtchequenumber').val();
                    chequedate = $('#ctl00_ContentPlaceHolder1_txtchequedate').val();
                    InsertSallery();
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtchequedate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy/mm/dd',
                maxDate: new Date()
            });

        });

        function InsertSallery() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "calculate-sallery.aspx/InsertSallery",
                data: "{'payid':'" + payid + "','adjustmenttype':'" + typeofadjustment + "','adjustmentamount':'" + adjusttableamount + "','salleryamount':'" + amounttobepaid + "','payableamount':'" + payableamount + "','paymentmode':'" + paymentmode + "','paymentdate':'" + paymentdate + "','bankname':'" + bankname + "','checkno':'" + chequeno + "','checkdate':'" + chequedate + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alert("Payment Sucessfull.");
                        $('#ctl00_ContentPlaceHolder1_btnpay').css("display", "none");
                        return false;
                    }
                    if (data.d == 2) {
                        alert("You can not give the sallery more than once in a Month.");
                        $('#ctl00_ContentPlaceHolder1_btnpay').css("display", "none");
                        return false;
                    }
                },
                error: function (result) {

                }
            });
        }

        function BindPayDetails(amountforpaid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "calculate-sallery.aspx/BindPayDetailsDatatable",
                data: "{'payid':'" + payid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#ctl00_ContentPlaceHolder1_txtpayableamount').val(amountforpaid);
                        $('#ctl00_ContentPlaceHolder1_lbladvancepaidamount').html(data.d[0].AdvanceAmount);
                        amountforpaid = (parseFloat(amountforpaid) - parseFloat(data.d[0].AdvanceAmount)).toFixed(2);
                        $('#ctl00_ContentPlaceHolder1_lblamounttobepaidafterdeduction').html(amountforpaid);
                        $('#ctl00_ContentPlaceHolder1_txtamounttobepaid').val(amountforpaid);
                    }
                },
                error: function (result) {

                }
            });
        }
        function Lock_Salary() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "calculate-sallery.aspx/LockSalary",
                data: "{'isclosed':'" + isclosed + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 0) {
                        alert('Error during Loking Salary.');
                    }
                    else if (data.d = 3)
                    {
                        alert('Salary Lock Succesfully');
                    }
                },
                error: function (result) {
                }
            });
        }
        function BindGrid() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "calculate-sallery.aspx/BindDatatable",
                data: "{'payid':'" + payid + "','effectivedate':'" + changeeffectiveday + "','issavecahnge':'" + issavecahnge + "','isclosed':'" + isclosed + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_divgrid').css("display", "block");
                    if (data.d.length > 0) {
                        row = $("[id*=gvdetails] tr:last-child").clone(true);
                        $("[id*=gvdetails] tr:not(:first)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != "0") {
                                row = $("[id*=gvdetails] tr:last-child").clone(true);
                            }
                            $("[id$=gvdetails]").append(row);
                            $(row).find('.lbltotalworkingdays').html(data.d[i].workingdayofoffice);
                            $(row).find('.lblemployeeworkingdays').html(data.d[i].workingdayofemployees);
                            $(row).find('.lbltotalunpaidleave').html(data.d[i].totalunpaidleave);
                            $(row).find('.lbltotalpaidleave').html(data.d[i].totalpaidleave);
                            $(row).find('.lbltotallateday').html(data.d[i].totallate);
                            $(row).find('.lbltotalhalfday').html(data.d[i].totalhalfday);
                            $(row).find('.txttotaleffectiveday').val(data.d[i].effectivedays_system);
                            $(row).find('.lbltotalmonthlysallery').html(data.d[i].monthlysalary);
                            $(row).find('.lbltotalcalculatedsallery').html(data.d[i].calculatedsalary);
                        }

                        $("[id*=gvdetails] tr").show();
                        $("[id*=gvdetails] tr:first-child").show();
                    }
                },
                error: function (result) {
                }
            });
        }

        function BindMainGrid() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "calculate-sallery.aspx/BinMainGridDemo",
                data: "{'payid':'" + payid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        row = $("[id*=gridmain] tr:last-child").clone(true);
                        $("[id*=gridmain] tr:not(:first)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != "0") {
                                row = $("[id*=gridmain] tr:last-child").clone(true);
                            }
                            $("[id$=gridmain]").append(row);
                            $(row).find('.RowNumber').html(data.d[i].RowNumber);
                            $(row).find('.Month').html(data.d[i].Month);
                            $(row).find('.monthlysalary').html(data.d[i].monthlysalary);
                            $(row).find('.calculatedsalary').html(data.d[i].calculatedsalary);
                            $(row).find('.Recalculatedsalary').html(data.d[i].Recalculatedsalary);
                            $(row).find('.paystatus').html(data.d[i].paystatus);
                            $(row).find('.taxdeduction').html(data.d[i].deduction);
                            $(row).find("input[type=hidden][id*=hfrecalculatepayid]").val(data.d[i].payid);
                            $(row).find("input[type=hidden][id*=hfisclosed]").val(data.d[i].isclosed);
                            $(row).find("input[type=hidden][id*=hfimgbuttonpaynow]").val(data.d[i].payid);
                            $(row).find("input[type=hidden][id*=hfconfirmpayid]").val(data.d[i].isconfirm);
                            $(row).find("input[type=hidden][id*=hfisclosedsecond]").val(data.d[i].isclosed);
                        }

                        $("[id*=gridmain] tr").show();
                        $("[id*=gridmain] tr:first-child").show();
                    }
                },
                error: function (result) {
                }
            });
        }

        function validatefield() {
            if ($('#ctl00_ContentPlaceHolder1_txtamounttobepaid').val() == "") {
                alert('Amount to be paid can not blank.');
                $('#ctl00_ContentPlaceHolder1_txtamounttobepaid').focus();
                return false;
            }
            else if ($('#ctl00_ContentPlaceHolder1_txtpaymentdate').val() == "") {
                alert('Payment date can not blank.');
                $('#ctl00_ContentPlaceHolder1_txtpaymentdate').focus();
                return false;
            }
            else if ($('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val() == "0") {
                alert('Select one of two payment mode either cash or cheque.');
                $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').focus();
                return false;
            }

            if ($('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val() == "2") {

                if ($('#ctl00_ContentPlaceHolder1_txtbankname').val() == "") {
                    alert('Bank name can not blank.');
                    $('#ctl00_ContentPlaceHolder1_txtbankname').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtchequenumber').val() == "") {
                    alert('Cheque number can not blank.');
                    $('#ctl00_ContentPlaceHolder1_txtchequenumber').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtchequedate').val() == "") {
                    alert('cheque date can not blank.');
                    $('#ctl00_ContentPlaceHolder1_txtchequedate').focus();
                    return false;
                }
            }

            var payableamount = 0, paidamount = 0;
            payableamount = $('#ctl00_ContentPlaceHolder1_txtpayableamount').val();
            paidamount = $('#ctl00_ContentPlaceHolder1_txtamounttobepaid').val();
            if (paidamount > payableamount) {
                alert('You Can Not Give The Sallery More Than Payable Amount.');
                return false;
            }

        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Salary</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <asp:LinkButton ID="lbtnsalarystructure" runat="server" Text="Salary Structure" Style="margin-left: 950px; font-size: 13px !important; margin-bottom: 5px !important"></asp:LinkButton>
        <asp:LinkButton ID="advancesalary" runat="server" Text="Advance Salary" Style="margin-left: 952px; font-size: 13px !important"></asp:LinkButton>
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px; margin-top: 5px"
            class="containerHeadline">
            Salary Report
        </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 50px !important; display: none" id="tablemaingrid" runat="server">
            <tr id="trmaingridrecord" runat="server" style="display: block">
                <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView runat="server" ID="gridmain" ShowHeader="true" AutoGenerateColumns="false"
                        GridLines="None" Width="100%" CssClass="stm">
                        <Columns>
                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="S.No" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblmainserialno" runat="server" Text='<%# Eval("RowNumber") %>' CssClass="RowNumber"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="130px" HeaderText="Month" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblmainmonth" runat="server" Text='<%# Eval("Month") %>' CssClass="Month"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Monthly Salary" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblmainmonthlysalary" runat="server" Text='<%# Eval("monthlysalary") %>' CssClass="monthlysalary"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Sys.calculated salary" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblmaincalculatedsalary" runat="server" Text='<%# Eval("calculatedsalary") %>' CssClass="calculatedsalary"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Recalculated Salary" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecalculatedsalary" runat="server" Text='<%# Eval("Recalculatedsalary") %>' CssClass="Recalculatedsalary"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Tax Deduction" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblresalarydeduction" runat="server" Text='<%# Eval("deduction") %>' CssClass="taxdeduction"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Recalculate" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnrecalculate" runat="server" ImageUrl="~/images/recalculate.png" Style="width: 25px;" CssClass="Recalculate" />
                                    <asp:HiddenField ID="hfrecalculatepayid" Value='<%# Eval("payid") %>' runat="server" />
                                    <asp:HiddenField ID="hfisclosed" Value='<%# Eval("isclosed") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" runat="server" Text='<%# Eval("paystatus") %>' CssClass="paystatus"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Pay" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnpaynow" runat="server" ImageUrl="~/images/paynow.png" Style="width: 30px" CssClass="Pay" />
                                    <asp:HiddenField ID="hfimgbuttonpaynow" Value='<%# Eval("payid") %>' runat="server" />
                                    <asp:HiddenField ID="hfconfirmpayid" Value='<%# Eval("isconfirm") %>' runat="server" />
                                    <asp:HiddenField ID="hfisclosedsecond" Value='<%# Eval("isclosed") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light clseveryrow" />
                        <AlternatingRowStyle CssClass="stm_dark clseveryrow" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
        </table>

        <div id="divgrid" runat="server" style="display: block;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr id="trmessage" style="display: none">
                    <td>
                        <asp:Label ID="lblmessage" runat="server" Text="No Calculated Sallery History For Selected Payid." Style="color: red; font-size: 15px; margin-left: 150px; margin-bottom: 100px !important"></asp:Label>
                    </td>
                </tr>
                <tr id="trgrid" runat="server" style="display: block">
                    <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                        <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                            GridLines="None" Width="100%" CssClass="stm">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="165px" HeaderText="Employee Working Days" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblemployeeworkingdays" runat="server" Text='<%# Eval("workingdayofemployees") %>' CssClass="lblemployeeworkingdays"></asp:Label>
                                        <asp:HiddenField ID="hiddennoofworkingdays" runat="server" Value='<%# Eval("workingdayofoffice") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="130px" HeaderText="Approve Unpaid" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotalunpaidleave" runat="server" Text='<%# Eval("totalunpaidleave") %>' CssClass="lbltotalunpaidleave"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="130px" HeaderText="Unapprove Unpaid" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotalunapproveunpaidleave" runat="server" Text='<%# Eval("unapproveunpaidleave") %>' CssClass="lbltotalunpaidleave"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="110px" HeaderText="Paid" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotalpaidleave" runat="server" Text='<%# Eval("totalpaidleave") %>' CssClass="lbltotalpaidleave"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Late" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotallateday" runat="server" Text='<%# Eval("totallate") %>' CssClass="lbltotallateday"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="95px" HeaderText="Half" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotalhalfday" runat="server" Text='<%# Eval("totalhalfday") %>' CssClass="lbltotalhalfday"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="105px" HeaderText="Employee Effective Days" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="txteffectivedaybysystem" runat="server" Text='<%# Eval("effectivedays_system") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="111px" HeaderText="Admin Effective Days" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Image ID="imgminus" CssClass="imgminus" Style="width: 16px ! important; margin-bottom: 4px !important; cursor: pointer; float: left" runat="server" ImageUrl="~/images/minus.png" />
                                        <asp:TextBox ID="txteffectiveday" runat="server" Text='<%# Eval("effectivedays_changebyadmin") %>' CssClass="txttotaleffectiveday"></asp:TextBox>
                                        <asp:Image ID="imgplus" CssClass="imgplus" Style="width: 15px !important; margin-bottom: 3px !important; cursor: pointer; float: right" runat="server" ImageUrl="~/images/add.png" />
                                        <asp:HiddenField ID="hfsalaryperday" runat="server" Value='<%# Eval("salaryperday") %>' />
                                        <asp:HiddenField ID="hfCutsalaryperday" runat="server" Value='<%# Eval("salaryperday") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Monthly Salary" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotalmonthlysallery" runat="server" Text='<%# Eval("monthlysalary","{0:f}") %>' CssClass="lbltotalmonthlysallery"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="125px" HeaderText="Calculated Salary" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotalcalculatedsallerybysystem" runat="server" Text='<%# Eval("calculatedsalary","{0:f}") %>' CssClass="lblcalculatedsalary"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="125px" HeaderText="Modified Salary" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotalcalculatedsallery" runat="server" Text='<%# Eval("Modifiedsallery","{0:f}") %>' CssClass="lbltotalcalculatedsallery"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light makeunedit" />
                            <AlternatingRowStyle CssClass="stm_dark makeunedit" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <div class="for_sigle_row_form">
                <label>
                    <span style="color: Red"></span>
                </label>
                <asp:Button ID="btnbackforrecalculate" runat="server" OnClientClick="return false;" Text="Back" CssClass="button2" Style="cursor: pointer" />
                <asp:Button ID="btnpayamount" runat="server" OnClientClick="return false" Text="Lock Salary" CssClass="button2" Style="cursor: pointer" />
                <asp:Button ID="btnsavechange" runat="server" Text="Save Changes" OnClientClick="return false;" CssClass="button2" Style="cursor: pointer" />
            </div>
        </div>

        <div class="for_sigle_row_form boxti shadow1" id="divpaynow" style="background-color: #F1F1F1; margin-left: 10px; width: 563px; min-height: 50px; box-shadow: 0 0 5px rgba(152, 150, 150, 0.65); margin-top: 10px !important; margin-bottom: 7px !important; display: none">
            <table class="paytable">
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Payable Amount<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtpayableamount" runat="server" MaxLength="10" ReadOnly="true"></asp:TextBox></td>
                </tr>

                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Amount To Be Paid<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtamounttobepaid" runat="server" ReadOnly="true" MaxLength="10"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Payment Date<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtpaymentdate" runat="server" MaxLength="100"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Payment Mode<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlpaymentmode" runat="server">
                            <asp:ListItem Value="0"> Select One </asp:ListItem>
                            <asp:ListItem Value="1"> Cash </asp:ListItem>
                            <asp:ListItem Value="2"> Cheque </asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>

            <div id="divcheque" style="display: none">

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Bank Name<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtbankname" runat="server" MaxLength="100"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Cheque No<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtchequenumber" runat="server" MaxLength="100"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Cheque Date<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtchequedate" runat="server" MaxLength="100"></asp:TextBox>
                </div>
            </div>

            <div class="for_sigle_row_form" style="margin-left: -25px">
                <label>
                    <span style="color: Red"></span>
                </label>
                <asp:Button ID="btnpay" runat="server" Text="Pay" OnClientClick="return false;" CssClass="button2" Style="cursor: pointer" />
                <asp:Button ID="btnpayback" runat="server" OnClientClick="return false;" Text="Back" CssClass="button2" Style="cursor: pointer" />
            </div>
        </div>

        <div class="for_sigle_row_form boxti shadow1" id="divadvancereport" style="background-color: #F1F1F1; margin-left: 600px; width: 400px; min-height: 50px; box-shadow: 0 0 5px rgba(152, 150, 150, 0.65); margin-top: -219px !important; position: absolute; margin-bottom: 7px !important; display: none">
            <label style="margin-left: 75px; font-size: 15px; color: green !important;">Advance Deduction Report</label>
            <div class="clear"></div>
            <div class="for_sigle_row_form" style="">
                <label>
                    Advanced Amount:
                </label>
                <asp:Label ID="lbladvancepaidamount" runat="server" Style="font-size: 16px"></asp:Label>
            </div>

            <div class="clear"></div>
            <div class="for_sigle_row_form" style="">
                <label>
                    Amount To Be Paid:
                </label>
                <asp:Label ID="lblamounttobepaidafterdeduction" runat="server" Style="font-size: 16px;"></asp:Label>
            </div>
        </div>

        <div class="for_sigle_row_form boxti shadow1" id="divadvancepayment" style="background-color: #F1F1F1; margin-left: 227px; width: 563px; min-height: 50px; box-shadow: 0 0 5px rgba(152, 150, 150, 0.65); margin-top: 10px !important; margin-bottom: 50px !important; display: none">
            <table class="paytable">
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Amount<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtadvanceamount" runat="server" MaxLength="10"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Payment Date<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtadvancepaymentdate" runat="server" MaxLength="100"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Description<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtadvancedescription" runat="server" MaxLength="100"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Payment Mode<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddladvancepaymentmode" runat="server">
                            <asp:ListItem Value="0"> Select One </asp:ListItem>
                            <asp:ListItem Value="1"> Cash </asp:ListItem>
                            <asp:ListItem Value="2"> Cheque </asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <div id="divadvancecheck" style="display: none">

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Bank Name<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtadvancebankname" runat="server" MaxLength="100"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Cheque No<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtadvancecheckno" runat="server" MaxLength="100"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Cheque Date<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtadvancecheckdate" runat="server" MaxLength="100"></asp:TextBox>
                </div>
            </div>
            <div class="for_sigle_row_form" style="margin-left: -25px">
                <label>
                    <span style="color: Red"></span>
                </label>
               
                <asp:Button ID="btnadvancepay" runat="server" Text="Pay" CssClass="button2" Style="cursor: pointer" />
                <asp:Button ID="btnadvanceback" runat="server" OnClientClick="return false;" Text="Back" CssClass="button2" Style="cursor: pointer; margin-top:-28px" />
            </div>
        </div>

        
       <%-- <div class="clear"></div>
        <div class="for_sigle_row_form" style="margin-top: 20px !important;">
            <label>
                <span style="color: Red"></span>
            </label>
            <asp:Button ID="btnbackofsalarystructure" runat="server" Text="Back" CssClass="button2" Style="cursor: pointer;" />
            <asp:Button ID="btnprintforsalarystructure" runat="server" OnClientClick="return false;" Text="Print" CssClass="button2" Style="cursor: pointer;" />
            <asp:Button ID="btnsendmailsalaryslip" runat="server" OnClientClick="return false;" Text="Mail" CssClass="button2" Style="cursor: pointer; margin-right: 300px !important;" />
        </div>
       
   --%>
</asp:Content>