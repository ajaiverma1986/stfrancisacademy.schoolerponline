<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="cheque-payment.aspx.cs" Inherits="HO_cheque_payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style>
        .showpopup2 {
    background: #ffffff none repeat scroll 0 0;
    border: 1px solid #3cb8ea;
    border-radius: 3px;
    box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
    color: #000000;
    font-family: sans-serif;
    height: auto;
    left: 50%;
    margin-left: -225px;
    opacity: 1;
    position:inherit;
    top: 25%;
    width: 500px;
    z-index: 100;
}
    </style>
    <div class="content_pane_cont input_content  main-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Cheque Payment List</h2>
        </div>
        <div class="searchbar containerHeadline for_sigle_row_form">
                    <div class="clear"></div>
                    <asp:DropDownList ID="ddlfinancialyear" runat="server" Style="height: 31px; width: 123px;">
                    </asp:DropDownList>
            <asp:DropDownList ID="ddlbranch" runat="server" style="height: 31px; width: 130px;"></asp:DropDownList>
                    <input type="text" id="txtname" placeholder="Enter Bank Name" style="width: 140px;"/>
                    <input type="text" id="txtmobile" placeholder="Enter Cheque Number" style="width: 140px;"/>
                    <input type="text" id="txtduedatefrom" placeholder="Enter From Date" readonly="readonly" style="width: 140px;"/>
                    <input type="text" id="txtduedateto" placeholder="Enter To Date" readonly="readonly" style="width: 140px;"/>
                    <input id="btnclear" type="image" style="width: 25px; height: 25px;" src="../images/clearsearch.png" title="Click Here For Reset The Search." />
                    <div class="clear"></div>
                </div>
         <div class="clear"></div>
                <div class="divTableDataHolder">
                    <table width="100%" class="stm stmcheque"  id="GridBatch">
                                    <tr class="stm_head" align="center" id="Grid_Country" runat="server">
                                        <th>S.No.</th>
                                        <th>Student Name</th>
                                        <th>Class</th>
                                        <th>Cheque Amount</th>
                                        <th>Cheque Number</th>
                                        <th>Cheque Date</th>
                                        <th>Status Change Date</th>
                                        <th>Bank Name</th>
                                        <th>Status</th>
                                    </tr>
                    </table>
                    <div id="divProgressBar" class="progress"></div>
                </div>
                <div class="Grid_Country" style="display: none">
                    <label class="no-record-found">There is not any cheque list found.</label>
                </div>
         <div class="clear"></div>
        <div style="margin-left: 0px; float: left; width: 500px;" class="page-number">
                            <asp:Label ID="lblpage" CssClass="lblpage"
                                runat="server"></asp:Label>
                           <span> of</span>
                        <asp:Label ID="lblTotalPages" CssClass="lbltotalpage"
                            runat="server"></asp:Label>
                            <span">Page</span>
                        </div>     
        
        <div style="margin-left: 10px; float: right; width: 500px;">
                            <img src="../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; "
                                alt="" />
                            <img src="../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; "
                                alt="" />
                            <img src="../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; "
                                alt="" />
                            <img src="../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; "
                                alt="" />
                        </div><input type="hidden" id="hfpages" />
    </div>
    <script type="text/javascript">
        var pagesize = 100, pageno = 1, statusid = 0, statustype = "", txtcheckno = "", txtfromdate = "", txttodate = "", fyid = 0, txtbankname = "", year = 2050, classid = 0, pagecount = 0, brid = 0;
        $(document).ready(function () {
            pagecount = $("#hfpages").val();

            $(".lblpage").html(1);
            $('.btnfirst').live('click', function () {
                pageno = 1;
                $(".lblpage").html(pageno);
                FillField();
                BindGrid();
                alertify.success('You Are On The First Page.');
                return false;
            });
            $("#txtduedatefrom,#txtduedateto,#ctl00_ContentPlaceHolder1_TextBox1").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:' + year,
                dateFormat: 'dd MM yy'
            });
            $('.btnprev').live('click', function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    FillField();
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
                    FillField();
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
                FillField();
                BindGrid();
                alertify.error('You Are On The Last Page.');
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlfinancialyear,#ctl00_ContentPlaceHolder1_ddlfinancialyear,#txtname,#txtduedatefrom,#txtduedateto,#txtmobile,#ctl00_ContentPlaceHolder1_ddlbranch").on('change', function () {
                FillField();
                BindGrid();
                return false;
            });
            $('#btnclear').click(function () {
                $('#txtname').val('');
                $('#txtduedatefrom').val('');
                $('#txtduedateto').val('');
                $('#txtmobile').val('');
                $('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
                FillField();
                BindGrid();
                return false;
            });
            $(".btnClose").click(function () {
                $("#divforemail").hide(500);
            });
            $("#Button4").click(function () {
                $("#divforemail").hide(500);
            });
           
           
        });
        
        function BindGrid() {
            brid = $('#ctl00_ContentPlaceHolder1_ddlbranch').val();
            //call_progressbar('start');
            $('.stmcheque tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "cheque-payment.aspx/ChequeDetail",
                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno + "','checkno':'" + txtcheckno + "','fromdate':'" + txtfromdate + "','todate':'" + txttodate + "','fyid':'" + fyid + "','txtbankname':'" + txtbankname + "','classid':'" + classid + "','brid':'" + brid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.Grid_Country').css('display', 'none');
                    if (data.d.length > 0) {
                        $('#hfpages').val(data.d[0].pagecount);
                        $('.lbltotalpage').html(data.d[0].pagecount);
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                    '<td><span>' + data.d[i].Name + '</span></td>' +
                                    '<td><span>' + data.d[i].Classname + '</td>' +
                                    '<td><span >' + data.d[i].ChequeAmount + '</span></td>' +
                                    '<td><span ">' + data.d[i].Chequeno + '</span></td>' +
                                    '<td><span >' + data.d[i].ChequeDate + '</span></td>' +
                                    '<td><span >' + data.d[i].ChequeClearDate + '</span></td>' +
                                    '<td><span >' + data.d[i].BankName + '</span></td>' +
                                    '<td><input type=hidden value=' + data.d[i].SCDID + '>' + data.d[i].ChequeStatus + '</td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                    '<td><span>' + data.d[i].Name + '</span></td>' +
                                    '<td><span>' + data.d[i].Classname + '</td>' +
                                    '<td><span >' + data.d[i].ChequeAmount + '</span></td>' +
                                    '<td><span ">' + data.d[i].Chequeno + '</span></td>' +
                                    '<td><span >' + data.d[i].ChequeDate + '</span></td>' +
                                    '<td><span >' + data.d[i].ChequeClearDate + '</span></td>' +
                                    '<td><span >' + data.d[i].BankName + '</span></td>' +
                                    '<td><input type=hidden value=' + data.d[i].SCDID + '>' + data.d[i].ChequeStatus + '</td></tr>';
                            }
                            $('.stmcheque').append(trforappend);
                            //if (data.d[i].fullname.length > 30) {
                            //    var j = i + 1;
                            //    $('.Chequelist').find('tr:eq(' + j + ')').find('td:eq(1)').find('span').attr("data-tooltip", data.d[i].fullname);
                            //}
                            //if (data.d[i].fullcoursename.length > 10) {
                            //    var j = i + 1;
                            //    $('.Chequelist').find('tr:eq(' + j + ')').find('td:eq(2)').find('span').attr("data-tooltip", data.d[i].fullcoursename);
                            //}
                            //if (data.d[i].fullbankname.length > 10) {
                            //    var j = i + 1;
                            //    $('.Chequelist').find('tr:eq(' + j + ')').find('td:eq(7)').find('span').attr("data-tooltip", data.d[i].fullbankname);
                            //}
                        }
                        //call_progressbar('end')
                    }
                    else {
                        //call_progressbar('end')

                        $('.Grid_Country').css('display', 'inline');
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                    }
                },
                error: function (response) {
                    //call_progressbar('end')
                }
            });
            //call_progressbar('end')
        }

        function FillField() {
            txtfromdate = $('#txtduedatefrom').val();
            txttodate = $('#txtduedateto').val();
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            txtbankname = $('#txtname').val().trim();
            txtcheckno = $('#txtmobile').val();
        }

        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
        FillField();
        BindGrid();
    </script>
</asp:Content>

