<%@ Page Title="Student Fee Collection" Language="C#" AutoEventWireup="true" CodeFile="Recentfee.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_Recentfee" EnableEventValidation="false" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/1.4-query.min.js" type="text/javascript"></script>
    <script src="../js/1.8-jquery-ui.min.js"></script>
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
        .active0 {
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

        .ui-menu .ui-menu-item a {
            display: block;
            line-height: 1.5;
            padding: 0.2em 0.4em;
            text-decoration: none;
        }

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

        .conductedlecture2556 {
            background: none repeat scroll 0 0 #15A1BF;
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

        .ui-widget-content a {
            color: #222222;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Fee Managment</a></li>
            <li><a>Fee Report</a></li>

            <li style="background: none;"><a class="active">Student Fee Collection</a></li>
            <div class="arrowt">
                <a href="Recentfee.aspx">
                    <img src="../images/back-button.png" /></a>
            </div>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div id="divstudentadno1" runat="server">
        </div>

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

            $("#<%=txtadno.ClientID %>").autocomplete({
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

            $("#<%=TextBox1.ClientID %>").autocomplete({
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

                //$('.name').click(function () {
                //    var id;

                //    id = $(this).closest("td").find("[id*=lblrid]").text();

                //    window.location.replace("studentfees.aspx?sturegno=" + id);

                //    return false;

                //});

                $('#ctl00_ContentPlaceHolder1_Button1').click(function () {

                    var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                    var ddltransportsearch = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                    var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                    var pagesizevalue1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                    var txtclassearch = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                    var txtadmissionno = $("#ctl00_ContentPlaceHolder1_txtadno").val();
                    var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                    if (ddltransportsearch == 0) {
                        $("#ctl00_ContentPlaceHolder1_Label1").text("Overall Collection");
                        $("#ctl00_ContentPlaceHolder1_Label4").text('');
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_Label1").text("Overall Collection of");
                        $("#ctl00_ContentPlaceHolder1_Label4").text($('#ctl00_ContentPlaceHolder1_ddlEnquirySource :selected').text());
                    }

                    $("#ctl00_ContentPlaceHolder1_PageNo").html("");

                    if (pagesize == "Page Size") {

                        pagesize = 20
                    }
                    if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {

                        ddltransportsearch = "--Select FeeType--";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");

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

                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {

                        ddltransportsearch = "Transportation Fee"

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));

                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {

                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);

                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        debugger;
                        ddltransportsearch = "--Select FeeType--"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);

                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee"

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {

                        ddltransportsearch = "--Select FeeType--";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {

                        ddltransportsearch = "Transportation Fee"

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));

                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {

                        ddltransportsearch = "--Select FeeType--";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {

                        ddltransportsearch = "Transportation Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {

                        ddltransportsearch = "Tution Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {

                        ddltransportsearch = "Examination Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {

                        ddltransportsearch = "Admission Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {

                        ddltransportsearch = "Development Charges";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {

                        ddltransportsearch = "--Select FeeType--";

                        debugger;
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {

                        ddltransportsearch = "Transportation Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {

                        ddltransportsearch = "Tution Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {

                        ddltransportsearch = "Examination Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {

                        ddltransportsearch = "Admission Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {

                        ddltransportsearch = "Development Charges";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {

                        ddltransportsearch = "--Select FeeType--";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {

                        ddltransportsearch = "Transportation Fee"

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));

                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges"
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {

                        ddltransportsearch = "--Select FeeType--";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {

                        ddltransportsearch = "Transportation Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));

                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {

                        ddltransportsearch = "--Select FeeType--";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {

                        ddltransportsearch = "Transportation Fee";

                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }

                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));

                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                        if (parseInt(pagesize) > 0) {
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Recentfee.aspx/bingrid1",

                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                                url: "Recentfee.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                            $("[id$=gridAnnualFee]").append(row);
                                            if (i == 0) {
                                                $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                                $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                                $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                                $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                            }
                                            $(row).find(".name").html(data.d[i].name);
                                            $(row).find(".applyclass").html(data.d[i].class1);
                                            $(row).find(".ADNO").html(data.d[i].adno);
                                            $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                            $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                            $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                            $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                            $(row).find(".ssno").html(data.d[i].rnumber);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gridAnnualFee] tr").show();
                                            $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        }
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                        $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                        $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

        <script type="text/javascript">  // bind gridview according to PAge size
            $(document).ready(function () {

                $("#ctl00_ContentPlaceHolder1_ddlRecordperPage").live('change', function (e) {

                    var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                    var ddltransportsearch = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                    var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                    var pagesizevalue1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                    var txtclassearch = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                    var txtadmissionno = $("#ctl00_ContentPlaceHolder1_txtadno").val();
                    var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                    if (pagesize == "Page Size") {
                        pagesize = 10;
                    }

                    if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }

                    $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                    if (parseInt(pagesize) > 0) {

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Recentfee.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
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
                            url: "Recentfee.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                        $("[id$=gridAnnualFee]").append(row);
                                        if (i == 0) {
                                            $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                            $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                            $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                            $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                        }
                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".applyclass").html(data.d[i].class1);
                                        $(row).find(".ADNO").html(data.d[i].adno);
                                        $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                        $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                        $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                        $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                        $(row).find(".ssno").html(data.d[i].rnumber);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridAnnualFee] tr").show();
                                    $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                }
                                else {
                                    $("[id*=gridAnnualFee] tr").show();
                                    $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                    $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                    $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                    $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                    $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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
                    var ddltransportsearch = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                    var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                    var pagesizevalue1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                    var txtclassearch = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                    var txtadmissionno = $("#ctl00_ContentPlaceHolder1_txtadno").val();
                    var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                    if (pagesize == "Page Size") {
                        pagesize = 10;
                    }

                    if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }

                    $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                    if (parseInt(pagesize) > 0) {

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Recentfee.aspx/bingrid1",

                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",

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
                            url: "Recentfee.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gridAnnualFee] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                        $("[id$=gridAnnualFee]").append(row);
                                        if (i == 0) {
                                            $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                            $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                            $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                            $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                        }
                                        $(row).find(".name").html(data.d[i].name);
                                        $(row).find(".applyclass").html(data.d[i].class1);
                                        $(row).find(".ADNO").html(data.d[i].adno);
                                        $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                        $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                        $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                        $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                        $(row).find(".ssno").html(data.d[i].rnumber);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gridAnnualFee] tr").show();
                                        $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                    }
                                    $("[id*=gridAnnualFee] tr").show();
                                    $("[id*=gridAnnualFee] tr:eq(1)").hide();

                                }
                                else {
                                    $("[id*=gridAnnualFee] tr").show();
                                    $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                    $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                    $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                    $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                    $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

        <script type="text/javascript"> //go on first page
            $(document).ready(function () {

                $("#ctl00_ContentPlaceHolder1_firstpage").click(function () {
                    var currentpage = 1;
                    var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                    var ddltransportsearch = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                    var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                    var pagesizevalue1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                    var txtclassearch = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                    var txtadmissionno = $("#ctl00_ContentPlaceHolder1_txtadno").val();
                    var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                    $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                    if (pagesize = "Page Size") {
                        pagesize = 10;
                    }
                    if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Recentfee.aspx/BindDatatable",
                        data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                        dataType: "json",
                        success: function (data) {

                            $("[id*=gridAnnualFee] tr:gt(1)").remove();
                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                    $("[id$=gridAnnualFee]").append(row);
                                    if (i == 0) {
                                        $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                        $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                        $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                        $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                    }
                                    $(row).find(".name").html(data.d[i].name);
                                    $(row).find(".applyclass").html(data.d[i].class1);
                                    $(row).find(".ADNO").html(data.d[i].adno);
                                    $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                    $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                    $(row).find(".ssno").html(data.d[i].rnumber);

                                    $(row).find(".swet").html(data.d[i].sname);

                                    $("[id*=gridAnnualFee] tr").show();
                                    $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                }
                                $("[id*=gridAnnualFee] tr").show();
                                $("[id*=gridAnnualFee] tr:eq(1)").hide();

                            }
                            else {
                                $("[id*=gridAnnualFee] tr").show();
                                $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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
                    var ddltransportsearch = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                    var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                    var pagesizevalue1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                    var txtclassearch = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                    var txtadmissionno = $("#ctl00_ContentPlaceHolder1_txtadno").val();
                    var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();
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

                    if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }

                    $("#ctl00_ContentPlaceHolder1_PageNo").val(parseInt(pageno1));

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Recentfee.aspx/BindDatatable",
                        data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                        dataType: "json",
                        success: function (data) {

                            $("[id*=gridAnnualFee] tr:gt(1)").remove();
                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                    $("[id$=gridAnnualFee]").append(row);
                                    if (i == 0) {
                                        $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                        $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                        $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                        $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                    }
                                    $(row).find(".name").html(data.d[i].name);
                                    $(row).find(".applyclass").html(data.d[i].class1);
                                    $(row).find(".ADNO").html(data.d[i].adno);
                                    $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                    $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                    $(row).find(".ssno").html(data.d[i].rnumber);

                                    $(row).find(".swet").html(data.d[i].sname);

                                    $("[id*=gridAnnualFee] tr").show();
                                    $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                }
                                $("[id*=gridAnnualFee] tr").show();
                                $("[id*=gridAnnualFee] tr:eq(1)").hide();

                            }
                            else {
                                $("[id*=gridAnnualFee] tr").show();
                                $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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
                    var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                    var max = $('#ctl00_ContentPlaceHolder1_PageNo option:last-child').val();
                    var ddltransportsearch = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                    var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                    var pagesizevalue1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                    var txtclassearch = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                    var txtadmissionno = $("#ctl00_ContentPlaceHolder1_txtadno").val();
                    var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                    if (pagesize == "Page Size") {

                        pagesize = 10;

                    }

                    if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
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
                        url: "Recentfee.aspx/BindDatatable",
                        data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                        dataType: "json",
                        success: function (data) {

                            $("[id*=gridAnnualFee] tr:gt(1)").remove();
                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                    $("[id$=gridAnnualFee]").append(row);
                                    if (i == 0) {
                                        $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                        $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                        $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                        $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                    }
                                    $(row).find(".name").html(data.d[i].name);
                                    $(row).find(".applyclass").html(data.d[i].class1);
                                    $(row).find(".ADNO").html(data.d[i].adno);
                                    $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                    $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                    $(row).find(".ssno").html(data.d[i].rnumber);

                                    $(row).find(".swet").html(data.d[i].sname);

                                    $("[id*=gridAnnualFee] tr").show();
                                    $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                }
                                $("[id*=gridAnnualFee] tr").show();
                                $("[id*=gridAnnualFee] tr:eq(1)").hide();

                            }
                            else {
                                $("[id*=gridAnnualFee] tr").show();
                                $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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
                    var pagesize = "";
                    var currentpage = $('#ctl00_ContentPlaceHolder1_PageNo option:last-child').val();
                    var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                    var ddltransportsearch = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                    var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                    var pagesizevalue1 = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                    var txtclassearch = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                    var txtadmissionno = $("#ctl00_ContentPlaceHolder1_txtadno").val();
                    var txtname = $("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                    $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                    if (pagesize = "Page Size") {
                        pagesize = 10;
                    }
                    if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch != "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno == "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname == "") {
                        ddltransportsearch = "Development Charges";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "0" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "--Select FeeType--";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "1" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Transportation Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "2" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Tution Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "3" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Examination Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "4" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Admission Fee";
                    }
                    else if (txtclassearch == "" && ddltransportsearch == "5" && txtadmissionno != "" && txtname != "") {
                        ddltransportsearch = "Development Charges";
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Recentfee.aspx/BindDatatable",
                        data: "{'pagesize':'" + pagesize + "','pageno':'" + pageno1 + "','searchvalue1':'" + ddltransportsearch + "','classname':'" + txtclassearch + "','adno':'" + txtadmissionno + "','name2':'" + txtname + "'}",
                        dataType: "json",
                        success: function (data) {

                            $("[id*=gridAnnualFee] tr:gt(1)").remove();
                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=gridAnnualFee] tr:eq(1)").clone(true);

                                    $("[id$=gridAnnualFee]").append(row);
                                    if (i == 0) {
                                        $('#ctl00_ContentPlaceHolder1_lblTotal').html(data.d[0].Totalamount);
                                        $('#ctl00_ContentPlaceHolder1_lblReceived').html(data.d[0].Paidamount);
                                        $('#ctl00_ContentPlaceHolder1_lblremain').html(data.d[0].Balanceamount);
                                        $('#ctl00_ContentPlaceHolder1_lbldiscount1').html(data.d[0].discount1);
                                    }
                                    $(row).find(".name").html(data.d[i].name);
                                    $(row).find(".applyclass").html(data.d[i].class1);
                                    $(row).find(".ADNO").html(data.d[i].adno);
                                    $(row).find(".totalfee").html(parseFloat(data.d[i].totalfee).toFixed(2));
                                    $(row).find(".paidfee").html(parseFloat(data.d[i].paidfee).toFixed(2));
                                    $(row).find(".balanfee").html(parseFloat(data.d[i].balanfee).toFixed(2));
                                    $(row).find(".discount").html(parseFloat(data.d[i].discount).toFixed(2));
                                    $(row).find(".ssno").html(data.d[i].rnumber);

                                    $(row).find(".swet").html(data.d[i].sname);

                                    $("[id*=gridAnnualFee] tr").show();
                                    $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                }
                                $("[id*=gridAnnualFee] tr").show();
                                $("[id*=gridAnnualFee] tr:eq(1)").hide();

                            }
                            else {
                                $("[id*=gridAnnualFee] tr").show();
                                $("[id*=gridAnnualFee] tr:eq(1)").hide();
                                $("[id*=gridAnnualFee] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                $("#ctl00_ContentPlaceHolder1_lblTotal").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lblReceived").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lblremain").text("0.00");
                                $("#ctl00_ContentPlaceHolder1_lbldiscount1").text("0.00");
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

        <div id="boxid" runat="server">

            <div style="margin-left: 750px;">
               
               
            </div>

            <table id="tbllde">

                <tr>

                    <td valign="top" align="left">
                        <div class="conductedlecture234 secbox" style="margin-left: 10px;">
                            <asp:Label runat="server" ID="lbl1" Text="Total" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label9" runat="server" Text="₹" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblTotal" runat="server" Text="0.00" ForeColor="#B136A4" Font-Bold="true"></asp:Label>
                        </div>
                    </td>
                    <td valign="top" align="left">
                        <div class="conductedlecture235 thirdbox" style="margin-left: 10px;">
                            <asp:Label runat="server" ID="Label6" Text="Received" Font-Bold="true" ForeColor="#824a9e"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label8" runat="server" Text="₹" Font-Bold="true" ForeColor="#824a9e"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblReceived" runat="server" Text="0.00" ForeColor="#824a9e" Font-Bold="true"></asp:Label>
                        </div>
                    </td>
                    <td valign="top" align="left">
                        <div class="conductedlecture236 fourthbox" style="margin-left: 11px; border: 1px solid #15E6B5;">
                            <asp:Label runat="server" ID="Label2" Text="Balance" Font-Bold="true" ForeColor="#14879e"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label3" runat="server" Text="₹" Font-Bold="true" ForeColor="#14879e"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblremain" runat="server" Text="0.00" Font-Bold="true" ForeColor="#14879e"></asp:Label>
                        </div>
                    </td>
                    <td valign="top" align="left">
                        <div class="conductedlecture2556" style="margin-left: 11px; border: 1px solid #15E6B5;">
                            <asp:Label runat="server" ID="lbldiscount2" Text="Discount" Font-Bold="true" ForeColor="Black"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="lbldiscount3" runat="server" Text="₹" Font-Bold="true" ForeColor="Black"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lbldiscount1" runat="server" Text="0" Font-Bold="true" ForeColor="Black"></asp:Label>
                        </div>
                    </td>
                </tr>
            </table>

            <div class="clear"></div>
            <br />
            <div id="hjh" runat="server">
                <table width="101%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px;"
                    class="stmft">
                    <tr>
                        <td colspan="10" class="containerHeadlinenew">
                            <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px"
                                Font-Size="11px" Style="margin-top: -2.5px; margin-left: 15px;">
                                <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="1" Text="20"></asp:ListItem>
                                <asp:ListItem Value="2" Text="30"></asp:ListItem>
                                <asp:ListItem Value="3" Text="50"></asp:ListItem>
                                <asp:ListItem Value="4" Text="100"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtnamesearch" placeholder="Search by Name" runat="server" Style="height: 23px; width: 150px;"> </asp:TextBox>
                            <asp:TextBox ID="txtadno" placeholder="Search by Adno" runat="server" Style="height: 23px; width: 150px;"> </asp:TextBox>
                            <asp:TextBox ID="TextBox1" runat="server" placeholder="Enter class Name"></asp:TextBox>
                            <asp:DropDownList ID="ddlEnquirySource" runat="server" Width="150px">
                                <asp:ListItem Value="0">--Select FeeType--</asp:ListItem>
                                <asp:ListItem Value="1">Transportation Fee</asp:ListItem>
                                <asp:ListItem Value="2">Tution Fee</asp:ListItem>
                                <asp:ListItem Value="3">Examination Fee</asp:ListItem>
                                <asp:ListItem Value="4">Admission Fee</asp:ListItem>
                                <asp:ListItem Value="5">Development Charges</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Button ID="Button1" runat="server" Text="Go" Height="25px" ToolTip="Click here to search items"
                                CssClass="view-enquiry" />
                            <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="false"
                                Height="20px" CssClass="excel" ToolTip="Click here to download Excel sheet" />
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
            <table cellpadding="2" cellspacing="0" border="0" style="width: 101%; border-left: none !important;">
                <tr>
                    <td align="left" colspan="7" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                        <asp:GridView runat="server" ID="gridAnnualFee" ShowHeader="true"
                            AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="stm">
                            <Columns>
                                <asp:TemplateField HeaderText="S No.">
                                    <ItemTemplate>
                                        <asp:Label ID="sno" runat="server" class="rownumber" Text='<%# Bind("rnumber") %>' CssClass="ssno"> </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Bind("name") %>' CssClass="name"> </asp:LinkButton>
                                        <asp:Label ID="lblrid" runat="server" CssClass="ridcss" Text='<%# Bind("adid") %>' Style="display: none;"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Class">
                                    <ItemTemplate>
                                        <asp:Label ID="lblclass" runat="server" Text='<%# Bind("applyclass") %>' CssClass="applyclass"> </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Admission No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblstudentname" runat="server" Text='<%# Bind("ADNO") %>' CssClass="ADNO"> </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total ( &#x20B9; ) ">
                                    <ItemTemplate>
                                        <asp:Label ID="lbtfe" runat="server" Font-Bold="true" Text='<%# Bind("totalfee","{0:0.00}") %>' ForeColor="#B136A4" CssClass="totalfee"> </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received ( &#x20B9; )">
                                    <ItemTemplate>
                                        <asp:Label ID="lblamnt" runat="server" ForeColor="#824A9E" Text='<%# Bind("paidfee","{0:0.00}") %>' CssClass="paidfee"> </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Balance ( &#x20B9; )">
                                    <ItemTemplate>
                                        <asp:Label ID="lbbaln" runat="server" ForeColor="#14879E" Text='<%# Bind("balanfee","{0:0.00}") %>' CssClass="balanfee"> </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discount ( &#x20B9; )">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldue" runat="server" ForeColor="#13879E" Font-Bold="true" Text='<%# Bind("discount","{0:0.00}") %>' CssClass="discount"> </asp:Label>
                                    </ItemTemplate>
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
                        <div id="gg" runat="server">
                            <asp:DropDownList ID="PageNo" runat="server" Width="85px">
                            </asp:DropDownList>
                            <div style="float: right; width: 153px;">
                                <asp:ImageButton ID="firstpage" runat="server" CssClass="first-click" ImageUrl="~/images/first.gif" Width="25px" />

                                <asp:ImageButton ID="previous" runat="server" CssClass="previous-click" ImageUrl="~/images/previous.gif" Width="25px" />
                                <asp:ImageButton ID="next" runat="server" CssClass="next-click" ImageUrl="~/images/next.gif" Width="25px" />
                                <asp:ImageButton ID="last" runat="server" CssClass="last-click" ImageUrl="~/images/last.gif" Width="25px" />
                            </div>
                        </div>
                    </td>
    </tr>
            </table>
        </div>
</asp:Content>