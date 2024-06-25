 <%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="overall-admissions.aspx.cs" Inherits="BranchPanel_Fee_Management_overall_admissions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .conductedlecture234 {
            height: auto;
            min-height: 128px;
            margin-bottom: 3px;
        }
    </style>
    <div class="clear"></div>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Overall Admissions </h2>
                <div class="upload">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
                </div>
            </div>
            <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Total Admissions</dd>
                <div class="clear"></div>
                <span id="lblnoofadm" style="font-weight: bold;">0</span>
            </div>
            <div class="conductedlecture234 secbox" style="border: 1px solid #f5d88c;">
                <dd>Total Fees (Excluding Tax) In ₹:</dd>
                <div class="clear"></div>
                <span id="Span2" style="font-weight: bold;"></span>
                <div class="clear"></div>
                <span id="Span9">Fee Fine =</span>
                <span id="Span11">0</span>
                <div class="clear"></div>
                <span id="Span12">Total Fee(Including Fine) =</span>
                <span id="Span13">0</span>                
            </div>
            <div class="conductedlecture234 thirdbox" style="border: 1px solid #41E1E6;">
                <dd>Received Fees (Including TAX) In ₹:</dd>
                <div class="clear"></div>
                <span id="Span5">Actual =</span>
                <span id="Span6" style="font-weight: bold;">0</span>
                <div class="clear"></div>
                <span id="Span3">Tax =</span>
                <span id="Span4" style="font-weight: bold;">0</span>
                <div class="clear"></div>
                <span id="Span7">Total =</span>
                <span id="Span8" style="font-weight: bold;">0</span>
                <div class="clear"></div>
            </div>

            <div class="conductedlecture234 fourthbox" style="border: 1px solid #a2e675;">
                <dd>Balance Fees (Excluding TAX) In ₹:</dd>
                <div class="clear"></div>
                <span id="Span17" style="font-weight: bold;">0.00</span>
                <div class="clear"></div>
                <span id="Span14" style="font-weight: bold;">DisCount</span>
                <span id="Span15" style="font-weight: bold;">0.00</span>
                <div class="clear"></div>
                <span id="Span16" style="font-weight: bold;">Balance = </span>
                <span id="Span10" style="font-weight: bold;">0.00</span>
                
            </div>
            <div class="clear"></div>
            <div class="grid-data-resposive">
                <div class="searchbar containerHeadline for_sigle_row_form">
                    <div class="clear"></div>
                    <input type="text" style="width: 100px;" placeholder="Student Name" id="sname" />
                    <input type="text" style="width: 100px; margin-left: 5px;" placeholder="Parent Mobile" id="parentmob" onkeypress="if (WebForm_TextBoxKeyHandler(event) == false) return false;return noAlphabets(event)" />
                    <input type="text" style="width: 100px; margin-left: 5px;" placeholder="Admission No" id="txtadmissionno" onkeypress="if (WebForm_TextBoxKeyHandler(event) == false) return false;return noAlphabets(event)" />
                    <asp:DropDownList ID="ddlfinancialyear" runat="server" style="height: 31px; width: 100px;">
                    </asp:DropDownList>
                    <select style="height: 31px; width: 150px;" id="dllclass"></select>
                    <asp:DropDownList ID="ddlSection" runat="server" Style="height: 31px; width: 140px;"></asp:DropDownList >
                    <input type="text" style="width: 150px;" placeholder="From Date" id="txtfromdate" onkeypress="return false" />
                    <input type="text" style="width: 150px;" placeholder="To Date" id="txttodate" onkeypress="return false" />
                    <input id="btnclear" type="image" style="width: 25px; height: 25px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
                    <input type="text" style="width: 150px; visibility:hidden" placeholder="Paid From Date" id="txtPaidfromdate" onkeypress="return false" />
                    <input type="text" style="width: 150px; visibility:hidden" placeholder="Paid To Date" id="txtPaidtodate" onkeypress="return false" />
                    
                    <div class="clear"></div>
                </div>
                <div class="divTableDataHolder m-l-sm m-r-sm">
                    <div class="divforstm">
                        <table class="stm" style="width: 100%;" cellpadding="0" cellspacing="0">
                            <tr class="stm_head" align="center">
                                <th align="center" scope="col" style="width: 50px;">S.No.</th>
                                <th align="center" scope="col" style="width: 100px">Date</th>
                                <th align="center" scope="col" style="width: 100px">Admission No</th>
                                <th align="center" scope="col" style="width: 300px">Name</th>
                                <th align="center" scope="col" style="width: 150px">Parent Mobile</th>
                                <th align="center" scope="col" style="width: 80px">Class</th>
                                <th align="center" scope="col" style="width: 80px">Section</th>
                                <th align="center" scope="col" style="width: 100px">Discount</th>
                                <th align="center" scope="col" style="width: 100px">Fee + Fee Fine</th>
                                <th align="center" scope="col" style="width: 100px">Paid</th>
                                <th align="center" scope="col" style="width: 100px">Balance</th>
                                <th align="center" scope="col" style="width: 100px">Tax Paid</th>
                            </tr>
                        </table>
                    </div>
                    <table class="" style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr class="stm_head" align="center">
                            <td align="center" scope="col"></td>
                            <td align="center" scope="col"></td>
                            <td align="center" scope="col"></td>
                            <td align="center" scope="col"></td>
                            <td align="center" scope="col">Total</td>
                            <td align="center" scope="col">
                                <label id="SumOfDiscount"></label>
                            </td>
                            <td align="center" scope="col">
                                <label id="SumOfTotalFee"></label>
                            </td>
                            <td align="center" scope="col">
                                <label id="SumOfPaid"></label>
                            </td>
                            <td align="center" scope="col">
                                <label id="SumOfBalance"></label>
                            </td>
                            <td align="center" scope="col">
                                <label id="SumOfTaxPaid"></label>
                            </td>
                        </tr>
                    </table>
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
            </div>
            <input type="hidden" id="hfpages" />
            <div id="divProgressBar" class="progress">
            </div>
            <script type="text/javascript">
                var year = 2050;
                var pagesize = 100, pageno = 1, sectionID = 0, pagecount = 1, StudentName = '', ParentMobileNo = '', AdmissionNo = '', PaidFromDate = '', PaidToDate = '', FromDate = '', ToDate = '', ClassId = 0, fyid = 0;
                $(document).ready(function () {
                    BindClass();
                    BindGrid();
                    Bindlabels();
                    $('#sname,#parentmob,#txtadmissionno,#ctl00_ContentPlaceHolder1_ddlfinancialyear,#txtfromdate,#txttodate,#txtPaidfromdate,#txtPaidtodate').change(function () {
                        BindGrid();
                        Bindlabels();
                    });
                    $('#dllclass').on('change keyup paste', function () {
                        BindSection();
                        BindGrid();
                        return false;
                    });
                    $('#ctl00_ContentPlaceHolder1_ddlSection').on('change keyup paste', function () {
                        BindGrid();
                        return false;
                    });
                    $("#txtfromdate,#txttodate").datepicker({
                        changeMonth: true,
                        changeYear: true,
                        yearRange: '2000:' + year,
                        dateFormat: 'dd MM yy'
                    });
                    $("#txtPaidfromdate,#txtPaidtodate").datepicker({
                        changeMonth: true,
                        changeYear: true,
                        yearRange: '2000:' + year,
                        dateFormat: 'dd MM yy'
                    });
                    $('#btnclear').click(function () {
                        $('#sname').val('');
                        $('#parentmob').val('');
                        $('#txtadmissionno').val('');
                        $('#txtfromdate').val('');
                        $('#txttodate').val('');
                        $('#txtPaidtodate').val('');
                        $('#txtPaidfromdate').val('');
                        $('#dllclass').val('0');
                        BindGrid();
                        Bindlabels();
                        return false;
                    });
                    $('.btnfirst').live('click', function () {
                        pageno = 1;
                        $(".lblpage").html(pageno);
                        BindGrid();
                        alertify.success('You Are On The First Page.');
                        return false;
                    });
                    $('.btnprev').live('click', function () {
                        if (parseInt(pageno) > 1) {
                            pageno = parseInt(pageno) - 1;
                            $(".lblpage").html(pageno);
                            BindGrid();
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
                            BindGrid();
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
                        BindGrid();
                        alertify.success('You Are On The Last Page.');
                        return false;
                    });
                    $(".BtnExcel").click(function (e) {
                        alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                            if (e) {
                                window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforstm').html()));
                                e.preventDefault();
                            }
                        });
                        return false;
                    });
                });
                function FillField() {
                    StudentName = $('#sname').val();
                    ParentMobileNo = $('#parentmob').val();
                    AdmissionNo = $('#txtadmissionno').val();
                    FromDate = $('#txtfromdate').val();
                    ToDate = $('#txttodate').val();
                    PaidFromDate = $('#txtPaidfromdate').val();
                    PaidToDate = $('#txtPaidtodate').val();
                    ClassId = $('#dllclass').val();
                    if ($('#ctl00_ContentPlaceHolder1_ddlSection').val() != null) {
                        sectionID = $('#ctl00_ContentPlaceHolder1_ddlSection').val();
                    }
                    fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
                }
                function noAlphabets(event) {
                    var charCode = (event.which) ? event.which : event.keyCode
                    if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                          && (charCode <= 90))
                        return false;

                    return true;
                };
                function BindClass() {
                    fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "overall-admissions.aspx/BindClassMethod",
                        data: "{'fyid':'" + fyid + "'}",
                        dataType: "json",
                        async:false,
                        success: function (data) {
                            $("#dllclass").html("");
                            $("#dllclass").append($("<option></option>").val('0').html('Select Class'));
                            $.each(data.d, function (key, value) {
                                $("#dllclass").append($("<option></option>").val(value.courseID).html(value.courseName));

                            });
                            call_progressbar("end");
                        }
                    });
                }
                function BindSection() {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "overdue-fee.aspx/BindSectionMethod",
                        data: "{'ClassID':'" + $("#dllclass").val() + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                            $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val('0').html('Select Section'));
                            $.each(data.d, function (key, value) {
                                $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.courseID).html(value.courseName));

                            });
                            call_progressbar("end");
                        }
                    });
                }
                function call_progressbar(progtype) {
                    if (progtype == "start") {
                        $("#divProgressBar").find("#loader").remove();
                        $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                        $("#divProgressBar").addClass("progressAdd");
                    }
                    if (progtype == "end") {
                        $("#divProgressBar").find("#loader").remove();
                        $("#divProgressBar").removeClass("progressAdd");
                    }
                }
                function Bindlabels() {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "overall-admissions.aspx/Bindlable",
                        data: "{'StudentName':'" + StudentName + "','ParentMobileNo':'" + ParentMobileNo + "','AdmissionNo':'" + AdmissionNo + "','FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','PaidFromDate':'" + PaidFromDate + "','PaidToDate':'" + PaidToDate + "','ClassId':'" + ClassId + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','fyid':'" + fyid + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    $("#lblnoofadm").text(data.d[i].TotalAdmission)
                                    $("#Span2").text(data.d[i].TotalFee)
                                    $("#Span6").text(data.d[i].RecivedFee)
                                    $("#Span4").text(data.d[i].RecivedTax)
                                    $("#Span8").text(data.d[i].TotalRecivedFee)
                                    $("#Span10").text(data.d[i].TotalBalanceFee)
                                    $("#Span11").text(data.d[i].TotalFeeFine)
                                    $("#Span11").text(data.d[i].TotalFeeFine)
                                    $("#Span15").text(data.d[i].TotalDiscount)
                                    $("#Span17").text(parseFloat(data.d[i].TotalDiscount) + parseFloat(data.d[i].TotalBalanceFee))
                                    $("#Span13").text(parseFloat(data.d[i].TotalFee) + parseFloat(data.d[i].TotalFeeFine))
                                    call_progressbar("end");
                                }
                            }
                        }
                    });
                }
                function BindGrid() {
                    FillField();
                    call_progressbar("start");
                    var trforappend = "", trclass = '';
                    $('.stm tr:gt(0)').remove();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "overall-admissions.aspx/BindGridByJs",
                        data: "{'StudentName':'" + StudentName + "','ParentMobileNo':'" + ParentMobileNo + "','AdmissionNo':'" + AdmissionNo + "','FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','PaidFromDate':'" + PaidFromDate + "','PaidToDate':'" + PaidToDate + "','ClassId':'" + ClassId + "','SectionId':'" + sectionID + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','fyid':'" + fyid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                          
                            if (data.d.length > 0) {
                                $('#hfpages').val(data.d[0].pagecount)
                                pagecount = parseInt(data.d[0].pagecount);
                                for (var i = 0; i < data.d.length; i++) {
                                    if (i % 2 != 0) {
                                        trclass = 'stm_dark';
                                    }
                                    else {
                                        trclass = 'stm_light';
                                    }
                                    trforappend = '<tr class="' + trclass + '"><td><input type="hidden" value=' + data.d[i].StuRegNo + '>' + (i + 1) + '</td>' +
                                    '<td>' + data.d[i].AdmissionDate + '</td>' +
                                    '<td>' + data.d[i].AdmissionNo + '</td>' +
                                    '<td>' + data.d[i].Name + '</span></td>' +
                                    '<td>' + data.d[i].MobileNo + '</td>' +
                                    '<td>' + data.d[i].Class + '</td>' +
                                     '<td>' + data.d[i].SectionID + '</td>' +
                                    '<td>' + data.d[i].Discount + '</td>' +
                                    '<td>' + data.d[i].TotalFee + ' + ' + data.d[i].FeeFine + '</td>' +
                                    '<td>' + data.d[i].PaidFee + '</td>' +
                                    '<td>' + data.d[i].BalanceFee + '</td>' +
                                    '<td>' + data.d[i].TaxPaid + '</td>' +
                                    '</tr>';
                                    $('.stm').append(trforappend);
                                    pagecount = parseInt(data.d[i].pagecount);
                                    if (parseInt(pagecount) == 1) {
                                        $(".lbltotalpage").html("1");
                                        $(".lblpage").text("1");
                                    }
                                    else {
                                        $(".lbltotalpage").html(pagecount);
                                        $(".lblpage").text(pageno);
                                    }
                                    $('#SumOfDiscount').text(data.d[0].SumOfDiscount);
                                    $('#SumOfTotalFee').text(data.d[0].SumOfTotalFee + ' + ' + data.d[0].SumOfFeeFine);
                                    $('#SumOfPaid').text(data.d[0].SumOfPaid);
                                    $('#SumOfBalance').text(data.d[0].SumOfBalance);
                                    $('#SumOfTaxPaid').text(data.d[0].SumOfTaxPaid);
                                }
                                $(".lbltotalpage").html(pagecount);
                                call_progressbar("end");
                            }
                            else {
                                alertify.error('No Record Found On The Behlaf Of Your Advance Searching.\n Reset All For Your Convenience.')
                                $('#SumOfDiscount').text('0.00');
                                $('#SumOfTotalFee').text('0.00');
                                $('#SumOfPaid').text('0.00');
                                $('#SumOfBalance').text('0.00');
                                $('#SumOfTaxPaid').text('0.00');
                                $(".lbltotalpage").html(0);
                                $(".lblpage").text(0);
                                call_progressbar("end");
                            }
                        },
                        error: function (result) {
                            call_progressbar("end");
                        }
                    });
                }
            </script>
        </div>
    </div>
</asp:Content>