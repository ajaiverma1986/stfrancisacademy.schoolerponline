<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OnlineFeePay.aspx.cs" Inherits="OnlineFeePay" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Student Information</title>
    <%-- css Link--%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%--<link href="../css/softwares_style.css" rel="stylesheet" type="text/css" />--%>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0' />
    <link href="../css/responsive.css" rel="stylesheet" />

    <link href="css/fullcalendar.css" rel="stylesheet" />
    <link href="css/datatables.css" rel="stylesheet" />
    <link href="css/bootstrap.datatables.css" rel="stylesheet" />
    <link href="css/chosen.css" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="css/app.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../css/font.css" />
    <link rel="shortcut icon" href="../images/favicon.ico" />
    <link href="../css/alertify.core.css" type="text/css" media="all" rel="stylesheet" />
    <link href="../css/alertify.default.css" type="text/css" media="all" rel="stylesheet" />
    <%-- J Query Link--%>

    <script src="../js/alertify.js" type="text/javascript"></script>
    <script src="../js/jquery-1.8.2.js" type="text/javascript"></script>
    <%-- <script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui.min.js" type="text/javascript"> </script>--%>
    <script type="text/javascript" src="../js/app.v1.js"></script>
    <%--Old Script Start Here--%>
    <link href="../js/1.8-themes-base-jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>



    <script src="js/jquery.sparkline.min.js" type="text/javascript"> </script>
    <script src="js/tab.js" type="text/javascript"> </script>
    <script src="js/dropdown.js" type="text/javascript"> </script>
    <script src="js/collapse.js" type="text/javascript"> </script>
    <script src="js/transition.js" type="text/javascript"> </script>
    <script src="js/tooltip.js" type="text/javascript"> </script>
    <script src="js/jquery.knob.js" type="text/javascript"> </script>
    <script src="js/fullcalendar.min.js" type="text/javascript"> </script>
    <script src="../js/datatables/datatables.min.js" type="text/javascript"> </script>
    <script src="js/chosen.jquery.min.js" type="text/javascript"> </script>
    <script src="js/bootstrap.datatables.js" type="text/javascript"> </script>
    <script src="js/color_settings.js" type="text/javascript"> </script>
    <script src="js/application.js" type="text/javascript"> </script>
    <script src="../js/alertify.js" type="text/javascript"></script>

    <style type="text/css">
        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 65%;
            height: 85%;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }
    </style>
    <style>
        #loader {
            position: relative;
            top: 10%;
        }

        .progress {
            display: none;
        }

        .progressAdd {
            display: block;
            position: fixed;
            background: -moz-linear-gradient(center top, #fff, #fff) repeat scroll 0 0 rgba(0, 0, 0, 0);
            z-index: 2147483647 !important;
            opacity: 0.8;
            overflow: hidden;
            text-align: center;
            top: 0;
            left: 0;
            height: 100%;
            vertical-align: middle;
            width: 100%;
            padding-top: 20%;
        }
    </style>
    <style type="text/css">
        .activestudentadmissionlist {
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

        .dashboard-boxes h3 {
            font-size: 13px !important;
        }

        /*.ui-datepicker {
            background: cadetblue;
            border: 1px solid #555;
            color: #EEE;
        }

        .ui-datepicker-title {
            margin-top: -34px;
            width: 100%;
        }

        .ui-datepicker-year {
            margin-left: 15px;
        }

        .ui-datepicker-month {
            margin-left: 25px;
        }*/
    </style>
    <style type="text/css">
        .calenderactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .for_sigle_row_form {
            margin-left: 0px !important;
        }

        #Grid_Calender_ctl03_lblsaturday {
            width: 200px !important;
        }

        .activelistofholiday {
            border-color: #2d9fdd !important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd !important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        #Grid_Calender td span {
            width: 100% !important;
        }

        #Grid_Calender th {
            background-color: #82403B;
            color: white !important;
            font-size: 20px !important;
        }

        #Grid_Calender td {
            border-left: 2px solid #CDCDCD !important;
            height: 50px !important;
        }

        #Grid_Calender {
            border: 2px solid #CDCDCD !important;
        }

        #contentPane {
            min-height: 440px !important;
        }

        .stm td {
            color: #333;
            line-height: 12px !important;
            text-align: center;
        }

        .overflow {
            overflow: auto !important;
            border-radius: 10px;
            border: 3px solid #82403B;
        }
    </style>
    <script type="text/javascript">
        var myData = {}, asaid = 0, trindexforpay = 0;
        var stdRegNo = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&')[0].split('=')[1];
        //CheckLoginDetails(stdRegNo);

        $(document).ready(function () {
            $("#txtpaydate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            })
            $("#txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            })
            $("#txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                minDate: new Date()
            })
            $('.ImgBtnForInstallmentDetails').live('click', function () {
                alert('INSTALLMENT NAME:' + $(this).parent('td').find('.SpanInstallmentName').text() + '\nINSTALLMENT DETAILS/BREAKUP:' + $(this).parent('td').find('.SpanInstallmentDetails').text() + '\nDISCOUNT DETAILS:' + $(this).parent('td').find('.SpanDiscountDetails').text() + '');
                return false;
            });
            var j = 0;
            $('.ImgBtnForPayNow').live('change', function () {             
                    trindexforpay = $(this).parent('td').parent('tr').index();
                    asaid = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                    $('#hfforasaid').val(asaid);
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../BranchPanel/StudentManagement/student-fee-info.aspx//BindPayNow",
                        data: "{'ASAID':'" + asaid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            var xmlDocGeneralDetails = $.parseXML(data.d);
                            var xmlGeneralDetails = $(xmlDocGeneralDetails);
                            var TableGeneralDetails = xmlGeneralDetails.find("Table");
                            var i = 0, Class = "";
                            TableGeneralDetails.each(function () {
                                var CurrentDeailsRow = $(this);
                                if (j > 0) {
                                    if ($('#GrdPayNow').find('tr:eq(' + trindexforpay + ')').find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == false) {
                                        j--;
                                    }
                                    alertify.error('You can pay only one Month Fee Only !');
                                }
                                else {
                                    if ($('#GrdPayNow').find('tr:eq(' + trindexforpay + ')').find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                                        $('#txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                                        $('#txtPayableamountexcludingtax').val((parseFloat(CurrentDeailsRow.find("InstallmentAmount").text()) + parseFloat($('#txtPayableamountexcludingtax').val())).toFixed(2));
                                        $('#txttableamount').val((parseFloat(CurrentDeailsRow.find("TaxableAmount").text()) + parseFloat($('#txttableamount').val())).toFixed(2));
                                        $('#txtnontaxableamount').val((parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text()) + parseFloat($('#txtnontaxableamount').val())).toFixed(2));
                                        $('#txttaxamount').val((parseFloat(CurrentDeailsRow.find("Tax").text()) + parseFloat($('#txttaxamount').val())).toFixed(2));
                                        $('#txtPayable').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtPayable').val())).toFixed(2));
                                        $('#txtAmount').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtAmount').val())).toFixed(2));
                                        j++;
                                    }
                                    else {
                                        $('#txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                                        $('#txtPayableamountexcludingtax').val((parseFloat($('#txtPayableamountexcludingtax').val()) - parseFloat(CurrentDeailsRow.find("InstallmentAmount").text())).toFixed(2));
                                        $('#txttableamount').val((parseFloat($('#txttableamount').val()) - parseFloat(CurrentDeailsRow.find("TaxableAmount").text())).toFixed(2));
                                        $('#txtnontaxableamount').val((parseFloat($('#txtnontaxableamount').val()) - parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text())).toFixed(2));
                                        $('#txttaxamount').val((parseFloat($('#txttaxamount').val()) - parseFloat(CurrentDeailsRow.find("Tax").text())).toFixed(2));
                                        $('#txtPayable').val((parseFloat($('#txtPayable').val()) - parseFloat(CurrentDeailsRow.find("PayableAmount").text())).toFixed(2));
                                        $('#txtAmount').val((parseFloat($('#txtAmount').val()) - parseFloat(CurrentDeailsRow.find("PayableAmount").text())).toFixed(2));
                                        j--;
                                    }
                                }
                                $('#txtReceiver').val($('#ctl00_lblAdmin').text());
                            });
                        },
                        error: function (response) {
                            alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                        }
                    });
                    $('#divPayment').show(500);
                    $('html, body').animate({
                        scrollTop: $("#divPayment").offset().top
                    }, 500);               
                return false;
            });
            $('#BtnBackNow').click(function () {
                $('#divPayment').hide(500);
                $('#txtareacomment').val('');
                return false;
            });
            $('#BtnBackNow1').click(function () {
                $('#txtRegNo').val('')
                $('#divPayment').hide(500);
                $('#txtareacomment').val('');
                return false;
            });
            $('.ImgBtnRollBackFee').live('click', function () {
                var ConfirmRollBack = confirm('Are You Sure You Want To Rollback The Fee.?');
                if (ConfirmRollBack == true) {
                    var ASAID = 1;
                    //ASAID = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../BranchPanel/StudentManagement/student-fee-info.aspx//RoolBackFee",
                        data: "{'ASAID':'" + ASAID + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == '1') {
                                alert('Rollback Done Sucessfully');
                            }
                            else if (data.d == '0') {
                                alert('Some Error Occur.');
                            }
                        }
                    });
                }
                return false;
            });
            $('.ImgGenerateRecipt').live('click', function () {
                asaid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                var win = window.open("../Fee Management/receipt.aspx?sid=" + asaid, '_blank');
                win.focus();
                return false;
            });
            $('#ddlkPayment').change(function () {
                paymentMode = $('#ddlkPayment option:selected').val();
                if (paymentMode > 1 && paymentMode != 4) {
                    $('#BankDetail').show(500);
                    if (paymentMode == 2) {
                        $('#lblchkrefno').html('Cheque Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('Cheque Date<span style="color: Red">*</span>');
                    }
                    else if (paymentMode == 3) {
                        $('#lblchkrefno').html('DD Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('DD Date<span style="color: Red">*</span>');
                    }
                    else if (paymentMode == 5) {
                        $('#lblchkrefno').html('Transaction Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('Transaction Date<span style="color: Red">*</span>');
                    }
                }
                else {
                    $('#BankDetail').hide(500);
                }
            });

            $('.ImgBtnForSendFeeRemnainder').live('click', function () {
                alert('You Have Lack Of Permission');
                return false;
            });
            $('#txtAmount').change(function () {
                $('#lblremainningamount').html('');
                $('#Partialpayment').css('display', 'none');
                $('#txtDate').val('');
                if (parseInt($(this).val()) < parseInt($('#txtPayable').val())) {
                    $('#lblremainningamount').html('Remaining Amount:' + (parseInt($('#txtPayable').val()) - $(this).val()) + '.00')
                    $('#Partialpayment').css('display', 'block');
                }
                else if (parseInt($(this).val()) > parseInt($('#txtPayable').val())) {
                    alert('Amount To Be Paid Can Not Greater Than Payable Amount.');
                }
            });
        });
        function BindFeeDetaisList(stdRegNo) {
            var trforappend = '';
            $.ajax({
                url: "../BranchPanel/StudentManagement/student-fee-info.aspx/BindFeeDetails",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{'SAMID':'" + stdRegNo + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#GrdPayNow tbody').find('tr:gt(0)').remove();
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    var i = 0, Class = "";
                    TableGeneralDetails.each(function () {
                        var CurrentDeailsRow = $(this);
                        if (i % 2 == 0)
                            Class = "stm_dark";
                        else
                            Class = "stm_light";
                        trforappend = trforappend + '<tr class=' + Class + '>'
                            + '<td><input type="hidden" value=' + CurrentDeailsRow.find("ASAID").text() + ' />' + CurrentDeailsRow.find("Number").text() + '</td>'
                            + '<td>' + CurrentDeailsRow.find("InstallmentAmount").text() + '</td>'
                            + '<td>' + CurrentDeailsRow.find("Tax").text() + '</td>'
                            + '<td>' + CurrentDeailsRow.find("InstallmentDate").text() + '</td>'
                            + '<td><input class="ImgBtnForPayNow" type="checkbox" title="Check Here For Pay Fee Now." /></td>'
                            + '<td>' +
                            '<span class="SpanInstallmentName" style="display:none">' + CurrentDeailsRow.find("InstallmentName").text() + '</span>' +
                            '<span class="SpanInstallmentDetails" style="display:none">' + CurrentDeailsRow.find("FeeDescription").text() + '</span>' +
                            '<span class="SpanDiscountDetails" style="display:none">' + CurrentDeailsRow.find("DiscountDescription").text() + '</span>' +
                            '<input class="ImgBtnForInstallmentDetails" type="image" style="width:18px;border-width:0px;" src="../images/viewquestion.png" title="Click Here For Send Fee Remiander." /></td>'
                        '</tr>'
                        i = i + 1;
                    });
                    $('#GrdPayNow tbody').append(trforappend);
                    result = 1;
                    return result;
                },
                error: function (response) {
                    window.location = 'http://paytopaid.com/OnlineFeePayment.aspx';
                }
            });
        }
        function FillFieldForPay() {
            var err = 0, ermsg = '';
            if ($('input[id="agree"]').prop("checked") == false) {
                ermsg = "Please check Agreement.";
                err = 1;
            }
            if (err > 0) {
                alert(ermsg);
                return;
            }
            else {
                myData.ASAID = $('#hfforasaid').val();
                myData.PAYMENTMODE = $('#ddlkPayment').val();
                myData.BANKNAME = $('#txtBank').val();
                myData.BRANCHNAME = $('#txtbranchbank').val();
                myData.CHKREFDDNEFTREFRENCENO = $('#txtChequeDD').val();
                myData.CHKREFDDNEFTDATE = $('#txtToDate').val();
                myData.RECIPTNO = $('#txtfeerecipt').val();
                myData.PAYMENTDATE = $('#txtpaydate').val();
                myData.RemarkOrComment = $('#txtareacomment').val();
                myData.PaidAmount = $('#txtAmount').val();
                myData.DateOfDueAmount = $('#txtDate').val();
                myData.SelectedASID = '';
                $('#GrdPayNow').find('tr:gt(0)').each(function () {
                    if ($(this).find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                        myData.SelectedASID = myData.SelectedASID + ',' + $(this).find('td:eq(0)').find('input[type="hidden"]').val();
                        $('#SelectedASID').val(myData.SelectedASID);
                    }
                });
                myData.SelectedASID = myData.SelectedASID.slice(1, myData.SelectedASID.length);
                $('#SelectedASID').val(myData.SelectedASID);

                $('#Button1').trigger('click');
            }
        }
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65) && (charCode <= 90)) {
                return false;
            }
            return true;
        };
        function BindPayNow(ASAID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../BranchPanel/StudentManagement/student-fee-info.aspx/BindPayNow",
                data: "{'ASAID':'" + ASAID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    var i = 0, Class = "";
                    TableGeneralDetails.each(function () {
                        var CurrentDeailsRow = $(this);
                        if ($('#GrdPayNow').find('tr:eq(' + trindexforpay + ')').find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                            $('#txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                            $('#txtPayableamountexcludingtax').val((parseFloat(CurrentDeailsRow.find("InstallmentAmount").text()) + parseFloat($('#txtPayableamountexcludingtax').val())).toFixed(2));
                            $('#txttableamount').val((parseFloat(CurrentDeailsRow.find("TaxableAmount").text()) + parseFloat($('#txttableamount').val())).toFixed(2));
                            $('#txtnontaxableamount').val((parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text()) + parseFloat($('#txtnontaxableamount').val())).toFixed(2));
                            $('#txttaxamount').val((parseFloat(CurrentDeailsRow.find("Tax").text()) + parseFloat($('#txttaxamount').val())).toFixed(2));
                            $('#txtPayable').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtPayable').val())).toFixed(2));
                            $('#txtAmount').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtAmount').val())).toFixed(2));
                        }
                        else {
                            $('#txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                            $('#txtPayableamountexcludingtax').val((parseFloat($('#txtPayableamountexcludingtax').val()) - parseFloat(CurrentDeailsRow.find("InstallmentAmount").text())).toFixed(2));
                            $('#txttableamount').val((parseFloat($('#txttableamount').val()) - parseFloat(CurrentDeailsRow.find("TaxableAmount").text())).toFixed(2));
                            $('#txtnontaxableamount').val((parseFloat($('#txtnontaxableamount').val()) - parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text())).toFixed(2));
                            $('#txttaxamount').val((parseFloat($('#txttaxamount').val()) - parseFloat(CurrentDeailsRow.find("Tax").text())).toFixed(2));
                            $('#txtPayable').val((parseFloat($('#txtPayable').val()) - parseFloat(CurrentDeailsRow.find("PayableAmount").text())).toFixed(2));
                            $('#txtAmount').val((parseFloat($('#txtAmount').val()) - parseFloat(CurrentDeailsRow.find("PayableAmount").text())).toFixed(2));
                        }
                        $('#txtReceiver').val($('#ctl00_lblAdmin').text());
                    });
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }

    </script>
