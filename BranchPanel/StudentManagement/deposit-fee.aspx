<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="deposit-fee.aspx.cs" Inherits="BranchPanel_Fee_Management_deposit_fee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Deposit Fee</h2>
            </div>
            <div class="clear"></div>
            <div class="searchbar containerHeadline for_sigle_row_form">
                    <div class="clear"></div>
                    <input type="text" style="width: 100px;" placeholder="Student Name" id="sname" />
                    
                    <input type="text" style="width: 100px; margin-left: 5px;" placeholder="Admission No" id="txtadmissionno" onkeypress="if (WebForm_TextBoxKeyHandler(event) == false) return false;return noAlphabets(event)" />
                    <asp:DropDownList ID="ddlfinancialyear" runat="server" style="height: 31px; width: 100px;">
                    </asp:DropDownList>
                    <select style="height: 31px; width: 150px;" id="dllclass"></select>
                    <input type="text" style="width: 150px;" placeholder="Due Date From" id="txtfromdate" onkeypress="return false" />
                    <input type="text" style="width: 150px;" placeholder="Due Date To" id="Text1" onkeypress="return false" />
                    <input id="btnclear" type="image" style="width: 25px; height: 25px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
                    <div class="clear"></div>
                </div>
            <div class="clear"></div>
            <div>
                <table id="GrdPayNow" class="stm" cellspacing="0" cellpadding="5" border="0" style="width: 100%; border-collapse: collapse;">
                    <tbody>
                        <tr class="stm_head" align="center">
                            <th align="center" scope="col">S.No</th>
                            <th align="center" scope="col">Admission No</th>
                            <th align="center" scope="col">Name</th>
                            <th align="center" scope="col">Class</th>
                            <th align="center" scope="col">Amount (₹)</th>
                            <th align="center" scope="col">Tax (₹)</th>
                            <th align="center" scope="col">Due Date</th>
                            <th align="center" scope="col">Pay</th>
                            <th align="center" scope="col">Reminder</th>
                            <th align="center" scope="col">Details</th>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div>
                 <table style="width: 100%">
                        <tr>
                            <td colspan="10">
                                <table border="0" width="100%">
                                    <tr>
                                        <td>

                                            <div style="margin-left: 0px; float: left; width: 500px;" class="page-number">
                                                <asp:Label ID="lblpage" CssClass="lblpage"
                                                    runat="server"></asp:Label>
                                                <span>of</span>
                                                <asp:Label ID="lblTotalPages" CssClass="lbltotalpage"
                                                    runat="server"></asp:Label>
                                                <span>Page</span>
                                            </div>
                                        </td>

                                        <td>
                                            <div style="margin-left: 0px; float: left; width: 500px;">
                                                <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer;"
                                                    alt="" />
                                                <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer;"
                                                    alt="" />
                                                <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer;"
                                                    alt="" />
                                                <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer;"
                                                    alt="" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
            </div>
            <div class="clear">
                <div id="divPayment" class="new-registration" style="margin-top: 10px; display: none">
                    <div class="tbl-top-heading" style="border-top: 1px solid #CCCCCC !important; border-bottom: 1px solid #CCCCCC !important">
                        <h2>Payment Details</h2>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <label>
                            Reciept No.</label>
                        <asp:TextBox runat="server" ID="txtfeerecipt" onkeypress="return noAlphabets(event)" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Payable Amount(Excluding Tax)</label>
                        <input id="txtPayableamountexcludingtax" readonly="readonly" type="text" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Taxable Amount</label>
                        <input id="txttableamount" readonly="readonly" type="text" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Fine Amount</label>
                        <input id="txtFine" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Non Taxable Amount</label>
                        <input id="txtnontaxableamount" readonly="readonly" type="text" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Service Tax(In%)</label>

                        <input id="txtsevicetax" readonly="readonly" type="text" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Tax Amount</label>
                        <input id="txttaxamount" readonly="readonly" type="text" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Payable Amount(Including Tax)</label>
                        <input id="txtPayable" readonly="readonly" type="text" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Enter Amount To Be Paid<span style="color: Red">*</span></label>
                        <input id="txtAmount" onkeypress="return noAlphabets(event)" type="text" />&nbsp;
                      <div style="float: right; width: 466px;">
                          <label id="lblremainningamount" style="color: green; width: 190px"></label>
                      </div>
                    </div>
                    <div id="Partialpayment" style="display: none">
                        <div class="for_sigle_row_form">
                            <label style="width: 221px">
                                Due Date For Remaining Amount<span style="color: Red">*</span></label>
                            <input id="txtDate" type="text" readonly="readonly" placeholder="Select Due Date For Remaing Amount" />
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label style="width: 221px">
                            Payment Date<span style="color: Red">*</span></label>
                        <input id="txtpaydate" type="text" onkeypress="return false" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Payment Mode<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlkPayment">
                            <asp:ListItem Value="1">Cash</asp:ListItem>
                            <asp:ListItem Value="2">Cheque</asp:ListItem>
                            <asp:ListItem Value="3">DD</asp:ListItem>
                            <asp:ListItem Value="4">Card</asp:ListItem>
                            <asp:ListItem Value="5">NEFT</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div id="BankDetail" style="display: none">
                        <div class="for_sigle_row_form" id="divforbankname">
                            <label>
                                Bank Name<span style="color: Red">*</span></label>
                            <input type="text" id="txtBank" placeholder="Enter Bank Name PLease" />
                        </div>

                        <div class="for_sigle_row_form" id="divforbranchname">
                            <label>
                                Branch Name<span style="color: Red">*</span></label>
                            <input type="text" id="txtbranchbank" placeholder="Enter Branch Name PLease" />
                        </div>

                        <div class="for_sigle_row_form" id="divforchkrefno">
                            <label runat="server" id="lblchkrefno">
                                Cheque Number<span style="color: Red">*</span></label>
                            <input type="text" id="txtChequeDD" placeholder="Enter Refrence Number PLease" />
                        </div>

                        <div class="for_sigle_row_form" id="divforchkrefdate">
                            <label id="lblchkrefdate">
                                Cheque Date<span style="color: Red">*</span></label>
                            <input type="text" id="txtToDate" onkeypress="return false" placeholder="Select Date PLease" />
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Received By<span style="color: Red">*</span></label>
                        <input type="text" readonly="readonly" id="txtReceiver" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Comment/Remark</label>
                        <textarea cols="2" rows="3" id="txtareacomment" placeholder="Enter The Remark Please."></textarea>
                    </div>
                    <div class="for_sigle_row_form">
                        <label></label>
                        <label style="width: auto;">
                            <input type="checkbox" checked="checked" id="chkprint" />
                            Print Now</label>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form" style="margin-bottom: 10px !important;">
                        <label></label>
                        <a id="BtnPayNow" class="button_save">Pay Now</a>
                        <a id="BtnBackNow" class="button2">BACK</a>
                    </div>
                    <asp:HiddenField ID="hfforasaid" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var year = 2050;
        var ASAID = 0, name = '',money = 0, admission = '', fyid = 0, classid = 0, duefromdate = '', duetodate = '', pageno = 1, pagesize = 100, pagecount = 1;
        var myData = {};
        $(document).ready(function () {
            BindClass();
            FillFeild()
            BindAdmissionList();
            $("#txtpaydate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            }).datepicker("setDate", new Date());
            $("#txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            }).datepicker("setDate", new Date());
            $("#txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                minDate: new Date()
            }).datepicker("setDate", new Date());
            $("#txtfromdate,#Text1").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:' + year,
                dateFormat: 'dd MM yy'
            });
            $('.ImgBtnForInstallmentDetails').live('click', function () {
                alert('INSTALLMENT NAME:' + $(this).parent('td').find('.SpanInstallmentName').text() + '\nINSTALLMENT DETAILS/BREAKUP:' + $(this).parent('td').find('.SpanInstallmentDetails').text() + '\nDISCOUNT DETAILS:' + $(this).parent('td').find('.SpanDiscountDetails').text() + '');
                return false;
            });
            $('#txtpaydate').live('change', function () {
                getFine(ASAID, money)
                return false;
            });
            $('.ImgBtnForPayNow').live('click', function () {                
                ASAID = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                $('#ctl00_ContentPlaceHolder1_hfforasaid').val(ASAID);
                BindPayNow(ASAID);
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
            $('#ctl00_ContentPlaceHolder1_ddlkPayment').change(function () {
                paymentMode = $('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val();
                if (paymentMode > 1 && paymentMode != 4) {
                    $('#BankDetail').show(500);
                    if (paymentMode == 2) {
                        $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('Cheque Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('Cheque Date<span style="color: Red">*</span>');
                    }
                    else if (paymentMode == 3) {
                        $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('DD Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('DD Date<span style="color: Red">*</span>');
                    }
                    else if (paymentMode == 5) {
                        $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('Transaction Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('Transaction Date<span style="color: Red">*</span>');
                    }
                }
                else {
                    $('#BankDetail').hide(500);
                }
            });
            $('#BtnPayNow').click(function () {
                var err = 0, ermsg = '';
                if ($('#txtAmount').val() == '') {
                    ermsg = "Please Enter The Amount To Be Paid. \n";
                    err = 1;
                }
                if ($('#txtpaydate').val() == '') {
                    ermsg = "Please Select Payment Date. \n";
                    err = 1;
                }
                if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 0) {
                    ermsg = ermsg + "please Select Payment Mode \n";
                    err = 1;
                }

                if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 2) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtbranchbank').val() == '') {
                        ermsg = ermsg + "Please Enter The Branch Name. \n";
                        err = 1;
                    }
                    if ($('#txtChequeDD').val() == '') {
                        ermsg = ermsg + "Please Enter Cheque Number. \n";
                        err = 1;
                    }
                    if ($('#txtToDate').val() == '') {
                        ermsg = ermsg + "Please Enter Cheque Date. \n";
                        err = 1;
                    }
                }

                else if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 3) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtbranchbank').val() == '') {
                        ermsg = ermsg + "Please Enter The Branch Name. \n";
                        err = 1;
                    }
                    if ($('#txtChequeDD').val() == '') {
                        ermsg = ermsg + "Please Enter DD Number. \n";
                        err = 1;
                    }
                    if ($('#txtToDate').val() == '') {
                        ermsg = ermsg + "Please Enter DD Date. \n";
                        err = 1;
                    }
                }

                else if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 5) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtbranchbank').val() == '') {
                        ermsg = ermsg + "Please Enter The Branch Name. \n";
                        err = 1;
                    }
                    if ($('#txtChequeDD').val() == '') {
                        ermsg = ermsg + "Enter Transaction Number Please. \n";
                        err = 1;
                    }
                    if ($('#txtToDate').val() == '') {
                        ermsg = ermsg + "Select Transaction Date Please. \n";
                        err = 1;
                    }
                }
                if (err > 0) {
                    alert(ermsg);
                    return;
                }
                else {
                    FillFieldForPay();
                    var DTO = { 'theData': myData };
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../StudentManagement/student-fee-info.aspx/DepositFee",
                        data: JSON.stringify(DTO),
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == '1') {
                                alert('Fee Deposited Successfully and Sent Msg to Registered Mobile No.');
                                if ($('#chkprint').attr('checked') == 'checked') {
                                    window.open('feereceipt.aspx?sid=' + myData.ASAID + '', '_blank');
                                }                                
                            }
                            if (data.d == '2') {
                                alert('Duplicate Recipt No.');
                                location.reload();
                            }
                            if (data.d == '0') {
                                alert('Some Error Occur.');
                                location.reload();
                            }
                            if (data.d == '5') {
                                alert('Fee Deposited Successfully.');
                                location.reload();
                            }
                            $('#divPayment').hide(500);
                            $('#txtareacomment').val('');
                            BindAdmissionList();
                            location.reload(true);
                        }
                    });                    
                }
            });
            $('.ImgBtnForSendFeeRemnainder').live('click', function () {
                trindexforpay = $(this).parent('td').parent('tr').index();
                asaid = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                $('#ctl00_ContentPlaceHolder1_hfforasaid').val(asaid);
                SendFeeMsg(asaid);
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
            $('#sname,#txtadmissionno,#dllclass,#txtfromdate,#Text1').change(function () {
                FillFeild()
                BindAdmissionList();
            })
            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                BindClass();
                FillFeild()
                BindAdmissionList();
            });
            $('#btnclear').click(function () {
                $('#sname').val('');
                $('#txtadmissionno').val('');
                $('#dllclass').val('0');
                $('#txtfromdate').val('');
                $('#Text1').val('');
                FillFeild()
                BindAdmissionList();
                return false;
            });
            $('.btnfirst').live('click', function () {
                pageno = 1;
                $(".lblpage").html(pageno);
                FillFeild()
                BindAdmissionList();
                alertify.success('You Are On The First Page.');
                return false;
            });
            $('.btnprev').live('click', function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    FillFeild()
                    BindAdmissionList();
                    return false;
                }
                else {
                    alertify.error('No More Prevoius Page Is There.');
                    return false;
                }
            });
            $('.btnnext').live('click', function () {
                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    $(".lblpage").html(pageno);
                    FillFeild()
                    BindAdmissionList();
                    return false;
                }
                else {
                    alertify.error('No More Next Page Is There.');
                    return false;
                }
            });
            $('.btnlast').live('click', function () {
                pageno = pagecount;
                $(".lblpage").html(pageno);
                FillFeild()
                BindAdmissionList();
                alertify.success('You Are On The Last Page.');
                return false;
            });
        });

        function SendFeeMsg(ASAID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../StudentManagement/student-fee-info.aspx/sendFeeRemainder",
                data: "{'ASAID':'" + ASAID + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == '5') {
                        alert('Fee Remainder Msg Send to Registered Mobile No.');
                        return false;
                    }
                    else {
                        alert('Msg not Send');
                    } return false;
                }
            });
        }
        function FillFeild() {
            name = $('#sname').val();
            admission = $('#txtadmissionno').val();
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            classid = $('#dllclass').val();
            duefromdate = $('#txtfromdate').val();
            duetodate = $('#Text1').val();
        }
        function FillFieldForPay() {
            myData.ASAID = $('#ctl00_ContentPlaceHolder1_hfforasaid').val();
            myData.PAYMENTMODE = $('#ctl00_ContentPlaceHolder1_ddlkPayment').val();
            myData.BANKNAME = $('#txtBank').val();
            myData.BRANCHNAME = $('#txtbranchbank').val();
            myData.CHKREFDDNEFTREFRENCENO = $('#txtChequeDD').val();
            myData.CHKREFDDNEFTDATE = $('#txtToDate').val();
            myData.RECIPTNO = $('#ctl00_ContentPlaceHolder1_txtfeerecipt').val();
            myData.PAYMENTDATE = $('#txtpaydate').val();
            myData.FineAmount = $('#txtFine').val();
            myData.RemarkOrComment = $('#txtareacomment').val();
            myData.PaidAmount = $('#txtAmount').val();
            myData.DateOfDueAmount = $('#txtDate').val();
            myData.SelectedASID = $('#ctl00_ContentPlaceHolder1_hfforasaid').val();
        }
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65) && (charCode <= 90)) {
                return false;
            }
            return true;
        };
        function getFine(ASAID, AMOUNT) {
            var TodayDate = $('#txtpaydate').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../StudentManagement/student-fee-info.aspx/GetFine",
                data: "{'ASAID':'" + ASAID + "','TodayDate':'" + TodayDate + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d > 0) {
                        $('#txtFine').val(parseFloat(data.d).toFixed(2));
                        $('#txtPayable').val((parseFloat(AMOUNT) + parseFloat($('#txtFine').val())).toFixed(2));
                        $('#txtAmount').val((parseFloat(AMOUNT) + parseFloat($('#txtFine').val())).toFixed(2));
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
                url: "../StudentManagement/student-fee-info.aspx/BindPayNow",
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
                        $('#ctl00_ContentPlaceHolder1_txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                        $('#txtPayableamountexcludingtax').val(CurrentDeailsRow.find("InstallmentAmount").text());
                        $('#txttableamount').val(CurrentDeailsRow.find("TaxableAmount").text());
                        $('#txtnontaxableamount').val(CurrentDeailsRow.find("NonTaxableAmount").text());
                        $('#txtsevicetax').val(CurrentDeailsRow.find("ServiceTax").text());
                        $('#txttaxamount').val(CurrentDeailsRow.find("Tax").text());
                        $('#txtPayable').val(CurrentDeailsRow.find("PayableAmount").text());
                        $('#txtAmount').val(CurrentDeailsRow.find("PayableAmount").text());
                        $('#txtReceiver').val($('#ctl00_lblAdmin').text());
                        asaid = ASAID, money = $('#txtAmount').val();
                        getFine(ASAID,$('#txtAmount').val());
                    });
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
        function BindAdmissionList() {
            var trforappend = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "deposit-fee.aspx/BindFeeDetails",
                data: "{'pageno':'" + pageno + "','pagesize':'" + pagesize + "','name':'" + name + "','admission':'" + admission + "','fyid':'" + fyid + "','classid':'" + classid + "','duefromdate':'" + duefromdate + "','duetodate':'" + duetodate + "'}",
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
                          + '<td>' + CurrentDeailsRow.find("AdmissionNo").text() + '</td>'
                          + '<td>' + CurrentDeailsRow.find("Name").text() + '</td>'
                          + '<td>' + CurrentDeailsRow.find("Classname").text() + '</td>'
                          + '<td>' + CurrentDeailsRow.find("InstallmentAmount").text() + '</td>'
                          + '<td>' + CurrentDeailsRow.find("Tax").text() + '</td>'
                          + '<td>' + CurrentDeailsRow.find("InstallmentDate").text() + '</td>'
                          + '<td><input class="ImgBtnForPayNow" type="image" style="width:20px;border-width:0px;" src="../../images/paynow.png" title="Click Here For Pay Fee Now." /></td>'
                          + '<td><input class="ImgBtnForSendFeeRemnainder" type="image" style="width:20px;border-width:0px;" src="../../images/message.png" title="Click Here For Send Fee Remiander." /></td>'
                          + '<td>' +
                          '<span class="SpanInstallmentName" style="display:none">' + CurrentDeailsRow.find("InstallmentName").text() + '</span>' +
                          '<span class="SpanInstallmentDetails" style="display:none">' + CurrentDeailsRow.find("FeeDescription").text() + '</span>' +
                          '<span class="SpanDiscountDetails" style="display:none">' + CurrentDeailsRow.find("DiscountDescription").text() + '</span>' +
                          '<input class="ImgBtnForInstallmentDetails" type="image" style="width:18px;border-width:0px;" src="../../images/viewquestion.png" title="Click Here For Send Fee Remiander." /></td>'
                        '</tr>'
                        i = i + 1;
                        pagecount = CurrentDeailsRow.find("Pages").text();
                        $('.lbltotalpage').html(CurrentDeailsRow.find("Pages").text());
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                    });
                    $('#GrdPayNow tbody').append(trforappend);
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
        function BindClass() {
            fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overall-admissions.aspx/BindClassMethod",
                data: "{'fyid':'" + fyid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#dllclass").html("");
                    $("#dllclass").append($("<option></option>").val('0').html('Select Class'));
                    $.each(data.d, function (key, value) {
                        $("#dllclass").append($("<option></option>").val(value.courseID).html(value.courseName));

                    });
                }
            });
        }   
        </script>
</asp:Content>