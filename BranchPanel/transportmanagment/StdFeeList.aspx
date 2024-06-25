<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="StdFeeList.aspx.cs" Inherits="BranchPanel_transportmanagment_StdFeeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .new-registration .for_sigle_row_form label {
            width:135px;
        }
    </style>
    <%--<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>--%>
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="grid-data-resposive" runat="server" visible="false">
            <div class="sub-heading">
                Student Information                             
            </div>
            <div class="for_sigle_row_form" runat="server">
                <label>
                    Admission Session<span style="color: Red; font-weight: bold">*</span></label>
                <asp:DropDownList ID="ddlFyid" runat="server" Enabled="true">
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
                Student Transport Fees
                <img src="../../images/Back.png" id="imgbtnforcollapseorexpend" title="Click here to expend or collapse all field." style="float: right; margin-right: 20px; margin-top: -2px; width: 60px;" alt="No Image" />
            </div>
            <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid" style="display:none">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">Registration No</th>
                    <th align="center">Admission No</th>
                    <th align="center">Student Name</th>
                    <th align="center">Parent Name</th>
                    <th align="center">Parent Mob No</th>
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
            <table style="width:100%">
                <tr>
                    <td style="width:50%">
                        <div class="sub-heading FeeDT">
                            Un Paid Fee Details
                        </div>
                        <table width="100%" class="stm1 stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="Table1" aligh="center"
                            style="width: 98%; text-align: center;">
                            <tr class="stm_head1" style="background: black; color: white;">
                                <th align="center">S.No.</th>
                                <th align="center">Month</th>
                                <th align="center">Amount</th>
                                <th align="center">Pay</th>
                            </tr>
                        </table>
                    </td>
                    <td style="width:50%">
                        <div class="main-div-tbl">
                            <div class="new-registration">
                                <div class="sub-heading">
                                    Fee Detail                
                                </div>  
                                <asp:HiddenField  ID="fdASAID" runat="server" Value="0"/>
                                <asp:HiddenField  ID="fdSturegNo" runat="server" Value="0"/>
                                <div class="for_sigle_row_form" runat="server" visible="false">
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
                                        Fine Amount</label>
                                    <asp:TextBox ID="txtFine" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Fine Amount">00.0</asp:TextBox>&nbsp;                        
                                </div>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Pay Amount<span style="color: Red; font-weight: bold">*</span></label>
                                    <asp:TextBox ID="txtPayAmt" onkeypress="return isNumberKey(event)" runat="server" ReadOnly placeholder="Enter Pay Amount"></asp:TextBox>&nbsp;
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
                        </div>

                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="height:20px"></div>
                    </td>
                </tr>
                <tr>
                    <td style="width:50%">
                         <div class="sub-heading FeeDT">
                            Paid Fee Details
                             
                        </div>
                        <table width="100%" class="stmPaid stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="Table2" aligh="center"
                            style="width: 98%; text-align: center;">
                            <tr class="stm_head1" style="background: black; color: white;">
                                <th align="center">S.No.</th>
                                <th align="center">Month</th>
                                <th align="center">Paid Date</th>
                                <th align="center">Amount</th>
                                <th align="center">Roll Back</th>
                                <th align="center">Print</th>
                            </tr>
                        </table>
                    </td>
                    <td></td>
                </tr>
            </table>
        </div>
        <div class="clear"></div>        
    </div>
    <script type="text/javascript">
        var year = 2024, RID = 0, Fyid = 0, ASAID = 0, AllPayASAID = '', PayableAmount = 0, AllPrintASAID = '', StuRegNo=0;
        $(document).ready(function () {
            Fyid = $('#ctl00_ContentPlaceHolder1_ddlFyid').val();
            //$(".main-div-tbl").hide();
            //$(".divforstm").hide();
            $(".main-div-tbl").hide();
            $(".FeeDT").hide();
            $("#ctl00_ContentPlaceHolder1_Table2").hide();
            $("#ctl00_ContentPlaceHolder1_Table1").hide();
            $(".grid-data-resposive").show();
            //Bindstudentregistration(0);

            BindTransportFees();

            $('#ctl00_ContentPlaceHolder1_ddlsection').change(function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() > 0) {
                    $(".divforstm").show();
                    $("#ctl00_ContentPlaceHolder1_Table2").hide();
                    $("#ctl00_ContentPlaceHolder1_Table1").hide();
                    $(".FeeDT").hide();
                    Bindstudentregistration(0);
                }
                else {
                    window.location.href = "StdFeeList.aspx";
                }
            });
            $('#ctl00_ContentPlaceHolder1_txtFine').keyup(function () {
                var payableAmt = parseFloat($("#ctl00_ContentPlaceHolder1_txtPayableAmt").val());
                var newPayableAmt = 0;
                if ($(this).val() != undefined) {
                    if ($(this).val() != '') {
                        var fineAmt = parseFloat($(this).val());
                        newPayableAmt = (fineAmt + payableAmt).toFixed(2);
                    } else
                        newPayableAmt = payableAmt.toFixed(2);
                }
                else
                    newPayableAmt = payableAmt.toFixed(2);
                $('#ctl00_ContentPlaceHolder1_txtPayAmt').val(newPayableAmt);
            });
            $('#btnAdd').click(function () {
                $(".main-div-tbl").show();
                $(".grid-data-resposive").hide();
            });
            $('#btnPay').click(function () {
                window.location.href = "PayLastFee.aspx";
            });
            $('#ctl00_ContentPlaceHolder1_ddlFyid').live('click', function () {
                Fyid = $('#ctl00_ContentPlaceHolder1_ddlFyid').val();
                $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val('0');
                $('#ctl00_ContentPlaceHolder1_ddlsection').val('0');
            });
            $('#imgbtnforcollapseorexpend').live('click', function () {               
                window.location.href = "../StudentManagement/student-admission-list.aspx";
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
                debugger;
            //    if ($(this).closest('tr').find('td:eq(3)').text().trim() == 'Unpaid') {
                    if ($(this).prop("checked") == true) {
                        //alert($(this).closest('tr').find('input[type=checkbox]').val());
                    }
                    $(".main-div-tbl").show();
                    ASAID = $(this).closest('tr').find('input[type=hidden]').val();
                    getMuiltyPayASAID();
                    $("#ctl00_ContentPlaceHolder1_fdASAID").val(AllPayASAID);
                    $("#ctl00_ContentPlaceHolder1_txtPayableAmt").val(PayableAmount);
                    $("#ctl00_ContentPlaceHolder1_txtPayAmt").val(PayableAmount);
                $('#ctl00_ContentPlaceHolder1_txtPaidDate').datepicker({ dateFormat: 'dd-mm-yy' }).datepicker("setDate", new Date());
                $('#ctl00_ContentPlaceHolder1_txtFine').val('00.0');
                //}
                //else {
                //    $(".main-div-tbl").hide();
                //    $(this).prop("checked", false);
                //    alertify.alert('Already Fee Deposite this Month.');
                //}
            });

            $('.PrintAll').live('click', function () {
                if ($('.PrintAll').prop("checked") == true) {
                    checkUncheckAllPrint(true);
                } else {
                    checkUncheckAllPrint(false);
                }
            });
            $('.BtnRollBack').live('click', function () {
                var isPaid = $(this).closest('tr').find('td:eq(3)').text().trim();
                ASAID = $(this).closest('tr').find('input[type=hidden]').val();
                if (isPaid == 'Unpaid') {
                    $(this).prop("checked", false);
                    alertify.alert('Fee does not Deposite of this Month.');
                }
                else {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "StdFeeList.aspx/RollBackFee",
                        data: "{'ASAID':'" + ASAID + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == '1') {
                                alertify.success('Rollback Done Sucessfully');
                                $('.showdiscount').click();
                                CallMethod();
                            }
                            else if (data.d == '0') {
                                alertify.error('Some Error Occur.');
                            }
                        }
                    });
                }
                return false;
            });
            $('.PrintPay').live('click', function () {
                var isPaid = $(this).closest('tr').find('td:eq(3)').text().trim();
                ASAID = $(this).closest('tr').find('input[type=hidden]').val();
                if (isPaid == 'Unpaid') {
                    $(this).prop("checked", false);
                    alertify.alert('Fee does not Deposite of this Month.');
                }
                else {
                    window.open("TransDoublePay.aspx?ASAID=" + ASAID + "", '_blank');
                }
                return false;
            });

            $('.PrintPayAmt').live('click', function () {                 
                getMuiltyPrintASAID();
                if (AllPrintASAID != '') {
                    window.open("TransDoublePay.aspx?ASAID=" + AllPrintASAID + "", '_blank');
                } else {
                    alertify.alert('No Paid Month is Selected');
                }
            });
            $('.showdiscount').live('click', function () {
                $(".grid-data-resposive").hide();
                $(".divforstm").show();
                $("#ctl00_ContentPlaceHolder1_Table2").show();
                $("#ctl00_ContentPlaceHolder1_Table1").show();
                $(".FeeDT").show();
                StuRegNo = $(this).closest('tr').find('input[type=hidden]').val();
                $("#ctl00_ContentPlaceHolder1_fdSturegNo").val(StuRegNo);
                Bindstudentregistration(StuRegNo);
                BindTrans(StuRegNo);
                BindPaidTrans(StuRegNo);
                //window.location.href = "PayLastFee.aspx?RID=" + RID + "&FYID=" + $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() + "";
            });
            $("#ctl00_ContentPlaceHolder1_txtPaidDate,#ctl00_ContentPlaceHolder1_txtregistrationdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:2024',
                dateFormat: 'dd MM yy'
            });
            $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').change(function () {
                BindSection();
            });
            $('#ctl00_ContentPlaceHolder1_btnforupdateorsave').click(function (e) {
                e.preventDefault();
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
                else if ((parseFloat($('#ctl00_ContentPlaceHolder1_txtPayableAmt').val()) + parseFloat($('#ctl00_ContentPlaceHolder1_txtFine').val())) != parseFloat($('#ctl00_ContentPlaceHolder1_txtPayAmt').val())) {
                    alertify.error('Pay Amount should equal to Payable Amount,');
                    $('#ctl00_ContentPlaceHolder1_txtPayAmt').focus();
                    return false;
                }
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "StdFeeList.aspx/Deposite",
                    data: "{'FineAmt':'" + $('#ctl00_ContentPlaceHolder1_txtFine').val() +"','PaymentDate':'" + $("#ctl00_ContentPlaceHolder1_txtPaidDate").val() + "','Fyid':'" + Fyid + "','SturegNo':'" + $("#ctl00_ContentPlaceHolder1_fdSturegNo").val() + "','ASAID':'" + $("#ctl00_ContentPlaceHolder1_fdASAID").val() + "','TotalAmount':'" + $("#ctl00_ContentPlaceHolder1_txtPayAmt").val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != '') {
                            window.open("TransDoublePay.aspx?ASAID=" + data.d, '_blank');  
                        }
                        else {
                            alertify.alert('Sorry Error during Fee Depositing .Please try again');
                        }
                        BindTrans(StuRegNo);
                        BindPaidTrans(StuRegNo);
                        $(".main-div-tbl").hide();
                        return false;
                    }
                });
            });
        });
        function BindTransportFees() {
            $(".grid-data-resposive").hide();
            $(".divforstm").show();
            $("#ctl00_ContentPlaceHolder1_Table2").show();
            $("#ctl00_ContentPlaceHolder1_Table1").show();
            $(".FeeDT").show();
            //StuRegNo = $(this).closest('tr').find('input[type=hidden]').val();
            $("#ctl00_ContentPlaceHolder1_fdSturegNo").val(StuRegNo);

            BindTrans(0);
            BindPaidTrans(0);
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        function getMuiltyPayASAID() {
            PayableAmount = 0;
            AllPayASAID = 0;
            var i = 0;
            $(".stm1 tbody tr").each(function () {
                if ($(this).find('.PayAmt').prop("checked") == true) {
                    i = i + 1;
                    var isPaid = $(this).find('td:eq(3)').text().trim();
                   // if (isPaid != '') {
                     //   if (isPaid != 'Paid') {
                            var payAmt = $(this).find('td:eq(2)').text();
                            var asaid = $(this).find('input[type=hidden]').val();

                            PayableAmount = (parseFloat(PayableAmount) + parseFloat(payAmt)).toFixed(2);

                            if (AllPayASAID == '') {
                                AllPayASAID = asaid;
                            } else {
                                AllPayASAID = AllPayASAID + ',' + asaid;
                            }
                       // }
                   // }
                }
                if (i == 0) {
                    $(".main-div-tbl").hide();
                } else {
                    $(".main-div-tbl").show();
                }
            });
        }

        function checkUncheckAllPrint(isChecked) {
            $(".stm1 tbody tr").each(function () {
                var isPaid = $(this).find('td:eq(3)').text().trim();  
                if (isPaid != '') {
                    if (isPaid == 'Paid') {
                        $(this).find('.PrintPay').prop("checked", isChecked);
                    }
                }
            });
        }

        function getMuiltyPrintASAID() {
            AllPrintASAID = '';
            debugger;
            $(".stm1 tbody tr").each(function () {
                if ($(this).find('.PrintPay').prop("checked") == true) {
                    //var isPaid = $(this).find('td:eq(3)').text().trim();                    
                    //if (isPaid != '') {
                    //    if (isPaid == 'Paid') {
                            var asaid = $(this).find('input[type=hidden]').val();
                            if (AllPrintASAID == '') {
                                AllPrintASAID = asaid;
                            } else {
                                AllPrintASAID = AllPrintASAID + ',' + asaid;
                           // }
                       // }
                    }
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
                url: "StdFeeList.aspx/BindGridByJs",
                data: "{'Mode':'5','Fyid':'" + Fyid + "'}",
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

                            StuRegNo = data.d[0].StuRegNo;

                            $("#ctl00_ContentPlaceHolder1_fdSturegNo").val(StuRegNo);

                            trforappend = trforappend + "<tr class=" + trclass + ">" +
                            "<td><input type='hidden' value='" + data.d[i].StuRegNo + "' />" + (i + 1) + "</td>" +
                            "<td>" + data.d[i].Registration_No + " </td>" +
                             "<td>" + data.d[i].AdmissionNo + " </td>" +
                          "<td>" + data.d[i].studentFname + " " + data.d[i].studentMname + " " + data.d[i].studentLname + " </td>" +
                          "<td>" + data.d[i].fatherFname + " " + data.d[i].fatherMname + " " + data.d[i].fatherLname + " </td>" +
                          "<td>" + data.d[i].PrimaryMobileNo + " </td>" +
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

                        $(".grid-data-resposive").hide();
                        $(".divforstm").show();
                        $("#ctl00_ContentPlaceHolder1_Table2").show();
                        $("#ctl00_ContentPlaceHolder1_Table1").show();
                        $(".FeeDT").show();
                        BindTrans(StuRegNo);
                        BindPaidTrans(StuRegNo);
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
        function BindPaidTrans(StuRegNo) {
            $('.stmPaid tr:gt(0)').remove();
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "StdFeeList.aspx/BindTransAmount",
                data: "{'StuRegNo':'" + StuRegNo + "','Mode':'8','Fyid':'" + Fyid + "','PayStatus':'2'}",
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
                            var trStyle = '', tdStyle = '';
                            //if (data.d[i].Status == 'Paid') {
                            //    trStyle = 'style="background-color: red;"'
                            //    tdStyle = 'style="color: white;"'
                            //}
                            trforappend = trforappend + "<tr " + trStyle + ">" +
                                "<td " + tdStyle + "><input type='hidden' value='" + data.d[i].PayAmtId + "' />" + (i + 1) + "</td>" +
                                "<td " + tdStyle + ">" + data.d[i].Month + " </td>" +
                                "<td " + tdStyle + ">" + data.d[i].PaidDate + " </td>" +
                                "<td " + tdStyle + ">" + data.d[i].FeeAmount + " </td>" +
                                "<td " + tdStyle + "><input class='BtnRollBack' type='image' style='width: 20px; border - width: 0px; ' src='../../images/no.png' title='Click Here For Pay Fee Now.'></td>" +
                                "<td " + tdStyle + "><input class='PrintPay' type='image' style='width: 20px; border - width: 0px; ' src='../../images/recipt.png' title='Click Here For Pay Fee Now.'></td>" +
                                "</tr>"
                        }
                        trforappend = trforappend + "<tr class=" + trclass + ">" +
                            "<td><input type='hidden' value='" + data.d[0].ASAID + "' /></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" + 
                            "</tr>"
                        $('.stmPaid').append(trforappend);
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
                url: "StdFeeList.aspx/BindTransAmount",
                data: "{'StuRegNo':'" + StuRegNo + "','Mode':'8','Fyid':'" + Fyid + "','PayStatus':'1'}",
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
                            var trStyle = '', tdStyle='';
                            //if (data.d[i].Status == 'Paid') {
                            //    trStyle = 'style="background-color: red;"'
                            //    tdStyle = 'style="color: white;"'
                            //}
                            trforappend = trforappend + "<tr " + trStyle + ">" +
                                "<td " + tdStyle + "><input type='hidden' value='" + data.d[i].ASAID + "' />" + (i + 1) + "</td>" +
                                "<td " + tdStyle + ">" + data.d[i].Month + " </td>" +
                                "<td " + tdStyle + ">" + data.d[i].FeeAmount + " </td>" +
                                "<td " + tdStyle + "><input type='checkbox' id='vehicle1' name='vehicle1' value='Bike' class='PayAmt' /></td>" +
                                "</tr>"
                        }
                        //trforappend = trforappend + "<tr class=" + trclass + ">" +
                        //    "<td><input type='hidden' value='" + data.d[0].ASAID + "' /></td>" +
                        //    "<td></td>" +
                        //    "<td></td>" +
                        //    "<td>All <input type='checkbox' id='vehicle1' name='vehicle1' value='Bike' class='PrintAll' /><img src='../../images/recipt.png' style='border-width:0px;height:30px;width:40px;border-width:0px;' title='Click here to show detail.' class='PrintPayAmt'></img></td>" +
                        //    "<td></td>" +
                        //    "</tr>"
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
    </script>

</asp:Content>



