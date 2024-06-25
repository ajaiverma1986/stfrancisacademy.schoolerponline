<%@ Page Title="" Language="C#" MasterPageFile="~/ParentPanel/MasterPage.master" AutoEventWireup="true" CodeFile="parentpay.aspx.cs" Inherits="ParentPanel_parentpay" %>

<%@ Register Src="~/ParentPanel/parentuser.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <style>
        label {
            display: inline-block;
            margin-bottom: 5px;
            font-weight: 700;
            width: 53%;
        }
    </style>

    <script type="text/javascript">

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
        function ValidateAlpha() {
            var keyCode = window.event.keyCode;
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32) {
                window.event.returnValue = false;
                alert("Enter only letters");
            }
        }
    </script>

    <script type="text/javascript">

        function check() {

            if (document.getElementById('<%=lblMonthName.ClientID %>').value.trim() == 0) {
                alert("Please select month.");
                document.getElementById('<%=lblMonthName.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlPayMode.ClientID %>').value == 0) {
                alert("Please Select Payment Mode.");
                document.getElementById('<%=ddlPayMode.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtAmount.ClientID %>').value.trim() == 0) {
                alert("Please enter amount.");
                document.getElementById('<%=txtAmount.ClientID %>').focus();
                return false;
            }

            if ($('#ctl00_ContentPlaceHolder1_divbank').css('display') == 'block') {

                if (document.getElementById('<%=txtBankName.ClientID %>').value.trim() == 0) {
                      alert("Please enter Bank Name.");
                      document.getElementById('<%=txtBankName.ClientID %>').focus();
                     return false;

                 }

                 if (document.getElementById('<%=txtCheque.ClientID %>').value.trim() == 0) {
                      alert("Please enter Cheque number.");
                      document.getElementById('<%=txtCheque.ClientID %>').focus();
                     return false;
                 }
             }

         }
    </script>

    <script type="text/javascript">

        function alertTest() {
            var admno = "";
            var monid = "";
            $(document).ready(function () {
                var balanc = 0;
                var sum = 0;
                var sum1 = 0;
                var disamt = 0;
                var c1 = 0;
                $("#<%=grdclass.ClientID %> input:checkbox[id*=chkclass1]").live('click', function () {

                    var cal1 = 0;
                    var monthid = "";
                    var payabamt = $(this).closest('tr').find('td:eq(3) span:last-child').text();
                    var paidamt = $(this).closest('tr').find('td:eq(4) span:last-child').text();

                    $(this).closest('tr').css("background-color", "rgb(160, 242, 220)");

                    if ($(this).is(':checked')) {
                        $('#<%=grdclass.ClientID%>').find("input:checkbox").each(function () {

                            if ($(this).is(':checked')) {
                                var amt1 = $(this).closest('tr').find('td:eq(3)').text();
                                var paidamt = $(this).closest('tr').find('td:eq(4)').text();

                                monthid = monthid + "," + $(this).closest('tr').find('td:eq(1) span:last-child').text();
                                sum1 += parseFloat(paidamt);
                                cal1 += parseFloat(amt1);
                            }

                        });

                        balanc = parseFloat(cal1);

                        $('#ctl00_ContentPlaceHolder1_lblMonthName').val(cal1);
                        monthid = monthid.substring(1, monthid.length);

                        $("#ctl00_ContentPlaceHolder1_lblremainbal").text(0);
                        $("#ctl00_ContentPlaceHolder1_txtAmount").val(0);
                        $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");

                        $('#ctl00_ContentPlaceHolder1_Label3').val(monthid);

                    }
                    else {
                        $('#<%=grdclass.ClientID%>').find("input:checkbox").each(function () {
                            if ($(this).is(':checked')) {
                                var amt1 = $(this).closest('tr').find('td:eq(3)').text();
                                var paidamt = $(this).closest('tr').find('td:eq(4)').text();
                                monthid = monthid + "," + $(this).closest('tr').find('td:eq(1) span:last-child').text();
                                sum1 += parseFloat(paidamt);
                                cal1 += parseFloat(amt1);
                            }
                        });
                        monthid = monthid.substring(1, monthid.length);
                        $('#ctl00_ContentPlaceHolder1_Label3').val(monthid);
                        sum = 0;
                        amt = 0;
                        var amt = $(this).closest('tr').find('td:eq(3)').text();
                        balanc = parseFloat(balanc) - parseFloat($(this).closest('tr').find('td:eq(3) span:last-child').text());
                        // $('#ctl00_ContentPlaceHolder1_Label3').val(monthid) - ($(this).closest('tr').find('td:eq(2) span:last-child').html());;
                        $('#ctl00_ContentPlaceHolder1_lblMonthName').val(balanc);
                        $("#ctl00_ContentPlaceHolder1_txtAmount").val(0);
                        $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                        $(this).closest('tr').css("background-color", "White");
                    }
                });

                var balanc = 0;
                var sum = 0;
                var sum1 = 0;
                var disamt = 0;
                var c1 = 0;
                var sum2 = 0;
                var a2 = 0;
                $("#<%=GridView2.ClientID %> input:checkbox[id*=chkclss]").live('click', function () {
                    monthid = "";
                    sum2 = 0;
                    $('#ctl00_ContentPlaceHolder1_lblMonthName').val(0);
                    if ($(this).is(':checked')) {
                        monthid = "";

                        $('#<%=GridView2.ClientID%>').find("input:checkbox").each(function () {

                            a2 = $(this).parents(".stm_dark").index();
                            if ($(this).is(':checked')) {
                                for (var i = a2; i <= parseInt(a2) + parseInt(2) ; i++) {
                                    if ($("#<%=GridView2.ClientID %> tr:eq(" + i + ")").find('td:eq(2) span:first-child').text() == "Full Paid") {

                                    }
                                    else {
                                        monthid = monthid + "," + $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").find('td:eq(1) span:last-child').text();
                                        var cvalue = $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").find('td:eq(3) span:first-child').text();
                                        sum2 += parseFloat(cvalue);

                                    }

                                    if (i >= 2 && i < 5) {
                                        $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").css("background-color", "Beige");
                                    }
                                    if (i >= 5 && i < 8) {
                                        $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").css("background-color", "Beige");
                                    }
                                    if (i >= 8 && i < 11) {
                                        $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").css("background-color", "Beige");
                                    }

                                    if (i >= 11 && i < 14) {
                                        $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").css("background-color", "Beige");
                                    }

                                }
                            }

                        });

                        balanc = parseFloat(sum2);
                        $('#ctl00_ContentPlaceHolder1_lblMonthName').val(sum2);
                        $("#ctl00_ContentPlaceHolder1_lblremainbal").text(0);
                        $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_txtAmount").val('');
                        //var novalue = 0;
                        //novalue = cal1;
                        //var ch1 = $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val();
                        //novalue = parseFloat(ch1) + parseFloat(novalue)
                        //$("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(novalue);

                    }

                    else {

                        monthid = "";
                        sum2 = 0;
                        var a = "";
                        $('#ctl00_ContentPlaceHolder1_lblMonthName').val(0)
                        $('#<%=GridView2.ClientID%>').find("input:checkbox").each(function () {

                            a = $(this).parents(".stm_dark").index();
                            if ($(this).is(':checked')) {
                                for (var i = a; i <= parseInt(a) + parseInt(2) ; i++) {

                                    var cvalue = $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").find('td:eq(3) span:first-child').text();

                                    sum2 += parseFloat(cvalue);
                                    var amt1 = $(this).closest('tr').find('td:eq(3)').text();
                                    var paidamt = $(this).closest('tr').find('td:eq(4)').text();
                                    if ($("#<%=GridView2.ClientID %> tr:eq(" + i + ")").find('td:eq(2) span:first-child').text() == "Full Paid") {

                                    }
                                    else {
                                        monthid = monthid + "," + $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").find('td:eq(1) span:last-child').text();
                                    }

                                    if (i >= 2 && i < 5) {
                                        $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").css("background-color", "#95E9EC");
                                    }
                                    if (i >= 5 && i < 8) {
                                        $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").css("background-color", "#EAE38E");
                                    }
                                    if (i >= 8 && i < 11) {
                                        $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").css("background-color", "#A0EDA0");
                                    }

                                    if (i >= 11 && i < 14) {
                                        $("#<%=GridView2.ClientID %> tr:eq(" + i + ")").css("background-color", "#B0C4DE");
                                    }
                                }

                                $('#ctl00_ContentPlaceHolder1_lblMonthName').val(parseFloat(sum2));
                                $("#ctl00_ContentPlaceHolder1_txtAmount").val('');
                                $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                                $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                                $('#ctl00_ContentPlaceHolder1_Label3').val('');

                            }
                            $("#ctl00_ContentPlaceHolder1_txtAmount").val(0);
                            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_Label3').val('');

                        });

                    }

                    $('#ctl00_ContentPlaceHolder1_Label3').val(monthid);
                });

                $("#ctl00_ContentPlaceHolder1_ddlPayMode").change(function () {
                    var mode = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;
                    if (mode == 1) {
                        $("#ctl00_ContentPlaceHolder1_divbank").css("display", "none");
                    }
                    else {

                        $("#ctl00_ContentPlaceHolder1_divbank").css("display", "block");
                    }
                });

                $("#ctl00_ContentPlaceHolder1_txtAmount").on('change', function () {

                    var txtvalue = $("#ctl00_ContentPlaceHolder1_txtAmount").val();
                    var payamt = $("#ctl00_ContentPlaceHolder1_lblMonthName").val();
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");

                    if (txtvalue != "") {

                        if (parseFloat(payamt) < parseFloat(txtvalue)) {

                            $("#ctl00_ContentPlaceHolder1_lblremainbal").text("Amount to be paid is greater than balance amount!");
                            $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00")
                            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                            return;
                        }
                        else if (parseFloat(payamt) == parseFloat(txtvalue)) {
                            $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(payamt) - parseFloat(txtvalue));
                            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                        }
                        else if (parseFloat(payamt) > parseFloat(txtvalue)) {
                            $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(payamt) - parseFloat(txtvalue));
                            $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                        }
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                    }
                });
            });
        }
    </script>

    <script type="text/javascript">
        var adid = "";
        $(document).ready(function () {

            $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
            setTimeout(function () {

                $.ajax(
                     {
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         url: "parentpay.aspx/getadid",
                         dataType: "json",
                         success: function (data) {
                             if (data.d != 0) {
                                 adid = parseInt(data.d);
                             }
                             else {

                                 alert("Error");
                                 return false;
                             }

                             getfine();

                             $.ajax(
                                   {
                                       type: "POST",
                                       contentType: "application/json; charset=utf-8",
                                       url: "parentpay.aspx/getpayType",
                                       data: "{'admno':'" + parseInt(adid) + "'}",
                                       dataType: "json",
                                       success: function (data) {
                                           if (data.d == 1) {
                                               filldetails();
                                           }
                                           else {

                                               $.ajax(
                                                    {
                                                        type: "POST",
                                                        contentType: "application/json; charset=utf-8",
                                                        url: "parentpay.aspx/Bindsecondgrid",
                                                        dataType: "json",
                                                        success: function (data) {
                                                            $("[id*=grdclass] tr:gt(1)").remove();
                                                            if (data.d.length > 0) {
                                                                for (var i = 0; i < data.d.length; i++) {
                                                                    var row = $("[id*=grdclass] tr:eq(1)").clone(true);
                                                                    $("[id$=grdclass]").append(row);
                                                                    $(row).find('.monname').html(data.d[i].monthname);
                                                                    $(row).find('.montid').html(data.d[i].monthid);
                                                                    $(row).find('.paystatus').html(data.d[i].paystatus);
                                                                    $(row).find('.paybleamount').html(parseFloat(data.d[i].paybleamount).toFixed(2));
                                                                    $(row).find('.paidamount').html(parseFloat(data.d[i].paidamount).toFixed(2));

                                                                }
                                                                $("[id*=grdclass] tr").show();
                                                                $("[id*=grdclass] tr:eq(1)").hide();

                                                                $("#ctl00_ContentPlaceHolder1_Div1").css("display", "none");
                                                                $("#ctl00_ContentPlaceHolder1_t1").css("display", "block");
                                                                $('#ctl00_ContentPlaceHolder1_txtAmount').val(0.00);
                                                                $("#ctl00_ContentPlaceHolder1_divbank").css("display", "none");
                                                                $("#ctl00_ContentPlaceHolder1_lbfmsg").css("display", "none");
                                                                $('#ctl00_ContentPlaceHolder1_divpay').css("display", "block");
                                                                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                                                return false;
                                                            }
                                                            else {
                                                                $("#ctl00_ContentPlaceHolder1_lbfmsg").text("Fee Already Submitted.");
                                                                $("#ctl00_ContentPlaceHolder1_lbfmsg").css("display", "block");
                                                                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                                                return false;
                                                            }

                                                        },
                                                        error: function (result) {
                                                            alert("Error");
                                                        }
                                                    });
                                           }

                                       }

                                   });

                         }

                     });
                return false;

            }, 600);

            function filldetails() {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "parentpay.aspx/BindDatatable",
                        data: "{'FeType':'" + 5 + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.length > 0) {
                                $("[id*=GridView2] tr:gt(1)").remove();
                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=GridView2] tr:eq(1)").clone(true);
                                    $("[id$=GridView2]").append(row);
                                    $(row).find('.monname11').html(data.d[i].monthname);
                                    if (data.d[i].monthid == 1 || data.d[i].monthid == 4 || data.d[i].monthid == 7 || data.d[i].monthid == 10) {
                                        $(row).find('.chkItem11').css("display", "block");
                                        $(row).find('.lblItem11').css("display", "block");

                                    }
                                    else {
                                        $(row).find('.chkItem11').css("display", "none");
                                        $(row).find('.lblItem11').css("display", "none");
                                    }

                                    if (data.d[i].monthid == 1 || data.d[i].monthid == 2 || data.d[i].monthid == 3) {
                                        $(row).css("background-color", "#95E9EC");
                                        $(row).find('.lblItem11').text("Ist");
                                        $(row).find('.lblItem11').css({ "font-size": "150%" });
                                    }
                                    else
                                        if (data.d[i].monthid == 4 || data.d[i].monthid == 5 || data.d[i].monthid == 6) {
                                            $(row).css("background-color", "#EAE38E");
                                            $(row).find('.lblItem11').text("IInd");
                                            $(row).find('.lblItem11').css({ "font-size": "150%" });
                                        }
                                        else
                                            if (data.d[i].monthid == 7 || data.d[i].monthid == 8 || data.d[i].monthid == 9) {
                                                $(row).css("background-color", "#A0EDA0");
                                                $(row).find('.lblItem11').text("IIIrd");
                                                $(row).find('.lblItem11').css({ "font-size": "150%" });
                                            }
                                            else
                                                if (data.d[i].monthid == 10 || data.d[i].monthid == 11 || data.d[i].monthid == 12) {
                                                    $(row).css("background-color", "#B0C4DE");
                                                    $(row).find('.lblItem11').text("IVth");
                                                    $(row).find('.lblItem11').css({ "font-size": "150%" });
                                                }

                                    $(row).find('.montid').html(data.d[i].monthid);
                                    $(row).find('.paystatus11').html(data.d[i].paystatus);
                                    $(row).find('.paybleamount11').html(parseFloat(data.d[i].paybleamount).toFixed(2));
                                    $(row).find('.paidamount11').html(parseFloat(data.d[i].paidamount).toFixed(2));

                                }
                                $("[id*=GridView2] tr").show();
                                $("[id*=GridView2] tr:eq(1)").hide();
                                $("#ctl00_ContentPlaceHolder1_lbquater").css("display", "block");
                                $("#ctl00_ContentPlaceHolder1_lbquater").text("Quaterly Fees");
                                $('#ctl00_ContentPlaceHolder1_txtAmount').val(0.00);
                                $("#ctl00_ContentPlaceHolder1_divbank").css("display", "none");
                                $("#ctl00_ContentPlaceHolder1_Div1").css("display", "block");
                                $('#ctl00_ContentPlaceHolder1_divpay').css("display", "block");
                                $("#ctl00_ContentPlaceHolder1_t1").css("display", "none");
                                $("#ctl00_ContentPlaceHolder1_lbfmsg").css("display", "none");
                                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                return false;
                            }
                            else {
                                $("#ctl00_ContentPlaceHolder1_lbfmsg").css("display", "block");
                                //  $("#ctl00_ContentPlaceHolder1_btnback").css("display", "block");
                                $("#ctl00_ContentPlaceHolder1_lbfmsg").text("Fee Already Submitted.");
                                $("#ctl00_ContentPlaceHolder1_Div1").css("display", "none");
                                $('#ctl00_ContentPlaceHolder1_divpay').css("display", "none");
                                $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                return false;
                            }
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                return false;
            }

            function getfine() {
                $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "parentpay.aspx/getfine",
                                data: "{'admno':'" + adid + "'}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d[0].fine == 0) {
                                        $("#ctl00_ContentPlaceHolder1_txtfine").val(parseFloat(data.d[0].fine).toFixed(2));
                                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                        return false;
                                    }
                                    else {

                                        $("#ctl00_ContentPlaceHolder1_txtfine").val(parseFloat(data.d[0].fine).toFixed(2));

                                    }

                                }
                            });
                return false;
            }

        });
    </script>

    <style type="text/css">
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 100px;
            height: 750px;
            margin-top: 7px;
        }

        #content_pane {
            background: #fff;
        }

        .chkItem11 {
            margin-left: -46px;
            margin-top: -26px;
            width: 18px;
        }

        .lblItem11 {
            width: 25px;
            margin-left: 0px;
        }
    </style>
    <script type="text/javascript" lang="javascript">
        Sys.Application.add_load(alertTest);
    </script>

    <%--<div class="content_top">
        <ul>
            <li><a style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
             <li style="background: none;"><a class="active">
               Pay Fee<asp:Label ID="lblHeading" runat="server"></asp:Label></a></li>
        </ul>
    </div>--%>

    <div class="page-content" id="contentPane">
        <%--    <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>

        <%-- <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            <asp:Label ID="tblheading" runat="server"></asp:Label>
        </div>--%>

        <div class="page-header">
            <h1>
                <a href="studentviewinfo.aspx">Home</a>
                <small>
                    <i class="ace-icon fa fa-angle-double-right"></i>
                    Pay Fee
                </small>
            </h1>
        </div>

        <div class="row">

            <div class="col-xs-12" style="border-top: 2px solid #2bbce0; border-radius: 3px; background: #fff;">
                <asp:Label ID="lbfmsg" runat="server" ForeColor="Red" Style="display: none;"></asp:Label>

                <div id="divstudentadno1" runat="server">
                </div>
                <div class="col-xs-12 col-sm-4" style="width: 49.333%; margin-top: 5px;" runat="server" id="divpay">
                    <div class="widget-box">
                        <div class="widget-header">
                            <h4 class="widget-title">Pay Amount</h4>
                        </div>

                        <div class="widget-body">
                            <div class="widget-main">
                                <div>
                                    <label for="form-field-8">Payable Fine<span style="color: Red;">*</label>

                                    <asp:TextBox runat="server" ID="txtfine" Enabled="false" ForeColor="Black" Width="213px">0.00</asp:TextBox><span id="errmsg"></span>
                                </div>

                                <hr>

                                <div>
                                    <label for="form-field-9">Payable amount<span style="color: Red;">*</span></label>

                                    <asp:TextBox runat="server" ID="lblMonthName" ForeColor="Black" Enabled="false" Width="213px">0.00</asp:TextBox>
                                </div>

                                <hr>

                                <div>
                                    <label for="form-field-11">Enter amount to be paid<span style="color: Red;">*</span></label>

                                    <asp:TextBox runat="server" ID="txtAmount" onkeypress="return noAlphabets(event)" AutoComplete="off" Height="33px" Width="213px"></asp:TextBox>&nbsp;
                <asp:Label runat="server" ID="Label2" ForeColor="Red"></asp:Label>
                                    <asp:Label runat="server" ID="lblremain" Style="display: none; margin-left: 165px;" ForeColor="Red">Remaining Blanace:</asp:Label>
                                    <asp:Label runat="server" ID="lblremainbal" ForeColor="Red" Style="display: none; margin-left: 295px; margin-top: -10px;"></asp:Label>
                                </div>
                                <hr>
                                <div>
                                    <label for="form-field-9">Payment Mode<span style="color: Red;">*</span><span style="color: Red;">*</span></label>

                                    <asp:DropDownList ID="ddlPayMode" runat="server" Height="28px" Width="212px" Style="padding: 2px;">
                                        <asp:ListItem Value="0">--Select Payment Mode--</asp:ListItem>
                                        <asp:ListItem Value="1">Cash</asp:ListItem>
                                        <asp:ListItem Value="2">Bank Draft</asp:ListItem>
                                        <asp:ListItem Value="3">Cheque</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <hr>

                                <hr>

                                <div id="divbank" runat="server" style="display: none;">
                                    <div>
                                        <label for="form-field-9">Bank Name<span style="color: Red;">*</span> </label>

                                        <asp:TextBox runat="server" ID="txtBankName" onkeypress="ValidateAlpha()" Height="28px" Width="213px" Style="padding: 2px;"></asp:TextBox>
                                    </div>

                                    <hr>
                                    <div>
                                        <label for="form-field-9" runat="server" id="ll2">
                                            Cheque Number<asp:Label runat="server" ID="lblCDd"></asp:Label><span style="color: Red;">*</span></label>
                                        <asp:TextBox runat="server" ID="txtCheque" Height="28px" Width="213px" Style="padding: 2px;"></asp:TextBox>
                                    </div>

                                    <hr />
                                </div>

                                <div>
                                    <label for="form-field-9"></label>
                                    <asp:Button runat="server" ID="Button1" Text="Submit" CssClass="btn btn-primary" OnClick="Button1_Click" OnClientClick="return check();" />&nbsp;&nbsp;
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--<table class="file_border bkrt"  cellpadding="2" cellspacing="0" border="0" style="width: 464px; margin-left: 16px; height: auto; float: left; background: #F7F7F7; border-radius: 0px; border: 1px solid #249cdd; padding-top: 30px; position: relative; margin-top: 30px; display:none;">
            <tr>
                <td>
                    <div class="form-box-heading" style="width: 430px; top: 1px; left: 1px; height: 28px;"><span>Pay Amount</span></div>
                </td>
            </tr>
        </table>--%>

                <div id="t1" runat="server" style="display: none;">

                    <table class="file_border bkrt" runat="server" id="Table1" cellpadding="2" cellspacing="0" border="0" style="height: auto; width: 508px; float: left; background: #F7F7F7; border-radius: 0px; margin-bottom: 185px; border: 1px solid #249cdd; margin-left: 45px; margin-top: 7px; position: relative; padding-top: 30px;">
                        <tr>
                            <td>
                                <div class="table-header">
                                    Select Month for Pay
                                </div>

                                <%-- <div class="form-box-heading" style="width: 473.7px; top: 2px; left: 2px; height: 28px;"><span>Select Month for Pay</span></div>--%>

                                <asp:GridView ID="grdclass" AutoGenerateColumns="false" overflow="scroll"
                                    runat="server" CssClass="table table-striped table-bordered table-hover" GridLines="None" EmptyDataText="No Month added in this branch" Width="99.3%" Style="margin-left: 1.6px; border-left: 1px solid #ddd; margin-bottom: 1px;">
                                    <Columns>

                                        <asp:TemplateField HeaderText="">

                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkclass1" runat="server" CssClass="chkItem" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Month">
                                            <ItemTemplate>
                                                <asp:Label ID="lblsubject123" runat="server" Text='<%# Bind("monthname") %>' CssClass="monname"></asp:Label>
                                                <asp:Label ID="HD12" runat="server" Text='<%# Bind("monthid") %>' CssClass="montid" Style="display: none;" />
                                            </ItemTemplate>
                                            <HeaderStyle />
                                            <ItemStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pay Status">
                                            <ItemTemplate>
                                                <%--  <asp:Label ID="lblpaystatus" runat="server"  CssClass="paystatus" Text=""></asp:Label>--%>
                                                <asp:Label ID="lblpaystatus" runat="server" Text='<%# Bind("paystatus") %>' CssClass="paystatus"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle />
                                            <ItemStyle />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Payable">
                                            <ItemTemplate>
                                                <%--<asp:Label ID="lblPayable" runat="server"  CssClass="paybleamount" Text=""></asp:Label>--%>
                                                <asp:Label ID="lblPayable" runat="server" Text='<%# Bind("payableamount") %>' CssClass="paybleamount"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle />
                                            <ItemStyle />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Paid amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPaid" runat="server" Text='<%# Bind("paidamount") %>' CssClass="paidamount"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle />
                                            <ItemStyle />
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

                <div id="Div1" runat="server" style="display: none;">

                    <table class="file_border bkrt" runat="server" id="Table2" cellpadding="2" cellspacing="0" border="0" style="height: auto; width: 508px; float: left; background: #F7F7F7; border-radius: 0px; margin-bottom: 185px; border: 1px solid #249cdd; margin-left: 31px; position: relative; padding-top: 30px;">
                        <tr>
                            <td>
                                <div class="table-header" style="background-color: #307ecc;">
                                    <div class="clearfix"></div>
                                    <div style="float: left; width: 78%;">Select Quater for Pay   </div>
                                    <div style="float: left; width: 20%;">
                                        <asp:Label ID="lbquater" runat="server" Style="display: none; color: rgb(196, 254, 255);" Font-Underline="true"></asp:Label>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <%-- <div class="form-box-heading" style="width: 473.7px; top: 2px; left: 2px; height: 28px;"><span>Select Quater for Pay</span></div>--%>

                                <asp:GridView ID="GridView2" AutoGenerateColumns="false" overflow="scroll"
                                    runat="server" CssClass="table table-striped table-bordered table-hover" GridLines="None" EmptyDataText="No Month added in this branch" Width="99.3%" Style="margin-left: 1.6px; border-left: 1px solid #ddd; margin-bottom: 1px;">
                                    <Columns>

                                        <asp:TemplateField HeaderText="QuaterFee">

                                            <ItemTemplate>
                                                <asp:Label ID="lbl33" runat="server" Text="" CssClass="lblItem11"></asp:Label>
                                                <asp:CheckBox ID="chkclss" runat="server" CssClass="chkItem11" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Month">
                                            <ItemTemplate>
                                                <asp:Label ID="lblsmonth" runat="server" Text='<%# Bind("monthname") %>' CssClass="monname11"></asp:Label>
                                                <asp:Label ID="HD22" runat="server" Text='<%# Bind("monthid") %>' CssClass="montid" Style="display: none;" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pay Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpaystatus2" runat="server" Text='<%# Bind("paystatus") %>' CssClass="paystatus11"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Payable">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPayable11" runat="server" Text='<%# Bind("payableamount") %>' CssClass="paybleamount11"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Paid amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPaid33" runat="server" Text='<%# Bind("paidamount") %>' CssClass="paidamount11"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
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

                <asp:TextBox ID="Label3" runat="server" Text="" Style="display: none" ForeColor="Red"></asp:TextBox>
            </div>
        </div>
    </div>
    </span>
</asp:Content>