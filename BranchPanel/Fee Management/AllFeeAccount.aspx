<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="AllFeeAccount.aspx.cs" Inherits="BranchPanel_Fee_Management_AllFeeAccount" %>

<%@ Register Src="~/BranchPanel/Fee Management/FeeAccount.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <style type="text/css">
        .conductedlecture234 {
            height: auto;
            margin-bottom: 3px;
        }
    </style>
     <style>
        .conductedlecture235 {
            background: none repeat scroll 0 0 #eeefff;
            border: 1px solid #b4b8ff;
            border-radius: 4px;
            color: #000;
            float: left;
            font-size: 12px;
            line-height: 30px;
            margin-left: 100px;
            padding: 0 15px;
            text-align: left;
            width: auto;
        }

        .conductedlecture236 {
            background: none repeat scroll 0 0 #d4feff;
            border: 1px solid #41e1e6;
            border-radius: 4px;
            color: #000;
            float: left;
            font-size: 12px;
            line-height: 30px;
            margin-left: 100px;
            padding: 0 15px;
            text-align: left;
            width: auto;
        }

        #ctl00_ContentPlaceHolder1_grdAppoinmentLetter td {
            border-color: #c3c0c0!important;
        }

        #ctl00_ContentPlaceHolder1_grdAppoinmentLetter a {
            color: black !important;
        }

        .texthover {
            border: solid 1px red !important;
        }

        .activeofferlist {
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
          

        .user-deatils1 span {
            float: left;
            font-size: 12px;
        }

        .user-deatils1 dt {
            font-size: 12px !important;
        }

        .del-activestatusupdate {
            margin-left: 419px !important;
            margin-top: -60px !important;
        }

            .del-activestatusupdate input {
                margin-right: 5px !important;
                margin-left: 5px !important;
            }

            .del-activestatusupdate label {
                color: #3399FF !important;
                font-size: 15px !important;
            }

        .student-photo_frame1 {
            height: 165px !important;
        }

        .lblMessage {
            color: #FF5217;
            font-style: italic;
            font-size: 20px;
            font-family: sans-serif;
        }

        .t1 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 25px;
            text-align: left !important;
            width: 70px!important;
            border: 1px solid #CCCCCC;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 70px!important;
            border: 1px solid #CCCCCC;
            padding-left: 10px;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 10px;
            text-align: left !important;
            width: 40px!important;
            border: 1px solid #CCCCCC;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 70px!important;
            border: 1px solid #CCCCCC;
            padding-left: 10px;
        }

        .tblHeading {
            border-bottom: 1px solid #ddd !important;
            width: 95%;
            color: #493f3f;
            font-weight: bold;
            font-size: 17px;
            vertical-align: top;
            text-align: left;
            height: 30px;
            padding-bottom: 2px;
            padding-left: 15px;
            padding-top: 4px;
        }

        .showpopup {
            opacity: 1;
            position: fixed;
            left: 4%;
            top: 3%;
            background: none repeat scroll 0 0 #fff;
            border: 15px solid #8CBF26;
            border-radius: 17px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: 600px;
            width: 1200px;
            z-index: 99999999999;
            overflow: scroll;
        }

            .showpopup td {
                vertical-align: top;
                color: #666666;
            }

        .showpopup2 {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 15px solid #CD3B09;
            border-radius: 25px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 40%;
            left: 32%;
            opacity: 1;
            position: fixed;
            top: 15%;
            width: 38%;
            z-index: 2147483647;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
        }

        .trqualification {
            margin-top: 0px;
            height: 30px;
            border: 2px solid #CCCCCC!important;
            text-align: center;
            padding-left: 5px;
        }

        .tdfortrqualification {
            width: 20%;
            border: 1px solid #CCCCCC!important;
        }

        .eductabletxt {
            width: 100%;
            border: none;
            margin-left: 0px;
            text-transform: none!important;
        }
    </style>
    <div class="branch-div-tbl">
         <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Fee Management</a></li>
            <li style="background: none;"><a class="active">Total Overdue Fee</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <asp:HiddenField ID="HiddenField1" runat="server" />
            <div class="tbl-top-heading">
                <h2>Find Account Report </h2>
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
          <%--  <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Daily Fee Transaction</dd>
                <div class="clear"></div>
                <span id="Span1" style="font-weight: bold;"></span>
            </div>
            <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Registration Fee Report</dd>
                <div class="clear"></div>
                <span id="Span2" style="font-weight: bold;"></span>
            </div>
            <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Daiy Expance Report</dd>
                <div class="clear"></div>
                <span id="Span3" style="font-weight: bold;"></span>
            </div>--%>
            <div class="clear"></div>
            <div class="grid-data-resposive">
                <div class="searchbar containerHeadline ">
                    <div class="clear"></div>
                    <asp:DropDownList ID="ddlfinancialyear" runat="server"  Style="height: 31px; width: 100px;">
                    </asp:DropDownList>
                    <input type="text" id="txtname" placeholder="Enter Student Name" style="height: 31px; width: 140px;"/>
                     <asp:DropDownList ID="ddlclass" runat="server" Style="height: 31px; width: 140px;"></asp:DropDownList >
                    <input type="text" id="txtmobile" placeholder="Enter Mobile Number" style="height: 31px; width: 140px;"/>
                    <input type="text" id="txtduedatefrom" placeholder="Enter Due Date From" readonly="readonly" style="height: 31px; width: 140px;"/>
                    <input type="text" id="txtduedateto" placeholder="Enter Due Date To" readonly="readonly" style="height: 31px; width: 140px;"/>
                    <input id="btnclear" type="image" style="width: 25px; height: 25px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
                      <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif"
                                BackColor="#C8F1FB" Height="20px"
                                CssClass="btnExcel" ToolTip="Click here to download Excel sheet" OnClientClick="return false;" />
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
                                <th align="center" scope="col">Due Date</th>
                                <th align="center" scope="col">Payable/Overdue Amount</th>
                                <th align="center" scope="col">Tax</th>
                                <th align="center" scope="col">Total</th>
                                <th align="center" scope="col">Mobile</th>
                                <th align="center" scope="col">Send Reminder</th>
                                <th align="center" scope="col">Comment</th>
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
        var Fyid = 0, pagesize = 100, pageno = 1, pagecount = 0, stuname = '', duefromdate = '', duetodate = '', mobileno = '', classid = 0, year = 2050;
        $(document).ready(function () {
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
        });
        $(".btnExcel").click(function (e) {
            alertify.confirm("Are You Sure To Download The ExcelSheet?", function (e) {
                if (e) {
                    window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforbindgrid').html()));
                    e.preventDefault();
                }
            });
            return false;
        });
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
        $("#txtname,#txtduedatefrom,#txtduedateto,#txtmobile,#ctl00_ContentPlaceHolder1_ddlclass").on('change keyup paste', function () {
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
            alert('Work in progress.');
            return false;
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
            BindGridAfterSearch();
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
        function BindGridAfterSearch() {
            call_progressbar("start");
            var lasttr = '', FirstLastTr = '';
            $('.stm').find('tr:gt(0)').remove();
            var trforappend = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "account-management.aspx/BindGridOfOverDueList",
                data: "{'Fyid':'" + Fyid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','stuname':'" + stuname + "','duefromdate':'" + duefromdate + "','duetodate':'" + duetodate + "','mobileno':'" + mobileno + "','classid':'" + classid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#hfpages').val(data.d[0].pagecount);
                        pagecount = parseInt(data.d[0].pagecount);
                        $("#lbltotalstudent").text(data.d[0].TotalStudent);
                        $("#lbloverduefee").text(data.d[0].TotalOverDueFee);
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + data.d[i].Rownumber + '</td>' +
                                    '<td>' + data.d[i].AdmissionNo + '</td>' +
                                    '<td><input type="hidden" value="' + data.d[i].Sturegno + '" /><input type="hidden" value="' + data.d[i].Samid + '" /><input type="hidden" value="' + data.d[i].Asaid + '" /><span class="StudentName">' + data.d[i].Name + '</span></td>' +
                                    '<td><span>' + data.d[i].classes + '</span></td>' +
                                    '<td>' + data.d[i].DueDate + '</td>' +
                                    '<td>' + data.d[i].PayableOrDueAmount + '</td>' +
                                    '<td>' + data.d[i].Tax + '</td>' +
                                    '<td>' + data.d[i].TaxWithFee + '</td>' +
                                    '<td>' + data.d[i].Mobile + '</td>' +
                                    '<td><input type="hidden" value="' + data.d[i].Sturegno + '" /><input   class="sendremainder"  type="image"  style="height:25px;width:25px;border-width:0px;" alt="No Image" src="../../images/message.png"></td>' +
                                    '<td><img class="commentimg" src="../../images/comment.png" style="width:25px;cursor:pointer" /></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].Rownumber + '</td>' +
                                    '<td>' + data.d[i].AdmissionNo + '</td>' +
                                    '<td><input type="hidden" value="' + data.d[i].Sturegno + '" /><input type="hidden" value="' + data.d[i].Samid + '" /><input type="hidden" value="' + data.d[i].Asaid + '" /><span class="StudentName">' + data.d[i].Name + '</span></td>' +
                                    '<td><span>' + data.d[i].classes + '</span></td>' +
                                    '<td>' + data.d[i].DueDate + '</td>' +
                                    '<td>' + data.d[i].PayableOrDueAmount + '</td>' +
                                   '<td>' + data.d[i].Tax + '</td>' +
                                    '<td>' + data.d[i].TaxWithFee + '</td>' +
                                    '<td>' + data.d[i].Mobile + '</td>' +
                                    '<td><input type="hidden" value="' + data.d[i].Sturegno + '" /><input   class="sendremainder"  type="image"  style="height:25px;width:25px;border-width:0px;" alt="No Image" src="../../images/message.png"></td>' +
                                    '<td><img class="commentimg" src="../../images/comment.png" style="width:25px;cursor:pointer" /></td></tr>';
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

