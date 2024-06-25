<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="PayHostel.aspx.cs" Inherits="BranchPanel_Fee_Management_PayHostel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .new-registration .for_sigle_row_form label {
            width: 135px;
        }

        .ui-dialog {
            top: 100px;
            width: 500px;
            left: 500px;
        }
    </style>
    <%--<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>--%>
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="grid-data-resposive">
            <div class="sub-heading">
                Student Information                             
            </div>
            <div class="for_sigle_row_form" runat="server">
                <label>
                    Admission Session<span style="color: Red; font-weight: bold">*</span></label>
                <asp:DropDownList ID="ddlFyid" runat="server" Enabled="false">
                    <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                </asp:DropDownList>&nbsp;                   
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Class<span style="color: Red; font-weight: bold">*</span></label>
                <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                    <asp:ListItem Value="0">--Select Class--</asp:ListItem>
                </asp:DropDownList>&nbsp;                   
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Section<span style="color: Red; font-weight: bold">*</span></label>
                <asp:DropDownList ID="ddlsection" runat="server">
                    <asp:ListItem Value="0">--Select Section--</asp:ListItem>
                </asp:DropDownList>&nbsp;                   
            </div>
            <br />
        </div>
        <div class="divforstm">
            <div class="sub-heading">
                Student Information
                <img src="../../images/Back.png" id="imgbtnforcollapseorexpend" title="Click here to expend or collapse all field." style="float: right; margin-right: 20px; margin-top: -2px; width: 60px;" alt="No Image" />
            </div>
            <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">Registration No</th>
                    <th align="center">Admission No</th>
                    <th align="center">Student Name</th>
                    <th align="center">Parent Name</th>
                    <th align="center">Hostel Name</th>
                    <th align="center">Class</th>
                    <th align="center">Section</th>
                    <th align="center">Total Amt</th>
                    <th align="center">Paid Amt</th>
                    <th align="center">Bal Amt</th>
                    <th align="center">Pay Status</th>
                    <th align="center">View Details</th>
                </tr>
            </table>
            <br />
            <table style="width: 100%">
                <tr>
                    <td valign="top" style="width: 50%">
                        <table width="100%" class="stm1 stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="Table2" aligh="center"
                            style="width: 98%; text-align: center;">
                            <tr class="stm_head1">
                                <th align="center">S.No.</th>
                                <th align="center">Month</th>
                                <th align="center">Amount</th>
                                <th align="center">Status</th>
                                <th align="center">Print</th>
                                <th align="center">View Fee</th>
                                <th align="center">Pay</th>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 50%">
                        <%--<div class="main-div-tbl">
                            <div class="new-registration">
                                <div class="sub-heading">
                                    Fee Detail                
                                </div>  
                                <asp:HiddenField  ID="fdASAID" runat="server" Value="0"/>
                                <asp:HiddenField  ID="fdSturegNo" runat="server" Value="0"/>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Payable Month</label>
                                    <asp:TextBox ID="txtMonth" runat="server" Enabled="false" placeholder="Enter Payable Amount"></asp:TextBox>&nbsp;                        
                                </div>                            
                                <div class="for_sigle_row_form">
                                    <label>
                                        Payable Amount</label>
                                    <asp:TextBox ID="txtPayableAmt" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Payable Amount"></asp:TextBox>&nbsp;                        
                                </div>
                                 <div class="for_sigle_row_form">
                                    <label>
                                        Fine<span style="color: Red; font-weight: bold">*</span></label>
                                    <asp:TextBox ID="txtFeeFine" runat="server" placeholder="0" Enabled="false">0</asp:TextBox>&nbsp; 
                    
                                </div> 
                                <div class="for_sigle_row_form">
                                    <label>
                                        Pay Amount<span style="color: Red; font-weight: bold">*</span></label>
                                    <asp:TextBox ID="txtPayAmt" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Pay Amount"></asp:TextBox>&nbsp;
                                </div>
                                <div class="for_sigle_row_form" id="StudentDOB">
                                    <label>
                                        Pay Date<span style="color: Red; font-weight: bold">*</span></label>
                                    <asp:TextBox ID="txtPaidDate" onkeypress="return false" runat="server" placeholder="Select Payment Date"></asp:TextBox>&nbsp; 
                    
                                </div>   
                                                             

                                <div class="clear"></div>
                                <div class="for_sigle_row_form">
                                    <label style="padding-top: 4px;">
                                        Submit</label>
                                    <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" CssClass="button_save" />
                                    <asp:Button ID="btnforcancel" runat="server" Text="Cancel" CssClass="button_cancel" />
                                </div>
                                <br />
                                <br />
                            </div>
                        </div>--%>

                        <div class="main-div-tbl">
                        <div id="divPayment" class="new-registration">                          
                            <div class="sub-heading">
                                    Fee Detail                
                                </div>  
                                <asp:HiddenField  ID="fdASAID" runat="server" Value="0"/>
                                <asp:HiddenField  ID="fdSturegNo" runat="server" Value="0"/>
                           <%-- <asp:HiddenField  ID="txtremainningamount" runat="server" />--%>
                            <div class="for_sigle_row_form">
                                    <label>Payable Month</label>
                                    <asp:TextBox ID="txtMonth" runat="server" Enabled="false" placeholder="Enter Payable Amount"></asp:TextBox>&nbsp;                        
                                </div>  
                            <div class="for_sigle_row_form" id="div0">
                                <label>Reciept No.</label>
                                <asp:TextBox runat="server" ID="txtfeerecipt" onkeypress="return noAlphabets(event)" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form" id="div1">
                                <label>Payable Amount(Excluding Tax)</label>
                                <input id="txtPayableamountexcludingtax" readonly="readonly" type="text" value="0.00" />
                            </div>
                            <div class="for_sigle_row_form" id="div2">
                                <label>Taxable Amount</label>
                                <input id="txttableamount" readonly="readonly" type="text" value="0.00" />
                            </div>
                            <div class="for_sigle_row_form" id="div3">
                                <label>Non Taxable Amount</label>
                                <input id="txtnontaxableamount" readonly="readonly" type="text" value="0.00" />
                            </div>
                            <div class="for_sigle_row_form" id="div4">
                                <label>Service Tax(In%)</label>
                                <input id="txtsevicetax" readonly="readonly" type="text" value="0.00" />
                            </div>
                            <div class="for_sigle_row_form" id="div5">
                                <label>Tax Amount</label>
                                <input id="txttaxamount" readonly="readonly" type="text" value="0.00" />
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Fine Amount</label>                              
                                 <asp:TextBox ID="txtFeeFine" runat="server" placeholder="0" Enabled="false">0</asp:TextBox>&nbsp; 
                            </div>
                            <div class="for_sigle_row_form">                               
                                <label>Payable Amount</label>                                
                                <asp:TextBox ID="txtPayableAmt" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Payable Amount"></asp:TextBox>&nbsp;  
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Enter Amount Paid<span style="color: Red">*</span></label>                               
                                <asp:TextBox ID="txtPayAmt" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Pay Amount"></asp:TextBox>&nbsp;
                      <div style="float: right; width: 466px;">
                          <label id="lblremainningamount" style="color: green; width: 190px"></label>
                      </div>
                            </div>
                            <div id="Partialpayment" style="display: none">
                                <div class="for_sigle_row_form">
                                    <label>Due Date For Remaining Amount<span style="color: Red">*</span></label>
                                    <input id="txtDate" type="text" readonly="readonly" placeholder="Select Due Date For Remaing Amount" />
                                </div>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Payment Date<span style="color: Red">*</span></label>                              
                                 <asp:TextBox ID="txtPaidDate" onkeypress="return false" runat="server" placeholder="Select Payment Date"></asp:TextBox>&nbsp; 
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Payment Mode<span style="color: Red">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlkPayment">
                                    <asp:ListItem Value="1">Cash</asp:ListItem>
                                    <asp:ListItem Value="2">Cheque</asp:ListItem>
                                    <asp:ListItem Value="3">DD</asp:ListItem>
                                    <asp:ListItem Value="4">Card</asp:ListItem>
                                    <asp:ListItem Value="5">NEFT</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="for_sigle_row_form" id="ChequeDetail" style="display: none">
                                <label>Cash Mode<span style="color: Red">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlChequeMode">
                                    <asp:ListItem Value="1">Non Cheque</asp:ListItem>
                                    <asp:ListItem Value="2">Micar Cheque</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div id="BankDetail" style="display: none">
                                <div class="for_sigle_row_form" id="divforbankname">
                                    <label>Bank Name<span style="color: Red">*</span></label>
                                    <input type="text" id="txtBank" placeholder="Enter Bank Name PLease" />
                                </div>

                                <div class="for_sigle_row_form" id="divforANo">
                                    <label>Account Number<span style="color: Red">*</span></label>
                                    <input type="text" id="txtANo" placeholder="Enter Account No PLease" />
                                </div>

                                <div class="for_sigle_row_form" id="divforbranchname">
                                    <label>Branch Name<span style="color: Red">*</span></label>
                                    <input type="text" id="txtbranchbank" placeholder="Enter Branch Name PLease" />
                                </div>

                                <div class="for_sigle_row_form" id="divforchkrefno">
                                    <label runat="server" id="lblchkrefno">Cheque Number<span style="color: Red">*</span></label>
                                    <input type="text" id="txtChequeDD" placeholder="Enter Refrence Number PLease" />
                                </div>

                                <div class="for_sigle_row_form" id="divmicraname">
                                    <label>Micre Code<span style="color: Red">*</span></label>
                                    <input type="text" id="txtmicre" placeholder="Enter Micre Code" />
                                </div>

                                <div class="for_sigle_row_form" id="divforchkrefdate">
                                    <label id="lblchkrefdate">Cheque Date<span style="color: Red">*</span></label>
                                    <input type="text" id="txtToDate" onkeypress="return false" placeholder="Select Date PLease" />
                                </div>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Received By<span style="color: Red">*</span></label>
                                <input type="text" readonly="readonly" id="txtReceiver" />
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Comment/Remark</label>
                                <textarea cols="2" rows="3" id="txtareacomment" placeholder="Enter The Remark Please."></textarea>
                            </div>
                           <%-- <div class="for_sigle_row_form">
                                <label></label>
                                <label style="width: auto;">
                                    <input type="checkbox" checked="checked" id="chkprint" />
                                    Print Now</label>
                            </div>--%>
                            <div class="clear"></div>
                            <div class="for_sigle_row_form" style="margin-bottom: 10px !important;">
                                <label></label>
                                <a id="BtnPayNow" class="button_save">Pay Now</a>
                                 <asp:Button ID="btnforcancel" runat="server" Text="Cancel" CssClass="button_cancel" />
                            </div>

                            <%--<div class="for_sigle_row_form">
                                    <label style="padding-top: 4px;">Submit</label>
                                    <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" CssClass="button_save" />
                                    <asp:Button ID="btnforcancel" runat="server" Text="Cancel" CssClass="button_cancel" />
                                </div>--%>

                            <asp:HiddenField ID="hfforasaid" runat="server" />
                        </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry No Record found.</label>
        </div>
    </div>
    <div id="dialog" style="display: none" align="center">
        <table width="100%" class="stm2 stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="Table1" aligh="center"
            style="width: 98%; text-align: center;">
            <tr class="stm_head1">
                <th align="center">S.No.</th>
                <th align="center">Fee Name</th>
                <th align="center">Amount</th>
            </tr>
        </table>
    </div>
    <script type="text/javascript">      
        var myData = {},year = 2020, RID = 0, Fyid = 0, PayAmtID = 0, DueDate = '', PayAmount = 0,_txtremainningamount=0;
        $(document).ready(function () {
            $(function () {
                $("#dialog").dialog({
                    modal: true,
                    autoOpen: false,
                    title: "Fee Head List",
                    width: 500
                });
            });

            $('#div0').hide();
            $('#div1').hide();
            $('#div2').hide();
            $('#div3').hide();
            $('#div4').hide();
            $('#div5').hide();

            function ResetPaymentHistory() {
                $('#ctl00_ContentPlaceHolder1_txtPayAmt').val($('#ctl00_ContentPlaceHolder1_txtPayableAmt').val());
                $('#lblremainningamount').html('');
                $('#Partialpayment').css('display', 'none');
                $('#txtDate').val('');                
                $("#ctl00_ContentPlaceHolder1_ddlkPayment").val("1");               
                $("#ctl00_ContentPlaceHolder1_ddlChequeMode").val("1");              
                $('#txtBank').val('');
                $('#txtANo').val('');
                $('#txtbranchbank').val('');
                $('#txtChequeDD').val('');
                $('#txtmicre').val('');
                $('#txtToDate').val('');
                $('#txtReceiver').val('');
                $('#txtareacomment').val('');
                $('#BankDetail').hide();
                $('#divmicraname').hide();
                $(".main-div-tbl").hide();
            }

            

            $('#ctl00_ContentPlaceHolder1_txtPayAmt').change(function () {
                
                $('#lblremainningamount').html('');
                $('#Partialpayment').css('display', 'none');
                $('#txtDate').val('');               
                if (parseInt($(this).val()) < parseInt($('#ctl00_ContentPlaceHolder1_txtPayableAmt').val())) {                   
                    $('#lblremainningamount').html('Remaining Amount:' + (parseInt($('#ctl00_ContentPlaceHolder1_txtPayableAmt').val()) - $(this).val()) + '.00');
                    _txtremainningamount = (parseInt($('#ctl00_ContentPlaceHolder1_txtPayableAmt').val()) - $(this).val()) + '.00';
                    $('#Partialpayment').css('display', 'block');
                }
                else if (parseInt($(this).val()) > parseInt($('#ctl00_ContentPlaceHolder1_txtPayableAmt').val())) {
                    alertify.error('Amount To Be Paid Can Not Greater Than Payable Amount.');
                } 
            });

            $('#ctl00_ContentPlaceHolder1_ddlkPayment').change(function () {
                paymentMode = $('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val();
                if (paymentMode > 1 && paymentMode != 4) {
                    $('#BankDetail').show(500);
                    if (paymentMode == 2) {
                        $('#divmicraname').hide(500);
                        $('#ChequeDetail').show(500);
                    }
                    else if (paymentMode == 3) {
                        $('#ChequeDetail').hide(500);
                        $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('DD Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('DD Date<span style="color: Red">*</span>');
                    }
                    else if (paymentMode == 5) {
                        $('#ChequeDetail').hide(500);
                        $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('Transaction Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('Transaction Date<span style="color: Red">*</span>');
                    }
                }
                else {
                    $('#ChequeDetail').hide(500);
                    $('#BankDetail').hide(500);
                }
            });

            $('#ctl00_ContentPlaceHolder1_ddlChequeMode').change(function () {
                chequeMode = $('#ctl00_ContentPlaceHolder1_ddlChequeMode option:selected').val();
                $('#BankDetail').show(500);
                if (chequeMode > 1) {
                    $('#divmicraname').show(500);
                }
                else {
                    $('#divmicraname').hide(500);
                }
            });

            function FillFieldForPay() {               
                myData.PaybleMonth = $('#ctl00_ContentPlaceHolder1_txtMonth').val();              
                myData.FineAmount = $('#ctl00_ContentPlaceHolder1_txtFeeFine').val();
                myData.PAYMENTDATE = $('#ctl00_ContentPlaceHolder1_txtPaidDate').val();
                myData.PayableAmount = $('#ctl00_ContentPlaceHolder1_txtPayableAmt').val();
                myData.PaidAmount = $('#ctl00_ContentPlaceHolder1_txtPayAmt').val();
                //alert(myData.PaidAmount);
                myData.PAYMENTMODE = $('#ctl00_ContentPlaceHolder1_ddlkPayment').val();
                myData.CHEQUEMODE = $('#ctl00_ContentPlaceHolder1_ddlChequeMode').val();
                myData.BANKNAME = $('#txtBank').val();
                myData.ACCOUNTNO = $('#txtANo').val();
                myData.BRANCHNAME = $('#txtbranchbank').val();
                myData.CHKREFDDNEFTREFRENCENO = $('#txtChequeDD').val();
                myData.MicreCode = $('#txtmicre').val();
                myData.CHKREFDDNEFTDATE = $('#txtToDate').val();
                myData.ReceivedBy = $('#txtReceiver').val();
                myData.RemarkOrComment = $('#txtareacomment').val(); 
                myData.RemainingAmountDate = $('#txtDate').val();
                //myData.RemainingAmount = $('#lblremainningamount').text(); 
                myData.RemainingAmount = _txtremainningamount;
                myData.Fyid = $('#ctl00_ContentPlaceHolder1_ddlFyid').val();
                myData.SturegNo = $("#ctl00_ContentPlaceHolder1_fdSturegNo").val(); 
                myData.MonthID = $("#ctl00_ContentPlaceHolder1_fdASAID").val();
                console.log(myData);
            }

            $('#BtnPayNow').click(function () {

                FillFieldForPay();
                
                var err = 0, ermsg = '';
                if ($('#ctl00_ContentPlaceHolder1_txtPayAmt').val() == '') {
                    ermsg = "Please Enter The Amount To Be Paid. \n";
                    err = 1;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtPaidDate').val() == '') {
                    ermsg = "Please Select Payment Date. \n";
                    err = 1;
                }
                if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 0) {
                    ermsg = ermsg + "please Select Payment Mode \n";
                    err = 1;
                }

                if ($('#ctl00_ContentPlaceHolder1_ddlChequeMode option:selected').val() == 2) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtANo').val() == '') {
                        ermsg = ermsg + "Please Enter Account Number. \n";
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

                if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 2) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtANo').val() == '') {
                        ermsg = ermsg + "Please Enter Account Number. \n";
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
                    if ($('#txtANo').val() == '') {
                        ermsg = ermsg + "Please Enter Account Number. \n";
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
                    if ($('#txtANo').val() == '') {
                        ermsg = ermsg + "Please Enter Account Number. \n";
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
                    alertify.error(ermsg);
                    return;
                }
                else {
                    var DTO = { 'theData': myData };
                    $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "PayHostel.aspx/DepositFee",
                    data: JSON.stringify(DTO),
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            $('#ctl00_ContentPlaceHolder1_txtFeeFine').val('0.00');
                            setTimeout(() => {
                                Fyid = myData.Fyid;
                                StuRegNo = $("#ctl00_ContentPlaceHolder1_fdSturegNo").val();                               
                                BindTrans(StuRegNo);
                                ResetPaymentHistory();
                            }, 10);
                            window.open("HostelFeeReceipt.aspx?PayAmtID=" + data.d + "", '_blank');
                            return false;
                        }
                        else {
                            alertify.alert('Sorry Error during Fee Depositing .Please try again');
                            return false;
                        }
                    }
                });
                }
              /*  else {
                    FillFieldForPay();
                    var DTO = { 'theData': myData };
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "student-fee-info.aspx/DepositFee",
                        data: JSON.stringify(DTO),
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == '1') {
                                alertify.success('Fee Deposited Successfully and Sent Msg to Registered Mobile No.');
                                if ($('#chkprint').attr('checked') == 'checked') {
                                    window.open("../Fee Management/DoublePay.aspx?sid=" + $('#ctl00_ContentPlaceHolder1_txtfeerecipt').val(), '_blank');
                                }
                            }
                            if (data.d == '2') {
                                alertify.error('Duplicate Recipt No.');
                            }
                            if (data.d == '0') {
                                alertify.error('Some Error Occur.');
                            }
                            if (data.d == '5') {
                                alertify.success('Fee Deposited Successfully.');
                            }
                            $('#divPayment').hide(500);
                            $('#txtareacomment').val('');
                            CallMethod();
                            return false;
                        }
                    });
                    location.reload(true);
                } 
                */
            });

            //$("#ctl00_ContentPlaceHolder1_txtPaidDate").datepicker.regional[""].dateFormat = 'dd MMM yyyy';
            //$("#ctl00_ContentPlaceHolder1_txtPaidDate").datepicker("setDate", new Date());

            Fyid = $('#ctl00_ContentPlaceHolder1_ddlFyid').val();
            $(".main-div-tbl").hide();
            $(".divforstm").hide();
            $(".main-div-tbl").hide();
            $("#ctl00_ContentPlaceHolder1_Table2").hide();
            $(".grid-data-resposive").show();
            $('#ctl00_ContentPlaceHolder1_ddlsection').change(function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() > 0) {
                    $(".divforstm").show();
                    $("#ctl00_ContentPlaceHolder1_Table2").hide();
                    Bindstudentregistration(0);
                }
                else {
                    window.location.href = "PayHostel.aspx";
                }
            });
            $('#btnAdd').click(function () {
                $(".main-div-tbl").show();
                $(".grid-data-resposive").hide();
            });
            $('#btnPay').click(function () {
                window.location.href = "PayLastFee.aspx";
            });
            $('#imgbtnforcollapseorexpend').live('click', function () {
                window.location.href = "PayHostel.aspx";
            });
            $('.PayFee').live('click', function () {
                var PayStatus = '';
                PayStatus = $(this).closest('tr').find(".name").html();
                if (PayStatus != 'Paid ') {
                    RID = $(this).closest('tr').find('input[type=hidden]').val();
                    window.location.href = "PayLastFee.aspx?RID=" + RID + "&FYID=" + Fyid + "";
                }
                else {
                    alert('Sorry, Fee Already Paid');
                }
            });
            $('.PayAmt').live('click', function () {
                if ($(this).closest('tr').find('td:eq(3)').text().trim() == 'Unpaid') {
                    PayAmtID = $(this).closest('tr').find('input[type=hidden]').val();
                    DueDate = $(this).closest('tr').find('td:eq(1)').text();
                    PayAmount = $(this).closest('tr').find('td:eq(2)').text();
                    $("#ctl00_ContentPlaceHolder1_txtMonth").val($(this).closest('tr').find('td:eq(1)').text());
                    $("#ctl00_ContentPlaceHolder1_fdASAID").val(PayAmtID);
                    $("#ctl00_ContentPlaceHolder1_txtPayableAmt").val($(this).closest('tr').find('td:eq(2)').text());
                    $("#ctl00_ContentPlaceHolder1_txtPayAmt").val($(this).closest('tr').find('td:eq(2)').text());
                    getFine(PayAmtID, DueDate, PayAmount);
                    $(".main-div-tbl").show();
                }
                else {
                    $(".main-div-tbl").hide();
                    alertify.alert('Already Fee Deposite this Month.');
                }
            });
            $('.ImgBtnFeeDetails').live('click', function () {
                MonthID = $(this).closest('tr').find('input[type=hidden]').val();
                BindFeName(StuRegNo, MonthID);
                $('#dialog').dialog('open');
                return false;
            });

            $('.PrintPayAmt').live('click', function () {
                PayAmtID = $(this).closest('tr').find('#fdPayID').val();
                if ($(this).closest('tr').find('td:eq(3)').text().trim() == 'Unpaid') {
                    alertify.alert('Fee does not Deposite of this Month.');
                }
                else {
                    $(".main-div-tbl").hide();
                    window.open("HostelFeeReceipt.aspx?PayAmtID=" + PayAmtID + "", '_blank');
                }
            });
            $('.showdiscount').live('click', function () {
                $(".grid-data-resposive").hide();
                $(".divforstm").show();
                $("#ctl00_ContentPlaceHolder1_Table2").show();
                StuRegNo = $(this).closest('tr').find('input[type=hidden]').val();
                $("#ctl00_ContentPlaceHolder1_fdSturegNo").val(StuRegNo);
                Bindstudentregistration(StuRegNo);
               
                BindTrans(StuRegNo);
                //BindFeName(StuRegNo, PayAmtID);
                //window.location.href = "PayLastFee.aspx?RID=" + RID + "&FYID=" + $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() + "";
            });
            $("#ctl00_ContentPlaceHolder1_txtPaidDate,#ctl00_ContentPlaceHolder1_txtregistrationdate,#txtToDate,#txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:2020',
                dateFormat: 'dd MM yy'
                //defaultDate: '01/26/2017'
            });
            $("#ctl00_ContentPlaceHolder1_txtPaidDate,#txtToDate").datepicker("setDate", new Date());

            $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').change(function () {
                BindSection();
            });
            $('#ctl00_ContentPlaceHolder1_txtPaidDate').live('change', function () {
                getFine(PayAmtID, DueDate, PayAmount);
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnforupdateorsave').click(function () {
                if ($('#ctl00_ContentPlaceHolder1_txtMonth').val() == '0') {
                    alertify.error('Enter Payable Month please.');
                    $('#ctl00_ContentPlaceHolder1_txtMonth').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtPayableAmt').val() == '') {
                    alertify.error('Enter Payable Amount please.');
                    $('#ctl00_ContentPlaceHolder1_txtPayableAmt').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtPayAmt').val() == '') {
                    alertify.error('Enter Pay Amount please.');
                    $('#ctl00_ContentPlaceHolder1_txtPayAmt').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtPaidDate').val() == '') {
                    alertify.error('Enter Payment Date please.');
                    $('#ctl00_ContentPlaceHolder1_txtPaidDate').focus();
                    return false;
                }
                else if (parseFloat($('#ctl00_ContentPlaceHolder1_txtPayAmt').val()) != (parseFloat($('#ctl00_ContentPlaceHolder1_txtPayableAmt').val()) + parseFloat($('#ctl00_ContentPlaceHolder1_txtFeeFine').val()))) {
                    alertify.error('Pay Amount should equal to Payable Amount,');
                    $('#ctl00_ContentPlaceHolder1_txtPayAmt').focus();
                    return false;
                }
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "PayHostel.aspx/Deposite",
                    data: "{'PaymentDate':'" + $("#ctl00_ContentPlaceHolder1_txtPaidDate").val() + "','Fyid':'" + Fyid + "','SturegNo':'" + $("#ctl00_ContentPlaceHolder1_fdSturegNo").val() + "','MonthID':'" + $("#ctl00_ContentPlaceHolder1_fdASAID").val() + "','FeeFine':'" + $('#ctl00_ContentPlaceHolder1_txtFeeFine').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            $('#ctl00_ContentPlaceHolder1_txtFeeFine').val('0.00');
                            window.open("HostelFeeReceipt.aspx?PayAmtID=" + data.d + "", '_blank');
                            return false;
                        }
                        else {
                            alertify.alert('Sorry Error during Fee Depositing .Please try again');
                            return false;
                        }
                    }
                });
            });
        });
        function getFine(PayAmtID, DueDate, Amount) {
            var TodayDate = $('#ctl00_ContentPlaceHolder1_txtPaidDate').val();
            var TtlFine = 0;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "PayHostel.aspx/GetFine",
                data: "{'PayAmtID':'" + PayAmtID + "','DueDate':'" + DueDate + "','TodayDate':'" + TodayDate + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d > 0) {
                        TtlFine = parseFloat(data.d);
                        //+parseFloat($('#txtFine').val());
                        //if ($('#txtFeeFine').val() == 0.00) {
                        $('#ctl00_ContentPlaceHolder1_txtFeeFine').val(TtlFine);
                        //}
                        //$("#ctl00_ContentPlaceHolder1_txtPayableAmt").val((parseFloat(Amount) + parseFloat(data.d)).toFixed(2));
                        $("#ctl00_ContentPlaceHolder1_txtPayAmt").val((parseFloat(Amount) + parseFloat(data.d)).toFixed(2));
                    }
                    else if (data.d == 5) {
                        if (confirm('Sorry, You have not Set Fine Fee. Do you want take transport ?')) {
                            window.location.replace('../Fee%20Management/mst_FeeFine.aspx');
                            return false;
                        }
                    }
                },
                error: function (response) {
                    alertify.error('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
        function BindSection() {
            $('#ctl00_ContentPlaceHolder1_ddlsection').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "../Admission/new-admission.aspx/BindSectionDDL",
                data: "{'Classid':'" + $("#ctl00_ContentPlaceHolder1_ddlapplyingforclass").val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlsection').html('<option value="0">--Select Section--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlsection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
                        }
                    }
                }
            });
        }
        function Bindstudentregistration(StuRegNo) {
            $('.stm tr:gt(0)').remove();
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "PayHostel.aspx/BindGridByJs",
                data: "{'StuRegNo':'" + StuRegNo + "','Mode':'7','Fyid':'" + Fyid + "','ClassID':'" + $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() + "','SectionID':'" + $('#ctl00_ContentPlaceHolder1_ddlsection').val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        pagecount = data.d[0].pagecount;
                        $('.lbltotalpage').html(data.d[0].pagecount);
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                        for (var i = 0; i < data.d.length; i++) {
                            trforappend = trforappend + "<tr class=" + trclass + ">" +
                                "<td><input type='hidden' value='" + data.d[i].StuRegNo + "' />" + (i + 1) + "</td>" +
                                "<td>" + data.d[i].Registration_No + " </td>" +
                                "<td>" + data.d[i].AdmissionNo + " </td>" +
                                "<td>" + data.d[i].studentFname + " " + data.d[i].studentMname + " " + data.d[i].studentLname + " </td>" +
                                "<td>" + data.d[i].fatherFname + " " + data.d[i].fatherMname + " " + data.d[i].fatherLname + " </td>" +
                                "<td>" + data.d[i].HostelName + " </td>" +
                                "<td>" + data.d[i].Classname + " </td>" +
                                "<td>" + data.d[i].Sectionname + " </td>" +
                                "<td>" + data.d[i].TotalFee + " </td>" +
                                "<td>" + data.d[i].PaidFee + " </td>" +
                                "<td>" + data.d[i].BalFee + "</td>" +
                                "<td class='name'>" + data.d[i].PayStatus + " </td>" +
                                "<td><img src='../../images/viewquestion.png' style='border-width:0px;height:15px;width:15px;border-width:0px;' title='Click here to show detail.' class='showdiscount'></img></td>" +
                                //"<td><img src='../../images/fee-payment.png' style='border-width:0px;height:25px;width:30px;border-width:0px;' title='Click here to show detail.' class='PayFee'></img></td>" +
                                "</tr>"
                        }
                        $('.stm').append(trforappend);
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                    }
                },
                error: function (result) {
                    alertify.error("Error While Grid Is Binding");
                }
            });
        }
        function BindTrans(StuRegNo) {
            $('.stm1 tr:gt(0)').remove();
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "PayHostel.aspx/BindTransAmount",
                data: "{'StuRegNo':'" + StuRegNo + "','Mode':'8','Fyid':'" + Fyid + "'}",
                dataType: "json",
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        pagecount = data.d[0].pagecount;
                        $('.lbltotalpage').html(data.d[0].pagecount);
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                        for (var i = 0; i < data.d.length; i++) {
                            trforappend = trforappend + "<tr class=" + trclass + ">" +
                                "<td><input type='hidden' value='" + data.d[i].PayAmtID + "' /><input type='hidden' id='fdPayID' value='" + data.d[i].PayID + "' />" + (i + 1) + "</td>" +
                                "<td>" + data.d[i].DueDate + " </td>" +
                                "<td>" + data.d[i].FeeAmount + " </td>" +
                                "<td>" + data.d[i].Status + " </td>" +
                                "<td><img src='../../images/recipt.png' style='border-width:0px;height:30px;width:40px;border-width:0px;' title='Click here to show detail.' class='PrintPayAmt'></img></td>" +
                                "<td><input class='ImgBtnFeeDetails' type='image' style='width:18px;border-width:0px;' src='../../images/viewquestion.png'></td>" +
                                "<td><img src='../../images/pay.png' style='border-width:0px;height:30px;width:40px;border-width:0px;' title='Click here to show detail.' class='PayAmt'></img></td>" +
                                "</tr>"
                        }
                        $('.stm1').append(trforappend);
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                    }
                },
                error: function (result) {
                    alertify.error("Error While Grid Is Binding");
                }
            });
        }
        function BindFeName(StuRegNo, MonthID) {
            $('.stm2 tr:gt(0)').remove();
            var Total = 0;
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "PayHostel.aspx/GetHostelFee",
                data: "{'StuRegNo':'" + StuRegNo + "','MonthID':'" + MonthID + "'}",
                dataType: "json",
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
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
                                + '<td><input type="hidden" value=' + CurrentDeailsRow.find("HostelFeeID").text() + ' />' + (i + 1) + '</td>'
                                + '<td>' + CurrentDeailsRow.find("HostelFeeName").text() + '</td>'
                                + '<td>' + CurrentDeailsRow.find("HostelFeeAmt").text() + '</td>'
                            '</tr>'
                            Total = parseFloat(Total) + parseFloat(CurrentDeailsRow.find("HostelFeeAmt").text());
                            i = i + 1;
                        });
                        trforappend = trforappend + '<tr class=' + Class + '>'
                            + '<td></td>'
                            + '<td><b>Total</b></td>'
                            + '<td><b>' + Total + '</b></td>'
                        '</tr>'
                        $('.stm2').append(trforappend);
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                    }
                },
                error: function (result) {
                    alertify.error("Error While Grid Is Binding");
                }
            });
        }
    </script>

</asp:Content>

