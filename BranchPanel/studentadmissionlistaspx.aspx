<%@ Page Title="Student Admission list" Language="C#" AutoEventWireup="true" CodeFile="studentadmissionlistaspx.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_studentadmissionlistaspx" EnableEventValidation="false" %>
<%@ OutputCache Duration='30'
    VaryByParam='none' %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../js/1.8-jquery-ui.min.js"></script>
    <link href="../js/1.8-themes-base-jquery-ui.css" rel="stylesheet" type="text/css" />
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
    </style>

    <script type="text/javascript">

        function CheckDate() {
            if (document.getElementById("ctl00_ContentPlaceHolder1_txtDate").value != "") {
                if (document.getElementById("ctl00_ContentPlaceHolder1_txtToDate").value == "") {
                    alert("Please Select To Date !");
                    document.getElementById("ctl00_ContentPlaceHolder1_txtToDate").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_txtToDate").value != "") {
                if (document.getElementById("ctl00_ContentPlaceHolder1_txtDate").value == "") {
                    alert("Please Select From Date !");
                    document.getElementById("ctl00_ContentPlaceHolder1_txtDate").focus();
                    return false;
                }

            }

            return true;
        }
    </script>

    <script type="text/javascript"> // bind dropdownlist

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_ddlsearchoption").change(function () {

                var cid = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;

                if (cid == "0") {
                    $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").html("");
                    $("#ctl00_ContentPlaceHolder1_txtnamesearch").val("");
                    $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").attr("disabled", "disabled");
                    return;
                }
                if (cid == "1" || cid == "2") {

                    $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").html("");
                    $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").attr("disabled", "disabled");

                    jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").focus();
                    jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").css("border", "1px solid #ccc");
                    jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").css("background-color", "#FFBFFF");

                }
                else
                    if (cid == "3") {

                        jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").val('');
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "studentadmissionlistaspx.aspx/bindclassses",
                            data: "{'cid':'" + cid + "'}",
                            dataType: "json",
                            success: function (data) {
                                $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").html("");
                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").append($("<option></option>").val(value.SID).html(value.statename));
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });

                        $("#ctl00_ContentPlaceHolder1_ddlEnquirySource").removeAttr("disabled");
                        jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").removeAttr('style');

                    }

                return;

            });
        });
    </script>

    <script type="text/javascript">   //for button click

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {

                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();

                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var textboxvalue = jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                var classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;

                $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                if (pagesize == "Page Size") {

                    pagesize = 10
                }

                if (searchitemvalue == "0") {

                    if (parseInt(pagesize) > 0) {

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "studentadmissionlistaspx.aspx/bingrid1",
                            data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
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
                            url: "studentadmissionlistaspx.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gvdetails] tr:gt(1)").remove();

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                    $("[id$=gvdetails]").append(row);

                                    $(row).find(".sturollno").html(data.d[i].adno);
                                    $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                    $(row).find(".stujoindate").html(data.d[i].admiDate);

                                    $(row).find(".ridcss").html(data.d[i].Rid);
                                    $(row).find(".stuclass").html(data.d[i].applyclass);
                                    $(row).find(".admiid").html(data.d[i].admiid);
                                    $(row).find(".sturollno").html(data.d[i].adno);

                                    $(row).find(".swet").html(data.d[i].sname);

                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();
                                }
                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else
                    if (searchitemvalue == "1") {

                        if (textboxvalue == " ") {

                            alert("Please enter name.")
                            return false
                        }
                        if (parseInt(pagesize) > 0) {

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "studentadmissionlistaspx.aspx/bingrid1",
                                data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
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
                                url: "studentadmissionlistaspx.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + 1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();

                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                            $("[id$=gvdetails]").append(row);

                                            $(row).find(".sturollno").html(data.d[i].adno);
                                            $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                            $(row).find(".stujoindate").html(data.d[i].admiDate);

                                            $(row).find(".ridcss").html(data.d[i].Rid);
                                            $(row).find(".stuclass").html(data.d[i].applyclass);
                                            $(row).find(".admiid").html(data.d[i].admiid);
                                            $(row).find(".sturollno").html(data.d[i].adno);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gvdetails] tr").show();
                                            $("[id*=gvdetails] tr:eq(1)").hide();
                                        }
                                    }
                                    else {
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                        $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }

                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });
                        }

                        return false;

                    }
                    else if (searchitemvalue == "2") {
                        if (textboxvalue == " ") {

                            alert("Please enter name .")
                            return false
                        }
                        if (parseInt(pagesize) > 0) {

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "studentadmissionlistaspx.aspx/bingrid1",
                                data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
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

                        }
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "studentadmissionlistaspx.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + 1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gvdetails] tr:gt(1)").remove();

                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        //  var row = $("[id*=gvdetails] tr").clone(true);

                                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                        $("[id$=gvdetails]").append(row);

                                        $(row).find(".sturollno").html(data.d[i].adno);
                                        $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                        $(row).find(".stujoindate").html(data.d[i].admiDate);
                                        $(row).find(".ridcss").html(data.d[i].Rid);
                                        $(row).find(".stuclass").html(data.d[i].applyclass);
                                        $(row).find(".admiid").html(data.d[i].admiid);
                                        $(row).find(".sturollno").html(data.d[i].adno);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                    }
                                }
                                else {
                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();
                                    $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });

                        return false;

                    }

                    else
                        if (searchitemvalue == "3") {
                            if (classid == "0") {

                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/bingrid1",
                                    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
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

                                alert("Please Select Class.!")
                                return false;
                            }
                            else {
                                if (parseInt(pagesize) > 0) {

                                    $.ajax({
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "studentadmissionlistaspx.aspx/bingrid1",
                                        data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + 1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
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
                                        url: "studentadmissionlistaspx.aspx/BindDatatable",
                                        data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + 1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
                                        dataType: "json",
                                        success: function (data) {

                                            $("[id*=gvdetails] tr:gt(1)").remove();
                                            if (data.d.length > 0) {
                                                for (var i = 0; i < data.d.length; i++) {
                                                    //  var row = $("[id*=gvdetails] tr").clone(true);

                                                    var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                                    $("[id$=gvdetails]").append(row);

                                                    $(row).find(".sturollno").html(data.d[i].adno);
                                                    $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                                    $(row).find(".stujoindate").html(data.d[i].admiDate);

                                                    $(row).find(".ridcss").html(data.d[i].Rid);
                                                    $(row).find(".stuclass").html(data.d[i].applyclass);
                                                    $(row).find(".admiid").html(data.d[i].admiid);
                                                    $(row).find(".sturollno").html(data.d[i].adno);

                                                    $(row).find(".swet").html(data.d[i].sname);

                                                    $("[id*=gvdetails] tr").show();
                                                    $("[id*=gvdetails] tr:eq(1)").hide();
                                                }
                                            }
                                            else {
                                                $("[id*=gvdetails] tr").show();
                                                $("[id*=gvdetails] tr:eq(1)").hide();
                                                $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                            }
                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });
                                }

                            }

                            return false;
                        }

                        else if (searchitemvalue == "4") {
                            if (textboxvalue == " ") {

                                alert("Please enter mobile no .")
                                return false
                            }
                            if (parseInt(pagesize) > 0) {

                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/bingrid1",
                                    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
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

                            }

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "studentadmissionlistaspx.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();

                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                            $("[id$=gvdetails]").append(row);

                                            $(row).find(".registrationno").html(data.d[i].adno);
                                            $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                            $(row).find(".stujoindate").html(data.d[i].admiDate);

                                            $(row).find(".ridcss").html(data.d[i].Rid);
                                            $(row).find(".stuclass").html(data.d[i].applyclass);
                                            $(row).find(".admiid").html(data.d[i].admiid);
                                            $(row).find(".sturollno").html(data.d[i].adno);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gvdetails] tr").show();
                                            $("[id*=gvdetails] tr:eq(1)").hide();
                                        }
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                        $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                            return false;

                        }

                        else {
                            if (parseInt(pagesize) > 0) {

                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/bindgridPagesize",
                                    data: "{'cid':'" + pagesize + "'}",
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

                            }
                        }

            });

        });
    </script>

    <script type="text/javascript">  // bind gridview according to PAge size
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_ddlRecordperPage").live('change', function (e) {
                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var classid = $("#ctl00_ContentPlaceHolder1_ddlEnquirySource option:selected").val();

                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var textboxvalue = jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                if (pagesize == "Page Size") {
                    pagesiz = 10;
                }

                $("#ctl00_ContentPlaceHolder1_PageNo").html("");

                if (searchitemvalue == "0") {

                    if (parseInt(pagesize) > 0) {

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "studentadmissionlistaspx.aspx/bingrid1",
                            data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
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
                            url: "studentadmissionlistaspx.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gvdetails] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        //  var row = $("[id*=gvdetails] tr").clone(true);

                                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                        $("[id$=gvdetails]").append(row);

                                        $(row).find(".sturollno").html(data.d[i].adno);
                                        $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                        $(row).find(".stujoindate").html(data.d[i].admiDate);

                                        $(row).find(".ridcss").html(data.d[i].Rid);
                                        $(row).find(".stuclass").html(data.d[i].applyclass);
                                        $(row).find(".admiid").html(data.d[i].admiid);
                                        $(row).find(".sturollno").html(data.d[i].adno);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                    }
                                }
                                else {
                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();
                                    $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                }
                else
                    if (searchitemvalue == "1") {

                        if (parseInt(pagesize) > 0) {

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "studentadmissionlistaspx.aspx/bingrid1",
                                data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
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
                                url: "studentadmissionlistaspx.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + 1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                            $("[id$=gvdetails]").append(row);

                                            $(row).find(".sturollno").html(data.d[i].adno);
                                            $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                            $(row).find(".stujoindate").html(data.d[i].admiDate);

                                            $(row).find(".ridcss").html(data.d[i].Rid);
                                            $(row).find(".stuclass").html(data.d[i].applyclass);
                                            $(row).find(".admiid").html(data.d[i].admiid);
                                            $(row).find(".sturollno").html(data.d[i].adno);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gvdetails] tr").show();
                                            $("[id*=gvdetails] tr:eq(1)").hide();
                                        }
                                    }
                                    else {
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                        $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });
                        }

                    }

                    else
                        if (searchitemvalue == "3") {

                            //aler(classid);
                            //if (classid == "0") {

                            //    alert("Please Select Class.!")
                            //    return false;
                            //}
                            //else {

                            if (parseInt(pagesize) > 0) {
                                var c = 1;
                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/bingrid1",
                                    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
                                    dataType: "json",
                                    success: function (data) {

                                        $.each(data.d, function (key, value) {
                                            $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                            c = parseInt(c) + 1;
                                        });
                                    },
                                    error: function (result) {
                                        alert("Error");
                                    }
                                });

                                if (c < parseInt(pageno1)) {
                                    pageno1 = parseInt(pageno1) - 1;
                                    $("#ctl00_ContentPlaceHolder1_PageNo").value(pageno1);
                                    alert(pageno1);
                                }
                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/BindDatatable",
                                    data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + 1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
                                    dataType: "json",
                                    success: function (data) {

                                        $("[id*=gvdetails] tr:gt(1)").remove();

                                        if (data.d.length > 0) {
                                            for (var i = 0; i < data.d.length; i++) {
                                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                                var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                                $("[id$=gvdetails]").append(row);

                                                $(row).find(".sturollno").html(data.d[i].adno);
                                                $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                                $(row).find(".stujoindate").html(data.d[i].admiDate);

                                                $(row).find(".ridcss").html(data.d[i].Rid);
                                                $(row).find(".stuclass").html(data.d[i].applyclass);
                                                $(row).find(".admiid").html(data.d[i].admiid);
                                                $(row).find(".sturollno").html(data.d[i].adno);

                                                $(row).find(".swet").html(data.d[i].sname);

                                                $("[id*=gvdetails] tr").show();
                                                $("[id*=gvdetails] tr:eq(1)").hide();
                                            }
                                        }
                                        else {
                                            $("[id*=gvdetails] tr").show();
                                            $("[id*=gvdetails] tr:eq(1)").hide();
                                            $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                        }
                                    },
                                    error: function (result) {
                                        alert("Error");
                                    }
                                });
                            }

                        }

                            //}

                        else if (searchitemvalue == "2") {

                            if (parseInt(pagesize) > 0) {

                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/bingrid1",
                                    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
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

                            }
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "studentadmissionlistaspx.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + 1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();

                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                            $("[id$=gvdetails]").append(row);

                                            $(row).find(".sturollno").html(data.d[i].adno);
                                            $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                            $(row).find(".stujoindate").html(data.d[i].admiDate);

                                            $(row).find(".ridcss").html(data.d[i].Rid);
                                            $(row).find(".stuclass").html(data.d[i].applyclass);
                                            $(row).find(".admiid").html(data.d[i].admiid);
                                            $(row).find(".sturollno").html(data.d[i].adno);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gvdetails] tr").show();
                                            $("[id*=gvdetails] tr:eq(1)").hide();
                                        }
                                    }
                                    else {
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                        $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }

                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                        }
                        else if (searchitemvalue == "4") {

                            if (parseInt(pagesize) > 0) {

                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/bingrid1",
                                    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
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

                            }

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "studentadmissionlistaspx.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();

                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                            $("[id$=gvdetails]").append(row);
                                            //alert(data.d[i].RowNumber);
                                            $(row).find(".sno1").html(data.d[i].RowNumber);

                                            $(row).find(".registrationno").html(data.d[i].registrationno);

                                            $(row).find(".date1").html(data.d[i].RegistrationDate);
                                            $(row).find(".cllblpmid").html(data.d[i].Rid);
                                            $(row).find(".view1").html(data.d[i].Rid);
                                            $(row).find(".applyclass1").html(data.d[i].applyclass);

                                            $(row).find(".fname1").html(data.d[i].Fname);
                                            $(row).find(".sname1").html(data.d[i].sname);
                                        }
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();

                                    }
                                    else {
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                        $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                        }

                        else {
                            if (parseInt(pagesize) > 0) {

                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/bindgridPagesize",
                                    data: "{'cid':'" + pagesize + "'}",
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

                            }
                        }
            });
        });
    </script>

    <script type="text/javascript">    // Page No
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_PageNo").change(function () {

                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();

                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var textboxvalue = jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                var classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;

                if (pagesize == "Page Size") {

                    pagesize = 10
                }

                if (searchitemvalue == "0") {

                    if (parseInt(pagesize) > 0) {

                        //$.ajax({
                        //    type: "POST",
                        //    contentType: "application/json; charset=utf-8",
                        //    url: "RegList.aspx/bingrid1",
                        //    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                        //    dataType: "json",
                        //    success: function (data) {

                        //        $.each(data.d, function (key, value) {
                        //            $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                        //        });
                        //    },
                        //    error: function (result) {
                        //        alert("Error");
                        //    }
                        //});

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "studentadmissionlistaspx.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gvdetails] tr:gt(1)").remove();

                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        //  var row = $("[id*=gvdetails] tr").clone(true);

                                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                        $("[id$=gvdetails]").append(row);

                                        $(row).find(".sturollno").html(data.d[i].adno);
                                        $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                        $(row).find(".stujoindate").html(data.d[i].admiDate);

                                        $(row).find(".ridcss").html(data.d[i].Rid);
                                        $(row).find(".stuclass").html(data.d[i].applyclass);
                                        $(row).find(".admiid").html(data.d[i].admiid);
                                        $(row).find(".sturollno").html(data.d[i].adno);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                    }
                                }
                                else {
                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();
                                    $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else
                    if (searchitemvalue == "1") {

                        if (textboxvalue == " ") {

                            alert("Please enter registration no.")
                            return false
                        }
                        if (parseInt(pagesize) > 0) {

                            //$.ajax({
                            //    type: "POST",
                            //    contentType: "application/json; charset=utf-8",
                            //    url: "RegList.aspx/bingrid1",
                            //    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                            //    dataType: "json",
                            //    success: function (data) {

                            //        $.each(data.d, function (key, value) {
                            //            $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                            //        });
                            //    },
                            //    error: function (result) {
                            //        alert("Error");
                            //    }
                            //});

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "studentadmissionlistaspx.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                            $("[id$=gvdetails]").append(row);

                                            $(row).find(".sturollno").html(data.d[i].adno);
                                            $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                            $(row).find(".stujoindate").html(data.d[i].admiDate);

                                            $(row).find(".ridcss").html(data.d[i].Rid);
                                            $(row).find(".stuclass").html(data.d[i].applyclass);
                                            $(row).find(".admiid").html(data.d[i].admiid);
                                            $(row).find(".sturollno").html(data.d[i].adno);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gvdetails] tr").show();
                                            $("[id*=gvdetails] tr:eq(1)").hide();
                                        }
                                    }
                                    else {
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                        $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }

                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });
                        }

                        return false;

                    }
                    else if (searchitemvalue == "2") {
                        if (textboxvalue == " ") {

                            alert("Please enter name .")
                            return false
                        }
                        if (parseInt(pagesize) > 0) {

                            //$.ajax({
                            //    type: "POST",
                            //    contentType: "application/json; charset=utf-8",
                            //    url: "RegList.aspx/bingrid1",
                            //    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                            //    dataType: "json",
                            //    success: function (data) {

                            //        $.each(data.d, function (key, value) {
                            //            $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                            //        });
                            //    },
                            //    error: function (result) {
                            //        alert("Error");
                            //    }
                            //});

                        }
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "studentadmissionlistaspx.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gvdetails] tr:gt(1)").remove();
                                if (data.d.length > 0) {
                                    for (var i = 0; i < data.d.length; i++) {
                                        //  var row = $("[id*=gvdetails] tr").clone(true);

                                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                        $("[id$=gvdetails]").append(row);

                                        $(row).find(".sturollno").html(data.d[i].adno);
                                        $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                        $(row).find(".stujoindate").html(data.d[i].admiDate);

                                        $(row).find(".ridcss").html(data.d[i].Rid);
                                        $(row).find(".stuclass").html(data.d[i].applyclass);
                                        $(row).find(".admiid").html(data.d[i].admiid);
                                        $(row).find(".sturollno").html(data.d[i].adno);

                                        $(row).find(".swet").html(data.d[i].sname);

                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                    }
                                }
                                else {
                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();
                                    $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                }

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });

                        return false;

                    }

                    else
                        if (searchitemvalue == "3") {
                            if (classid == "0") {

                                alert("Please Select Class.!")
                                return false;
                            }
                            else {
                                if (parseInt(pagesize) > 0) {

                                    //$.ajax({
                                    //    type: "POST",
                                    //    contentType: "application/json; charset=utf-8",
                                    //    url: "RegList.aspx/bingrid1",
                                    //    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
                                    //    dataType: "json",
                                    //    success: function (data) {

                                    //        $.each(data.d, function (key, value) {
                                    //            $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                    //        });
                                    //    },
                                    //    error: function (result) {
                                    //        alert("Error");
                                    //    }
                                    //});

                                    $.ajax({
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "studentadmissionlistaspx.aspx/BindDatatable",
                                        data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
                                        dataType: "json",
                                        success: function (data) {

                                            $("[id*=gvdetails] tr:gt(1)").remove();
                                            if (data.d.length > 0) {
                                                for (var i = 0; i < data.d.length; i++) {
                                                    //  var row = $("[id*=gvdetails] tr").clone(true);

                                                    var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                                    $("[id$=gvdetails]").append(row);

                                                    $(row).find(".sturollno").html(data.d[i].adno);
                                                    $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                                    $(row).find(".stujoindate").html(data.d[i].admiDate);

                                                    $(row).find(".ridcss").html(data.d[i].Rid);
                                                    $(row).find(".stuclass").html(data.d[i].applyclass);
                                                    $(row).find(".admiid").html(data.d[i].admiid);
                                                    $(row).find(".sturollno").html(data.d[i].adno);

                                                    $(row).find(".swet").html(data.d[i].sname);

                                                    $("[id*=gvdetails] tr").show();
                                                    $("[id*=gvdetails] tr:eq(1)").hide();
                                                }
                                            }
                                            else {
                                                $("[id*=gvdetails] tr").show();
                                                $("[id*=gvdetails] tr:eq(1)").hide();
                                                $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                            }
                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });
                                }

                            }

                            return false;
                        }

                        else if (searchitemvalue == "4") {
                            if (textboxvalue == " ") {

                                alert("Please enter mobile no .")
                                return false
                            }
                            if (parseInt(pagesize) > 0) {

                                //$.ajax({
                                //    type: "POST",
                                //    contentType: "application/json; charset=utf-8",
                                //    url: "RegList.aspx/bingrid1",
                                //    data: "{'cid':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                                //    dataType: "json",
                                //    success: function (data) {

                                //        $.each(data.d, function (key, value) {
                                //            $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                //        });
                                //    },
                                //    error: function (result) {
                                //        alert("Error");
                                //    }
                                //});

                            }

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "studentadmissionlistaspx.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();
                                    if (data.d.length > 0) {
                                        for (var i = 0; i < data.d.length; i++) {
                                            //  var row = $("[id*=gvdetails] tr").clone(true);

                                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                            $("[id$=gvdetails]").append(row);

                                            $(row).find(".sturollno").html(data.d[i].adno);
                                            $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                            $(row).find(".stujoindate").html(data.d[i].admiDate);

                                            $(row).find(".ridcss").html(data.d[i].Rid);
                                            $(row).find(".stuclass").html(data.d[i].applyclass);
                                            $(row).find(".admiid").html(data.d[i].admiid);
                                            $(row).find(".sturollno").html(data.d[i].adno);

                                            $(row).find(".swet").html(data.d[i].sname);

                                            $("[id*=gvdetails] tr").show();
                                            $("[id*=gvdetails] tr:eq(1)").hide();
                                        }
                                    }
                                    else {
                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                        $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                                    }
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                            return false;

                        }

                        else {
                            if (parseInt(pagesize) > 0) {

                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "studentadmissionlistaspx.aspx/bindgridPagesize",
                                    data: "{'cid':'" + pagesize + "'}",
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

                            }
                        }

            });
        });
    </script>

    <script type="text/javascript">      //  for row command as anchor tag
        $(document).ready(function () {
            $('.swet').click(function () {

                var id;

                id = $(this).closest("td").find("[id*=lblrid]").text();

                window.location.replace("viewadmission.aspx?adid=" + id);

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
                var textboxvalue = jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                if (pagesize = "Page Size") {
                    pagesize = 10;
                }

                var classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "studentadmissionlistaspx.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + currentpage + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gvdetails] tr:gt(1)").remove();
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                $("[id$=gvdetails]").append(row);

                                $(row).find(".sturollno").html(data.d[i].adno);
                                $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                $(row).find(".stujoindate").html(data.d[i].admiDate);

                                $(row).find(".ridcss").html(data.d[i].Rid);
                                $(row).find(".stuclass").html(data.d[i].applyclass);
                                $(row).find(".admiid").html(data.d[i].admiid);
                                $(row).find(".sturollno").html(data.d[i].adno);

                                $(row).find(".swet").html(data.d[i].sname);

                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();
                            }
                        }
                        else {
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                            $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
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
                var textboxvalue = jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

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
                var classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "studentadmissionlistaspx.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gvdetails] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                $("[id$=gvdetails]").append(row);

                                $(row).find(".sturollno").html(data.d[i].adno);
                                $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                $(row).find(".stujoindate").html(data.d[i].admiDate);

                                $(row).find(".ridcss").html(data.d[i].Rid);
                                $(row).find(".stuclass").html(data.d[i].applyclass);
                                $(row).find(".admiid").html(data.d[i].admiid);
                                $(row).find(".sturollno").html(data.d[i].adno);

                                $(row).find(".swet").html(data.d[i].sname);

                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();
                            }
                        }
                        else {
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                            $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
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
                var textboxvalue = jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                if (pagesize == "Page Size") {

                    pagesize = 10;

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
                var classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "studentadmissionlistaspx.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + pageno1 + "','searchitem':'" + searchitemvalue + "','classid':'" + classid + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gvdetails] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                $("[id$=gvdetails]").append(row);

                                $(row).find(".sturollno").html(data.d[i].adno);
                                $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                $(row).find(".stujoindate").html(data.d[i].admiDate);

                                $(row).find(".ridcss").html(data.d[i].Rid);
                                $(row).find(".stuclass").html(data.d[i].applyclass);
                                $(row).find(".admiid").html(data.d[i].admiid);
                                $(row).find(".sturollno").html(data.d[i].adno);

                                $(row).find(".swet").html(data.d[i].sname);

                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();
                            }
                        }
                        else {
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                            $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
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

                var pageno1 = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();

                var searchitemvalue = document.getElementById("ctl00_ContentPlaceHolder1_ddlsearchoption").value;
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                var pagesizevalue = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage').value;
                var textboxvalue = jQuery("#ctl00_ContentPlaceHolder1_txtnamesearch").val();

                $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                if (pagesize = "Page Size") {
                    pagesize = 10;
                }
                var classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlEnquirySource").value;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "studentadmissionlistaspx.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','textboxvalue1':'" + textboxvalue + "','pageno':'" + currentpage + "','searchitem':'" + searchitemvalue + "','classid':'" + parseInt(0) + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gvdetails] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                //  var row = $("[id*=gvdetails] tr").clone(true);

                                var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                $("[id$=gvdetails]").append(row);

                                $(row).find(".sturollno").html(data.d[i].adno);
                                $(row).find(".stuimage").attr("src", data.d[i].imageurl);
                                $(row).find(".stujoindate").html(data.d[i].admiDate);

                                $(row).find(".ridcss").html(data.d[i].Rid);
                                $(row).find(".stuclass").html(data.d[i].applyclass);
                                $(row).find(".admiid").html(data.d[i].admiid);
                                $(row).find(".sturollno").html(data.d[i].adno);

                                $(row).find(".swet").html(data.d[i].sname);

                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();
                            }
                        }
                        else {
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                            $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
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

    <style>
        .student-photo_frame2 {
            background: #EDEDED;
            height: 99px;
            border: 2px solid #ccc;
            width: 99.9%;
            margin-top: 4px;
        }

        .stm td {
            border-bottom: none;
            border-right: none;
            line-height: 15px;
            padding-left: 10px;
            color: #333;
        }

        .input_content {
            background-color: #AEE5EE!important;
            height: auto !important;
        }
    </style>

    <div class="content_top">

        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li style="background: none;"><a class="active">Admission</a></li>
        </ul>

        <div class="arrowt">
            <a href="Default.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div id="Label1" style="width: 3px;">
        <asp:Button ID="btnAdd" runat="server" Text="New Admission"
            OnClick="btnAdd_Click" CssClass="button_save" />
        <%-- <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <%-- <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>
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

                    <div style="float: right; width: 600px;">
                        <asp:DropDownList ID="ddlsearchoption" runat="server" Width="150px">
                            <asp:ListItem Value="0">Search Items</asp:ListItem>
                            <asp:ListItem Value="1">Name</asp:ListItem>
                            <asp:ListItem Value="2">Admission No</asp:ListItem>
                            <asp:ListItem Value="3">Class</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlEnquirySource" runat="server" Width="150px"></asp:DropDownList>
                        <asp:TextBox ID="txtnamesearch" runat="server" Width="150px" Height="23px"> </asp:TextBox>
                        <asp:Button ID="Button1" runat="server" Text="Go" Height="23px" ToolTip="Click here to search items"
                            CssClass="view-enquiry" />
                        <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="false"
                            OnClick="ImageButton1_Click" Height="20px" CssClass="excel" ToolTip="Click here to download Excel sheet" />
                    </div>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">

                    <asp:GridView runat="server" ID="gvdetails"
                        GridLines="None"
                        AutoGenerateColumns="false" Width="100%" CssClass="stm">
                        <Columns>

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="student-photo_frame2">
                                        <div class="student-photo_frame_img">
                                            <asp:Image runat="server" CssClass="stuimage" ID="imgsource" ImageUrl='<%# Eval("photo") %>' />
                                            <asp:HiddenField ID="hfimage" runat="server" Value='<%# Eval("photo") %>' />
                                        </div>
                                        <div style="float: left;">
                                            <div class="user-deatils1">
                                                <asp:LinkButton ID="lbtn3" runat="server" Text='<%# Bind("name") %>' CssClass="swet"
                                                    ToolTip="Click here to see the student profile."></asp:LinkButton>
                                                <asp:Label ID="lbladmiid" runat="server" CssClass="admiid" Text='<%#Eval("admiid") %>' Style="display: none;"></asp:Label>
                                                <asp:Label ID="lblrid" runat="server" CssClass="ridcss" Text='<%# Bind("adid") %>' Style="display: none;"></asp:Label>
                                                <%--<asp:HiddenField ID="hfd" runat="server" Value='<%#Eval("admiid") %>' />--%>
                                            </div>
                                            <div class="clear">
                                            </div>
                                            <div class="user-deatils1">
                                                <dt>Admission No.</dt>
                                                <cite>:</cite> <span>
                                                    <asp:Label ID="lblbraddress" CssClass="sturollno" runat="server" Text='<%#  Eval("ADNO")  %>'></asp:Label>
                                                </span>
                                            </div>
                                            <div class="clear">
                                            </div>
                                            <div class="user-deatils1">
                                                <dt>Class.</dt>
                                                <cite>:</cite> <span>
                                                    <asp:Label ID="lblrollnew" CssClass="stuclass" runat="server" Text='<%#  Eval("applyclass")  %>'></asp:Label>
                                                </span>
                                            </div>
                                            <div class="clear">
                                            </div>
                                            <div class="user-deatils1">
                                                <dt>Joining Date</dt>
                                                <cite>:</cite> <span>
                                                    <asp:Label ID="Label2" runat="server" CssClass="stujoindate" Text='<%#  Eval("AdmissionDate")  %>'></asp:Label></span>
                                                <div class="del-active">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>

            <tr>
                <td colspan="10" class="containerHeadline" style="padding-left: 10px; padding-bottom: 5px;">
                    <asp:DropDownList ID="PageNo" runat="server" Width="90px">
                    </asp:DropDownList>
                    <div style="margin-left: 350px; float: left; width: 300px;">
                        <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px" />
                        <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px" />
                        <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px" />
                        <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px" />
                    </div>
                </td>
            </tr>
        </table>

        <tr>

            <td runat="server" id="abc" visible="false">

                <asp:GridView runat="server" ID="gvdetails1" AllowPaging="true"
                    PageSize="20" AutoGenerateColumns="false" GridLines="None"
                    Width="100%" CssClass="stm">
                    <Columns>

                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">

                            <HeaderTemplate>
                                <asp:Label ID="lblsno" runat="server">S.No.</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="8%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                            <HeaderTemplate>
                                <asp:Label ID="lbldatex" runat="server">Date</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="date1" runat="server" Text='<%# Bind("AdmissionDate") %>'> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="17%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                            <HeaderTemplate>
                                <asp:Label ID="lblanox" runat="server">Admission NO.</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="date1" runat="server" Text='<%# Bind("adno") %>'> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="17%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                            <HeaderTemplate>
                                <asp:Label ID="lblstunamex" runat="server">Student Name</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="stuname" runat="server" Text='<%# Bind("name") %>'> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                            <HeaderTemplate>
                                <asp:Label ID="lblfathernamex" runat="server">Father Name</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="fathername" runat="server" Text='<%# Bind("Fname") %>'> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                            <HeaderTemplate>
                                <asp:Label ID="lbldatex" runat="server">Class</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# Eval("applyclass")%>
                                <asp:HiddenField ID="hidden3" runat="server" Value='<%# Bind("applyclass") %>' />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light" />
                    <AlternatingRowStyle CssClass="stm_dark" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
    </div>
</asp:Content>