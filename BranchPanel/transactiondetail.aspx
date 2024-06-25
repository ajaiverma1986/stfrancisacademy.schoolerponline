<%@ Page Title="Transaction Detail" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="transactiondetail.aspx.cs" Inherits="BranchPanel_transactiondetail" EnableEventValidation="false" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/1.4-query.min.js" type="text/javascript"></script>
    <script src="../js/1.8-jquery-ui.min.js"></script>
    <link href="../js/1.8-themes-base-jquery-ui.css" rel="stylesheet" type="text/css" />
    <style>
        .active69 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #15A1BF;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 13px;
            margin-top: 3px;
        }

        .ui-widget-content a {
            color: #222222;
        }
    </style>

    <%--  <script type="text/javascript">
        $(document).ready(function () {

            $('.recept').click(function () {
                alert("aa");
                var mid, rno, sid;
                sid = $(this).closest("td").find("[id*=lblbt2]").text();
                //mid = $(this).closest('tr').find('td:eq(2)').find("input[type='hidden']").val();
                rno = $(this).closest("td").find("[id*=lblDafddte23]").text();

                alert(sid);
                //alert(mid);
                alert(rno);
                $.ajax(
                  {
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "transactiondetail.aspx/getregno",
                      data: "{'mid':'" + mid + "','rno':'" + rno + "'}",
                      dataType: "json",
                      success: function (data) {
                          if (data.d == "0") {
                              alert("Error");
                              return false;

                          }
                          else {
                              window.open("receipt.aspx?sid=" + sid, '_blank');
                              return false;
                          }
                      }
                  });
                return false;

            });

        });
    </script>--%>

    <script type="text/javascript">
        $(document).ready(function () {

            $('.name').click(function () {
                var id;
                id = $(this).closest("td").find("[id*=lblrid]").text();
                window.location.replace("studentpayfee.aspx?adid=" + id);
                return false;
            });

        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {
                $("#ctl00_ContentPlaceHolder1_lblTotal").text("0");
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();
                var txtadmissionvalue = $("#ctl00_ContentPlaceHolder1_txtadmission").val();
                var txtclass = $("#ctl00_ContentPlaceHolder1_txtclass").val();
                var frmdate = $("#ctl00_ContentPlaceHolder1_txtodate").val();
                var todate = $("#ctl00_ContentPlaceHolder1_txtodate1").val();
                var sum = 0, sum1 = 0;
                $("#ctl00_ContentPlaceHolder1_PageNo").html("");

                if (pagesize == "Page Size") {

                    pagesize = 10
                }
                if (txtname == "" && txtadmissionvalue == "" && txtclass == "" && frmdate == "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);
                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue == "" && txtclass == "" && frmdate == "" && todate == "") {
                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                        // alert($("#ctl00_ContentPlaceHolder1_lblTotal").text());

                                    }

                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue != "" && txtclass == "" && frmdate == "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue == "" && txtclass != "" && frmdate == "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        //  alert(sum);
                                        sum1 = parseFloat(sum1) + parseFloat(sum);
                                        //  alert(sum1);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue == "" && txtclass == "" && frmdate != "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue == "" && txtclass == "" && frmdate == "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue == "" && txtclass == "" && frmdate != "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue != "" && txtclass == "" && frmdate == "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue != "" && txtclass != "" && frmdate == "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue != "" && txtclass != "" && frmdate != "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue != "" && txtclass != "" && frmdate == "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue != "" && txtclass != "" && frmdate != "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue != "" && txtclass != "" && frmdate == "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue != "" && txtclass != "" && frmdate != "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue != "" && txtclass != "" && frmdate == "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue != "" && txtclass != "" && frmdate != "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue == "" && txtclass != "" && frmdate != "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue == "" && txtclass != "" && frmdate == "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue == "" && txtclass != "" && frmdate != "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue == "" && txtclass == "" && frmdate != "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue != "" && txtclass == "" && frmdate != "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname == "" && txtadmissionvalue != "" && txtclass == "" && frmdate == "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue != "" && txtclass == "" && frmdate != "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue == "" && txtclass != "" && frmdate != "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue == "" && txtclass != "" && frmdate == "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname == "" && txtadmissionvalue == "" && txtclass != "" && frmdate != "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue == "" && txtclass == "" && frmdate != "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue == "" && txtclass == "" && frmdate == "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (txtname != "" && txtadmissionvalue == "" && txtclass == "" && frmdate != "" && todate != "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

                else if (txtname != "" && txtadmissionvalue == "" && txtclass != "" && frmdate == "" && todate == "") {

                    if (parseInt(pagesize) > 0) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                        $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "transactiondetail.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridtransaction] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                        $("[id$=gridtransaction]").append(row);

                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".class").html(data.d[i].class1);
                                        $(row).find(".adno").html(data.d[i].adno);
                                        $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                        $(row).find(".recept").html(data.d[i].receiptno);
                                        $(row).find(".paymode").html(data.d[i].paymode);
                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".transdate").html(data.d[i].transactiondate);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridtransaction] tr").show();
                                        $("[id*=gridtransaction] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();

                                    $("[id*=gridtransaction] tr:gt(1)").each(function () {

                                        sum = $(this).closest('tr').find('td:eq(4) span:first-child').text();
                                        sum1 = parseFloat(sum1) + parseFloat(sum);

                                    });
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text(sum1);

                                }
                                else {
                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                    $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }
                                $.each(data.d, function (key, value) {

                                });

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }

            });

        });
    </script>

    <script type="text/javascript">

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_ddlRecordperPage").live('change', function (e) {

                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();
                var txtadmissionvalue = $("#ctl00_ContentPlaceHolder1_txtadmission").val();
                var txtclass = $("#ctl00_ContentPlaceHolder1_txtclass").val();
                var frmdate = $("#ctl00_ContentPlaceHolder1_txtodate").val();
                var todate = $("#ctl00_ContentPlaceHolder1_txtodate1").val();

                if (pagesize == "Page Size") {
                    pagesize = 10;
                }
                $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                if (parseInt(pagesize) > 0) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transactiondetail.aspx/bingrid1",
                        data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                        dataType: "json",
                        success: function (data) {

                            $.each(data.d, function (key, value) {
                                $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                            });
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                    $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transactiondetail.aspx/BindDatatable",
                        data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                        dataType: "json",
                        success: function (data) {

                            $("[id*=gridtransaction] tr:gt(1)").remove();
                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                    $("[id$=gridtransaction]").append(row);

                                    $(row).find(".name").html(data.d[i].name);
                                    $(row).find(".class").html(data.d[i].class1);
                                    $(row).find(".adno").html(data.d[i].adno);
                                    $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                    $(row).find(".recept").html(data.d[i].receiptno);
                                    $(row).find(".paymode").html(data.d[i].paymode);
                                    $(row).find(".ssno").html(data.d[i].rnumber);
                                    $(row).find(".transdate").html(data.d[i].transactiondate);

                                    $(row).find(".swet").html(data.d[i].sname);

                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                }
                                $("[id*=gridtransaction] tr").show();
                                $("[id*=gridtransaction] tr:eq(1)").hide();

                            }
                            else {
                                $("[id*=gridtransaction] tr").show();
                                $("[id*=gridtransaction] tr:eq(1)").hide();
                                $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                            }
                            $.each(data.d, function (key, value) {

                            });

                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                }

            });
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_PageNo").change(function () {

                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();
                var txtadmissionvalue = $("#ctl00_ContentPlaceHolder1_txtadmission").val();
                var txtclass = $("#ctl00_ContentPlaceHolder1_txtclass").val();
                var frmdate = $("#ctl00_ContentPlaceHolder1_txtodate").val();
                var todate = $("#ctl00_ContentPlaceHolder1_txtodate1").val();

                if (pagesize == "Page Size") {
                    pagesize = 10;
                }

                $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                if (parseInt(pagesize) > 0) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transactiondetail.aspx/bingrid1",
                        data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",

                        dataType: "json",
                        success: function (data) {

                            $.each(data.d, function (key, value) {
                                $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                            });
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                    $('#ctl00_ContentPlaceHolder1_PageNo').find('option:second').attr('selected', 'selected');

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transactiondetail.aspx/BindDatatable",
                        data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                        dataType: "json",
                        success: function (data) {

                            $("[id*=gridtransaction] tr:gt(1)").remove();
                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                    $("[id$=gridtransaction]").append(row);

                                    $(row).find(".name").html(data.d[i].name);
                                    $(row).find(".class").html(data.d[i].class1);
                                    $(row).find(".adno").html(data.d[i].adno);
                                    $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                    $(row).find(".recept").html(data.d[i].receiptno);
                                    $(row).find(".paymode").html(data.d[i].paymode);
                                    $(row).find(".ssno").html(data.d[i].rnumber);
                                    $(row).find(".transdate").html(data.d[i].transactiondate);

                                    $(row).find(".swet").html(data.d[i].sname);

                                    $("[id*=gridtransaction] tr").show();
                                    $("[id*=gridtransaction] tr:eq(1)").hide();
                                }
                                $("[id*=gridtransaction] tr").show();
                                $("[id*=gridtransaction] tr:eq(1)").hide();

                            }
                            else {
                                $("[id*=gridtransaction] tr").show();
                                $("[id*=gridtransaction] tr:eq(1)").hide();
                                $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                            }
                            $.each(data.d, function (key, value) {

                            });

                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                }

            });
        });
    </script>

    <script type="text/javascript">  //for the firstpage

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_firstpage").click(function () {
                var currentpage = 1;
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();
                var txtadmissionvalue = $("#ctl00_ContentPlaceHolder1_txtadmission").val();
                var txtclass = $("#ctl00_ContentPlaceHolder1_txtclass").val();
                var frmdate = $("#ctl00_ContentPlaceHolder1_txtodate").val();
                var todate = $("#ctl00_ContentPlaceHolder1_txtodate1").val();

                $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                if (pagesize = "Page Size") {
                    pagesize = 10;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "transactiondetail.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gridtransaction] tr:gt(1)").remove();
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                $("[id$=gridtransaction]").append(row);

                                $(row).find(".name").html(data.d[i].name);
                                $(row).find(".class").html(data.d[i].class1);
                                $(row).find(".adno").html(data.d[i].adno);
                                $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                $(row).find(".recept").html(data.d[i].receiptno);
                                $(row).find(".paymode").html(data.d[i].paymode);
                                $(row).find(".ssno").html(data.d[i].rnumber);
                                $(row).find(".transdate").html(data.d[i].transactiondate);

                                $(row).find(".swet").html(data.d[i].sname);

                                $("[id*=gridtransaction] tr").show();
                                $("[id*=gridtransaction] tr:eq(1)").hide();
                            }
                            $("[id*=gridtransaction] tr").show();
                            $("[id*=gridtransaction] tr:eq(1)").hide();

                        }
                        else {
                            $("[id*=gridtransaction] tr").show();
                            $("[id*=gridtransaction] tr:eq(1)").hide();
                            $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }
                        $.each(data.d, function (key, value) {

                        });

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                return false;
            });
        });
    </script>

    <script type="text/javascript">  //go on previeous page

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_previous").click(function () {

                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();
                var txtadmissionvalue = $("#ctl00_ContentPlaceHolder1_txtadmission").val();
                var txtclass = $("#ctl00_ContentPlaceHolder1_txtclass").val();
                var frmdate = $("#ctl00_ContentPlaceHolder1_txtodate").val();
                var todate = $("#ctl00_ContentPlaceHolder1_txtodate1").val();

                if (pagesize = "Page Size") {
                    pagesize = 10;
                }

                if (pageno1 == "Page No") {
                    pageno1 = 1;
                }
                else if (pageno1 == "1") {

                    pageno1 = 1;
                }
                else {
                    pageno1 = parseInt(pageno1) - 1;
                }
                $("#ctl00_ContentPlaceHolder1_PageNo").val(parseInt(pageno1));

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "transactiondetail.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gridtransaction] tr:gt(1)").remove();
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                $("[id$=gridtransaction]").append(row);

                                $(row).find(".name").html(data.d[i].name);
                                $(row).find(".class").html(data.d[i].class1);
                                $(row).find(".adno").html(data.d[i].adno);
                                $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                $(row).find(".recept").html(data.d[i].receiptno);
                                $(row).find(".paymode").html(data.d[i].paymode);
                                $(row).find(".ssno").html(data.d[i].rnumber);
                                $(row).find(".transdate").html(data.d[i].transactiondate);

                                $(row).find(".swet").html(data.d[i].sname);

                                $("[id*=gridtransaction] tr").show();
                                $("[id*=gridtransaction] tr:eq(1)").hide();
                            }
                            $("[id*=gridtransaction] tr").show();
                            $("[id*=gridtransaction] tr:eq(1)").hide();

                        }
                        else {
                            $("[id*=gridtransaction] tr").show();
                            $("[id*=gridtransaction] tr:eq(1)").hide();
                            $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }
                        $.each(data.d, function (key, value) {

                        });

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                return false;

            });
        });
    </script>

    <script type="text/javascript"> //Go on next page
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_next").click(function () {
                //alert("ff");
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var max = $('#ctl00_ContentPlaceHolder1_PageNo option:last-child').val();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();
                var txtadmissionvalue = $("#ctl00_ContentPlaceHolder1_txtadmission").val();
                var txtclass = $("#ctl00_ContentPlaceHolder1_txtclass").val();
                var frmdate = $("#ctl00_ContentPlaceHolder1_txtodate").val();
                var todate = $("#ctl00_ContentPlaceHolder1_txtodate1").val();

                if (pagesize == "Page Size") {

                    pagesize = 10;

                }
                if (max == "Page No")
                    max = 1;

                if (pageno1 == "Page No") {

                    pageno1 = 1;
                    if (max == "1") {
                        pageno1 = 1;

                    }
                    else {
                        pageno1 = 2;
                    }
                }

                else if (parseInt(pageno1) < parseInt(max)) {
                    pageno1 = parseInt(pageno1) + 1;

                }
                else {
                    pageno1 = parseInt(pageno1);
                }

                $("#ctl00_ContentPlaceHolder1_PageNo").val(parseInt(pageno1));

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "transactiondetail.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gridtransaction] tr:gt(1)").remove();
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                $("[id$=gridtransaction]").append(row);

                                $(row).find(".name").html(data.d[i].name);
                                $(row).find(".class").html(data.d[i].class1);
                                $(row).find(".adno").html(data.d[i].adno);
                                $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                $(row).find(".recept").html(data.d[i].receiptno);
                                $(row).find(".paymode").html(data.d[i].paymode);
                                $(row).find(".ssno").html(data.d[i].rnumber);
                                $(row).find(".transdate").html(data.d[i].transactiondate);

                                $(row).find(".swet").html(data.d[i].sname);

                                $("[id*=gridtransaction] tr").show();
                                $("[id*=gridtransaction] tr:eq(1)").hide();
                            }
                            $("[id*=gridtransaction] tr").show();
                            $("[id*=gridtransaction] tr:eq(1)").hide();

                        }
                        else {
                            $("[id*=gridtransaction] tr").show();
                            $("[id*=gridtransaction] tr:eq(1)").hide();
                            $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }
                        $.each(data.d, function (key, value) {

                        });

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                return false;

            });
        });
    </script>
    <script type="text/javascript">//Go on last page
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_last").click(function () {
                var currentpage = $('#ctl00_ContentPlaceHolder1_PageNo option:last-child').val();
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();
                var txtadmissionvalue = $("#ctl00_ContentPlaceHolder1_txtadmission").val();
                var txtclass = $("#ctl00_ContentPlaceHolder1_txtclass").val();
                var frmdate = $("#ctl00_ContentPlaceHolder1_txtodate").val();
                var todate = $("#ctl00_ContentPlaceHolder1_txtodate1").val();

                $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                if (pagesize = "Page Size") {
                    pagesize = 10;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "transactiondetail.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchbyname':'" + txtname + "','searchbyadno':'" + txtadmissionvalue + "','searchbyclass':'" + txtclass + "','searchbyfrmdate':'" + frmdate + "','searchbytodate':'" + todate + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gridtransaction] tr:gt(1)").remove();
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=gridtransaction] tr:eq(1)").clone(true);

                                $("[id$=gridtransaction]").append(row);

                                $(row).find(".name").html(data.d[i].name);
                                $(row).find(".class").html(data.d[i].class1);
                                $(row).find(".adno").html(data.d[i].adno);
                                $(row).find(".paidamount").html(parseFloat(data.d[i].payfee).toFixed(2));
                                $(row).find(".recept").html(data.d[i].receiptno);
                                $(row).find(".paymode").html(data.d[i].paymode);
                                $(row).find(".ssno").html(data.d[i].rnumber);
                                $(row).find(".transdate").html(data.d[i].transactiondate);

                                $(row).find(".swet").html(data.d[i].sname);

                                $("[id*=gridtransaction] tr").show();
                                $("[id*=gridtransaction] tr:eq(1)").hide();
                            }
                            $("[id*=gridtransaction] tr").show();
                            $("[id*=gridtransaction] tr:eq(1)").hide();

                        }
                        else {
                            $("[id*=gridtransaction] tr").show();
                            $("[id*=gridtransaction] tr:eq(1)").hide();
                            $("[id*=gridtransaction] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }
                        $.each(data.d, function (key, value) {

                        });

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                return false;

            });
        });
    </script>

    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtodate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "dd MM yy"
                });
            });

        });
    </script>

    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtodate1").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "dd MM yy"
                });
            });

        });
    </script>

    <script type="text/javascript">
        var brid = 0;
        function pageLoad() {
            brid = '<%= Session["BrBrid"] %>'

             $("#<%=txtnamesearch.ClientID %>").autocomplete({
                 source: function (request, response) {

                     $.ajax({
                         url: '<%=ResolveUrl("~/TimeTable.asmx/getstudentdashboard") %>',
                           data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                           dataType: "json",
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           success: function (data) {
                               if (data.d.length > 0) {
                                   response($.map(data.d, function (item) {
                                       return {
                                           label: item.split('-')[0],
                                           val: item.split('-')[1],
                                           val1: item.split('-')[2]

                                       };
                                   }))
                               }
                               else {
                                   response([{ label: 'No results found.', val: -1 }]);
                               }

                           },
                           error: function (response) {
                               alert(response.responseText);
                           },
                           failure: function (response) {
                               alert(response.responseText);
                           }
                       });
                   },
                   select: function (e, i) {

                   },
                   minLength: 1
               });

               $("#<%=txtadmission.ClientID %>").autocomplete({
                 source: function (request, response) {

                     $.ajax({
                         url: '<%=ResolveUrl("~/TimeTable.asmx/admissionsearch") %>',
                           data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                           dataType: "json",
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           success: function (data) {
                               if (data.d.length > 0) {
                                   response($.map(data.d, function (item) {
                                       return {
                                           label: item.split('-')[0],
                                           val: item.split('-')[1],
                                           val1: item.split('-')[2]

                                       };
                                   }))
                               }
                               else {
                                   response([{ label: 'No results found.', val: -1 }]);
                               }

                           },
                           error: function (response) {
                               alert(response.responseText);
                           },
                           failure: function (response) {
                               alert(response.responseText);
                           }
                       });
                   },
                select: function (e, i) {

                },
                minLength: 1
            });

               $("#<%=txtclass.ClientID %>").autocomplete({
                 source: function (request, response) {

                     $.ajax({
                         url: '<%=ResolveUrl("~/TimeTable.asmx/searchclass") %>',
                           data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                           dataType: "json",
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           success: function (data) {
                               if (data.d.length > 0) {
                                   response($.map(data.d, function (item) {
                                       return {
                                           label: item.split('-')[0],
                                           val: item.split('-')[1],
                                           val1: item.split('-')[2]

                                       };
                                   }))
                               }
                               else {
                                   response([{ label: 'No results found.', val: -1 }]);
                               }

                           },
                           error: function (response) {
                               alert(response.responseText);
                           },
                           failure: function (response) {
                               alert(response.responseText);
                           }
                       });
                   },
                select: function (e, i) {

                    $("#<%=HiddenField1.ClientID %>").val(i.item.val);
                },
                minLength: 1
            });

            };
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="">Fee Management</a></li>
            <li><a href="">Fee Report</a></li>
            <li style="background: none;"><a class="active" href="">Transaction Report</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <td valign="top" align="left">
            <div class="conductedlecture234 secbox" style="margin-left: 10px;">
                <asp:Label runat="server" ID="lbl1" Text="Total Collection" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label9" runat="server" Text="₹" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblTotal" runat="server" Text="0.00" ForeColor="#B136A4" Font-Bold="true"></asp:Label>
            </div>
        </td>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
            class="stm">
            <tr>
                <td colspan="10" class="containerHeadline">
                    <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px"
                        Font-Size="11px">
                        <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text="10"></asp:ListItem>
                        <asp:ListItem Value="2" Text="20"></asp:ListItem>
                        <asp:ListItem Value="3" Text="50"></asp:ListItem>
                        <asp:ListItem Value="4" Text="100"></asp:ListItem>
                        <asp:ListItem Value="5" Text="200"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtodate" runat="server" placeholder="Enter From Date" Width="150px" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtodate1" runat="server" Width="150px" Height="23px" placeholder="Enter To Date"> </asp:TextBox>
                    <div style="float: right; width: 550px;">

                        <asp:TextBox ID="txtclass" runat="server" placeholder="Enter class" Width="150px" Height="23px"> </asp:TextBox>
                        <asp:TextBox ID="txtadmission" runat="server" Width="150px" Height="23px" placeholder="Enter Admission No"> </asp:TextBox>
                        <asp:TextBox ID="txtnamesearch" runat="server" Width="150px" Height="23px" placeholder="Enter Name"> </asp:TextBox>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:Button ID="Button1" runat="server" Text="Go" Height="23px" ToolTip="Click here to search items"
                            CssClass="view-enquiry" />
                    </div>
                </td>
            </tr>
        </table>
        <table cellpadding="2" cellspacing="0" border="0" style="width: 101%; border-left: none !important;">
            <tr>

                <td align="left" colspan="6" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView runat="server" ID="gridtransaction" AutoGenerateColumns="false"
                        Width="100%" CssClass="stm" GridLines="None">
                        <Columns>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>" CssClass="ssno"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lbstu" Text='<%#Eval("name") %>' CommandName="gotop" ForeColor="#41BBEC" Font-Underline="true" ToolTip="Click here to pay fee for this student." Font-Bold="true" CssClass="name"></asp:LinkButton>
                                    <asp:Label ID="lblrid" runat="server" CssClass="ridcss" Text='<%# Bind("adid") %>' Style="display: none;"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Admission No">
                                <ItemTemplate>

                                    <asp:Label ID="lbladno" runat="server" Font-Bold="true" Text='<%#Eval("adno") %>' CssClass="adno"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Class">
                                <ItemTemplate>

                                    <asp:Label ID="lblclass" runat="server" Font-Bold="true" Text='<%#Eval("applyclass") %>' CssClass="class"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Paid Amount (₹)">
                                <ItemTemplate>
                                    <asp:Label ID="lblDate2" runat="server" Text='<%# Bind("payfee","{0:0.00}") %>' CssClass="paidamount"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Receipt No" Visible="false">
                                <ItemTemplate>

                                    <asp:LinkButton ID="lblDafddte23" runat="server" Font-Bold="true" Text='<%#Eval("receiptno") %>' CssClass="recept"></asp:LinkButton>
                                    <asp:Label ID="lblbt2" runat="server" Text='<%# Bind("studentid") %>' CssClass="admo" Style="display: none;"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Payment Mode">
                                <ItemTemplate>

                                    <asp:Label ID="lblpaymode" runat="server" Font-Bold="true" Text='<%#Eval("paymode") %>' CssClass="paymode"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Transaction Date">
                                <ItemTemplate>

                                    <asp:Label ID="lbltransactiondate" runat="server" Font-Bold="true" Text='<%#Eval("transaction_date") %>' CssClass="transdate"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <div id="gg" runat="server">
                    <td colspan="10" class="containerHeadline pagingstrip" style="padding-left: 10px; padding-bottom: 5px;">
                        <asp:DropDownList ID="PageNo" runat="server" Width="85px">
                        </asp:DropDownList>
                        <div style="float: right; width: 153px;">
                            <asp:ImageButton ID="firstpage" runat="server" CssClass="first-click" ImageUrl="~/images/first.gif" Width="25px" />
                            <asp:ImageButton ID="previous" runat="server" CssClass="previous-click" ImageUrl="~/images/previous.gif" Width="25px" />
                            <asp:ImageButton ID="next" runat="server" CssClass="next-click" ImageUrl="~/images/next.gif" Width="25px" />
                            <asp:ImageButton ID="last" runat="server" CssClass="last-click" ImageUrl="~/images/last.gif" Width="25px" />
                        </div>
                    </td>
                </div>
            </tr>
        </table>
    </div>
</asp:Content>