<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-discount-details.aspx.cs" Inherits="BranchPanel_StudentManagement_student_discount_details" %>
<%@ Register Src="~/BranchPanel/StudentManagement/student-admission-list.ascx" TagPrefix="My" TagName="stu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activestudentdiscountdetails {
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
    </style>
    <div class="clear"></div>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
              <div class="tbl-top-heading">
               <h2>Student Discount List</h2>
                    <div class="upload">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
                </div>
            </div>
            <My:stu runat="server" ID="MyUserInfoBoxControl" />
             <div class="grid-data-resposive">
           
            <div class="divforstm">
                <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                    <tr class="stm_head">
                        <th align="center">S.No.</th>
                        <th align="center">Discount Code</th>
                        <th align="center">Class</th>
                        <th align="center">Parent Name</th>
                        <th align="center">Parent Mob No</th>
                        <th align="center">Discount Implemented</th>
                        <th align="center">Comment/Remark</th>
                        <th align="center">Detail</th>
                    </tr>
                </table>
                <div class="clear"></div>
                <div class="divnorecordfound" style="margin-left: 480px; display: none">
                    <label style="font-size: 15px; color: red">Sorry Discount list not found.</label>
                </div>
            </div>



            <div class="DivForDailyStockListDetails" style="display: none">
                <div class="pop-headng-sty">
                    Student Discount Detail
            <a id="A1" title="Close this from here" class="btnClose">
                <img src="../../images/no.png" alt="No Image" class="ImgCloseStockDetails" /></a>
                </div>
                <table style="width: 98%;" class="stm1">
                    <tr class="stm_head">
                        <td>SNo.</td>
                        <td>Fee Category</td>
                        <td>Fee Head</td>
                        <td>Discount Type</td>
                        <td>Discount Month</td>
                        <td>Actual Fee</td>
                        <td>Discount</td>
                        <td>Fee After Discount</td>
                    </tr>
                </table>
                <table class="GridSum" style="width: 100%">
                    <tr class="stm_head">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td style="color: red;">Total Actual Amount:</td>
                        <td>
                            <label id="lblTotalActualAmount"></label>
                        </td>
                        <td style="color: red;">Total Discount Amount:</td>
                        <td>
                            <label id="lblTotalDiscountAmount"></label>
                        </td>
                        <td style="color: red;">Total Fee After Discount:</td>
                        <td>
                            <label id="lblFeeAfterDiscount"></label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script src="../../js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var Fromdate = '',registrationno='',admissionno='', Todate = '', TotalActualAmount = 0, TotalDiscountAmount = 0, TotalFeeAfterDiscount = 0, Discountcode = '', Registrationnumber = '', StudentName = '', Applyingforclass = 0, Parentname = '', checkNo = '', studentid = 0, paymentmode = 0, Fyid = 1, discountcode = '', discountid = 0, ParentMobileNo = '', discountgivenbyuser = 0;
        Bindstudentdiscount();
        $('.showdiscount').live('click', function () {
            discountcode = $(this).parent('td').parent('tr').find('td:eq(1)').text();
            $('.DivForDailyStockListDetails').show(500);
            $('html, body').animate({
                scrollTop: $(".DivForDailyStockListDetails").offset().top
            }, 500);
            Binddiscountdetail();
            return false;
        });
        $('.ImgCloseStockDetails').click(function () { $('.DivForDailyStockListDetails').css("display", "none"); });      
        function Bindstudentdiscount() {
         
            $('.stm tr:gt(0)').remove();
            call_progressbar('start')
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-discount-details.aspx/BindGridByJs",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            trforappend = trforappend + "<tr class=" + trclass + ">" +
                            "<td><input type='hidden' value='" + data.d[i].DSID + "' />" + (i + 1) + "</td>" +
                            "<td>" + data.d[i].DiscountCode + " </td>" +
                            "<td>" + data.d[i].ApplyClass + " </td>" +
                            "<td>" + data.d[i].ParentName + " </td>" +
                            "<td>" + data.d[i].Parentmobile + " </td>" +
                            "<td>" + data.d[i].IsDiscountImplemented + " </td>" +
                            "<td>" + data.d[i].Comment_Remark + " </td>" +
                            "<td><img src='../../images/viewquestion.png' style='border-width:0px;height:15px;width:15px;border-width:0px;' title='Click here to show detail.' class='showdiscount'></img></td>" +
                            "</tr>"
                        }
                        $('.stm').append(trforappend);
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                    }
                    call_progressbar("end");
                }
            });
        }
        function Binddiscountdetail() {
          
            $('.stm1 tr:gt(0)').remove();
            call_progressbar('start')
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../DiscountManagement/discount-list.aspx/BindGridByJsfordiscountdetail",
                data: "{'discountcode':'" + discountcode + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length-1; i++) {
                            trforappend = trforappend + "<tr class=" + trclass + ">" +
                            "<td>" + (i + 1) + "</td>" +
                            "<td>" + data.d[i].FeeCategoryName + " </td>" +
                            "<td>" + data.d[i].FeeHeadName + " </td>" +
                            "<td>" + data.d[i].DiscountTypeName + " </td>" +
                            "<td>" + data.d[i].DiscountInMonthName + " </td>" +
                            "<td>" + data.d[i].ActualFeeBeforeDiscount + " </td>" +
                            "<td>" + data.d[i].Discount1 + " </td>" +
                            "<td>" + data.d[i].FeeAfterDiscount + " </td>" +
                            "</tr>"
                        }
                        $('.stm1').append(trforappend);
                        //for (var i = 0; i < data.d.length; i++) {
                        //    //TotalActualAmount += parseFloat(data.d[i].ActualFeeBeforeDiscount);
                        //    TotalDiscountAmount += parseFloat(data.d[i].Discount1);
                        //    TotalFeeAfterDiscount += parseFloat(data.d[i].FeeAfterDiscount);
                        //    $('#ctl00_ContentPlaceHolder1_lblstudentname').text(data.d[i].studentname);
                        //}
                        TotalActualAmount = parseFloat(data.d[data.d.length - 1].ActualFeeBeforeDiscount);
                        TotalDiscountAmount = parseFloat(data.d[data.d.length - 1].Discount1);
                        TotalFeeAfterDiscount = parseFloat(TotalActualAmount - TotalDiscountAmount);

                        $('#ctl00_ContentPlaceHolder1_lblstudentname').text(data.d[0].studentname);
                        $('#lblTotalActualAmount').text(TotalActualAmount.toFixed(2));
                        $('#lblTotalDiscountAmount').text(TotalDiscountAmount.toFixed(2));
                        $('#lblFeeAfterDiscount').text(TotalFeeAfterDiscount.toFixed(2));
                    }
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
    </script>
</asp:Content>