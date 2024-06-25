<%@ Page Title="New Admission" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="admissionshort.aspx.cs" Inherits="BranchPanel_admissionshort" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%-- <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />--%>

    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .abc {
            color: white;
            display: inline-block;
            padding: 5px 10px;
            text-decoration: none;
            font-weight: bold;
            margin: 3px;
            background: #000;
            display: none;
        }

        .labelfor_radio21 {
            margin-top: 15px;
        }

        .checkitemclass {
            color: green;
        }

        .uncheckitemclass {
            color: green;
        }

        .stm_head th {
            font-size: 12px;
            color: #333 !important;
            border-right: 1px solid #dddddd;
            border-top: 1px solid #dddddd;
            border-left: 1px solid #dddddd;
            border-bottom: 1px solid #dddddd;
        }

        .stm td {
            border-bottom: 1px solid #dddddd;
            border-right: 1px solid #dddddd;
            line-height: 27px;
            padding-left: 10px;
            padding-right: 5px;
            color: #333;
            border-left: 1px solid #ddd;
        }

        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 325px;
        }

        .for_sigle_row_form input[type="text"], input[type="select"], input[type="Password"] {
            background-color: #FCFCFC;
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 28px;
            line-height: 20px;
            padding: 3px 6px;
            text-align: left;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
            width: 313px;
        }

        .for_sigle_row_form textarea {
            background-color: #FCFCFC;
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 79px;
            line-height: 20px;
            margin-bottom: 0;
            margin-top: 0;
            padding: 3px 6px;
            text-align: left;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
            width: 310px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
            });

        });
    </script>

    <script type="text/javascript">
        function pageLoad() {
            $("#ctl00_ContentPlaceHolder1_grdDetails tr:eq(1)").hide();
            $("#ctl00_ContentPlaceHolder1_grdclass tr:eq(1)").hide();
            $("#ctl00_ContentPlaceHolder1_grd1 tr:eq(1)").hide();
            $("#ctl00_ContentPlaceHolder1_Table3").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_Table2").css("display", "none");
            //  $("#ctl00_ContentPlaceHolder1_Table1").css("display", "none");

            $('.stm_head').css("display", "none");

            //var row = $("[id*=grdDetails] tr:eq(1)").clone(true);
        }
    </script>

    <script type="text/javascript">
        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
         ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
         (charCode < 97 || charCode > 122)) {
                return false;
            }
            else
                return true;
        };
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                 && (charCode <= 90))
                return false;
            return true;
        };
    </script>

    <script type="text/javascript">
        function CalculateAge(DOB) {

            var inputdob = DOB.value;

            if (inputdob == "") {

                alert("Enter date of Birth");

                document.getElementById('lblAge').innerHTML = '';

                return false;

            }

            var DOBDate = new Date(inputdob);

            var currentDate = new Date();

            var months = currentDate.getMonth() - DOBDate.getMonth();

            var years = currentDate.getFullYear() - DOBDate.getFullYear();

            var days = currentDate.getDate() - DOBDate.getDate();

            if (years <= 0) {

                alert("Date of Birth is atleast 3 years old ");

                $('#ctl00_ContentPlaceHolder1_txtToDate').val("");

                return false;

            }

            else if (months < 0) {

                years = parseInt(years, 10) - 1;

                months = 12 + parseInt(months, 10);

                if (days < 0) {

                    months = parseInt(months, 10) - 1;

                    days = 30 + parseInt(days, 10);

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';

                }

                else

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + (days) + ' Days';

            }

            else {

                if (months == 0) {

                    years = parseInt(years, 10) - 1;

                    if (days < 0) {

                        dayDiff = 30 + parseInt(days, 10);

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + (-days) + ' Days';

                    }

                    else

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';

                }

                else {

                    if (days < 0) {

                        months = parseInt(months, 10) - 1;

                        days = 30 + parseInt(days, 10);

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';

                    }

                    else

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';

                }

            }

        }
    </script>

    <script type="text/javascript" id="hjfkhgjk">

        function alertTest() {
            $(document).ready(function () {

                $('input[type="text"]').keyup(function (evt) {
                    var txt = $(this).val();

                    $(this).val(txt.replace(/^(.)|\s(.)/g, function ($1) { return $1.toUpperCase(); }));
                });

                //debugger;

                $("#ctl00_ContentPlaceHolder1_ddlPayMode").change(function () {

                    var modeid = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;
                    if (modeid == "0") {
                        $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "none");
                        return;
                    }
                    else if (modeid == "1") {

                        $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "none");
                        return;
                    }
                    else if (modeid == "2") {

                        $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "block");
                        return;
                    }
                    else if (modeid == "3") {

                        $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "block");
                        return;
                    }
                });

                $("#ctl00_ContentPlaceHolder1_ddlCountry1").change(function () {
                    // alert("ashuuuu");
                    var cid = document.getElementById("ctl00_ContentPlaceHolder1_ddlCountry1").value;
                    if (cid == "0") {
                        $('#ctl00_ContentPlaceHolder1_ddl_state').children('option:not(:first)').remove();
                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children('option:not(:first)').remove();

                        return;
                    }
                    else {
                        $('#ctl00_ContentPlaceHolder1_ddl_state').children().remove();
                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children().remove();

                    }

                    $.ajax(
                       {
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "common.aspx/bindstate",
                           data: "{'cid':'" + cid + "'}",
                           dataType: "json",
                           success: function (data) {
                               $("#ctl00_ContentPlaceHolder1_ddl_state").html("");
                               $.each(data.d, function (key, value) {
                                   $("#ctl00_ContentPlaceHolder1_ddl_state").append($("<option></option>").val(value.SID).html(value.statename));
                               });
                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });
                });

                $("#ctl00_ContentPlaceHolder1_ddl_state").change(function () {

                    var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_state").value;

                    if (sid == "0") {
                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children('option:not(:first)').remove();

                        return;
                    }
                    else {
                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children().remove();
                    }

                    $.ajax(
                       {
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "common.aspx/bindcity",
                           data: "{'sid':'" + sid + "'}",
                           dataType: "json",
                           success: function (data) {
                               $("#ctl00_ContentPlaceHolder1_ddlCity1").html("");
                               $.each(data.d, function (key, value1) {
                                   $("#ctl00_ContentPlaceHolder1_ddlCity1").append($("<option></option>").val(value1.CTID).html(value1.cityName));
                               });
                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });

                });

                $("#ctl00_ContentPlaceHolder1_ddl_Course").change(function () {

                    var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;
                    $('#ctl00_ContentPlaceHolder1_lbDiscount').html("Set Discount");
                    var tansptype1 = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
                    $.ajax({
                        type: "POST",
                        url: "admissionshort.aspx/BindDatatable",
                        data: "{'classid':'" + sid + "','transport':'" + tansptype1 + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var srno = 1;
                            var sr = 1;
                            $("[id*=grdDetails] tr:gt(1)").remove();
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=grdDetails] tr:eq(1)").clone(true);
                                var hdval = data.d[i].cfid;
                                var hdid = "";
                                var txt1 = ""
                                if (srno < 10) {
                                    hdid = "ctl00_ContentPlaceHolder1_grdDetails_ctl0" + srno + "_HD1";
                                    // txt1 = "ctl00_ContentPlaceHolder1_grdDetails_ct10" + srno + "_txtDiscount";

                                    //alert(txt1);

                                }
                                else {
                                    hdid = "ctl00_ContentPlaceHolder1_grdDetails_ctl" + srno + "_HD1";
                                    //txt1 = "ctl00_ContentPlaceHolder1_grdDetails_ctl" + srno + "_txtDiscount";
                                }

                                $("[id$=grdDetails]").append(row);
                                $(row).find(".clslblSrNo").html(srno);
                                $(row).find(".clslblfeename").html(data.d[i].feename);
                                $(row).find(".clslblfeenamefeeid").html(data.d[i].cfid);
                                //$(row).find("td:eq(3) input").attr("id", txt1);
                                $(row).find("td:eq(1) input").attr("id", hdid);
                                $(row).find("td:eq(1) input").val(hdval);
                                $(row).find(".clslblfeeamount").html(parseFloat(data.d[i].fees).toFixed(2));
                                srno = parseInt(srno) + 1;
                                sr = parseInt(sr) + 1;
                            }
                            $("[id*=grdDetails] tr").show();
                            $("[id*=grdDetails] tr:eq(1)").hide();

                            $("#ctl00_ContentPlaceHolder1_grdDetails").css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_Table2').css("display", "block");
                            //for (var i = 0; i < data.d.length; i++) {
                            //    $("ctl00_ContentPlaceHolder1_gvDetails").append("<tr><td>" + data.d[i].feename + "</td><td>" + data.d[i].fees + "</td></tr>");
                            //    alert(data.d[i].feename);
                            //}

                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

                    // Fee structure show

                    $.ajax({
                        type: "POST",
                        url: "admissionshort.aspx/Bindfeestructure",
                        data: "{'classid':'" + sid + "','transport':'" + tansptype1 + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var srno = 1;
                            //$("[id*=grdclass] tr:gt(1)").remove();
                            $("[id*=grdclass] tr:gt(1)").remove();
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=grdclass] tr:eq(1)").clone(true);

                                $("[id$=grdclass]").append(row);

                                $(row).find(".clslblSrNo1").html(srno);

                                $(row).find(".clslblmonth1").html(data.d[i].month);
                                $(row).find(".clslblfeename1").html(data.d[i].feename);
                                $(row).find(".clslblfee1").html(parseFloat(data.d[i].fees).toFixed(2));
                                srno = parseInt(srno) + 1;
                            }
                            $("[id*=grdclass] tr").show();
                            $("[id*=grdclass] tr:eq(1)").hide();

                            $("#ctl00_ContentPlaceHolder1_grdclass").css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_Table1').css("display", "block");

                            //$("#ctl00_ContentPlaceHolder1_Table1").css("display", "none");

                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

                    $.ajax({
                        type: "POST",
                        url: "admissionshort.aspx/bindpay",
                        data: "{'classid':'" + sid + "','transport':'" + tansptype1 + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",

                        success: function (data) {

                            $("[id*=grd1] tr:gt(1)").remove();
                            var hdid = "";
                            var srno = 1;
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=grd1] tr:eq(1)").clone(true);

                                $("[id$=grd1]").append(row);
                                $(row).find(".clsmonthname2").html(data.d[i].month);
                                $(row).find(".clsmonthid2").html(data.d[i].monthid);

                                if (srno < 10) {
                                    hdid = "ctl00_ContentPlaceHolder1_grd1_ctl0" + srno + "_chkclass1";
                                }
                                else {
                                    hdid = "ctl00_ContentPlaceHolder1_grd1_ctl" + srno + "_chkclass1";
                                }
                                //alert(hdid);
                                $(row).find("td:eq(0) input").attr("id", hdid);

                                if (srno > 1) {

                                    //$(row).find("#"+hdid+"").prop('disabled', true);
                                }

                                // $(row).find("td:eq(1) input").attr("id", hdid);

                                $(row).find(".clspay2").html(parseFloat(data.d[i].fees).toFixed(2));
                                $(row).find(".clspay3").html(parseFloat(data.d[i].fees).toFixed(2));
                                srno = parseInt(srno) + 1;
                            }
                            $("[id*=grd1] tr").show();
                            $("[id*=grd1] tr:eq(1)").hide();

                            $("#ctl00_ContentPlaceHolder1_Table3").css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_grd1').css("display", "block");

                        },
                        error: function (result) {

                            alert("Error");
                        }
                    });

                    $.ajax({

                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "admissionshort.aspx/bindsection",
                        data: "{'sid':'" + sid + "'}",
                        dataType: "json",
                        success: function (data) {
                            $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                            $.each(data.d, function (key, value) {

                                $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.SID).html(value.sectionname));
                            });
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

                });

                $("#ctl00_ContentPlaceHolder1_ddlSection").change(function () {

                    var secid = document.getElementById("ctl00_ContentPlaceHolder1_ddlSection").value;

                    if (secid != null) {

                        var sectnme = ($("#ctl00_ContentPlaceHolder1_ddl_Course").find("option:selected").text() + " " + $("#ctl00_ContentPlaceHolder1_ddlSection").find("option:selected").text());

                        $("#ctl00_ContentPlaceHolder1_txtClassSec").val(sectnme);
                        return;

                    }

                });

                var sum = 0;
                var sum1 = 0;
                var disamt = 0;
                var c1 = 0;
                $("#<%=grd1.ClientID %> input:checkbox[id*=chkclass1]").live('click', function () {

                    var cal1 = 0;
                    var check = 0;

                    if ($(this).is(':checked')) {

                        $('#<%=grd1.ClientID%>').find("input:checkbox").each(function () {

                            if ($(this).is(':checked')) {
                                var amt1 = $(this).closest('tr').find('td:eq(2)').text();
                                cal1 += parseFloat(amt1);
                                check = check + 1;

                            }
                        });

                        disamt = 0;
                        c1 = 0;
                        amt = 0;

                        var GridId = "<%=grdDetails.ClientID %>";
                        var grid = document.getElementById(GridId);
                        rowscount = grid.rows.length;
                        //alert($(this).closest('tr').find('td:eq(2)').text());
                        var amt = $(this).closest('tr').find('td:eq(2)').text();
                        sum += parseFloat(amt);
                        for (var i = 3; i <= rowscount; i++) {

                            if ($('tr:nth-child(' + i + ') td:nth-child(2) input').val() == 6) {
                                c1 = parseFloat(check) * parseFloat($('tr:nth-child(' + i + ') td:nth-child(4) input').val());
                                // alert(check);

                            }
                            else {
                                c1 = $('tr:nth-child(' + i + ') td:nth-child(4) input').val();
                            }

                            disamt = parseFloat(disamt) + parseFloat(c1);

                        }
                        //alert(sum);

                        if ((parseFloat((cal1)) - parseFloat(disamt)) < 0) {
                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(0.00);
                        } else {
                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(parseFloat((cal1)) - parseFloat(disamt));
                        }
                        disamt = 0;

                        var checkvalue = $(this).closest('tr').find('td:eq(1) span:first-child').text();

                        $(this).closest('tr').find('td:eq(1)').css("background-color", "Green");
                        $(this).closest('tr').find('td:eq(2)').css("background-color", "Green");

                        //alert(parseFloat(amt) - parseFloat(disamt));
                        //alert(parseFloat(c1));
                        //alert($('#ctl00_ContentPlaceHolder1_txtpayablefee').val());

                        if ($('#ctl00_ContentPlaceHolder1_txtpayablefee').val() < 0) {
                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val('0.00')
                            // return;
                        }

                        $("#ctl00_ContentPlaceHolder1_grdclass tr:has(td)").each(function () {

                            $(this).closest('tr').find('td:contains(' + checkvalue + ')').css("background-color", "Green");

                        });

                    }

                    else {

                        checkvalue = $(this).closest('tr').find('td:eq(1) span:first-child').text();

                        $("#ctl00_ContentPlaceHolder1_grdclass tr:has(td)").each(function () {

                            $(this).closest('tr').find('td:contains(' + checkvalue + ')').css("background-color", "White");

                        });

                        $(this).closest('tr').find('td:eq(1)').css("background-color", "White");
                        $(this).closest('tr').find('td:eq(2)').css("background-color", "White");
                        sum = 0;
                        disamt = 0;
                        amt = 0;
                        if ($('#ctl00_ContentPlaceHolder1_txtpayablefee').val() < 0) {

                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val('0.00');
                        }

                        var amt = $(this).closest('tr').find('td:eq(2)').text();

                        //alert(amt);
                        var GridId = "<%=grdDetails.ClientID %>";
                        var grid = document.getElementById(GridId);
                        rowscount = grid.rows.length;
                        for (var i = 3; i <= rowscount; i++) {

                            // discount = discount + "," + $('tr:nth-child(' + i + ') td:nth-child(4) input').val();
                            c1 = $('tr:nth-child(' + i + ') td:nth-child(4) input').val();
                            disamt = parseFloat(disamt) + parseFloat(c1);

                            //alert(disamt);
                        }
                        //alert(parseFloat(amt));

                        if (parseFloat($('#ctl00_ContentPlaceHolder1_txtpayablefee').val()) - parseFloat(amt) < 0) {
                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(0.00).toFixed(2);

                        }
                        else {
                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(parseFloat($('#ctl00_ContentPlaceHolder1_txtpayablefee').val()) - parseFloat(amt)).toFixed(2);
                        }
                        if ($('#ctl00_ContentPlaceHolder1_txtpayablefee').val() < 0) {
                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val('0.00');
                        }
                    }

                });

                //$('.chkItem').click(function () {

                //    alert("sds");
                //    $('#ctl00_ContentPlaceHolder1_grd1 tr:nth-child(2)');
                //    alert($('tr:nth-child(2) td:nth-child(2) input').val());
                //});

                $('.abc').on("click", function (e) {
                    var lbltext = $('#ctl00_ContentPlaceHolder1_lbDiscount').html();

                    //alert(lbltext.trim());

                    if (lbltext.trim() == "Set Discount") {
                        var cal1 = 0;
                        $('#<%=grd1.ClientID%>').find("input:checkbox").each(function () {

                            //alert($(this).closest('tr').find('td:eq(2)').text());
                            if ($(this).is(':checked')) {

                                var amt1 = $(this).closest('tr').find('td:eq(2)').text();
                                cal1 += parseFloat(amt1);

                            }
                        });

                        $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(cal1);

                        var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;

                        $('#ctl00_ContentPlaceHolder1_lbDiscount').html("Cancel");
                        // $('#ctl00_ContentPlaceHolder1_grdDetails').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_grdclass').css("display", "block");

                        if (sid != 0) {
                            $("#ctl00_ContentPlaceHolder1_Table2").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_Table3").css("display", "block");

                            //$("#ctl00_ContentPlaceHolder1_Table1").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_Label1").css("display", "none");

                            if ($("#ctl00_ContentPlaceHolder1_txtRegNo").text != null) {
                                $.ajax({
                                    type: "POST",
                                    url: "admissionshort.aspx/BindDatatable",
                                    data: "{'classid':'" + sid + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {
                                        var srno = 1;
                                        $("[id*=grdDetails] tr:gt(1)").remove();
                                        for (var i = 0; i < data.d.length; i++) {
                                            var row = $("[id*=grdDetails] tr:eq(1)").clone(true);
                                            var hdval = data.d[i].cfid;
                                            var hdid = "";
                                            if (srno < 10) {
                                                hdid = "ctl00_ContentPlaceHolder1_grdDetails_ctl0" + srno + "_HD1";
                                            }
                                            else {
                                                hdid = "ctl00_ContentPlaceHolder1_grdDetails_ctl" + srno + "_HD1";
                                            }

                                            $("[id$=grdDetails]").append(row);
                                            $(row).find(".clslblSrNo").html(srno);
                                            $(row).find(".clslblfeename").html(data.d[i].feename);
                                            $(row).find(".clslblfeenamefeeid").html(data.d[i].cfid);
                                            $(row).find("td:eq(1) input").attr("id", hdid);
                                            $(row).find("td:eq(1) input").val(hdval);
                                            $(row).find(".clslblfeeamount").html(parseFloat(data.d[i].fees).toFixed(2));
                                            srno = parseInt(srno) + 1;
                                        }
                                        $("[id*=grdDetails] tr").show();
                                        $("[id*=grdDetails] tr:eq(1)").hide();
                                    },
                                    error: function (result) {
                                        alert("Error");
                                    }
                                });
                            }
                        }
                        if (sid == 0) {
                            // alert("dsd");
                            $("#ctl00_ContentPlaceHolder1_Label1").text("Please select class first.!");
                            $('#ctl00_ContentPlaceHolder1_grdDetails').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lbDiscount').html("Set Discount");
                            $('#ctl00_ContentPlaceHolder1_Table2').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_Table3').css("display", "none");

                            $('#ctl00_ContentPlaceHolder1_Label1').css("display", "block");

                        }
                        return false;
                    }

                    else {
                        var cal1 = 0;

                        // alert(lbltext.trim());

                        $('#<%=grd1.ClientID%>').find("input:checkbox").each(function () {

                            //alert($(this).closest('tr').find('td:eq(2)').text());
                            if ($(this).is(':checked')) {

                                var amt1 = $(this).closest('tr').find('td:eq(2)').text();
                                cal1 += parseFloat(amt1);

                            }
                        });

                        $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(cal1);

                        $('#ctl00_ContentPlaceHolder1_grdDetails').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_lbDiscount').html("Set Discount");
                        $("#ctl00_ContentPlaceHolder1_Label1").css("display", "none");
                        //$("#ctl00_ContentPlaceHolder1_Table2").css("display", "none");
                        //$("#ctl00_ContentPlaceHolder1_Table1").css("display", "none");
                        //$("#ctl00_ContentPlaceHolder1_Table3").css("display", "none");
                        //alert("dd");

                        return false;
                    }

                });

                $("#ctl00_ContentPlaceHolder1_txtpaimat").on('change', function () {

                    if (parseFloat($("#ctl00_ContentPlaceHolder1_txtpayablefee").val()) < parseFloat($("#ctl00_ContentPlaceHolder1_txtpaimat").val())) {
                        alert("Paid amount cannot greater than payable amount.");
                        $('#ctl00_ContentPlaceHolder1_txtpaimat').val('0.00');
                        return;
                    }

                });

                $("#ctl00_ContentPlaceHolder1_txtRegNo").on('change', function () {
                    var regno = $(this).val();

                    if ($("#ctl00_ContentPlaceHolder1_txtRegNo").text != null) {
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "admissionshort.aspx/checkregitartion",
                            data: "{'regist':'" + regno + "'}",
                            dataType: "json",
                            success: function (data) {

                                if (parseInt(data.d) == parseInt(1)) {

                                    $('#ctl00_ContentPlaceHolder1_lblmsg').text('');
                                    $('#ctl00_ContentPlaceHolder1_lblmsg').css("display", "none");

                                }
                                else {
                                    //alert("no record found");
                                    $('#ctl00_ContentPlaceHolder1_lblmsg').css("display", "block");
                                    $('#ctl00_ContentPlaceHolder1_lblmsg').text('No record found.');
                                    $('#ctl00_ContentPlaceHolder1_txtName').val('');

                                    $('#ctl00_ContentPlaceHolder1_txtmidname').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtLName').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtToDate').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtFname').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtmidname1').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtlastname1').val('');

                                    $('#ctl00_ContentPlaceHolder1_txtmother').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtmidname2').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtlastname2').val('');

                                    $('#ctl00_ContentPlaceHolder1_ddl_Course').find('option:first').attr('selected', 'selected');
                                    $('#ctl00_ContentPlaceHolder1_ddlSection').html('');

                                    $('#ctl00_ContentPlaceHolder1_txtPAddress').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtPZIP').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtmob').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtadmNo').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtOfficer').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtClassSec').val('');

                                    return;
                                }
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });

                        $.ajax({
                            type: "POST",
                            url: "admissionshort.aspx/BindStudentdetail",
                            data: "{'classid':'" + regno + "'}",
                            dataType: 'json',
                            contentType: 'application/json',
                            success: function (data) {
                                $.each(data.d, function (key, value) {

                                    var c = jQuery.parseJSON(data);

                                    $('#ctl00_ContentPlaceHolder1_txtName').val(value.firstname);

                                    $('#ctl00_ContentPlaceHolder1_txtmidname').val(value.middlename);
                                    $('#ctl00_ContentPlaceHolder1_txtLName').val(value.lastname);
                                    $('#ctl00_ContentPlaceHolder1_txtToDate').val(value.dateofbirth);
                                    $('#ctl00_ContentPlaceHolder1_txtFname').val(value.ffirstname);
                                    $('#ctl00_ContentPlaceHolder1_txtmidname1').val(value.fmiddlename);
                                    $('#ctl00_ContentPlaceHolder1_txtlastname1').val(value.flastname);

                                    $('#ctl00_ContentPlaceHolder1_txtmother').val(value.mfirstname);
                                    $('#ctl00_ContentPlaceHolder1_txtmidname2').val(value.MmiddleName);
                                    $('#ctl00_ContentPlaceHolder1_txtlastname2').val(value.mlastname);

                                    if (value.gender == "1") {
                                        $('#<%=rbgender.ClientID %>').find("input[value=" + value.gender + "]").attr("checked", "checked");
                                        //$(':radio[value="' + value.gender + '"]').attr('checked', true);

                                    }
                                    else {
                                        $('#<%=rbgender.ClientID %>').find("input[value=" + value.gender + "]").attr("checked", "checked");
                                        //$(':radio[value="' + value.gender + '"]').attr('checked', 'checked');
                                    }

                                    $('#ctl00_ContentPlaceHolder1_ddl_Course').val(value.classid);

                                    $('#ctl00_ContentPlaceHolder1_lbDiscount').html("Set Discount");

                                    $.ajax({
                                        type: "POST",
                                        url: "admissionshort.aspx/BindDatatable",
                                        data: "{'classid':'" + value.classid + "','transport':'" + 0 + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (data) {
                                            var srno = 1;
                                            var sr = 1;
                                            $("[id*=grdDetails] tr:gt(1)").remove();
                                            for (var i = 0; i < data.d.length; i++) {
                                                var row = $("[id*=grdDetails] tr:eq(1)").clone(true);
                                                var hdval = data.d[i].cfid;
                                                var hdid = "";
                                                var txt1 = ""
                                                if (srno < 10) {
                                                    hdid = "ctl00_ContentPlaceHolder1_grdDetails_ctl0" + srno + "_HD1";
                                                    // txt1 = "ctl00_ContentPlaceHolder1_grdDetails_ct10" + srno + "_txtDiscount";

                                                    //alert(txt1);

                                                }
                                                else {
                                                    hdid = "ctl00_ContentPlaceHolder1_grdDetails_ctl" + srno + "_HD1";
                                                    //txt1 = "ctl00_ContentPlaceHolder1_grdDetails_ctl" + srno + "_txtDiscount";
                                                }

                                                $("[id$=grdDetails]").append(row);
                                                $(row).find(".clslblSrNo").html(srno);
                                                $(row).find(".clslblfeename").html(data.d[i].feename);
                                                $(row).find(".clslblfeenamefeeid").html(data.d[i].cfid);
                                                //$(row).find("td:eq(3) input").attr("id", txt1);
                                                $(row).find("td:eq(1) input").attr("id", hdid);
                                                $(row).find("td:eq(1) input").val(hdval);
                                                $(row).find(".clslblfeeamount").html(parseFloat(data.d[i].fees).toFixed(2));
                                                srno = parseInt(srno) + 1;
                                                sr = parseInt(sr) + 1;
                                            }
                                            $("[id*=grdDetails] tr").show();
                                            $("[id*=grdDetails] tr:eq(1)").hide();

                                            $("#ctl00_ContentPlaceHolder1_grdDetails").css("display", "block");
                                            $('#ctl00_ContentPlaceHolder1_Table2').css("display", "block");
                                            //for (var i = 0; i < data.d.length; i++) {
                                            //    $("ctl00_ContentPlaceHolder1_gvDetails").append("<tr><td>" + data.d[i].feename + "</td><td>" + data.d[i].fees + "</td></tr>");
                                            //    alert(data.d[i].feename);
                                            //}

                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });

                                    $.ajax({
                                        type: "POST",
                                        url: "admissionshort.aspx/bindpay",
                                        data: "{'classid':'" + value.classid + "','transport':'" + 0 + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",

                                        success: function (data) {

                                            $("[id*=grd1] tr:gt(1)").remove();
                                            var hdid = "";
                                            var srno = 1;
                                            for (var i = 0; i < data.d.length; i++) {
                                                var row = $("[id*=grd1] tr:eq(1)").clone(true);

                                                $("[id$=grd1]").append(row);
                                                $(row).find(".clsmonthname2").html(data.d[i].month);
                                                $(row).find(".clsmonthid2").html(data.d[i].monthid);

                                                if (srno < 10) {
                                                    hdid = "ctl00_ContentPlaceHolder1_grd1_ctl0" + srno + "_chkclass1";
                                                }
                                                else {
                                                    hdid = "ctl00_ContentPlaceHolder1_grd1_ctl" + srno + "_chkclass1";
                                                }
                                                //alert(hdid);
                                                $(row).find("td:eq(0) input").attr("id", hdid);

                                                if (srno > 1) {

                                                    //$(row).find("#"+hdid+"").prop('disabled', true);
                                                }

                                                // $(row).find("td:eq(1) input").attr("id", hdid);

                                                $(row).find(".clspay2").html(parseFloat(data.d[i].fees).toFixed(2));
                                                $(row).find(".clspay3").html(parseFloat(data.d[i].fees).toFixed(2));
                                                srno = parseInt(srno) + 1;
                                            }
                                            $("[id*=grd1] tr").show();
                                            $("[id*=grd1] tr:eq(1)").hide();

                                            $("#ctl00_ContentPlaceHolder1_Table3").css("display", "block");
                                            $('#ctl00_ContentPlaceHolder1_grd1').css("display", "block");

                                        },
                                        error: function (result) {

                                            alert("Error");
                                        }
                                    });

                                    $.ajax({
                                        type: "POST",
                                        url: "admissionshort.aspx/Bindfeestructure",
                                        data: "{'classid':'" + value.classid + "','transport':'" + 0 + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (data) {
                                            var srno = 1;
                                            //$("[id*=grdclass] tr:gt(1)").remove();
                                            $("[id*=grdclass] tr:gt(1)").remove();
                                            for (var i = 0; i < data.d.length; i++) {
                                                var row = $("[id*=grdclass] tr:eq(1)").clone(true);

                                                $("[id$=grdclass]").append(row);

                                                $(row).find(".clslblSrNo1").html(srno);

                                                $(row).find(".clslblmonth1").html(data.d[i].month);
                                                $(row).find(".clslblfeename1").html(data.d[i].feename);
                                                $(row).find(".clslblfee1").html(parseFloat(data.d[i].fees).toFixed(2));
                                                srno = parseInt(srno) + 1;
                                            }
                                            $("[id*=grdclass] tr").show();
                                            $("[id*=grdclass] tr:eq(1)").hide();

                                            $("#ctl00_ContentPlaceHolder1_grdclass").css("display", "block");
                                            //$('#ctl00_ContentPlaceHolder1_Table1').css("display", "block");

                                            //$("#ctl00_ContentPlaceHolder1_Table1").css("display", "none");

                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });

                                    $('#ctl00_ContentPlaceHolder1_txtPAddress').val(value.Address);

                                    $('#ctl00_ContentPlaceHolder1_ddlCountry1').val(value.countryid);
                                    $('#ctl00_ContentPlaceHolder1_ddl_state').val(value.stateid);

                                    var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_state").value;

                                    // alert(sid);

                                    if (sid == "0") {
                                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children('option:not(:first)').remove();
                                        return;
                                    }
                                    else {
                                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children().remove();
                                    }

                                    $.ajax(
                                       {
                                           type: "POST",
                                           contentType: "application/json; charset=utf-8",
                                           url: "common.aspx/bindcity",
                                           data: "{'sid':'" + sid + "'}",
                                           dataType: "json",
                                           success: function (data) {
                                               $("#ctl00_ContentPlaceHolder1_ddlCity1").html("");
                                               $.each(data.d, function (key, value1) {
                                                   $("#ctl00_ContentPlaceHolder1_ddlCity1").append($("<option></option>").val(value1.CTID).html(value1.cityName));
                                               });
                                               $('#ctl00_ContentPlaceHolder1_ddlCity1').val(value.cityid);
                                           },
                                           error: function (result) {
                                               alert("Error");
                                           }
                                       });

                                    $('#ctl00_ContentPlaceHolder1_txtPZIP').val(value.pincode);
                                    $('#ctl00_ContentPlaceHolder1_txtmob').val(value.Fmobileno);

                                    $('#ctl00_ContentPlaceHolder1_txtadmNo').val("HMS/" + parseInt(value.rid + 1));

                                    if (value.classid != "") {
                                        var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Course").value;

                                        $.ajax({
                                            type: "POST",
                                            contentType: "application/json; charset=utf-8",
                                            url: "admissionshort.aspx/bindsection",
                                            data: "{'sid':'" + sid + "'}",
                                            dataType: "json",
                                            success: function (data) {
                                                $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                                                $.each(data.d, function (key, value) {
                                                    $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.SID).html(value.sectionname));
                                                });
                                            },
                                            error: function (result) {
                                                alert("Error");
                                            }
                                        });

                                    }
                                    return;
                                });

                            }

                        });

                    }

                });

                $(".txdiscount").on('change', function () {

                    var discnt = 0;
                    var discnt1 = "";
                    var amt = "";
                    amt = $(this).closest('tr').find('td:eq(2)').text();
                    if ($(this).parent("td").parent("tr").find(".txdiscount").val() == "") {

                        $(this).parent("td").parent("tr").find(".txdiscount").val(0.00);

                    }
                    discnt1 = $(this).parent("td").parent("tr").find(".txdiscount").val();

                    if (parseFloat(discnt1) >= parseFloat(amt)) {

                        alert("Discount amount cannot be greater than fee amount.!");
                        $(this).val("0.00");
                        return;
                        //$(this).parent("td").parent("tr").find(".txdiscount").val("0.00");

                    }

                    $(".txdiscount").each(function () {

                        var amt1 = "";

                        discnt = parseFloat(discnt) + parseFloat($(this).parent("td").parent("tr").find(".txdiscount").val());
                        //alert(discnt);

                        // alert("hi");

                        // alert(amt);
                        var tot1 = $("#ctl00_ContentPlaceHolder1_txtpayablefee").val();
                        var cal1 = 0

                        //alert(discnt);
                        if (discnt >= 0) {

                            //$("#<%=grdDetails.ClientID%> input[id*='checkbox']:checkbox").each(function()
                            $('#<%=grd1.ClientID%>').find("input:checkbox").each(function () {

                                //alert($(this).closest('tr').find('td:eq(2)').text());
                                if ($(this).is(':checked')) {

                                    var amt1 = $(this).closest('tr').find('td:eq(2)').text();
                                    cal1 += parseFloat(amt1);

                                }

                                if ($('#ctl00_ContentPlaceHolder1_txtpayablefee').val() < 0) {
                                    $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(0.00);
                                }

                            });

                            if (discnt == "0.00" || discnt == "0") {

                                $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(parseFloat(cal1));
                            }
                            else {
                                //alert(cal1);
                                $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(parseFloat(cal1) - parseFloat(discnt));
                            }
                            if (parseFloat(discnt1) >= parseFloat(amt)) {

                                alert("Discount amount cannot be greater than fee amount.!");
                                //$(this).closest('tr').find('td:eq(2)').find(".txdiscount").val("0.00");
                                //$(this).parent("td").parent("tr").find(".txdiscount").val("0.00");

                            }
                            else if (discnt1 < 0) {
                                alert("Discount amount cannot be less than zero.");
                                //$(this).parent("td").parent("tr").find(".txdiscount").val("0.00");
                            }

                        }

                        if ($("#ctl00_ContentPlaceHolder1_txtpayablefee").val() < 0) {
                            $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(0.00);
                        }

                    });
                });

                $("#ctl00_ContentPlaceHolder1_ddlMonth").change(function () {

                    var mid = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;

                    if (mid == "--Month--") {

                        $("#ctl00_ContentPlaceHolder1_ddlDate").html("");
                        $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option />").text("--Date--"))
                    }
                    if (mid != 0) {
                        $("#ctl00_ContentPlaceHolder1_ddlDate").prop('disabled', false);
                        $.ajax({
                            type: "POST",
                            url: "admissionshort.aspx/monthdetails",
                            data: "{'mid':'" + mid + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                $("#ctl00_ContentPlaceHolder1_ddlDate").html("");
                                $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option />").text("--Date--"));
                                for (var i = 1; i <= data.d; i++) {
                                    $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option />").text(i));

                                }

                            }

                        });

                    }

                });

                $('[id*=rtransportation] input').unbind().click(function (e) {

                    $("#ctl00_ContentPlaceHolder1_ddl_Course").html('');

                    $.ajax(
                                           {
                                               type: "POST",
                                               contentType: "application/json; charset=utf-8",
                                               url: "admissionshort.aspx/binclass",

                                               dataType: "json",
                                               success: function (data) {
                                                   $("#ctl00_ContentPlaceHolder1_ddl_Course").html("");
                                                   $.each(data.d, function (key, value1) {
                                                       $("#ctl00_ContentPlaceHolder1_ddl_Course").append($("<option></option>").val(value1.SID1).html(value1.statename1));
                                                   });
                                                   // $('#ctl00_ContentPlaceHolder1_ddlCity1').val(value.cityid);
                                               },
                                               error: function (result) {
                                                   alert("Error");
                                               }
                                           });

                    $("#ctl00_ContentPlaceHolder1_bankdetail").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_ddlPayMode").val(0);
                    $("#ctl00_ContentPlaceHolder1_txtpaimat").val(0);
                    $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(0);
                    $("#ctl00_ContentPlaceHolder1_txtBankName").val('');
                    $("#ctl00_ContentPlaceHolder1_txtCheque").val('');
                    $("#ctl00_ContentPlaceHolder1_ddlSection").html("");

                });

                $("#ctl00_ContentPlaceHolder1_Button2").click(function () {

                    if (document.getElementById('<%=txtName.ClientID %>').value.trim() == 0) {
                        alert("Please enter student first name.");
                        document.getElementById('<%=txtName.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtLName.ClientID %>').value.trim() == 0) {
                        alert("Please enter student last name.");
                        document.getElementById('<%=txtLName.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtToDate.ClientID %>').value.trim() == 0) {
                        alert("Please Enter Date of Birth.");
                        document.getElementById('<%=txtToDate.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtFname.ClientID %>').value.trim() == 0) {
                        alert("Please enter father first name.");
                        document.getElementById('<%=txtFname.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtlastname1.ClientID %>').value.trim() == 0) {
                        alert("Please enter father last name.");
                        document.getElementById('<%=txtlastname1.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddl_Course.ClientID %>').value == 0) {
                        alert("Please select class.");
                        document.getElementById('<%=ddl_Course.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddlSection.ClientID %>').value == 0) {
                        alert("Please select Section.");
                        document.getElementById('<%=ddlSection.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtPAddress.ClientID %>').value.trim() == 0) {
                        alert("Please enter address.");
                        document.getElementById('<%=txtPAddress.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=ddlCountry1.ClientID %>').value == 0) {
                        alert("Please select Country.");
                        document.getElementById('<%=ddlCountry1.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=ddl_state.ClientID %>').value == 0) {
                        alert("Please select State.");
                        document.getElementById('<%=ddl_state.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=ddlCity1.ClientID %>').value == 0) {
                        alert("Please select city.");
                        document.getElementById('<%=ddlCity1.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtPZIP.ClientID %>').value.trim() == 0) {
                        alert("Please eneter pin code!");
                        document.getElementById('<%=txtPZIP.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtmob.ClientID %>').value.trim() == 0) {
                        alert("Please enter mobile number.");
                        document.getElementById('<%=txtmob.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddlMonth.ClientID %>').value == 0) {
                        alert("Please select month.");
                        document.getElementById('<%=ddlMonth.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddlDate.ClientID %>').value == 0) {
                        alert("Please select Date.");
                        document.getElementById('<%=ddlDate.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddlYear.ClientID %>').value == 0) {
                        alert("Please select Year.");
                        document.getElementById('<%=ddlYear.ClientID %>').focus();
                        return false;
                    }

                    $('#ctl00_ContentPlaceHolder1_payfeehere').css("display", "block");

                    $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "none");

                    return false;
                });

                $("#ctl00_ContentPlaceHolder1_Button3").click(function () {

                    $('#ctl00_ContentPlaceHolder1_payfeehere').css("display", "none");

                    $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "block");

                    return false;
                });

                $("#ctl00_ContentPlaceHolder1_Button4").click(function () {

                    // alert($("#ctl00_ContentPlaceHolder1_txtName").val() + " " + $("#ctl00_ContentPlaceHolder1_txtmidname").val() + " " + $("#ctl00_ContentPlaceHolder1_txtLName").val());
                    if (document.getElementById('<%=txtName.ClientID %>').value.trim() == 0) {
                        alert("Please enter student first name.");
                        document.getElementById('<%=txtName.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtLName.ClientID %>').value.trim() == 0) {
                        alert("Please enter student last name.");
                        document.getElementById('<%=txtLName.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtToDate.ClientID %>').value.trim() == 0) {
                        alert("Please Enter Date of Birth.");
                        document.getElementById('<%=txtToDate.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtFname.ClientID %>').value.trim() == 0) {
                        alert("Please enter father first name.");
                        document.getElementById('<%=txtFname.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtlastname1.ClientID %>').value.trim() == 0) {
                        alert("Please enter father last name.");
                        document.getElementById('<%=txtlastname1.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddl_Course.ClientID %>').value == 0) {
                        alert("Please select class.");
                        document.getElementById('<%=ddl_Course.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddlSection.ClientID %>').value == 0) {
                        alert("Please select Section.");
                        document.getElementById('<%=ddlSection.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtPAddress.ClientID %>').value.trim() == 0) {
                        alert("Please enter address.");
                        document.getElementById('<%=txtPAddress.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=ddlCountry1.ClientID %>').value == 0) {
                        alert("Please select Country.");
                        document.getElementById('<%=ddlCountry1.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=ddl_state.ClientID %>').value == 0) {
                        alert("Please select State.");
                        document.getElementById('<%=ddl_state.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=ddlCity1.ClientID %>').value == 0) {
                        alert("Please select city.");
                        document.getElementById('<%=ddlCity1.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtPZIP.ClientID %>').value.trim() == 0) {
                        alert("Please eneter pin code!");
                        document.getElementById('<%=txtPZIP.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtmob.ClientID %>').value.trim() == 0) {
                        alert("Please enter mobile number.");
                        document.getElementById('<%=txtmob.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddlMonth.ClientID %>').value == 0) {
                        alert("Please select month.");
                        document.getElementById('<%=ddlMonth.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddlDate.ClientID %>').value == 0) {
                        alert("Please select Date.");
                        document.getElementById('<%=ddlDate.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=ddlYear.ClientID %>').value == 0) {
                        alert("Please select Year.");
                        document.getElementById('<%=ddlYear.ClientID %>').focus();
                        return false;
                    }

                    $("#ctl00_ContentPlaceHolder1_regno1").text($("#ctl00_ContentPlaceHolder1_txtRegNo").val());
                    $("#ctl00_ContentPlaceHolder1_lblappname1").text($("#ctl00_ContentPlaceHolder1_txtName").val() + " " + $("#ctl00_ContentPlaceHolder1_txtmidname").val() + " " + $("#ctl00_ContentPlaceHolder1_txtLName").val());

                    $("#ctl00_ContentPlaceHolder1_lbldob1").text($("#ctl00_ContentPlaceHolder1_txtToDate").val());
                    $("#ctl00_ContentPlaceHolder1_lblfather1").text($("#ctl00_ContentPlaceHolder1_txtFname").val() + " " + $("#ctl00_ContentPlaceHolder1_txtmidname1").val() + " " + $("#ctl00_ContentPlaceHolder1_txtlastname1").val());
                    $("#ctl00_ContentPlaceHolder1_lblmother1").text($("#ctl00_ContentPlaceHolder1_txtmother").val() + " " + $("#ctl00_ContentPlaceHolder1_txtmidname2").val() + " " + $("#ctl00_ContentPlaceHolder1_txtlastname2").val());

                    if ($("#ctl00_ContentPlaceHolder1_rbgender :checked").val() == 1) {
                        $("#ctl00_ContentPlaceHolder1_lblgnder1").text('Mail');

                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblgnder1").text('Femail');
                    }

                    $("#ctl00_ContentPlaceHolder1_lblclass1").text($("#ctl00_ContentPlaceHolder1_ddl_Course option:selected").text());
                    $("#ctl00_ContentPlaceHolder1_lblsection1").text($("#ctl00_ContentPlaceHolder1_ddlSection option:selected").text());

                    $("#ctl00_ContentPlaceHolder1_lbladdress1").text($("#ctl00_ContentPlaceHolder1_txtPAddress").val());
                    $("#ctl00_ContentPlaceHolder1_lblcountry1").text($("#ctl00_ContentPlaceHolder1_ddlCountry1 option:selected").text());
                    $("#ctl00_ContentPlaceHolder1_lblstate1").text($("#ctl00_ContentPlaceHolder1_ddl_state option:selected").text());
                    $("#ctl00_ContentPlaceHolder1_lblcity1").text($("#ctl00_ContentPlaceHolder1_ddlCity1 option:selected").text());

                    $("#ctl00_ContentPlaceHolder1_lblpincode1").text($("#ctl00_ContentPlaceHolder1_txtPZIP").val());
                    $("#ctl00_ContentPlaceHolder1_lblmobile12").text($("#ctl00_ContentPlaceHolder1_txtmob").val());

                    $("#ctl00_ContentPlaceHolder1_labledateadd").text($("#ctl00_ContentPlaceHolder1_ddlMonth option:selected").text() + " " + $("#ctl00_ContentPlaceHolder1_ddlDate option:selected").text() + " " + $("#ctl00_ContentPlaceHolder1_ddlYear option:selected").text());

                    //$("#ctl00_ContentPlaceHolder1_lblsecclass1").text($("#ctl00_ContentPlaceHolder1_xtClassSec").val());
                    // $("#ctl00_ContentPlaceHolder1_lblsecclass1").text("#ctl00_ContentPlaceHolder1_txtClassSec").val());
                    // $("#ctl00_ContentPlaceHolder1_lbloffice1").text(("#ctl00_ContentPlaceHolder1_txtOfficer").val());

                    $('#ctl00_ContentPlaceHolder1_preview').css("display", "block");

                    $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "none");

                    return false;
                });

                $("#ctl00_ContentPlaceHolder1_Button5").click(function () {

                    $('#ctl00_ContentPlaceHolder1_preview').css("display", "none");

                    $('#ctl00_ContentPlaceHolder1_admissionform').css("display", "block");
                    return false;

                });

                $("#ctl00_ContentPlaceHolder1_Button1").click(function () {

                    if (document.getElementById('<%=ddlPayMode.ClientID %>').value == 0) {
                        alert("Please select Payment mode.");
                        document.getElementById('<%=ddlPayMode.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtpayablefee.ClientID %>').value.trim() == 0) {
                        alert("Please select months!");
                        document.getElementById('<%=txtpayablefee.ClientID %>').focus();
                        return false;
                    }

                    if (document.getElementById('<%=txtpaimat.ClientID %>').value.trim() == 0) {
                        alert("Please enter payable amount!");
                        document.getElementById('<%=txtpaimat.ClientID %>').focus();
                        return false;
                    }

                    if (parseFloat($("#ctl00_ContentPlaceHolder1_txtpayablefee").val()) < parseFloat($("#ctl00_ContentPlaceHolder1_txtpaimat").val())) {
                        alert("amount cannot greater than payable amount.");
                        $('#ctl00_ContentPlaceHolder1_txtpaimat').val('0.00');
                        return false;
                    }

                    var lbltext = $('#ctl00_ContentPlaceHolder1_lbDiscount').html();
                    // alert(lbltext);

                    var mode = $("#ctl00_ContentPlaceHolder1_txtName").val();

                    var smname = $("#ctl00_ContentPlaceHolder1_txtmidname").val();
                    var slname = $("#ctl00_ContentPlaceHolder1_txtLName").val();
                    var sdob = $("#ctl00_ContentPlaceHolder1_txtToDate").val();
                    var sfname = $("#ctl00_ContentPlaceHolder1_txtFname").val();
                    var sfmname = $("#ctl00_ContentPlaceHolder1_txtmidname1").val();
                    var sflname = $("#ctl00_ContentPlaceHolder1_txtlastname1").val();
                    var smfname = $("#ctl00_ContentPlaceHolder1_txtmother").val();
                    var smmname = $("#ctl00_ContentPlaceHolder1_txtmidname2").val();
                    var smlname = $("#ctl00_ContentPlaceHolder1_txtlastname2").val();

                    var sgender = $("#ctl00_ContentPlaceHolder1_rbgender :checked").val();

                    var transport = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();

                    var scourse = $("#ctl00_ContentPlaceHolder1_ddl_Course option:selected").text();

                    var sclassid = $("#ctl00_ContentPlaceHolder1_ddl_Course").val();
                    var ssecnme = $("#ctl00_ContentPlaceHolder1_ddlSection option:selected").text();
                    var ssecid = $("#ctl00_ContentPlaceHolder1_ddlSection").val()

                    var saddress = $("#ctl00_ContentPlaceHolder1_txtPAddress").val();

                    var scounty = $("#ctl00_ContentPlaceHolder1_ddlCountry1 option:selected").text();
                    var scid = $("#ctl00_ContentPlaceHolder1_ddlCountry1").val()

                    var sstate = $("#ctl00_ContentPlaceHolder1_ddl_state option:selected").text();
                    var sstatid = $("#ctl00_ContentPlaceHolder1_ddl_state").val()

                    var scity = $("#ctl00_ContentPlaceHolder1_ddlCity1 option:selected").text();
                    var scityid = $("#ctl00_ContentPlaceHolder1_ddlCity1").val()

                    var szipcod = $("#ctl00_ContentPlaceHolder1_txtPZIP").val();

                    var smoble = $("#ctl00_ContentPlaceHolder1_txtmob").val();

                    var paidamount = $("#ctl00_ContentPlaceHolder1_txtpaimat").val();
                    var payable = $("#ctl00_ContentPlaceHolder1_txtpayablefee").val();

                    var modeid = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;
                    var checkno = "";
                    var bankname = "";
                    if (modeid == "1") {

                    }
                    else if (modeid == "2") {
                        bankname = $("#ctl00_ContentPlaceHolder1_txtBankName").val();
                        checkno = $("#ctl00_ContentPlaceHolder1_txtCheque").val();
                    }

                    else if (modeid == "3") {
                        bankname = $("#ctl00_ContentPlaceHolder1_txtBankName").val();
                        checkno = $("#ctl00_ContentPlaceHolder1_txtCheque").val();

                    }

                    var pymode = $("#ctl00_ContentPlaceHolder1_ddlPayMode option:selected").text();

                    var ffid = "";
                    var feenm = "";
                    var feamt = "";

                    ///  gridview discount ////////////////

                    var inputs = $('#ctl00_ContentPlaceHolder1_grdDetails').getele
                    // alert(lbltext.trim());
                    if (lbltext.trim() == "Set Discount") {
                        var feeid = "";
                        var feenm = "";
                        var feamt = "";
                        var discount = "";
                        var checkbox1 = "";
                        var checkbox2 = "";

                        var GridId = "<%=grdDetails.ClientID %>";
                        var grid = document.getElementById(GridId);
                        rowscount = grid.rows.length;

                        for (var i = 3; i <= rowscount; i++) {

                            var row = $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ')'); // skip the header row

                            feeid = feeid + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(2) input').val();
                            feenm = feenm + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(2) span').text();
                            feamt = feamt + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(3) span').text();
                            discount = discount + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(4) input').val();
                            // checkbox2= checkbox2 + "," + $('tr:nth-child(' + i + ') td:nth-child(4) span.checked');
                            if ($('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(4) input:checkbox').is(':checked')) {

                                checkbox2 = checkbox2 + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(4) span').text();
                            }
                            else {
                                checkbox2 = checkbox2 + "," + 0;
                            }

                        }
                        feeid = feeid.substring(1, feeid.length);
                        feenm = feenm.substring(1, feenm.length);
                        feamt = feamt.substring(1, feamt.length);
                        discount = discount.substring(1, discount.length);
                        checkbox2 = checkbox2.substring(1, checkbox2.length);

                    }
                    var month = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;
                    var dte = $("#ctl00_ContentPlaceHolder1_ddlDate option:selected").text();
                    var year = $("#ctl00_ContentPlaceHolder1_ddlYear option:selected").text();
                    var admdate = year + "-" + month + "-" + dte;

                    var paymonthids = "";

                    $('#<%=grd1.ClientID%>').find("input:checkbox").each(function () {

                        if ($(this).is(':checked')) {
                            var amt1 = $(this).closest('tr').find('td:eq(1) span:last-child').text();
                            paymonthids = paymonthids + "," + amt1;
                        }
                    });

                    paymonthids = paymonthids.substring(1, paymonthids.length);

                    //alert(monid);
                    // return false;
                    var paytypeid = 2
                    var paytypename = "Monthly"
                    var myData = {};

                    myData.paymodeid = modeid;   // fee paymode
                    myData.paytypeid = paytypeid;
                    myData.paytypename = paytypename;
                    if (modeid == "1") {           // cash
                        myData.bankname = "";
                        myData.checkno = "";
                    }
                    else if (modeid == "2") {      // Draft
                        myData.bankname = bankname;
                        myData.checkno = checkno;
                    }
                    else if (modeid == "3") {           // Checkno
                        myData.bankname = bankname;
                        myData.checkno = checkno;
                    }

                    myData.payableamount = payable;      // fee payable amount
                    myData.paynowamount = paidamount;     // enter paybale amount
                    myData.cpaymonthids = paymonthids;

                    myData.fname = mode;

                    myData.mname = smname;
                    myData.lname = slname;
                    myData.dob = sdob;
                    myData.ffname = sfname;

                    myData.fmname = sfmname;
                    myData.flname = sflname;
                    myData.Mnname = smfname;

                    myData.mmname = smmname;
                    myData.mlname = smlname;
                    myData.gender = sgender;

                    myData.tranType = transport;
                    myData.apclass = scourse;

                    myData.classid = sclassid;
                    myData.section = ssecnme;

                    myData.sectionid = ssecid;
                    myData.address = saddress;
                    myData.country = scounty;

                    myData.countryid = scid;
                    myData.state = sstate;
                    myData.stateid = sstatid;

                    myData.city = scity;

                    myData.cityid = scityid;
                    myData.pinzcode = szipcod;

                    myData.mobile = smoble;

                    myData.feeid = feeid;
                    myData.feeamount = feamt;
                    myData.feename = feenm;
                    myData.discounamount = discount;
                    myData.checkbox2 = checkbox2;
                    myData.admissiondate = admdate;
                    myData.mode = lbltext;

                    //return false;
                    var DTO = { 'theData': myData };
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: 'admissionshort.aspx/insertdata',
                        data: JSON.stringify(DTO),
                        success: function (response) {
                            //alert(response.d);
                            //alert(response.d);
                            if (response.d == "Error during admission") {
                                return false;
                            }
                            if (response.d != "Error during admission") {
                                //alert(response.d);
                                window.location.href = response.d;

                            }
                        },
                        error: function () {

                            alert("Error during admission.");
                            return false;
                        }
                    });
                    return false;
                });
            });
        }
        //alertTest();
    </script>

    <script type="text/javascript" lang="javascript">
        Sys.Application.add_load(alertTest);
    </script>

    <script type="text/javascript">

        function toggle5(showHideDiv, switchImgTag, s1) {
            var ele = document.getElementById(showHideDiv);
            var ele1 = document.getElementById(s1);
            var imageEle = document.getElementById(switchImgTag);

            if (ele.style.display == "none") {

                if (ele1.textContent == "Click here to set discount") {
                    ele1.textContent = "Click here to hide discount";

                }
                else if (ele1.textContent == "Click here to show fee structure") {
                    ele1.textContent = "Click here to hide fee structure";

                }

                ele.style.display = "block";
                imageEle.innerHTML = '<img src="../images/Green_Minus.gif" />';
            }
            else {

                ele.style.display = "none";

                if (ele1.textContent == "Click here to hide fee structure") {
                    ele1.textContent = "Click here to show fee structure";
                }
                else if (ele1.textContent == "Click here to hide discount") {
                    ele1.textContent = "Click here to set discount";
                }

                imageEle.innerHTML = '<img src="../images/addd11.png" />';
            }

        }
    </script>

    <style>
        .frmde {
            color: #676767;
            font-size: 13px;
            font-weight: bold;
            padding: 5px;
        }

        .shadow1 {
            -webkit-box-shadow: 0 0 3px rgba(0,0,0, .35);
            -moz-box-shadow: 0 0 3px rgba(0,0,0, .35);
            box-shadow: 0 0 3px rgba(0,0,0, .35);
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active">New Admission</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>
    <div class="clear">
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <br />
        <div runat="server" id="admissionform">
            <div class="for_sigle_row_form">
                <label>
                    Registration No.(for reference)</label>
                <asp:TextBox ID="txtRegNo" runat="server"></asp:TextBox>
                <asp:HiddenField ID="hfrid" runat="server" Value='<%# Bind("rid") %>' />
                <asp:Label runat="server" ID="lblmsg" ForeColor="Chocolate"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Name of Applicant<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtName" runat="server" CssClass="fname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtmidname" runat="server" CssClass="mname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp
            <asp:TextBox ID="txtLName" runat="server" CssClass="lname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Date of Birth<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtToDate" runat="server" onchange="CalculateAge(this)"></asp:TextBox>
                &nbsp;
           <%-- <asp:Label runat="server" ID="DateTimeLabel" ForeColor="Black" Font-Size="12px"></asp:Label>--%>
                <span id="lblAge"></span>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Father's Name<span style="color: Red">*</span></label>
                <asp:TextBox runat="server" ID="txtFname" CssClass="fname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtmidname1" runat="server" CssClass="mname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtlastname1" runat="server" CssClass="lname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Mother's Name</label>
                <asp:TextBox runat="server" ID="txtmother" CssClass="fname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtmidname2" runat="server" CssClass="mname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtlastname2" runat="server" CssClass="lname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form ">
                <label>
                    Gender<span style="color: Red">*</span></label>
                <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                    <asp:ListItem Selected="True" Value="1">Male</asp:ListItem>
                    <asp:ListItem Value="0">Female</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <div class="for_sigle_row_form ">
                <label>
                    Transportation:</label>
                <asp:RadioButtonList runat="server" ID="rtransportation" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <div class="clear">
            </div>
            <asp:UpdatePanel ID="updr" runat="server">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Applying for Class<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddl_Course" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Section<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddlSection" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Address Line<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Country<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlCountry1">
                        </asp:DropDownList>
                        &nbsp;
                    <asp:Label runat="server" ID="lblCountryMsg" ForeColor="Chocolate" Text=""></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            State/Province<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddl_state" runat="server">
                        </asp:DropDownList>
                        &nbsp;
                    <asp:Label runat="server" ID="lblStateMsg" ForeColor="Chocolate" Text=""></asp:Label>
                        <%--<asp:DropDownList  ID="ddlState1" runat="server"
                                                 onselectedindexchanged="ddlState1_SelectedIndexChanged"></asp:DropDownList>--%>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            City<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlCity1">
                        </asp:DropDownList>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    PIN/ZIP code<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtPZIP" runat="server" MaxLength="8" onkeypress=" return noAlphabets(event)"></asp:TextBox>
                &nbsp;
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtPZIP"
                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Mobile No.<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtmob" runat="server" MaxLength="12" onkeypress=" return noAlphabets(event)"></asp:TextBox>
                &nbsp;
            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="rqd" ControlToValidate="txtmob"
                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>

            <div class="clear"></div>

            <%-- <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <br />
                </div>--%>
            <div id="divas" runat="server">
                <div class="for_sigle_row_form">
                    <label>
                        <h3>
                            <b>For Office USe Only</b></h3>
                    </label>
                </div>
                <div class="clear">
                </div>
                <div class="for_sigle_row_form" style="display: none">
                    <label>
                        Admission No.<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtadmNo" runat="server" onkeypress=" return noAlphabets(event)"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Admission Date<span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlMonth" runat="server" Width="120px">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlDate" runat="server" Width="94px">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlYear" runat="server" Width="105px">
                        <asp:ListItem Value="1">2014</asp:ListItem>
                        <asp:ListItem Value="2">2015</asp:ListItem>
                        <asp:ListItem Value="3">2016</asp:ListItem>
                        <asp:ListItem Value="4">2017</asp:ListItem>
                        <asp:ListItem Value="5">2018</asp:ListItem>
                        <asp:ListItem Value="6">2019</asp:ListItem>
                        <asp:ListItem Value="7">2020</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Class & Section<span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtClassSec" Enabled="false"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Officer Name<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtOfficer" runat="server"></asp:TextBox>
                </div>
            </div>
            <%--  <div class="for_sigle_row_form">
                <label>
                </label>
                <br />
            </div>--%>

            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="Button2" runat="server" CssClass="button_save" Text="Pay" />

                <asp:Button ID="Button4" runat="server" CssClass="button_save" Text="Preview" />
            </div>
        </div>
        <div class="clear">
        </div>

        <div id="preview" runat="server" style="display: none">

            <div class="shadow1" style="width: 42.8%; border: 2px solid #FCFAFA; padding: 5px 20px; margin: 0px auto; background: #fff;">

                <table class="file_border" cellpadding="2" cellspacing="0" border="0" style="min-width: 487px; border-bottom: 1px dashed #DDDDDD; padding: 5px 20px; margin: 0 auto 0 -15px;">

                    <tr>

                        <td>

                            <asp:Label ID="Label3" runat="server" ForeColor="#249cdd" Font-Bold="true" Font-Size="Large" Style="margin-left: 123px;">Form Preview Details</asp:Label>
                        </td>
                    </tr>
                </table>

                <table class="file_border" cellpadding="2" cellspacing="0" border="0" style="min-width: 382px;">

                    <tr>

                        <td class="frmde" style="text-align: right;">Registration No.(for reference) :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="regno1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="frmde" style="text-align: right;">Name of Applicant :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblappname1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="frmde" style="text-align: right;">Date of Birth :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lbldob1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">

                            <b>Father's Name :</b>
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblfather1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">Mother's Name :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblmother1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">Gender :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblgnder1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">Applying Class :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblclass1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">Section :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblsection1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Address Line :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lbladdress1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Country :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblcountry1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="frmde" style="text-align: right;">State/Province :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblstate1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">City :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblcity1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">PIN/ZIP Code :
                        </td>
                        <td class="frmde">

                            <asp:Label ID="lblpincode1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Mobile No :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblmobile12" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="for_sigle_row_form" style="margin-left: 26%;">
                <label>
                </label>
                <asp:Button ID="Button5" runat="server" CssClass="button_save" Text="Back" />
            </div>
        </div>
        <div class="clear">
        </div>
        <div style="display: none; float: left" runat="server" id="payfeehere">
            <div class="for_sigle_row_form">
                <label>
                    <asp:LinkButton runat="server" ID="lbDiscount" CssClass="abc" Text="Set Discount"></asp:LinkButton>
                </label>
                <span id="Label1" runat="server" style="color: chocolate"></span>
            </div>
            <div style="float: left; background: #F7F7F7; border-radius: 0px; border: 1px solid #75ABC8; margin-left: -135px; margin-top: 29px; margin-bottom: 20px; position: relative; padding-top: 30px;">
                <table class="file_border bkrt" cellpadding="1" cellspacing="0" border="0">

                    <tr>
                        <td>
                            <div class="form-box-heading" style="width: 91.7%!important; top: 1px; left: 1px; height: 28px;">Select month for pay</div>

                            <asp:GridView ID="grd1" AutoGenerateColumns="false" BorderWidth="0"
                                runat="server" CssClass="stm" GridLines="None" EmptyDataText="No Month added in this branch" Width="100%">
                                <Columns>

                                    <asp:TemplateField HeaderText="">

                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkclass1" runat="server" CssClass="chkItem" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Month">
                                        <ItemTemplate>
                                            <asp:Label ID="lblmonth" runat="server" CssClass="clsmonthname2" Text='<%# Bind("monthname") %>'></asp:Label>
                                            <asp:Label ID="lblmonthid" runat="server" Style="display: none" CssClass="clsmonthid2" Text='<%# Bind("monthid") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Payable amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPaid1" runat="server" CssClass="clspay2" Text='<%# Bind("credit") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Paid amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPaid" runat="server" CssClass="clspay3" Text='<%# Bind("credit") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>

                            <div class="clear"></div>
                            <div class="for_sigle_row_form1" style="margin-left: 7%; padding-top: 0px;">

                                <label>
                                    Payment Mode:<span style="color: Red">*</span></label>

                                <asp:DropDownList ID="ddlPayMode" runat="server" Height="29px" Width="233px" Style="margin-left: -2px;">
                                    <asp:ListItem Value="0">--Select Payment Mode--</asp:ListItem>
                                    <asp:ListItem Value="1">Cash</asp:ListItem>
                                    <asp:ListItem Value="2">Bank Draft</asp:ListItem>
                                    <asp:ListItem Value="3">Cheque</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="clear"></div>
                            <div id="bankdetail" runat="server" style="display: none; margin-left: 20px;">
                                <div class="for_sigle_row_form1" style="margin-left: 7%; padding-top: 0px;">
                                    <label runat="server" id="ll1">
                                        Bank Name:<span style="color: Red;">*</span></label>
                                    <asp:TextBox runat="server" ID="txtBankName" Height="29px" Width="226px" onkeypress="ValidateAlpha()" Style="padding: 2px; margin-left: -2px;"></asp:TextBox>
                                </div>
                                <div class="clear"></div>
                                <div id="Div3" runat="server" style="margin-left: -30px;">
                                    <div class="for_sigle_row_form1" style="margin-left: 7%; padding-top: 0px;">
                                        <label runat="server" id="ll2">
                                            Draft/Check NO:<span style="color: Red;">*</span></label>
                                        <asp:TextBox runat="server" Height="29px" Width="226px" ID="txtCheque" Style="padding: 2px;"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="clear"></div>
                            <%--<div style="padding:5px 0;width:100px; min-height:auto; margin-left: 20%; margin-right: auto; margin-bottom: 0px; margin-top: 10px;">--%>
                            <div id="Div4" runat="server" style="margin-left: 20px;">
                                <div class="for_sigle_row_form1" style="margin-left: 7%; padding-top: 0px;">
                                    <label>Payable Fee:</label>
                                    <asp:TextBox ID="txtpayablefee" runat="server" Height="29px" Width="226px" Enabled="false" Style="padding: 2px;">0.00</asp:TextBox>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div id="Div5" runat="server" style="margin-left: 40px;">
                                <div class="for_sigle_row_form1" style="margin-left: 7%; padding-top: 0px;">
                                    <label>Amount:<span style="color: Red">*</span></label>
                                    <asp:TextBox ID="txtpaimat" runat="server" Height="29px" Width="226px" onkeypress="return noAlphabets(event)" Style="padding: 2px;">0.00</asp:TextBox>
                                </div>

                                <%--<div class="for_sigle_row_form1" style="padding-top: 0px;margin-left:24%;">

                        <label>
                            Pay Type:<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddlpaystatus" runat="server" Height="29px" Width="233px" Style="margin-left: -2px;">
                            <asp:ListItem Value="0">--Select Pay Type--</asp:ListItem>
                            <asp:ListItem Value="1">Quarterly</asp:ListItem>
                            <asp:ListItem Value="2">Monthly</asp:ListItem>
                        </asp:DropDownList>
                    </div>--%>
                            </div>

                            <div id="Div6" runat="server" style="margin-left: 106px;">
                                <div class="for_sigle_row_form1" style="margin-left: 7%;">
                                    <label>
                                    </label>
                                    <asp:Button ID="Button1" runat="server" CssClass="button_save" Text="Submit" Style="height: 29px" />
                                    <asp:Button ID="Button3" runat="server" CssClass="button_cancel" Text="Back" />
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <div>

                <div id="Div1" style="margin-left: 798px; font-weight: bold; font-size: 15px; color: #249cdd;"><span>Click here to set discount </span></div>
                <div style="margin-left: 90%; margin-top: -2%;">

                    <a id="A1" href="javascript:toggle5('Div2', 'A1','Div1');">
                        <img src="../images/addd11.png" />
                    </a>
                </div>

                <div id="Div2" style="display: none;">
                    <table class="file_border bkrt" cellpadding="2" cellspacing="0" border="0" style="width: 359px; float: right; margin-right: 3px; background: #F7F7F7; border-radius: 0px; border: 1px solid #75ABC8; margin-bottom: 20px; margin-left: 0px; margin-top: 10px; position: relative; padding-top: 30px;" id="Table2">
                        <tr>
                            <td>
                                <div class="form-box-heading" style="width: 90.2%; left: 2px; top: 2px; height: 28px;">Set Discount here</div>

                                <asp:GridView ID="grdDetails" AutoGenerateColumns="false" Width="99%"
                                    CellPadding="0" CellSpacing="0" runat="server" BorderWidth="0"
                                    CssClass="stm" BorderColor="black" class="grdvw" Style="margin-bottom: 2px; margin-left: 2px;">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblperiod" runat="server" Text='<%#Container.DataItemIndex+1 %>' class="clslblSrNo"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="FeeName" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFee" runat="server" Text='<%# Bind("feename") %>' class="clslblfeename"></asp:Label>
                                                <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("CFid") %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="50%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Amount" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>

                                                <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("fees","{0:0.00}") %>' class="clslblfeeamount"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="25%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Set Discount" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                Rs.&nbsp;

                                    <asp:TextBox ID="txtDiscount" class="txdiscount" Width="100px"
                                        runat="server" Text="0" ToolTip="Enter the discount"></asp:TextBox>
                                                <asp:CheckBox ID="chkstatus" CssClass="chekc" Width="100px"
                                                    runat="server" ToolTip="Check if you want discount every month"></asp:CheckBox>
                                                <asp:Label ID="lblfeeid" runat="server" Style="display: none;" Text='<%# Bind("CFid") %>' class="clslblfeenamefeeid"></asp:Label>
                                                <%-- <asp:HiddenField ID="HD2" runat="server" Value='<%# Bind("CFid") %>' />--%>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="30%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="clear"></div>

            <div style="margin-left: -58%; margin-top: 2%; margin-bottom: 20px;">

                <div style="position: absolute; margin-top: -35px;">

                    <div id="h1" style="padding: 10px 0px 0px 575px; font-weight: bold; font-size: 15px; color: #249cdd;">Click here to show fee structure</div>

                    <div style="padding: 0px 0px 0px 810px; margin-top: -16px;">

                        <a id="imageDivLink" href="javascript:toggle5('contentDivImg', 'imageDivLink','h1');">
                            <img src="../images/addd11.png" />
                        </a>
                    </div>
                </div>

                <div id="contentDivImg" style="display: none;">
                    <table runat="server" id="Table1" cellpadding="2" cellspacing="0" border="0" style="width: 62.8%; float: right; background: #F7F7F7; border-radius: 0px; border: 1px solid #75ABC8; margin-bottom: 20px; margin-right: 2px; margin-top: 2px; position: relative; padding-top: 30px;">

                        <tr>
                            <td>
                                <div class="form-box-heading" style="width: 96.8%; left: 2px!important; top: 2px!important; height: 27px!important;">
                                    Annual Fee Structure
                                </div>

                                <asp:GridView ID="grdclass" AutoGenerateColumns="false" BorderWidth="0" Width="99.7%"
                                    runat="server" CssClass="stm" GridLines="None" EmptyDataText="No Month added in this branch" Style="margin-left: 1px; margin-bottom: 2px;">
                                    <Columns>

                                        <asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblperiod" runat="server" Text='<%#Container.DataItemIndex+1 %>' class="clslblSrNo1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Month">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmonth" runat="server" class="clslblmonth1" Text='<%# Bind("monthname") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Fee Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblfeetype" runat="server" class="clslblfeename1" Text='<%# Bind("transtype") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fee">
                                            <ItemTemplate>
                                                <asp:Label ID="lblfee" runat="server" class="clslblfee1" Text='<%# Bind("credit") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" Width="104.0px" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="checkboxgenerate" runat="server" class="checkboxt"></asp:CheckBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" Width="104.0px" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="stm_dark" />
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <AlternatingRowStyle CssClass="stm_light" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="clear"></div>
    </div>
</asp:Content>