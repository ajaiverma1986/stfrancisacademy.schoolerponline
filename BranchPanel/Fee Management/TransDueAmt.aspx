<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="TransDueAmt.aspx.cs" Inherits="BranchPanel_Fee_Management_TransDueAmt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <style type="text/css">
        .conductedlecture234 {
            height: auto;
            margin-bottom: 3px;
        }
    </style>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Overdue Fee List </h2>
                <div class="upload">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
                </div>
                <div class="upload">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="Button1" runat="server" Text="Month Wise Report" Visible="true"
                        CausesValidation="false" Height="20px" PostBackUrl="~/BranchPanel/Fee Management/overdue-fee.aspx" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
                </div>
            </div>
            <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Total Students</dd>
                <div class="clear"></div>
                <span id="lbltotalstudent" style="font-weight: bold;"></span>
            </div>
            <div class="conductedlecture234 secbox" style="border: 1px solid #f5d88c;">
                <dd>Total Overdue Fees</dd>
                <div class="clear"></div>
                <span id="lbloverduefee" style="font-weight: bold;"></span>
            </div>
            <div class="clear"></div>
            <div class="grid-data-resposive">
                <div class="searchbar containerHeadline ">
                    <div class="clear"></div>
                    <asp:DropDownList ID="ddlfinancialyear" runat="server"  Style="height: 31px; width: 100px;">
                    </asp:DropDownList>
                    <input type="text" id="txtname" placeholder="Enter Student Name" style="height: 31px; width: 140px;"/>
                     <asp:DropDownList ID="ddlclass" runat="server" Style="height: 31px; width: 140px;"></asp:DropDownList >
                    <asp:DropDownList ID="ddlSection" runat="server" Style="height: 31px; width: 140px;"></asp:DropDownList >
                    <input type="text" id="txtmobile" placeholder="Enter Mobile Number" style="height: 31px; width: 140px;"/>
                    <input type="text" id="txtduedatefrom" placeholder="Enter Due Date From" readonly="readonly" style="height: 31px; width: 140px;"/>
                    <input type="text" id="txtduedateto" placeholder="Enter Due Date To" readonly="readonly" style="height: 31px; width: 140px;"/>
                    <input id="btnclear" type="image" style="width: 25px; height: 25px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
                    <input type="checkbox" name="vehicle" value="Bike" id="ckAll"/>
                    <input class="Allsendremainder" type="image" style="height:25px;width:25px;border-width:0px; visibility:hidden" alt="No Image" src="../../images/message.png">
                    <div class="clear"></div>
                </div>
                <div class="divTableDataHolder m-l-sm m-r-sm">
                    <div class="divforbindgrid">
                        <table class="stm m-t-sm" style="width: 100%;" cellpadding="0" cellspacing="0">
                            <tr class="stm_head" align="center">
                                <th align="center" scope="col">S.No.</th>
                                <th align="center" scope="col">Admission No</th>
                                <th align="center" scope="col">Name</th>
                                <th align="center" scope="col">Class</th>
                                <th align="center" scope="col">Section</th>
                                <th align="center" scope="col">Payable/Overdue Amount</th>
                                <th align="center" scope="col">Tax</th>
                                <th align="center" scope="col">Total</th>
                                <th align="center" scope="col">Total Due</th>
                                <th align="center" scope="col">Mobile</th>        
                              <%--  <th align="center" scope="col">Select</th>--%>
                         <%--       <th align="center" scope="col">Comment</th>--%>
                            </tr>
                        </table>
                          <table style="width: 100%">
                    <tr>
                        <td  colspan="10">
                           <table border="0" width="100%">
                                <tr>
                                    <td>

                        <div style="margin-left: 0px; float: left; width: 500px;" class="page-number">
                            <asp:Label ID="lblpage" CssClass="lblpage"
                                runat="server"></asp:Label>
                           <span> of</span>
                        <asp:Label ID="lblTotalPages" CssClass="lbltotalpage"
                            runat="server"></asp:Label>
                            <span">Page</span>
                        </div>                        </td>

                  <td>      <div style="margin-left: 0px; float: left; width: 500px;">
                            <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; "
                                alt="" />
                        </div> </td>
                                    </tr> </table>
                        </td>
                    </tr>
                </table>
                    </div>
                </div>
            </div>
            <div id="divforcomment" style="text-align: center; display: none;" class="">
                <div>
                    <table class="showpopuptopic showpopup2" style="background-color: white; vertical-align: top">
                        <tr>
                            <td colspan="2" class="pop-headng-sty">Comment
                            <a id="BtnCancelSend" title="Close this from here"
                                class="btnClose">
                                <img alt="No Image" src="../../images/popupcross.png" /></a>
                            </td>
                        </tr>
                        <tr class="for_sigle_row_form">
                            <td>
                                <label>Comment</label><span style="color: red">*</span>
                                <asp:TextBox ID="txtcomment" TextMode="MultiLine" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="for_sigle_row_form">
                            <td align="center">
                                <asp:Button ID="BtnSend" runat="server" Text="Submit" CssClass="button_save" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="divProgressBar" class="progress"></div>
            <input type="hidden" id="hfpages" />
        </div>
    </div>

    <script type="text/javascript">
        var Fyid = 0, pagesize = 1000, pageno = 1, sectionID = 0, trindexforpay = 0, pagecount = 0, stuname = '', duefromdate = '', duetodate = '', mobileno = '', classid = 0, year = 2050;
        $(document).ready(function () {
            $(".BtnExcel").click(function (e) {
                alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                    if (e) {
                        window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforbindgrid').html()));
                        e.preventDefault();
                    }
                });
                return false;
            });

            $('.ImgBtnForPayNow').live('change', function () {
                trindexforpay = $(this).parent('td').parent('tr').index();
                asaid = $(this).parent('td').parent('tr').find('td:eq(9)').find('input[type="hidden"]').val();
                $('#ctl00_ContentPlaceHolder1_hfforasaid').val(asaid);
                return false;
            });
            $('.Allsendremainder').live('click', function () {
                if ($("#ckAll").is(':checked')) {
                    ckAll = 'checked';
                }
                else {
                    ckAll = '';
                }

                var rows = $('.stm tbody >tr');
                var columns;
                for (var i = 1; i < rows.length; i++) {
                    columns = $(rows[i]).find('td');
                    var j = 10;
                    var ALLSAID = new Array();
                    ALLSAID = $(columns[j]).html().substring(28, 50).split('"');
                    if (columns.find('input[type="checkbox"]').is(':checked')) {
                        SendFeeMsg(ALLSAID[0]);
                    }
                }
                return false;
            });
            $('#ckAll').live('change', function () {
                BindGridAfterSearch();
                return false;
            });

            pagecount = $("#hfpages").val();
            $(".lblpage").html(1);
            $(".lbltotalpage").html(pagecount);
            BindClass();
            FillField();
            pagecount = $("#hfpages").val();
            if (parseInt(pagecount) > 0) {
                $(".lblpage").html(1);
                $(".lbltotalpage").html(pagecount);
            }
            else {
                $(".lblpage").html('0');
                $(".lbltotalpage").html('0');
            }
        
            $("#txtduedatefrom,#txtduedateto").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:' + year,
                dateFormat: 'dd MM yy'
            });
            $('#btnclear').click(function () {
                $('#txtname').val('');
                $('#txtduedatefrom').val('');
                $('#txtduedateto').val('');
                $('#txtmobile').val('');
                $('#ctl00_ContentPlaceHolder1_ddlclass').val('0');
                FillField();
                return false;
            });
            $("#txtname,#txtduedatefrom,#txtduedateto,#txtmobile").on('change keyup paste', function () {
                FillField();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlclass").on('change keyup paste', function () {
                BindSection();
                FillField();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlSection").on('change keyup paste', function () {
                FillField();
                return false;
            });
            $('.btnfirst').live('click', function () {
                pageno = 1;
                $(".lblpage").html(pageno);
                FillField();

                alertify.success('You Are On The First Page.');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                BindClass();
                FillField();
            });
            $('.btnprev').live('click', function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    FillField();

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
                    FillField();

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
                FillField();

                alertify.error('You Are On The Last Page.');
                return false;
            });

            $('.sendremainder,.commentimg').live('click', function () {
                trindexforpay = $(this).parent('td').parent('tr').index();
                asaid = $(this).parent('td').parent('tr').find('td:eq(9)').find('input[type="hidden"]').val();
                $('#ctl00_ContentPlaceHolder1_hfforasaid').val(asaid);
                SendFeeMsg(asaid);
                return false;
            });
        });

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
        function FillField() {
            Fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            stuname = $('#txtname').val();
            duefromdate = $('#txtduedatefrom').val();
            duetodate = $('#txtduedateto').val();
            mobileno = $('#txtmobile').val();
            classid = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
            if ($('#ctl00_ContentPlaceHolder1_ddlSection').val() != null) {
                sectionID = $('#ctl00_ContentPlaceHolder1_ddlSection').val();
            }
            BindGridAfterSearch();
        }
        function BindSection() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overdue-Monthwise.aspx/BindSectionMethod",
                data: "{'ClassID':'" + $("#ctl00_ContentPlaceHolder1_ddlclass").val() + "'}",
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
        function BindClass() {
            Fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overall-admissions.aspx/BindClassMethod",
                data: "{'fyid':'" + Fyid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
                    $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val('0').html('Select Class'));
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val(value.courseID).html(value.courseName));

                    });
                    call_progressbar("end");
                }
            });
        }
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
                    else if (data.d == '2') {
                        alert('Mobile No not foung, Please Update !!!');
                        return false;
                    }
                    else {
                        alert('Msg not Send');
                    } return false;
                }
            });
        }
        function BindGridAfterSearch() {
            call_progressbar("start");
            var lasttr = '', FirstLastTr = '';
            $('.stm').find('tr:gt(0)').remove();
            var trforappend = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overdue-Monthwise.aspx/BindGridOfOverDueList",
                data: "{'SectionID':'" + sectionID + "','Fyid':'" + Fyid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','stuname':'" + stuname + "','duefromdate':'" + duefromdate + "','duetodate':'" + duetodate + "','mobileno':'" + mobileno + "','classid':'" + classid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#hfpages').val(data.d[0].pagecount);
                        pagecount = parseInt(data.d[0].pagecount);
                        $(".lbltotalpage").html(pagecount);
                        $("#lbltotalstudent").text(data.d[0].TotalStudent);
                        $("#lbloverduefee").text(data.d[0].TotalOverDueFee);
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                        var ckAll = '';
                        if ($("#ckAll").is(':checked')) {
                            ckAll = 'checked';
                        }
                        else {
                            ckAll = '';
                        }
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + data.d[i].Rownumber + '</td>' +
                                    '<td>' + data.d[i].AdmissionNo + '</td>' +
                                    '<td><input type="hidden" value="' + data.d[i].Sturegno + '" /><input type="hidden" value="' + data.d[i].Samid + '" /><input type="hidden" value="' + data.d[i].Asaid + '" /><span class="StudentName">' + data.d[i].Name + '</span></td>' +
                                    '<td><span>' + data.d[i].classes + '</span></td>' +
                                    '<td>' + data.d[i].SectionID + '</td>' +
                                    '<td>' + data.d[i].PayableOrDueAmount + '</td>' +
                                    '<td>' + data.d[i].Tax + '</td>' +
                                    '<td>' + data.d[i].TaxWithFee + '</td>' +
                                     '<td>' + data.d[i].TotalDue + '</td>' +
                                    '<td>' + data.d[i].Mobile + '</td></tr>';
                                //'<td><input type="hidden" value="' + data.d[i].Asaid + '" /><input   class="sendremainder"  type="image"  style="height:25px;width:25px;border-width:0px;" alt="No Image" src="../../images/message.png"></td>' +
                                //'<td><input class="ImgBtnForPayNow" type="checkbox" ' + ckAll + ' undefined="" title="Check Here For Pay Fee Now." >' +
                                //'<td><img class="commentimg" src="../../images/comment.png" style="width:25px;cursor:pointer" /></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].Rownumber + '</td>' +
                                    '<td>' + data.d[i].AdmissionNo + '</td>' +
                                    '<td><input type="hidden" value="' + data.d[i].Sturegno + '" /><input type="hidden" value="' + data.d[i].Samid + '" /><input type="hidden" value="' + data.d[i].Asaid + '" /><span class="StudentName">' + data.d[i].Name + '</span></td>' +
                                    '<td><span>' + data.d[i].classes + '</span></td>' +
                                    '<td>' + data.d[i].SectionID + '</td>' +
                                     //'<td>' + data.d[i].DueDate + '</td>' +
                                    '<td>' + data.d[i].PayableOrDueAmount + '</td>' +
                                   '<td>' + data.d[i].Tax + '</td>' +
                                    '<td>' + data.d[i].TaxWithFee + '</td>' +
                                     '<td>' + data.d[i].TotalDue + '</td>' +
                                    '<td>' + data.d[i].Mobile + '</td></tr>';
                            //'<td><input type="hidden" value="' + data.d[i].Asaid + '" /><input   class="sendremainder"  type="image"  style="height:25px;width:25px;border-width:0px;" alt="No Image" src="../../images/message.png"></td>' +
                            //'<td><input class="ImgBtnForPayNow" type="checkbox" ' + ckAll + ' undefined="" title="Check Here For Pay Fee Now.">' +
                            //'<td><img class="commentimg" src="../../images/comment.png" style="width:25px;cursor:pointer" /></td></tr>';
                            $('.stm').append(trforappend);
                        }

                    }
                    else {
                        $(".lblpage").html(0);
                        $(".lbltotalpage").html(0);
                        alertify.error('No Record Found On The Behlaf Of Your Advance Searching.')
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
    </script>
</asp:Content>

