<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="PayTransportFee.aspx.cs" Inherits="EmployeePanel_PayTransportFee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 <%--   <link href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css" rel="stylesheet"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.9.2/jquery-ui.js"></script>--%>
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
            text-align: left;
        }

        .overflow {
            overflow: auto !important;
            border-radius: 10px;
            border: 3px solid #82403B;
        }
    </style> 
    <script type="text/javascript">
        var myData = {}, asaid = 0, trindexforpay = 0, money = 0;
        $(document).ready(function () {
            $("#ctl00_head_TextBox1").css({ "display": "none" });
            BindAdmissionList(0)
            CallMethod();
            $("#ctl00_head_txtPaidDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            })
            $('.PrintPay').live('click', function () {
                var isPaid = $(this).closest('tr').find('td:eq(3)').text().trim();
                ASAID = $(this).closest('tr').find('input[type=hidden]').val();
                if (isPaid == 'Unpaid') {
                    $(this).prop("checked", false);
                    alertify.alert('Fee does not Deposite of this Month.');
                } else {
                    window.open("TransDoublePay.aspx?ASAID=" + ASAID + "", '_blank');
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
                if ($('#ctl00_head_txtMonth').val() == '0') {
                    alertify.error('Enter Payable Month please.');
                    $('#ctl00_head_txtMonth').focus();
                    return false;
                }
                else if ($('#ctl00_head_txtPayableAmt').val() == '') {
                    alertify.error('Enter Payable Amount please.');
                    $('#ctl00_head_txtPayableAmt').focus();
                    return false;
                }
                else if ($('#ctl00_head_txtPayAmt').val() == '') {
                    alertify.error('Enter Pay Amount please.');
                    $('#ctl00_head_txtPayAmt').focus();
                    return false;
                }
                else if ($('#ctl00_head_txtPaidDate').val() == '') {
                    alertify.error('Enter Payment Date please.');
                    $('#ctl00_head_txtPaidDate').focus();
                    return false;
                }
                else if (parseFloat($('#ctl00_head_txtPayAmt').val()) != parseFloat($('#ctl00_head_txtPayableAmt').val())) {
                    alertify.error('Pay Amount should equal to Payable Amount,');
                    $('#ctl00_head_txtPayAmt').focus();
                    return false;
                }
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
        var result = 0;
        function BindAdmissionList(SAMID) {
            $('#GrdPayNow tr:gt(0)').remove();
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../Service.asmx/BindTransAmount",
                data: "{'Brid':'" + $("#ctl00_head_hdfBrid").val() + "','Fyid':'" + $("#ctl00_head_TextBox1").val() + "','SturegNo':'" + <%=Session["SturegNo"]%> + "'}",
                dataType: "json",
                success: function (data) {
                    $('#GrdPayNow tbody').find('tr:gt(0)').remove();
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    var i = 0, Class = "";
                    TableGeneralDetails.each(function () {
                        var tdStyle = '';
                        var CurrentDeailsRow = $(this);
                        if (i % 2 == 0)
                            Class = "stm_dark";
                        else
                            Class = "stm_light";

                        if (CurrentDeailsRow.find("PayStatus").text() == '2') {
                            trStyle = 'style="background-color: red;"'
                            tdStyle = 'style="color: white; background-color: red;"'
                            CurrentDeailsRow.find("PayStatus").text('Paid');
                        } else {
                            CurrentDeailsRow.find("PayStatus").text('Unpaid');
                        }
                        
                        if (CurrentDeailsRow.find("InstallmentAmount").text() != "0.00") {
                            trforappend = trforappend + '<tr class=' + Class + '>'
                                + '<td ' + tdStyle + '><input type="hidden" value=' + CurrentDeailsRow.find("ASAID").text() + ' />' + (i + 1) + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("MonthN").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("FeeAmount").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("PayStatus").text() + '</td>'
                                + '<td ' + tdStyle + '><input type="checkbox" id="vehicle1" name="vehicle1" value="Bike" class="PrintPay" /></td>'
                                + '<td ' + tdStyle + '><input type="checkbox" id="vehicle1" name="vehicle1" value="Bike" class="PayAmt" /></td>' +                             
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
        $('.PayAmt').live('click', function () {
            if ($(this).closest('tr').find('td:eq(3)').text().trim() == 'Unpaid') {
                $(".main-div-tbl").show();
                ASAID = $(this).closest('tr').find('input[type=hidden]').val();
                getMuiltyPayASAID();
                $("#ctl00_head_fdASAID").val(AllPayASAID);
                $("#ctl00_head_txtPayableAmt").val(PayableAmount);
                $("#ctl00_head_txtPayAmt").val(PayableAmount);
                $('#ctl00_head_txtPaidDate').datepicker({ dateFormat: 'dd-mm-yy' }).datepicker("setDate", new Date());
            }
            else {
                $(".main-div-tbl").hide();
                $(this).prop("checked", false);
                alertify.alert('Already Fee Deposite this Month.');
            }
            $("#ctl00_head_txtPayAmt").attr("readonly", "readonly");
        });
        function getMuiltyPayASAID() {
            PayableAmount = 0;
            AllPayASAID = 0;
            var i = 0;
            $("#GrdPayNow tbody tr").each(function () {
                if ($(this).find('.PayAmt').prop("checked") == true) {
                    i = i + 1;
                    var isPaid = $(this).find('td:eq(3)').text().trim();
                    if (isPaid != '') {
                        if (isPaid != 'Paid') {
                            var payAmt = $(this).find('td:eq(2)').text();
                            var asaid = $(this).find('input[type=hidden]').val();

                            PayableAmount = (parseFloat(PayableAmount) + parseFloat(payAmt)).toFixed(2);

                            if (AllPayASAID == '') {
                                AllPayASAID = asaid;
                            } else {
                                AllPayASAID = AllPayASAID + ',' + asaid;
                            }
                        }
                    }
                }
                if (i == 0) {
                    $(".main-div-tbl").hide();
                } else {
                    $(".main-div-tbl").show();
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
        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="btnforupdateorsave"
            CancelControlID="Button2" BackgroundCssClass="Background">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
            <iframe style="width: 99%; height: 80%;" id="irm1" src="../BranchPanel/StudentManagement/Agreement.aspx" runat="server"></iframe>
            <br />
            <br />
            <input type="checkbox" id="agree" name="agree" value="agree" />
            I have read, understood and accept the above term & Condition.<br />
            <br />
            <asp:Button ID="BtnPayNow" CssClass="button_save" Text="pay" runat="server" OnClientClick="FillFieldForPay(); return false;" Style="height: 28px; background-image: initial; width: auto;" />
            <asp:Button ID="Button2" runat="server" Text="Close" CssClass="button2" />
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
                        Transport Fee Details
                        <asp:TextBox ID="TextBox1" onkeypress="return false" runat="server" placeholder="Select Payment Date" Text="2"></asp:TextBox>&nbsp; 
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
                                                    <tr class="stm_head" align="left">
                                                        <th align="left">S.No.</th>
                                                        <th align="left" scope="col">Month</th>
                                                        <th align="left" scope="col">Amount</th>
                                                        <th align="left" scope="col">Status</th>
                                                        <th align="left" scope="col">Print</th>
                                                        <th align="left" scope="col">Pay</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="clear">
                            <div class="main-div-tbl new-registration" style="margin-top: 10px; display: none; padding: 20px 20px 20px 20px;">
                                <div class="new-registration">
                                    <div class="sub-heading">
                                        Fee Detail                
                                    </div>
                                    <asp:HiddenField ID="hdfBrid" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdfFyid1" runat="server" Value="0" />
                                    <asp:HiddenField ID="fdASAID" runat="server" Value="0" />
                                    <asp:HiddenField ID="fdSturegNo" runat="server" Value="0" />
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
                                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="padding: 0 0 0 0;" />
                                        <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" CssClass="button_save" />
                                        <asp:Button ID="btnforcancel" runat="server" Text="Cancel" CssClass="button_cancel" />
                                    </div>
                                    <br />
                                    <br />
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <asp:HiddenField ID="hfforasaid" runat="server" />
                <asp:HiddenField ID="SelectedASID" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>

