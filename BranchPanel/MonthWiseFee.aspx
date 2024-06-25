<%@ Page Title="Fee Collection" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="MonthWiseFee.aspx.cs" Inherits="BranchPanel_MonthWiseFee" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../js/1.4-query.min.js" type="text/javascript"></script>
    <script src="../js/1.8-jquery-ui.min.js" type="text/javascript"></script>
    <link href="../js/1.8-themes-base-jquery-ui.css" rel="stylesheet" type="text/css" />

    <style>
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }
    </style>
    <style type="text/css">
        .active4 {
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
    </style>
    <style>
        .conductedlecture235 {
            font-size: 12px;
            color: #000;
            line-height: 30px;
            text-align: left;
            padding: 0px 15px;
            background: #eeefff;
            width: auto;
            margin-left: 100px;
            border-radius: 4px;
            float: left;
            border: 1px solid #b4b8ff;
        }
    </style>
    <style>
        .conductedlecture236 {
            font-size: 12px;
            color: #000;
            line-height: 30px;
            text-align: left;
            padding: 0px 15px;
            background: #d4feff;
            width: auto;
            margin-left: 100px;
            border-radius: 4px;
            float: left;
            border: 1px solid #41e1e6;
        }

        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 313px;
        }
    </style>

    <script type="text/javascript">
        var brid = 0;
        function pageLoad() {
            brid = '<%= Session["BrBrid"] %>'

            $("#<%=txtnamesearch1.ClientID %>").autocomplete({
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

        };
    </script>

    <script type="text/javascript"> // bind dropdownlist

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_ddlsearchoption").change(function () {

                $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").html("");
                //  $("#ctl00_ContentPlaceHolder1_ddltransport").html("");
                $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").append($("<option></option>").val(0).html("--Select FeeType--"));
                $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").append($("<option></option>").val(1).html("Transportation Fee"));
                $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").append($("<option></option>").val(2).html("Tution Fee"));
                $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").append($("<option></option>").val(3).html("Registration Fee"));
                $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").append($("<option></option>").val(4).html("Admission Fee"));
                $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").append($("<option></option>").val(4).html("Examination Fee"));

            });

            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {

                $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                setTimeout(function () {

                    debugger;
                    var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                    var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                    var feetype = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").text();
                    var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                    var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val();
                    $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                    if (pagesize == "Page Size") {

                        pagesize = 20
                    }

                    $.ajax({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "MonthWiseFee.aspx/filldata",
                        data: "{'monthid':'" + searchitemvalue + "','transTtpe':'" + feetype + "','name':'" + txtname + "'}",
                        dataType: "json",
                        success: function (data) {

                            $.each(data.d, function (key, value) {
                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(parseFloat(value.totalfee).toFixed(2));
                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(parseFloat(value.payfee).toFixed(2));
                                $('#ctl00_ContentPlaceHolder1_lblremain').html(parseFloat(value.balfee).toFixed(2));
                            });
                        }
                    });

                    if (feetype != "--Select FeeType--") {

                        $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                        if (pagesize == "Page Size") {
                            pagesize = 20;
                        }

                        if (parseInt(pagesize) > 0) {

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "MonthWiseFee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feetype + "','name':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {
                                    $.each(data.d, function (key, value) {
                                        $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                    });
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                            $.ajax({

                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "MonthWiseFee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feetype + "','name':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridreport] tr:gt(1)").remove();

                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                            $("[id$=gridreport]").append(row);

                                            $(row).find(".ssno").html(data.d[i].rnumber);
                                            $(row).find(".stname").html(data.d[i].name);
                                            $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                            $(row).find(".stadno").html(data.d[i].adno);
                                            $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            //$(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            //$(row).find(".paidate").html(data.d[i].paiddate);
                                            if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                                $(row).find(".paidfee").css("color", "red");
                                                $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                                $(row).find(".paidate").html("----");
                                            }
                                            else {
                                                $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                                $(row).find(".paidate").html(data.d[i].paiddate);
                                            }
                                            if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                                $(row).find(".balfee").css("color", "Green");
                                            }
                                            $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                            $("[id*=gridreport] tr").show();
                                            $("[id*=gridreport] tr:eq(1)").hide();
                                        }
                                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                    }
                                    else {
                                        $("[id*=gridreport] tr").show();
                                        $("[id*=gridreport] tr:eq(1)").hide();
                                        $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }

                                },
                                error: function (result) {
                                    alert("Error");
                                }

                            });

                        }
                        return false;

                    }

                    //fildetail();

                    if (feetype == "--Select FeeType--") {

                        if (searchitemvalue == 0) {

                            alert("Please Select Month.")
                            return false;
                        }

                        if (parseInt(pagesize) > 0) {

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "MonthWiseFee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feetype + "','name':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {
                                    $.each(data.d, function (key, value) {
                                        $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                    });
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "MonthWiseFee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + 1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feetype + "','name':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridreport] tr:gt(1)").remove();

                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                            $("[id$=gridreport]").append(row);

                                            $(row).find(".ssno").html(data.d[i].rnumber);
                                            $(row).find(".stname").html(data.d[i].name);
                                            $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                            $(row).find(".stadno").html(data.d[i].adno);
                                            $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            //$(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            //$(row).find(".paidate").html(data.d[i].paiddate);
                                            if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                                $(row).find(".paidfee").css("color", "red");
                                                $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                                $(row).find(".paidate").html("----");
                                            }
                                            else {
                                                $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                                $(row).find(".paidate").html(data.d[i].paiddate);
                                            }
                                            if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                                $(row).find(".balfee").css("color", "Green");
                                            }
                                            $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                            $("[id*=gridreport] tr").show();
                                            $("[id*=gridreport] tr:eq(1)").hide();

                                        }
                                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                    }
                                    else {
                                        $("[id*=gridreport] tr").show();
                                        $("[id*=gridreport] tr:eq(1)").hide();
                                        $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>");
                                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                                    }

                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });
                        }
                    }
                }, 600);

                return false;
            });

        });
    </script>

    <script type="text/javascript">  // bind gridview according to PAge size
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_ddlRecordperPage").live('change', function (e) {
                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var feeTyp = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").text();
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val();
                if (pagesize == "Page Size") {
                    pagesize = 20;
                }

                $("#ctl00_ContentPlaceHolder1_PageNo").html("");

                if (feeTyp != "--Select FeeType--") {

                    $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                    if (pagesize == "Page Size") {
                        pagesize = 20;
                    }

                    if (parseInt(pagesize) > 0) {

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "MonthWiseFee.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                            dataType: "json",
                            success: function (data) {
                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });

                        $.ajax({

                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "MonthWiseFee.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridreport] tr:gt(1)").remove();

                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        //  var row = $("[id*=gvdetails] tr").clone(true);

                                        var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                        $("[id$=gridreport]").append(row);

                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".stname").html(data.d[i].name);
                                        $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                        $(row).find(".stadno").html(data.d[i].adno);
                                        $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                        if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                            $(row).find(".paidfee").css("color", "red");
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".paidate").html("----");
                                        }
                                        else {
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".paidate").html(data.d[i].paiddate);
                                        }
                                        if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                            $(row).find(".balfee").css("color", "Green");
                                        }
                                        $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                        $("[id*=gridreport] tr").show();
                                        $("[id*=gridreport] tr:eq(1)").hide();
                                    }
                                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                }
                                else {
                                    $("[id*=gridreport] tr").show();
                                    $("[id*=gridreport] tr:eq(1)").hide();
                                    $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }

                            },
                            error: function (result) {
                                alert("Error");
                            }

                        });

                    }
                    return false;

                }
                    //fildetail();
                else if (feeTyp == "--Select FeeType--") {

                    if (searchitemvalue == 0) {

                        alert("Please Select Month.")
                        return false;
                    }

                    if (parseInt(pagesize) > 0) {

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "MonthWiseFee.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
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

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "MonthWiseFee.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + 1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridreport] tr:gt(1)").remove();

                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        //  var row = $("[id*=gvdetails] tr").clone(true);

                                        var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                        $("[id$=gridreport]").append(row);

                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".stname").html(data.d[i].name);
                                        $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                        $(row).find(".stadno").html(data.d[i].adno);
                                        $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                        if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                            $(row).find(".paidfee").css("color", "red");
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".paidate").html("----");
                                        }
                                        else {
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".paidate").html(data.d[i].paiddate);
                                        }
                                        if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                            $(row).find(".balfee").css("color", "Green");
                                        }
                                        $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                        $("[id*=gridreport] tr").show();
                                        $("[id*=gridreport] tr:eq(1)").hide();
                                    }
                                }
                                else {
                                    $("[id*=gridreport] tr").show();
                                    $("[id*=gridreport] tr:eq(1)").hide();
                                    $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }

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

    <script type="text/javascript">    // Page No
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_PageNo").change(function () {

                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var feeTyp = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").text();
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val();
                if (pagesize == "Page Size") {

                    pagesize = 20
                }

                //  fildetail();

                if (feeTyp != "--Select FeeType--") {

                    if (pagesize == "Page Size") {
                        pagesize = 20;
                    }

                    if (parseInt(pagesize) > 0) {

                        $.ajax({

                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "MonthWiseFee.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridreport] tr:gt(1)").remove();

                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        //  var row = $("[id*=gvdetails] tr").clone(true);

                                        var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                        $("[id$=gridreport]").append(row);

                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".stname").html(data.d[i].name);
                                        $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                        $(row).find(".stadno").html(data.d[i].adno);
                                        $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                        if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                            $(row).find(".paidfee").css("color", "red");
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".paidate").html("----");
                                        }
                                        else {
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".paidate").html(data.d[i].paiddate);
                                        }
                                        if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                            $(row).find(".balfee").css("color", "Green");
                                        }
                                        $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                        $("[id*=gridreport] tr").show();
                                        $("[id*=gridreport] tr:eq(1)").hide();
                                    }
                                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                }
                                else {
                                    $("[id*=gridreport] tr").show();
                                    $("[id*=gridreport] tr:eq(1)").hide();
                                    $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }

                            },
                            error: function (result) {
                                alert("Error");
                            }

                        });

                    }
                    return false;
                }

                if (parseInt(pagesize) > 0) {

                    if (feeTyp == "--Select FeeType--") {

                        if (searchitemvalue == 0) {

                            alert("Please Select Month.")
                            return false;
                        }

                        if (parseInt(pagesize) > 0) {

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "MonthWiseFee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridreport] tr:gt(1)").remove();

                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                            $("[id$=gridreport]").append(row);

                                            $(row).find(".ssno").html(data.d[i].rnumber);
                                            $(row).find(".stname").html(data.d[i].name);
                                            $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                            $(row).find(".stadno").html(data.d[i].adno);
                                            $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                            if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                                $(row).find(".paidfee").css("color", "red");
                                                $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                                $(row).find(".paidate").html("----");
                                            }
                                            else {
                                                $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                                $(row).find(".paidate").html(data.d[i].paiddate);
                                            }
                                            if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                                $(row).find(".balfee").css("color", "Green");
                                            }
                                            $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                            $("[id*=gridreport] tr").show();
                                            $("[id*=gridreport] tr:eq(1)").hide();
                                        }
                                    }
                                    else {
                                        $("[id*=gridreport] tr").show();
                                        $("[id*=gridreport] tr:eq(1)").hide();
                                        $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }

                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });
                        }

                    }
                }
                return false;

            });

        });
    </script>

    <script type="text/javascript">   // go on first page

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_firstpage").click(function () {
                var currentpage = 1;
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();

                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var feeTyp = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").text();
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val();
                $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                if (pagesize = "Page Size") {
                    pagesize = 20;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "MonthWiseFee.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','pageno':'" + 1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gridreport] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                $("[id$=gridreport]").append(row);

                                $(row).find(".ssno").html(data.d[i].rnumber);
                                $(row).find(".stname").html(data.d[i].name);
                                $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                $(row).find(".stadno").html(data.d[i].adno);
                                $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                    $(row).find(".paidfee").css("color", "red");
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".paidate").html("----");
                                }
                                else {
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".paidate").html(data.d[i].paiddate);
                                }
                                if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                    $(row).find(".balfee").css("color", "Green");
                                }
                                $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                $("[id*=gridreport] tr").show();
                                $("[id*=gridreport] tr:eq(1)").hide();
                            }
                        }
                        else {
                            $("[id*=gridreport] tr").show();
                            $("[id*=gridreport] tr:eq(1)").hide();
                            $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
                return false;
            });

        });
    </script>

    <script type="text/javascript">    // go on previous page

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_previous").click(function () {
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();

                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var feeTyp = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").text();
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val();
                if (pagesize = "Page Size") {
                    pagesize = 20;
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
                    url: "MonthWiseFee.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gridreport] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                $("[id$=gridreport]").append(row);

                                $(row).find(".ssno").html(data.d[i].rnumber);
                                $(row).find(".stname").html(data.d[i].name);
                                $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                $(row).find(".stadno").html(data.d[i].adno);
                                $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                    $(row).find(".paidfee").css("color", "red");
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".paidate").html("----");
                                }
                                else {
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".paidate").html(data.d[i].paiddate);
                                }
                                if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                    $(row).find(".balfee").css("color", "Green");
                                }
                                $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                $("[id*=gridreport] tr").show();
                                $("[id*=gridreport] tr:eq(1)").hide();
                            }
                        }
                        else {
                            $("[id*=gridreport] tr").show();
                            $("[id*=gridreport] tr:eq(1)").hide();
                            $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
                return false;

            });
        });
    </script>

    <script type="text/javascript">   // go on next page

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_next").click(function () {

                var max = $('#ctl00_ContentPlaceHolder1_PageNo option:last-child').val();
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var feeTyp = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").text();
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val();
                if (pagesize == "Page Size") {

                    pagesize = 20;

                }

                if (pageno1 == "Page No") {
                    pageno1 = 1;
                    if (max = "1") {
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
                    url: "MonthWiseFee.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gridreport] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                $("[id$=gridreport]").append(row);

                                $(row).find(".ssno").html(data.d[i].rnumber);
                                $(row).find(".stname").html(data.d[i].name);
                                $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                $(row).find(".stadno").html(data.d[i].adno);
                                $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                    $(row).find(".paidfee").css("color", "red");
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".paidate").html("----");
                                }
                                else {
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".paidate").html(data.d[i].paiddate);
                                }
                                if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                    $(row).find(".balfee").css("color", "Green");
                                }
                                $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                $("[id*=gridreport] tr").show();
                                $("[id*=gridreport] tr:eq(1)").hide();
                            }
                        }
                        else {
                            $("[id*=gridreport] tr").show();
                            $("[id*=gridreport] tr:eq(1)").hide();
                            $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
                return false;

            });
        });
    </script>

    <script type="text/javascript">   // go on last page

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_last").click(function () {
                var pagesize = 10;
                var currentpage = $('#ctl00_ContentPlaceHolder1_PageNo option:last-child').val();
                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var feeTyp = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").text();
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val();
                $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                if (pagesize = "Page Size") {
                    pagesize = 20;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "MonthWiseFee.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','pageno':'" + currentpage + "','monthid':'" + searchitemvalue + "','feetype':'" + feeTyp + "','name':'" + txtname + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gridreport] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                $("[id$=gridreport]").append(row);

                                $(row).find(".ssno").html(data.d[i].rnumber);
                                $(row).find(".stname").html(data.d[i].name);
                                $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                $(row).find(".stadno").html(data.d[i].adno);
                                $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                    $(row).find(".paidfee").css("color", "red");
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".paidate").html("----");
                                }
                                else {
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".paidate").html(data.d[i].paiddate);
                                }
                                if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                    $(row).find(".balfee").css("color", "Green");
                                }
                                $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                $("[id*=gridreport] tr").show();
                                $("[id*=gridreport] tr:eq(1)").hide();
                            }
                        }
                        else {
                            $("[id*=gridreport] tr").show();
                            $("[id*=gridreport] tr:eq(1)").hide();
                            $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
                return false;

            });
        });
    </script>

    <script type="text/javascript">   //for button click

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_Button2").click(function () {
                var i = 0;
                $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val('');
                $('#ctl00_ContentPlaceHolder1_ddlsearchoption').find('option:first').attr('selected', 'selected');
                $('#ctl00_ContentPlaceHolder1_ddlEnquirySource').find('option:first').attr('selected', 'selected');

                var pageno2 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pagesize1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch1").val();
                var feetype = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").text();
                $("#ctl00_ContentPlaceHolder1_PageNo").html("");

                if (pagesize1 == "Page Size") {

                    pagesize1 = 20
                }

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "MonthWiseFee.aspx/filldata",
                    data: "{'monthid':'" + searchitemvalue + "','transTtpe':'" + feetype + "','name':'" + txtname + "'}",
                    dataType: "json",
                    success: function (data) {

                        $.each(data.d, function (key, value) {
                            $('#ctl00_ContentPlaceHolder1_lblTotal').html(parseFloat(value.totalfee).toFixed(2));
                            $('#ctl00_ContentPlaceHolder1_lblReceived').html(parseFloat(value.payfee).toFixed(2));
                            $('#ctl00_ContentPlaceHolder1_lblremain').html(parseFloat(value.balfee).toFixed(2));
                        });
                    }
                });

                $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                setTimeout(function () {

                    if (parseInt(pagesize1) > 0) {

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "MonthWiseFee.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize1 + "','pageno':'" + pageno2 + "','monthid':'" + searchitemvalue + "','feetype':'" + feetype + "','name':'" + txtname + "'}",
                            dataType: "json",
                            success: function (data) {
                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });

                        $.ajax({

                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "MonthWiseFee.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize1 + "','pageno':'" + pageno2 + "','monthid':'" + searchitemvalue + "','feetype':'" + feetype + "','name':'" + txtname + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridreport] tr:gt(1)").remove();

                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        //  var row = $("[id*=gvdetails] tr").clone(true);

                                        var row = $("[id*=gridreport] tr:eq(1)").clone(true);

                                        $("[id$=gridreport]").append(row);

                                        $(row).find(".ssno").html(data.d[i].rnumber);
                                        $(row).find(".stname").html(data.d[i].name);
                                        $(row).find(".stapplyclass").html(data.d[i].applyclass);
                                        $(row).find(".stadno").html(data.d[i].adno);
                                        $(row).find(".totfee").html(parseFloat(data.d[i].totalfee).toFixed(2));

                                        if (parseFloat(data.d[i].paidfee).toFixed(2) == 0.00) {

                                            $(row).find(".paidfee").css("color", "red");
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".paidate").html("----");
                                        }
                                        else {
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".paidate").html(data.d[i].paiddate);
                                        }
                                        if (parseFloat(data.d[i].balanfee).toFixed(2) == 0.00) {

                                            $(row).find(".balfee").css("color", "Green");
                                        }
                                        $(row).find(".balfee").html(parseFloat(data.d[i].balanfee).toFixed(2));

                                        $("[id*=gridreport] tr").show();
                                        $("[id*=gridreport] tr:eq(1)").hide();
                                    }
                                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                }
                                else {
                                    $("[id*=gridreport] tr").show();
                                    $("[id*=gridreport] tr:eq(1)").hide();
                                    $("[id*=gridreport] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }

                            },
                            error: function (result) {
                                alert("Error");
                            }

                        });
                    }

                    return false;
                }, 1000);
                return false;
            });
        });
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Fee Managment</a></li>
            <li><a>Fee Report</a></li>
            <li style="background: none;"><a class="active">Fee Collection</a></li>
        </ul>

        <div class="arrowt">
            <a href="Recentfee.aspx">
                <img src="../images/back-button.png"></a>
        </div>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <%-- <div
            class="containerHeadline stripheading">
            Monthly Fee Report
        </div>--%>

        <div id="divstudentadno1" runat="server">
        </div>

        <table cellpadding="2" id="Table4" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">
            <tr>
                <td align="left" style="margin-left: 10px;">
                    <br />
                    <div id="divde" runat="server">
                        <table id="tbllde">
                            <tr>

                                <td valign="top" align="left">
                                    <div class="conductedlecture234 secbox" style="margin-left: 10px;">
                                        <asp:Label runat="server" ID="lbl1" Text="Total" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label9" runat="server" Text="₹" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblTotal" runat="server" Text="0" ForeColor="#B136A4" Font-Bold="true"></asp:Label>
                                    </div>
                                </td>
                                <td valign="top" align="left">
                                    <div class="conductedlecture235 thirdbox" style="margin-left: 10px;">
                                        <asp:Label runat="server" ID="Label6" Text="Received" Font-Bold="true" ForeColor="#824a9e"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label8" runat="server" Text="₹" Font-Bold="true" ForeColor="#824a9e"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblReceived" runat="server" Text="0" ForeColor="#824a9e" Font-Bold="true"></asp:Label>
                                    </div>
                                </td>
                                <td valign="top" align="left">
                                    <div class="conductedlecture236 fourthbox" style="margin-left: 11px; border: 1px solid #15E6B5;">
                                        <asp:Label runat="server" ID="Label2" Text="Balance" Font-Bold="true" ForeColor="#14879e"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label3" runat="server" Text="₹" Font-Bold="true" ForeColor="#14879e"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblremain" runat="server" Text="0" Font-Bold="true" ForeColor="#14879e"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br />
                    </div>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="7" style="width: 100%; padding-left: 0px; padding-right: 0px;">

                    <table width="101%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                        class="stm">
                        <tr>
                            <td colspan="10" class="containerHeadlinenew">
                                <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px"
                                    Font-Size="11px" Style="margin-top: 3.1px;">
                                    <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="20"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="50"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="100"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="200"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="500"></asp:ListItem>
                                </asp:DropDownList>

                                <div style="float: right; width: 650px; margin-top: 3.1px;">
                                    <asp:TextBox ID="txtnamesearch1" placeholder="Search by Name" runat="server" Width="150px"> </asp:TextBox>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                    <asp:DropDownList ID="ddlsearchoption" runat="server" Width="150px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlEnquirySource" runat="server" Width="150px">
                                        <asp:ListItem Value="0" Text="--Select FeeType--" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="1">Transportation Fee</asp:ListItem>
                                        <asp:ListItem Value="2">Tution Fee</asp:ListItem>
                                        <asp:ListItem Value="3">Admission Fee</asp:ListItem>
                                        <asp:ListItem Value="4">Examination Fee</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Button ID="Button1" runat="server" Text="Go" Height="25px" ToolTip="Click here to search items"
                                        CssClass="view-enquiry" />
                                    <asp:Button ID="Button2" runat="server" Text="Reset" Height="25px" ToolTip="Click here to clear all fields"
                                        CssClass="view-enquiry1" />
                                </div>
                            </td>
                        </tr>
                    </table>
                    <asp:GridView runat="server" ID="gridreport" ShowHeader="true"
                        AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="stm">
                        <Columns>
                            <asp:TemplateField HeaderText="S No.">
                                <ItemTemplate>
                                    <asp:Label ID="sno" runat="server" Text='<%# Bind("rnumber") %>' CssClass="ssno"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" Text='<%# Bind("name") %>' CssClass="stname"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="11%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Class">
                                <ItemTemplate>
                                    <asp:Label ID="lblclass" runat="server" Text='<%# Bind("applyclass") %>' CssClass="stapplyclass"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Admission No">
                                <ItemTemplate>
                                    <asp:Label ID="lblstudentname" runat="server" Text='<%# Bind("ADNO") %>' CssClass="stadno"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="11%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Paid Date">
                                <ItemTemplate>
                                    <asp:Label ID="lbpaiddate" runat="server" Text='<%# Bind("paiddate") %>' CssClass="paidate"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="11%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Total Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lblamnt" runat="server" Text='<%# Bind("totalfee","{0:0.00}") %>' ForeColor="#B136A4" CssClass="totfee"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="11%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Paid Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lblamnt" runat="server" Text='<%# Bind("paidfee","{0:0.00}") %>' ForeColor="#824A9E" CssClass="paidfee"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="11%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Balance Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lbldue" runat="server" ForeColor="#14879E" Text='<%# Bind("balanfee","{0:0.00}") %>' CssClass="balfee"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="13%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <AlternatingRowStyle CssClass="stm_light" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="10" class="containerHeadline pagingstrip" style="padding-left: 10px; padding-bottom: 5px;">
                    <asp:DropDownList ID="PageNo" runat="server" Width="88px">
                    </asp:DropDownList>
                    <div style="float: right; width: 144px;">
                        <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px" />
                        <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px" />
                        <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px" />
                        <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>