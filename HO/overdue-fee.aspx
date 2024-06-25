﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="overdue-fee.aspx.cs" Inherits="HO_overdue_fee" %>

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
                <div class="searchbar containerHeadline for_sigle_row_form">
                    <div class="clear"></div>
                    <asp:DropDownList ID="ddlfinancialyear" runat="server" Style="height: 31px; width: 100px;">
                    </asp:DropDownList>
                     <asp:DropDownList ID="ddlbranch" runat="server" style="height: 31px; width: 130px;"></asp:DropDownList>
                    <input type="text" id="txtname" placeholder="Enter Student Name" style="width: 140px;"/>
                     <asp:DropDownList ID="ddlclass" runat="server" Style="height: 31px; width: 140px;"></asp:DropDownList >
                    <input type="text" id="txtmobile" placeholder="Enter Mobile Number" style="width: 140px;"/>
                    <input type="text" id="txtduedatefrom" placeholder="Enter Due Date From" readonly="readonly" style="width: 140px;"/>
                    <input type="text" id="txtduedateto" placeholder="Enter Due Date To" readonly="readonly" style="width: 140px;"/>
                    <input id="btnclear" type="image" style="width: 25px; height: 25px;" src="../images/clearsearch.png" title="Click Here For Reset The Search." />
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
                                <th align="center" scope="col">Total Due</th>
                                <th align="center" scope="col">Mobile</th>
                                
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
                            <img src="../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; "
                                alt="" />
                            <img src="../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; "
                                alt="" />
                            <img src="../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; "
                                alt="" />
                            <img src="../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; "
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
        var Fyid = 0, pagesize = 100, pageno = 1, pagecount = 0, stuname = '', duefromdate = '', duetodate = '', mobileno = '', classid = 0, year = 2050, brid = 0;
        $(document).ready(function () {
            pagecount = $("#hfpages").val();
            $(".lblpage").html(1);
            $(".lbltotalpage").html(pagecount);
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
            $('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
            $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
            $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val('0').html('-Select Class-'));
            FillField();
            return false;
        });
        $("#txtname,#txtduedatefrom,#txtduedateto,#txtmobile,#ctl00_ContentPlaceHolder1_ddlclass").on('change paste', function () {
            FillField();
            return false;
        });
        $("#ctl00_ContentPlaceHolder1_ddlbranch").change(function () {
            BindClass();
            FillField();
        });
        $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
            $('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
            $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
            $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val('0').html('-Select Class-'));
            FillField();
        });
        $('.btnfirst').live('click', function () {
            pageno = 1;
            $(".lblpage").html(pageno);
            FillField();

            alertify.success('You Are On The First Page.');
            return false;
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
            brid = $('#ctl00_ContentPlaceHolder1_ddlbranch').val();
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overall-admissions.aspx/BindClassDDL",
                data: "{'brid':'" + brid + "','fyid':'" + fyid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
                    $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val('0').html('-Select Class-'));
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val(value.ID).html(value.ClassName));
                    });
                    call_progressbar("end");
                },
                error: function () {
                    alertify.error("Some Error");
                }
            });
        }
        function BindGridAfterSearch() {
            brid = $('#ctl00_ContentPlaceHolder1_ddlbranch').val();;
            call_progressbar("start");
            var lasttr = '', FirstLastTr = '';
            $('.stm').find('tr:gt(0)').remove();
            var trforappend = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overdue-fee.aspx/BindGridOfOverDueList",
                data: "{'Fyid':'" + Fyid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','stuname':'" + stuname + "','duefromdate':'" + duefromdate + "','duetodate':'" + duetodate + "','mobileno':'" + mobileno + "','classid':'" + classid + "','brid':'" + brid + "'}",
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
                                    '<td>' + data.d[i].TotalDue + '</td>' +
                                    '<td>' + data.d[i].Mobile + '</td></tr>'
                                   
                            else
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].Rownumber + '</td>' +
                                    '<td>' + data.d[i].AdmissionNo + '</td>' +
                                    '<td><input type="hidden" value="' + data.d[i].Sturegno + '" /><input type="hidden" value="' + data.d[i].Samid + '" /><input type="hidden" value="' + data.d[i].Asaid + '" /><span class="StudentName">' + data.d[i].Name + '</span></td>' +
                                    '<td><span>' + data.d[i].classes + '</span></td>' +
                                    '<td>' + data.d[i].DueDate + '</td>' +
                                    '<td>' + data.d[i].PayableOrDueAmount + '</td>' +
                                   '<td>' + data.d[i].Tax + '</td>' +
                                    '<td>' + data.d[i].TaxWithFee + '</td>' +
                                    '<td>' + data.d[i].TotalDue + '</td>' +
                                    '<td>' + data.d[i].Mobile + '</td></tr>'
                                   
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

