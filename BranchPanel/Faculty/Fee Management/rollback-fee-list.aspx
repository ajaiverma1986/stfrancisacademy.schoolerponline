<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="rollback-fee-list.aspx.cs" Inherits="BranchPanel_Fee_Management_rollback_fee_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
            <div class="tbl-top-heading"><h2>RollBack Fee List</h2>
                   <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float:right;"
                ToolTip="Click here to download Excel sheet" />  </div>
        </div>
                <div class="clear"></div>
             <div class="grid-data-resposive">
           <div class="searchbar containerHeadline ">
                          <div class="clear"></div>
               <div class="for_sigle_row_form" id="divforsearching" runat="server">
                   <asp:DropDownList ID="ddlfinacialyearforsearching" runat="server" Style="width: 102px;height:32px">
                   </asp:DropDownList>

                                <input type="text" style="width: 160px; " placeholder="Student Name" id="sname" />
                                <input type="text" style="width: 160px; margin-left: 5px;" placeholder="Student Mobile" id="smob" onkeypress="if (WebForm_TextBoxKeyHandler(event) == false) return false;return noAlphabets(event)" />
                                <select style="height: 32px; width: 113px; " id="dllclass"></select>
                                <input type="text" style="width: 160px; " placeholder="From Date" id="txtfromdate" onkeypress="return false"/>
                                <input type="text" style="width: 160px;" placeholder="To Date" id="txttodate" onkeypress="return false"/>
                                <input id="btnclear" type="image" style="width: 25px;height:25px;border-width: 0px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
                                  </div>
                         <div class="clear"></div>
                       </div>
           <div class="divTableDataHolder m-l-sm m-r-sm">
            <div class="divforstm">
                <table class="stm" style="width: 100%; " cellpadding="0" cellspacing="0">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col">S.No.</th>
                          <th align="center" scope="col">Receipt No.</th>
                        <th align="center" scope="col" >RollBack Date</th>
                        <th align="center" scope="col" >Admission No.</th>
                        <th align="center" scope="col" >Name</th>
                        <th align="center" scope="col" >Mobile</th>
                        <th align="center" scope="col" >Class</th>
                        <th align="center" scope="col">Amount</th>
                        <th align="center" scope="col">RollBack By</th>
                        <th align="center" scope="col">System Name</th>
                    </tr>
                </table>
                          </div>

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
                <input type="hidden" id="hfpages" />
                <div id="divProgressBar" class="progress">
                </div>
            <script type="text/javascript">
                var name = "", stmob = "", classid = 0, frdate = "", todate = "", pagesize =100, pageno = 1, pagecount = 1, fyid = 0;
                $(document).ready(function () {
                    pagecount = $("#hfpages").val();
                    $(".lblpage").html(1);
                    $(".lbltotalpage").html(pagecount);
                    var year = 2015;

                    $(".BtnExcel").click(function (e) {
                      
                                    alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                                        if (e) {
                                            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforstm').html()));
                                            e.preventDefault();
                                        }
                                    });
                               
                        return false;
                    });

                    //$('.inputname').live('click', function () {
                    //    var scid = $(this).parent('td').find('input[type=hidden]').val();
                    //    var stuid = $(this).parents('tr').children("td:eq(0)").find('input[type=hidden]').val()
                    //    PageRedirect(scid, stuid)
                    //    window.open($(this).attr('href'));
                    //    return false;
                    //});
                    //$('.inputdue').live('click', function () {
                    //    var scid = $(this).parents('tr').children("td:eq(3)").find('input[type=hidden]').val()
                    //    var stuid = $(this).parents('tr').children("td:eq(0)").find('input[type=hidden]').val()
                    //    PageRedirect(scid, stuid)
                    //});
                    $("#txtfromdate").datepicker({
                        changeMonth: true,
                        changeYear: true,
                        dateFormat: 'dd MM yy'
                    });
                    $("#txttodate").datepicker({
                        changeMonth: true,
                        changeYear: true,
                        dateFormat: 'dd MM yy'
                    });
                    $('.btnfirst').live('click', function () {
                        pageno = 1;
                        $(".lblpage").html(pageno);
                        FillField();
                        BindGrid();
                        alertify.success('You Are On The First Page.');
                        return false;
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
                        alertify.success('You Are On The Last Page.');
                        return false;
                    });
                    $('#sname,#smob,#dllclass,#txtGname,#txtGmob,#txtfromdate,#txttodate').change(function () {
                        FillField();
                        BindGrid();
                        return false;
                    });
                    $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').change(function () {
                        BindClass();
                        FillField();
                        BindGrid();
                    });
                    $('#btnclear').click(function () {
                        $('#sname').val('');
                        $('#dllclass').val('');
                        $('#smob').val('');
                        $('#txtfromdate').val('');
                        $('#txttodate').val('');
                        $('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
                        $("#dllclass").html("");
                        $("#dllclass").append($("<option></option>").val('0').html('-Select Class-'));
                        FillField();
                        BindGrid();
                        return false;
                    });
                    BindClass();
                    //FillField();
                    BindGrid();
                   
                });
                function FillField() {
                    classid = $('#dllclass').val()
                    name = $('#sname').val();
                    stmob = $('#smob').val();
                    frdate = $('#txtfromdate').val();
                    todate = $('#txttodate').val();
                    fyid=$('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').val();
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
                function noAlphabets(event) {
                    var charCode = (event.which) ? event.which : event.keyCode
                    if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                          && (charCode <= 90))
                        return false;

                    return true;
                };
                function BindGrid() {
                    fyid = $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').val();
                    call_progressbar("start");
                    var trforappend = "";
                    $('.stm tr:gt(0)').remove();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "rollback-fee-list.aspx/BindGridByJs",
                        data: "{'name':'" + name + "','stmob':'" + stmob + "','classid':'" + classid + "','frdate':'" + frdate + "','todate':'" + todate + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','fyid':'" + fyid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d.length > 0) {
                                $('#hfpages').val(data.d[0].pagecount)
                                pagecount = parseInt(data.d[0].pagecount);
                                $("#lbltotalstudent").text(data.d[0].TotalStudent)
                                for (var i = 0; i < data.d.length; i++) {
                                    if (i % 2 != 0) {
                                        trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                                 '<td>' + data.d[i].Reciptno + '</td>' +
                                        '<td>' + data.d[i].RollbackDate + '</td>' +
                                        '<td>' + data.d[i].AdmissionNo + '</td>' +
                                        '<td><span>' + data.d[i].Name + '</span></td>' +
                                        '<td>' + data.d[i].MobileNo + '</td>' +
                                        '<td><span>' + data.d[i].Classname + '</span></td>' +
                                        '<td>' + data.d[i].InstallmentAmount + '</td>' +
                                        '<td>' + data.d[i].RollbackedByUserName + '</td>' +
                                        '<td>' + data.d[i].SystemName + '</td></tr>';
                                    }
                                    else {
                                        trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                                 '<td>' + data.d[i].Reciptno + '</td>' +
                                        '<td>' + data.d[i].RollbackDate + '</td>' +
                                        '<td>' + data.d[i].AdmissionNo + '</td>' +
                                        '<td><span>' + data.d[i].Name + '</span></td>' +
                                        '<td>' + data.d[i].MobileNo + '</td>' +
                                        '<td><span>' + data.d[i].Classname + '</span></td>' +
                                        '<td>' + data.d[i].InstallmentAmount + '</td>' +
                                        '<td>' + data.d[i].RollbackedByUserName + '</td>' +
                                        '<td>' + data.d[i].SystemName + '</td></tr>';

                                    }
                                    $('.stm').append(trforappend);
                                    //if (data.d[i].Fullname.length > 30) {
                                    //    var j = i + 1;
                                    //    $('.stm').find('tr:eq(' + j + ')').find('td:eq(4)').find('span').attr("data-tooltip", data.d[i].Fullname);
                                    //}
                                    //if (data.d[i].Fullcourse.length > 10) {
                                    //    var j = i + 1;
                                    //    $('.stm').find('tr:eq(' + j + ')').find('td:eq(6)').find('span').attr("data-tooltip", data.d[i].Fullcourse);
                                    //}
                                    pagecount = parseInt(data.d[i].pagecount);
                                    if (parseInt(pagecount) == 1) {
                                        $(".lbltotalpage").html("1");
                                        $(".lblpage").text("1");
                                    }
                                    else {
                                        $(".lbltotalpage").html(pagecount);
                                        $(".lblpage").text(pageno);
                                    }
                                }
                                call_progressbar("end");
                            }

                            else {
                                alertify.error('No Record Found On The Behlaf Of Your Advance Searching.\n Reset All For Your Convenience.')
                                $('.lblpage').text('0');
                                $('.lbltotalpage').text('0');
                                call_progressbar("end");
                            }
                        },

                        error: function (result) {
                            call_progressbar("end");

                        }
                    });
                }
                function PageRedirect(scid, stuid) {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "RollBackedFeeList.aspx/pageredirect",
                        data: "{'scid':'" + scid + "','stuid':'" + stuid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == 1) {
                                $('.inputname').attr("href", "../studentpanel/feeinfo.aspx")
                            }
                            else {
                                alertify.error('Sorry Redirecting Is Not Possible.');
                            }
                            call_progressbar("end");
                        },
                        error: function (result) {
                            call_progressbar("end");
                            alertify.error('error');
                        },
                    });
                }
                function BindClass() {
                    fyid = $('#ctl00_ContentPlaceHolder1_ddlfinacialyearforsearching').val();
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "rollback-fee-list.aspx/bindclass",
                        data: "{'fyid':'" + fyid + "'}",
                        dataType: "json",
                        success: function (data) {
                            $("#dllclass").html("");
                            $("#dllclass").append($("<option></option>").val('0').html('--Select Class--'));
                            $.each(data.d, function (key, value) {
                                $("#dllclass").append($("<option></option>").val(value.classid).html(value.Classname));
                            });
                            call_progressbar("end");
                        },
                        error: function (result) {
                            call_progressbar("end");
                            alertify.error('Some Network Issue.');
                        },
                    });
                }
            </script>
        </div>
      </div>
</asp:Content>

