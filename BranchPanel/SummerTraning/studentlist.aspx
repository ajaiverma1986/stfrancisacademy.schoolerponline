<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="studentlist.aspx.cs" Inherits="BranchPanel_SummerTraning_studentlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Summer Camp Student List</h2>
            <div class="upload">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
            </div>
        </div>
        <div class="searchbar containerHeadline for_sigle_row_form">
            <div class="clear"></div>
            <asp:DropDownList ID="ddlfinacialyearforsearching" runat="server" Style="height: 35px; width: 100px;">
            </asp:DropDownList>
            <input type="text" id="txtname" placeholder="Enter Student Name" style="width: 140px;" />
            <select id="ddlclass" style="height: 35px; width: 200px;"></select>
            <input type="text" id="txtparentname" placeholder="Enter Parent Name" style="width: 140px;" />
            <input type="text" id="txtparentmobile" placeholder="Enter Parent Mobile" style="width: 140px;" />
            <input type="text" id="txtActDate" placeholder="Activity Date" onkeypress="return false" style="width: 140px;" />
            
                    
                    <asp:DropDownList ID="ddlFeeType" runat="server" ClientIDMode="Static">
                        <asp:ListItem Value="--Select One--">--Select One--</asp:ListItem>
                        <asp:ListItem Value="Form Selling">Form Selling</asp:ListItem>
                        <asp:ListItem Value="Tc Fee">Tc Fee</asp:ListItem>
                        <asp:ListItem Value="Miscellaneous Fee">Miscellaneous Fee</asp:ListItem>
                        
                    </asp:DropDownList>&nbsp;
                
            <input id="btnclear" type="image" style="width: 25px; height: 25px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
            <div class="clear"></div>
        </div>
        <div class="divforstm">
            <table class="stm showstudent" width="100%">
            <tr class="stm_head" align="center">
                <th>S.No.</th>
                <th>Name</th>
                <th>Class</th>
                <th>Parent Name</th>
                <th>Parent Mobile</th>
                <th>Address</th>
                <th>Fee Paid</th>
                <th>Payment Mode</th>
                <th>Activity Date</th>
                <th>Fee Type</th>
                <th>Edit</th>
                <th>Print</th>
            </tr>
        </table>
        </div>
        
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
    <script type="text/javascript">
        var sscid = 0, studentname = '', classid = 0, parentname = '', parentmobile = '';
        $(document).ready(function () {
            $("#txtActDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                yearRange: '1970:2025' 
            });
            BindClass();
            BindListofPeriod();
            $("#txtActDate").on('change keyup paste', function () {
                FillField();
                BindListofPeriod();
                return false;
            });
            $("#ddlFeeType").on('change', function () {                
                BindListofPeriod();
                return false;
            });
            $('.editimage').live('click', function () {
                sscid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                window.location.replace("addstudent.aspx?id=" + sscid);
                return false;
            });
            $(".lblpage").html(1);
            $('.btnfirst').live('click', function () {
                pageno = 1;
                $(".lblpage").html(pageno);
                FillField();
                BindListofPeriod();
                alertify.success('You Are On The First Page.');
                return false;
            });
            $('.btnprev').live('click', function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    FillField();
                    BindListofPeriod();
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
                    BindListofPeriod();
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
                BindListofPeriod();
                alertify.error('You Are On The Last Page.');
                return false;
            });

            $('#btnclear').click(function () {
                $('#txtname').val('');
                $('#txtparentname').val('');
                $('#txtparentmobile').val('');
                $('#txtActDate').val('');
                $('#ddlclass').val('0');
                $('#ddlFeeType').val("--Select One--");
                FillField();
                BindListofPeriod();
                return false;
            });

            $('.ImgGenerateRecipt').live('click', function () {
                var registrationNo = $(this).parent('td').parent('tr').find('input[type="hidden"]').val();
                var win = window.open("../Fee Management/SummerTaining_History.aspx?REG=" + registrationNo, '_blank');
                win.focus();
                return false;
                alert(1);
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
        function BindListofPeriod() {
            $('.showstudent tr:gt(0)').remove();
           // alert($('#ddlFeeType').val());
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "studentlist.aspx/StudentList",
                data: "{'fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').val() + "','studentname':'" + studentname + "','classid':'" + classid + "','parentname':'" + parentname + "','parentmobile':'" + parentmobile + "','actDate':'" + actDate + "','payType':'" + $('#ddlFeeType').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td><input type=hidden value="' + data.d[i].Sscid + '" />' + (i + 1) + '</td>' +
                                    '<td>' + data.d[i].Name + '</td>' +
                                    '<td>' + data.d[i].Classname + '</td>' +
                                    '<td>' + data.d[i].ParentName + '</td>' +
                                    '<td>' + data.d[i].ParentMobile + '</td>' +
                                    '<td>' + data.d[i].Address + '</td>' +
                                    '<td>' + data.d[i].PaidFee + '</td>' +
                                    '<td>' + data.d[i].PaymentMode + '</td>' +
                                    '<td>' + data.d[i].ActivityDate + '</td>' +
                                    '<td>' + data.d[i].FeeType + '</td>' +
                                    '<td><input class=editimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/edit.png /></td>' +
                                    '<td><input class="ImgGenerateRecipt" type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/recipt.png /></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_ligth"><td><input type=hidden value="' + data.d[i].Sscid + '" />' + (i + 1) + '</td>' +
                                    '<td>' + data.d[i].Name + '</td>' +
                                    '<td>' + data.d[i].Classname + '</td>' +
                                    '<td>' + data.d[i].ParentName + '</td>' +
                                    '<td>' + data.d[i].ParentMobile + '</td>' +
                                    '<td>' + data.d[i].Address + '</td>' +
                                    '<td>' + data.d[i].PaidFee + '</td>' +
                                    '<td>' + data.d[i].PaymentMode + '</td>' +
                                     '<td>' + data.d[i].ActivityDate + '</td>' +
                                     '<td>' + data.d[i].FeeType + '</td>' +
                                    '<td><input class=editimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/edit.png /></td>' +
                                    '<td><input class="ImgGenerateRecipt" type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/recipt.png /></td></tr>';
                            }
                            $('.showstudent').append(trforappend);

                        }
                        //call_progressbar("end");
                    }
                    else {
                        //call_progressbar("end");
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                        alertify.error('No Record Found');
                    }
                },
                error: function (result) {
                    // call_progressbar("end");
                    alertify.error('Some Error occured during Binding Student.');
                }
            });
        }

        function BindClass() {
            //call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../Fee Management/overall-admissions.aspx/BindClassMethod",
                data: "{'fyid':'" + $("#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching").val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlclass").html("");
                    $("#ddlclass").append($("<option></option>").val('0').html('Select Class'));
                    $.each(data.d, function (key, value) {
                        $("#ddlclass").append($("<option></option>").val(value.courseID).html(value.courseName));
                    });
                    //call_progressbar("end");
                }
            });
        }
        var actDate = '';
        function FillField() {
            studentname = $('#txtname').val();
            classid = $('#ddlclass').val();
            parentname = $('#txtparentname').val();
            parentmobile = $('#txtparentmobile').val();
            actDate = $('#txtActDate').val();
        }
    </script>
</asp:Content>