</head>

<body>
    <form id="form1" runat="server" method="post">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="BtnPayNow"
            CancelControlID="Button3" BackgroundCssClass="Background">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
            <iframe style="width: 99%; height: 80%;" id="irm1" src="../BranchPanel/StudentManagement/Agreement.aspx" runat="server"></iframe>
            <br />
            <br />
            <input type="checkbox" id="agree" name="agree" value="agree" />
            I have read, understood and accept the above term & Condition.<br />
            <br />
            <asp:Button ID="Button2" CssClass="button_save" Text="pay" runat="server" OnClientClick="FillFieldForPay(); return false;" Style="height: 28px; background-image: initial; width: auto;" />
            <asp:Button ID="Button3" runat="server" Text="Close" CssClass="button2" />
        </asp:Panel>

        <div class="aspNetHidden">
        </div>
        <div class="aspNetHidden">
        </div>
        <div class="all-wrapper">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-center">
                        <button class="navbar-toggle" data-target=".navbar-ex1-collapse" data-toggle="collapse" type="button">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="col-md-3">
                        <div class="side-bar-wrapper collapse navbar-collapse navbar-ex1-collapse">
                            <a class="logo hidden-sm hidden-xs" href="employee-panel-home-page.aspx">
                                <asp:Image ID="imgPP" runat="server" Style="width:100%"/>
                            </a>
                        </div>

                        <div class="widget">
                            <div class="widget-content-white glossed">
                                <div class="padded">
                                    <div class="widget-controls pull-right"></div>
                                    <asp:Image ID="img1" runat="server" Width="100px" Height="100px" />
                                    <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                        <i class="icon-reorder"></i>
                                        Student Details
                                    </h3>
                                    <div class="row" style="margin-top: -25px!important">
                                        <table class="table">
                                            <tr style="display: none">
                                                <td class="t1"><span>Roll No:</span></td>
                                                <td class="t2">
                                                    <label id="lblRollno" runat="server"></label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="t1"><span>Name:</span></td>
                                                <td class="t2">
                                                    <label id="lblname" runat="server"></label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="t1"><span>Gender:</span></td>
                                                <td class="t2">
                                                    <label id="lblGender" runat="server"></label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="t1"><span>DOB:</span></td>
                                                <td class="t2">
                                                    <label id="lblDOB" runat="server"></label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="t1"><span>Address:</span></td>
                                                <td class="t2">
                                                    <label id="lblAddress" runat="server"></label>
                                                </td>
                                            </tr>
                                            <tr id="tr1" runat="server" visible="false">
                                                <td class="t1"><span>Board:</span></td>
                                                <td class="t2">
                                                    <label id="lblBoard" runat="server">--</label>
                                                </td>
                                            </tr>

                                            <tr id="tr2" runat="server" visible="false">
                                                <td class="t1"><span>Medium:</span></td>
                                                <td class="t2">
                                                    <label id="lblMedium" runat="server">--</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="t1"><span>Mobile No:</span></td>
                                                <td class="t2">
                                                    <label id="lblMobileno" runat="server">--</label>
                                                </td>
                                            </tr>
                                            <tr id="tr3" runat="server" visible="false">
                                                <td class="t1"><span>Landline No:</span></td>
                                                <td class="t2">
                                                    <label id="lblLandlineno" runat="server">--</label>
                                                </td>
                                            </tr>

                                            <tr id="tr4" runat="server" visible="false">
                                                <td class="t1"><span>School:</span></td>
                                                <td class="t2">
                                                    <label id="lblschool" runat="server">--</label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="t1"><span>Email-Id:</span></td>
                                                <td class="t2">
                                                    <label id="lblemailid" runat="server">--</label>
                                                </td>
                                            </tr>
                                            <tr id="tr5" runat="server" visible="false">
                                                <td class="t1"><span>Source of Student:</span></td>
                                                <td class="t2">
                                                    <label id="lblstudentsource" runat="server">--</label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="col-md-6"></div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-9">
                        <div class="content-wrapper">
                            <div class="content-inner">
                                <div class="page-header">
                                    <div class="header-links hidden-xs">
                                        <a id="lbLogOut" href="http://payment.paytopaid.com/payment.aspx"><i class="icon-signout"></i>Back
                                        </a>
                                    </div>
                                    <h1>
                                        <asp:Label runat="server" ID="lblMsg" Text="" Style="color: Red; font-size: 15px; font-weight: bold; margin-left: 30px !important;"></asp:Label><br />
                                        <i class="icon-user"></i>
                                        Fee Details
                                    </h1>

                                </div>
                                <div class="main-content">
                                    <div style="background-color: #F7F7F7; height: auto !important;" class="overflow">
                                        <table id="tbl1" cellspacing="0" cellpadding="2" border="0" style="width: 98%; margin: 5px 0 0 11px; position: relative;">
                                            <tbody>
                                                <tr>
                                                    <td style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                                                        <b>UNPAID FEE (Excluding Tax)</b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="tbl4" valign="top" style="width: 49%; border-bottom: 1px solid #DDDDDD; border-right: 1px solid #DDDDDD;">
                                                        <div>
                                                            <table id="GrdPayNow" class="stm" cellspacing="0" cellpadding="5" border="0" style="width: 100%; border-collapse: collapse;">
                                                                <tbody>
                                                                    <tr class="stm_head" align="center">
                                                                        <th align="center" scope="col">S.No</th>
                                                                        <th align="center" scope="col">Amount (₹)</th>
                                                                        <th align="center" scope="col">Tax (₹)</th>
                                                                        <th align="center" scope="col">Due Date</th>
                                                                        <th align="center" scope="col">Pay</th>
                                                                        <th align="center" scope="col">Details</th>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="clear">
                                            <div id="divPayment" class="new-registration" style="margin-top: 10px; display: none; background-color: white">
                                                <div style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                                                    <b>Payment Details</b>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Reciept No.</label>
                                                    <asp:TextBox runat="server" ID="txtfeerecipt" onkeypress="return noAlphabets(event)"></asp:TextBox>
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Payable Amount(Excluding Tax)</label>
                                                    <input id="txtPayableamountexcludingtax" readonly="readonly" type="text" value="0.00" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Taxable Amount</label>
                                                    <input id="txttableamount" readonly="readonly" type="text" value="0.00" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Non Taxable Amount</label>
                                                    <input id="txtnontaxableamount" readonly="readonly" type="text" value="0.00" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Service Tax(In%)</label>

                                                    <input id="txtsevicetax" readonly="readonly" type="text" value="0.00" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Tax Amount</label>
                                                    <input id="txttaxamount" readonly="readonly" type="text" value="0.00" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Payable Amount(Including Tax)</label>
                                                    <input id="txtPayable" readonly="readonly" type="text" value="0.00" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Enter Amount To Be Paid<span style="color: Red; float: right">*</span></label>
                                                    <asp:TextBox ID="txtAmount" runat="server" onkeypress="return noAlphabets(event)" Text="0.00" />&nbsp;                      
                          <label id="lblremainningamount" style="color: green; width: 190px"></label>
                                                </div>
                                                <div id="Partialpayment" style="display: none">
                                                    <div class="for_sigle_row_form">
                                                        <label style="width: 221px">
                                                            Due Date For Remaining Amount<span style="color: Red">*</span></label>
                                                        <asp:TextBox ID="txtDate" runat="server" Text="" placeholder="Enter The Remark Please."></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label style="width: 221px">
                                                        Payment Date<span style="color: Red">*</span></label>
                                                    <asp:TextBox ID="txtpaydate" runat="server" onkeypress="return false" />&nbsp;                        
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Comment/Remark</label>
                                                    <asp:TextBox ID="txtareacomment" runat="server" TextMode="MultiLine" placeholder="Enter The Remark Please."></asp:TextBox>
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label></label>
                                                    <label style="width: auto;">
                                                        <input type="checkbox" checked="checked" id="chkprint" />
                                                        Print Now</label>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" style="margin-bottom: 10px !important;">
                                                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="padding: 0 0 0 0;" />
                                                    <asp:Button ID="BtnPayNow" runat="server" Text="Pay Now" CssClass="button_save" />

                                                    <%--<asp:Button ID="BtnPayNow" CssClass="button_save" Text="pay" runat="server" OnClientClick="FillFieldForPay(); return false;" Style="height: 28px; background-image: initial; width: auto;" />--%>
                                                    <a id="BtnBackNow" class="button_save" style="height: 28px; width: auto; background-color: red; background-image: initial">Back</a>
                                                </div>
                                                <asp:HiddenField ID="hfforasaid" runat="server" />
                                                <asp:HiddenField ID="SelectedASID" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </form>
</body>
</html>
