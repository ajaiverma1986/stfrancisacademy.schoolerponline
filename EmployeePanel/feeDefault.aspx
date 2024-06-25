<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="feeDefault.aspx.cs" Inherits="EmployeePanel_feeDefault" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <style type="text/css">
        .Background
        {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }
        .Popup
        {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 65%;
            height: 85%;
        }
        .lbl
        {
            font-size:16px;
            font-style:italic;
            font-weight:bold;
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

        .ui-datepicker {
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
        }
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

        #ctl00_head_Grid_Calender_ctl03_lblsaturday {
            width: 200px !important;
        }

        .activelistofholiday {
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

        #ctl00_head_Grid_Calender td span {
            width: 100% !important;
        }

        #ctl00_head_Grid_Calender th {
            background-color: #82403B;
            color: white !important;
            font-size: 20px !important;
        }

        #ctl00_head_Grid_Calender td {
            border-left: 2px solid #CDCDCD !important;
            height: 50px !important;
        }

        #ctl00_head_Grid_Calender {
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
        var myData = {}, asaid = 0, trindexforpay = 0,money = 0;
        $(document).ready(function () {
            BindAdmissionList(0)
            CallMethod();
            $("#ctl00_head_txtpaydate").datepicker({
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
            $("#ctl00_head_txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                minDate: new Date()
            })          
            $('.ImgBtnForInstallmentDetails').live('click', function () {
                alert('INSTALLMENT NAME:' + $(this).parent('td').find('.SpanInstallmentName').text() + '\nINSTALLMENT DETAILS/BREAKUP:' + $(this).parent('td').find('.SpanInstallmentDetails').text() + '\nDISCOUNT DETAILS:' + $(this).parent('td').find('.SpanDiscountDetails').text() + '');
                return false;
            });
            $('.ImgBtnForPayNow').live('change', function () {
                trindexforpay = $(this).parent('td').parent('tr').index();
                asaid = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                $('#ctl00_head_hfforasaid').val(asaid);
                BindPayNow(asaid);
                $('#divPayment').show(500);
                $('html, body').animate({
                    scrollTop: $("#divPayment").offset().top
                }, 500);                
                return false;
            });
            $('#ctl00_head_txtpaydate').live('change', function () {
                getFine(asaid, money)
                return false;
            });
            $('#BtnBackNow').click(function () {
                $('#divPayment').hide(500);
                $('#ctl00_head_txtareacomment').val('');
                return false;
            });
            $('#BtnBackNow1').click(function () {
                $('#ctl00_head_txtRegNo').val('')
                $('#divPayment').hide(500);
                $('#ctl00_head_txtareacomment').val('');
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
                        url: "../Service.asmx/RoolBackFee",
                        data: "{'ASAID':'" + ASAID + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == '1') {
                                alert('Rollback Done Sucessfully');
                                CallMethod();
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
            $('#ctl00_head_ddlkPayment').change(function () {
                paymentMode = $('#ctl00_head_ddlkPayment option:selected').val();
                if (paymentMode > 1 && paymentMode != 4) {
                    $('#BankDetail').show(500);
                    if (paymentMode == 2) {
                        $('#ctl00_head_lblchkrefno').html('Cheque Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('Cheque Date<span style="color: Red">*</span>');
                    }
                    else if (paymentMode == 3) {
                        $('#ctl00_head_lblchkrefno').html('DD Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('DD Date<span style="color: Red">*</span>');
                    }
                    else if (paymentMode == 5) {
                        $('#ctl00_head_lblchkrefno').html('Transaction Number<span style="color: Red">*</span>');
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
            $('#ctl00_head_txtAmount').change(function () {
                $('#lblremainningamount').html('');
                $('#Partialpayment').css('display', 'none');
                $('#ctl00_head_txtDate').val('');
                if (parseInt($(this).val()) < parseInt($('#txtPayable').val())) {
                    $('#lblremainningamount').html('Remaining Amount:' + (parseInt($('#txtPayable').val()) - $(this).val()) + '.00')
                    $('#Partialpayment').css('display', 'block');
                }
                else if (parseInt($(this).val()) > parseInt($('#txtPayable').val())) {
                    alert('Amount To Be Paid Can Not Greater Than Payable Amount.');
                }
            });
        });    
        
        function FillFieldForPay() {
            var err = 0, ermsg = '';
            if ($('#agree').prop("checked") == false) {
                ermsg = "Please check Agreement.";
                err = 1;
            }
            if (err > 0) {
                alert(ermsg);
                return;
            }
            else {
                myData.ASAID = $('#ctl00_head_hfforasaid').val();
                myData.PAYMENTMODE = $('#ctl00_head_ddlkPayment').val();
                myData.BANKNAME = $('#txtBank').val();
                myData.BRANCHNAME = $('#txtbranchbank').val();
                myData.CHKREFDDNEFTREFRENCENO = $('#txtChequeDD').val();
                myData.CHKREFDDNEFTDATE = $('#txtToDate').val();
                myData.RECIPTNO = $('#ctl00_head_txtfeerecipt').val();
                myData.PAYMENTDATE = $('#ctl00_head_txtpaydate').val();
                myData.RemarkOrComment = $('#ctl00_head_txtareacomment').val();
                myData.FineAmount = $('#ctl00_head_txtfine').val();
                myData.PaidAmount = $('#ctl00_head_txtAmount').val();
                myData.DateOfDueAmount = $('#ctl00_head_txtDate').val();
                myData.SelectedASID = '';
                $('#GrdPayNow').find('tr:gt(0)').each(function () {
                    if ($(this).find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                        myData.SelectedASID = myData.SelectedASID + ',' + $(this).find('td:eq(0)').find('input[type="hidden"]').val();
                        $('#ctl00_head_SelectedASID').val(myData.SelectedASID);
                    }
                });
                myData.SelectedASID = myData.SelectedASID.slice(1, myData.SelectedASID.length);
                $('#ctl00_head_SelectedASID').val(myData.SelectedASID);

                $('#ctl00_head_Button1').trigger('click');
            }
            return false;
        }
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65) && (charCode <= 90)) {
                return false;
            }
            return true;
        };
        function getFine(ASAID, Amount) {
            var TodayDate = $('#ctl00_head_txtpaydate').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../BranchPanel/StudentManagement/student-fee-info.aspx/GetFine",
                data: "{'ASAID':'" + ASAID + "','TodayDate':'" + TodayDate + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d > 0) {
                        $('#ctl00_head_txtfine').val(parseFloat(data.d).toFixed(2));
                        $('#txtPayable').val((parseFloat(Amount) + parseFloat($('#ctl00_head_txtfine').val())).toFixed(2));
                        $('#ctl00_head_txtAmount').val((parseFloat(Amount) + parseFloat($('#ctl00_head_txtfine').val())).toFixed(2));
                    }
                    else if (data.d == 5) {
                        if (confirm('Sorry, You have not Set Fine Fee. Do you want take transport ?')) {
                            window.location.replace('../Fee%20Management/mst_FeeFine.aspx');
                            return false;
                        }
                    }
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }

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
                            $('#ctl00_head_txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                            $('#txtPayableamountexcludingtax').val((parseFloat(CurrentDeailsRow.find("InstallmentAmount").text()) + parseFloat($('#txtPayableamountexcludingtax').val())).toFixed(2));
                            $('#txttableamount').val((parseFloat(CurrentDeailsRow.find("TaxableAmount").text()) + parseFloat($('#txttableamount').val())).toFixed(2));
                            $('#txtnontaxableamount').val((parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text()) + parseFloat($('#txtnontaxableamount').val())).toFixed(2));
                            $('#txttaxamount').val((parseFloat(CurrentDeailsRow.find("Tax").text()) + parseFloat($('#txttaxamount').val())).toFixed(2));
                            $('#txtPayable').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtPayable').val())).toFixed(2));
                            $('#ctl00_head_txtAmount').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#ctl00_head_txtAmount').val())).toFixed(2));
                            asaid = ASAID, money = $('#ctl00_head_txtAmount').val();
                            getFine(ASAID, $('#ctl00_head_txtAmount').val());
                        }
                        else {
                            $('#ctl00_head_txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                            $('#txtPayableamountexcludingtax').val((parseFloat($('#txtPayableamountexcludingtax').val()) - parseFloat(CurrentDeailsRow.find("InstallmentAmount").text())).toFixed(2));
                            $('#txttableamount').val((parseFloat($('#txttableamount').val()) - parseFloat(CurrentDeailsRow.find("TaxableAmount").text())).toFixed(2));
                            $('#txtnontaxableamount').val((parseFloat($('#txtnontaxableamount').val()) - parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text())).toFixed(2));
                            $('#txttaxamount').val((parseFloat($('#txttaxamount').val()) - parseFloat(CurrentDeailsRow.find("Tax").text())).toFixed(2));
                            $('#txtPayable').val((parseFloat($('#txtPayable').val()) - parseFloat(CurrentDeailsRow.find("PayableAmount").text())).toFixed(2));
                            $('#ctl00_head_txtAmount').val((parseFloat($('#ctl00_head_txtAmount').val()) - parseFloat(CurrentDeailsRow.find("PayableAmount").text())).toFixed(2));
                            asaid = ASAID, money = $('#ctl00_head_txtAmount').val();
                            getFine(ASAID, $('#ctl00_head_txtAmount').val());
                        }
                        $('#txtReceiver').val($('#ctl00_lblAdmin').text());
                    });
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }       
        var result = 0;
        function BindAdmissionList(SAMID) {
            var trforappend = '';
            $.ajax({
                url: "../Service.asmx/BindFeeDetails",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{'SAMID':'" + <%=Session["SAMID"]%> + "'}",
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
                            if (CurrentDeailsRow.find("InstallmentAmount").text() != "0.00") {
                            trforappend = trforappend + '<tr class=' + Class + '>'
                              + '<td><input type="hidden" value=' + CurrentDeailsRow.find("ASAID").text() + ' />' + (i+1) + '</td>'
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
                        }
                    });
                    $('#GrdPayNow tbody').append(trforappend);
                    result = 1;
                    return result;
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
        function CallMethod() {
            //For Finding That Coming For Edit Start Here
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (parseInt(urlparam.length) > 1) {
                    BindAdmissionList(urlparam[1]);
                }
            }
            //For Finding That Coming For Edit End Here
        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="col-md-9">
        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="Button3"
    CancelControlID="Button2" BackgroundCssClass="Background">
</cc1:ModalPopupExtender>
<asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" style = "display:none">
    <iframe style=" width: 99%; height: 80%;" id="irm1" src="../BranchPanel/StudentManagement/Agreement.aspx" runat="server"></iframe>
   <br/><br />
    <input type="checkbox" id="agree" name="agree" value="agree" /> I have read, understood and accept the above term & Condition.<br /><br />
   <asp:Button ID="BtnPayNow" CssClass="button_save" Text="pay" runat="server" OnClientClick="FillFieldForPay(); return false;" style="height:28px; background-image:initial;  width: auto;"/>
    <asp:Button ID="Button2" runat="server" Text="Close" CssClass="button2"  />   
</asp:Panel>
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <a id="lbLogOut" href="../emp-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Fee Details
                    </h1>
                </div>
                <div class="main-content">
                    <div style="background-color: #F7F7F7; height: auto !important;" class="overflow">
                          <table id="ctl00_head_tbl1" cellspacing="0" cellpadding="2" border="0" style="width: 98%; margin: 5px 0 0 11px; position: relative;">
                <tbody>
                    <tr>                 
                        <td style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                            <b>UNPAID FEE (Excluding Tax)</b>
                        </td>
                    </tr>
                    <tr>                                              
                        <td id="ctl00_head_tbl4" valign="top" style="width: 49%; border-bottom: 1px solid #DDDDDD; border-right: 1px solid #DDDDDD;">
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
                <div id="divPayment" class="new-registration" style=" margin-top: 10px; display: none; background-color:white">
                    <div style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                        <b>Payment Details</b>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <label>
                            Reciept No.</label>
                        <asp:TextBox runat="server" ID="txtfeerecipt" onkeypress="return noAlphabets(event)" ></asp:TextBox>
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
                            Fine Amount</label>
                        <asp:TextBox ID="txtfine" runat="server" Text="0.00" />&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Payable Amount(Including Tax)</label>
                        <input id="txtPayable" readonly="readonly" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Enter Amount To Be Paid<span style="color: Red; float: right">*</span></label>
                        <asp:TextBox ID="txtAmount" runat="server" onkeypress="return noAlphabets(event)" Text="0.00" style="pointer-events:none" />&nbsp;                      
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
                        <asp:Button ID="Button3" runat="server" Text="Pay Now" CssClass="button_save"  />
                        <a id="BtnBackNow" class="button_save" style="height:28px; width: auto; background-color:red; background-image:initial">Back</a>
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
</asp:Content>

