<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="create-new-appoint-letter.aspx.cs" Inherits="BranchPanel_create_new_appoint_letter" %>

<%@ Register Src="~/branchpanel/employee/employee-managemen.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script src="../../js/jquery.com-ui-1.10.0-jquery-ui.js" type="text/javascript"></script>
    <script src="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style type="text/css">
        .activecreateappoint {
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

        .forlabel label {
            float: none;
            margin-left: 5px !important;
        }

        .separator {
            display: block;
            height: 2px;
            background-color: #E6E6E6;
            margin: 10px 0 15px;
        }

        .bg-blue {
            background-color: #006EB8;
        }

        h3.page-title {
            margin: 0;
        }

        .txtblue {
            color: #006EB8;
        }

        .icons {
            width: 20px;
            height: 20px;
            display: block;
            float: left;
            padding: 4px;
            margin-right: 8px;
            position: relative;
            top: -4px;
        }

        .border-blue {
            border: 1px solid #006EB8;
        }

        .fa {
            display: inline-block;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            line-height: 1;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .radius {
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            -ms-border-radius: 50%;
            border-radius: 50%;
        }

        .m-btm-big {
            margin-bottom: 30px;
        }

        .content-wrap {
            padding: 10px 15px;
        }

        #tblforsalarydetails td {
            width: 150px!important;
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
            border: 0px solid #CCCCCC!important;
        }

        .txtfocus {
            border: solid 1px #CCCCCC !important;
        }

        .eductabletxt {
            width: 100%;
            border: none;
            margin-left: 0px;
            text-transform: none!important;
        }

        .captchaclass {
            font-size: 15px!important;
            text-align: center!important;
            border: none!important;
            color: white!important;
            width: 137px!important;
            height: 25px!important;
            background-image: url(../../images/capimage.jpg);
            background-size: 100%!important;
            font-weight: bold!important;
            font-family: Serif;
            font-style: italic;
        }

        .texthover {
            border: solid 1px red !important;
        }
    </style>
    <script type="text/javascript">
        var cid = "0", sid = "0", bindcountryfrom = 0, annualctc = 0, roll = 0, year = 0, month = 0, day = 0;
        var txtqualification = ""
        function pageLoad() {
            FillCtcOnPageLoad();
            filldisig2();

            document.title = 'Add New Employee';
        }

        function checkrowempty() {
            var noofrows = document.getElementById('ctl00_ContentPlaceHolder1_tbl').rows.length;
            if (noofrows > 1) {
                for (var i = 1; i < noofrows; i++) {
                    var noofcells = document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells.length;
                    if (noofcells > 0) {
                        var finalnoofcells = 0;
                        if (i > 1) {
                            finalnoofcells = noofcells - 1;
                        }
                        else {
                            finalnoofcells = noofcells;
                        }
                        for (var j = 1; j < finalnoofcells; j++) {
                            var txt = "", ddlvalue = "";

                            ddlvalue = document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[0].getElementsByTagName("select")[0].value;
                            txt = document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[j].getElementsByTagName("input")[0].value;
                            if (txt == "" || ddlvalue == "0") {
                                alertify.error("Please fill the empty education details field first.");
                                return false;
                            }
                        }
                    }
                }
            }
        }
        var a = "";
        $(document).ready(function () {
            var ctr = 1;

            $(".imgclass").click(function () {

                var rowstatus = checkrowempty();
                if (rowstatus != false) {
                    ctr++;
                    txtqualification = "txtqualification" + ctr;
                    var txtboard = "txtboard" + ctr;
                    var txtyear = "txtyear" + ctr;
                    var session = "txtsession" + ctr;
                    var txtrollnumber = "txtrollnumber" + ctr;
                    var txtpercent = "txtpercent" + ctr;
                    var remove = "removebtn" + ctr;

                    var instituladdress = "txtinstituteaddress" + ctr;

                    var newTr = '<tr><td style="border: 0px solid #CCCCCC!important"><select style="font-size:12px;width:125px;text-transform:none!important" CssClass="qualification" placeholder="eg. 10th" id=' + txtqualification +
                        '></select></td><td style="border: 0px solid #CCCCCC!important"><input style="width:120px;text-transform:none!important" placeholder="eg. UP Board" type="text" id=' + txtboard
                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:120px;text-transform:none!important" placeholder="eg. 2010" type="text" id=' + txtyear
                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:120px;text-transform:none!important" placeholder="eg. 2010-2012" type="text" id=' + session
                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:150px;text-transform:none!important" placeholder="eg. 14354514" type="text" id=' + txtrollnumber
                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:150px;text-transform:none!important" placeholder="eg. 70%"  type="text" id=' + txtpercent
                        + ' /></td><td style="border:0px solid #CCCCCC!important"><input style="width:150px;text-transform:none!important" placeholder="eg. B-143 South Ex."  type="text" id=' + instituladdress
                        + ' /></td><td style="width:74px"><img style="width:15px;height:15px;cursor:pointer;" class="deleteButton" src="../../images/subb.png"   id=' + remove
                        + ' /></td></tr>';

                    $('#ctl00_ContentPlaceHolder1_tbl').append(newTr);
                    filldisig2();
                }

            });

            $("#ctl00_ContentPlaceHolder1_tbl").click(function () {
                var noofrows = document.getElementById('ctl00_ContentPlaceHolder1_tbl').rows.length;
                if (noofrows > 1) {
                    for (var i = 1; i < noofrows; i++) {
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[0].getElementsByTagName("select")[0].className = "txtfocus";
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[1].getElementsByTagName("input")[0].className = "txtfocus";
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[2].getElementsByTagName("input")[0].className = "txtfocus";
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[3].getElementsByTagName("input")[0].className = "txtfocus";
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[4].getElementsByTagName("input")[0].className = "txtfocus";
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[5].getElementsByTagName("input")[0].className = "txtfocus";
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[6].getElementsByTagName("input")[0].className = "txtfocus";

                        $('#ctl00_ContentPlaceHolder1_tbl tr:eq(' + i + ') td:eq(0)').css("border", "0px solid #CCCCCC");
                    }
                }

            });

            $(document).on("click", ".deleteButton", function (e1) {
                alertify.confirm("Are you sure you want to remove this field?", function (e) {
                    if (e) {
                        var target = e1.target;
                        $(target).closest('tr').remove();
                    }
                });
            });

            $("#ctl00_ContentPlaceHolder1_btnothercitycurrentadd").click(function () {

                alertify.confirm("Are you sure you want to enter other city? This city name will be permanently saved.", function (e) {
                    if (e) {
                        $("#ctl00_ContentPlaceHolder1_ddlCity2").val("0");
                        $("#divforcurrentothercity").css("display", "block");
                        $("#divforcitycurrent").css("display", "none");
                        return false;
                    }
                });
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_lnkcancel").click(function () {
                $("#ctl00_ContentPlaceHolder1_txtcurrentadd_othercity").val("");
                $("#divforcitycurrent").css("display", "block");
                $("#divforcurrentothercity").css("display", "none");
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_lnkbtnforpermothercity").click(function () {

                alertify.confirm("Are you sure you want to enter other city? This city name will be permanently saved.", function (e) {
                    if (e) {
                        $("#ctl00_ContentPlaceHolder1_ddlCity").val("0");
                        $("#divforpermanentothercity").css("display", "block");
                        $("#divforpermcity").css("display", "none");
                        return false;
                    }
                });

                return false;
            });
            $("#ctl00_ContentPlaceHolder1_lnkbutton2").click(function () {
                $("#ctl00_ContentPlaceHolder1_txtothercity2").val("");
                $("#divforpermanentothercity").css("display", "none");
                $("#divforpermcity").css("display", "block");
                return false;
            });

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $("#ctl00_ContentPlaceHolder1_ddlidproof").change(function () {
                var idvalue = $(this).val();
                if (idvalue > 0) {
                    $("#ctl00_ContentPlaceHolder1_txtidproof").css("display", "block");
                    $("#divforidupload").css("display", "block");

                }
                else {
                    $("#ctl00_ContentPlaceHolder1_txtidproof").css("display", "none");
                    $("#divforidupload").css("display", "none");
                }
            });
            $("#ctl00_ContentPlaceHolder1_ddlresidentioalproof").change(function () {
                var rsdncevalue = $(this).val();
                if (rsdncevalue > 0) {
                    $("#ctl00_ContentPlaceHolder1_txtresidenceproof").css("display", "block");
                    $("#divforresproofupload").css("display", "block");

                }
                else {
                    $("#ctl00_ContentPlaceHolder1_txtresidenceproof").css("display", "none");
                    $("#divforresproofupload").css("display", "none");
                }
            });

            $("#ctl00_ContentPlaceHolder1_ddlCountry").change(function () {
                bindcountryfrom = 1;
                cid = $(this).val();
                fillstate();
            });
            $("#ctl00_ContentPlaceHolder1_ddlState").change(function () {
                bindcountryfrom = 1;
                sid = $(this).val();
                fillcity();

            });
            $("#ctl00_ContentPlaceHolder1_ddl_dept").change(function () {

                did = $(this).val();
                filldisig();

            });

            $("#ctl00_ContentPlaceHolder1_ddlCountry2").change(function () {
                bindcountryfrom = 2;
                cid = $(this).val();
                fillstate();
            });
            $("#ctl00_ContentPlaceHolder1_ddlState2").change(function () {
                bindcountryfrom = 2;
                sid = $(this).val();
                fillcity();

            });

            $("#ctl00_ContentPlaceHolder1_ddlPCountry").change(function () {
                bindcountryfrom = 3;
                cid = $(this).val();
                fillstate();
            });
            $("#ctl00_ContentPlaceHolder1_ddlPstate").change(function () {
                bindcountryfrom = 3;
                sid = $(this).val();
                fillcity();

            });
            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").on("change blur", function () {
                roll = $('#<%=rdblistforemployee.ClientID %> input[type=radio]:checked').val();
                var ctcperenum = 0.00;
                ctcperenum = $(this).val();
                ctcperenum = (ctcperenum * 12).toFixed(2);
                $("#ctl00_ContentPlaceHolder1_txtannualctc").val(ctcperenum);
                if (annualctc == 0) {
                    annualctc = $("#ctl00_ContentPlaceHolder1_txtannualctc").val();
                }

                if (roll == 1) {
                    $("#divforprobationperiod").css("display", "none");
                    $("#divforpfno").css("display", "block");
                    $("#divforesino").css("display", "block");
                }
                else {
                    $("#divforprobationperiod").css("display", "block");
                    $("#divforpfno").css("display", "none");
                    $("#divforesino").css("display", "none");
                }
                getting_inhand_monthly_salary();
                annualctc = 0;
            });

            $("#ctl00_ContentPlaceHolder1_lblsameasmobileno").click(function () {
                if ($("#ctl00_ContentPlaceHolder1_txtContactNo").val() != "") {
                    $("#ctl00_ContentPlaceHolder1_txtPhoneNo").val($("#ctl00_ContentPlaceHolder1_txtContactNo").val());
                }
                else {
                    alertify.error("Please enter the mobile no first.");
                }
            });

            $("#ctl00_ContentPlaceHolder1_ddlyear").change(function () {
                year = $(this).val();
                openemphistroydiv();
            });
            $("#ctl00_ContentPlaceHolder1_ddlmonth").change(function () {
                month = $(this).val();
                openemphistroydiv();
            });
            $("#ctl00_ContentPlaceHolder1_ddlday").change(function () {
                day = $(this).val();
                openemphistroydiv();
            });
            $("#ctl00_ContentPlaceHolder1_lnkbtnsameas").click(function () {

                var status = 1;

                if ($("#ctl00_ContentPlaceHolder1_txtcurrentaddress").val() == "") {
                    $("#ctl00_ContentPlaceHolder1_txtcurrentaddress").addClass("texthover");
                    status = 0
                }
                if ($("#ctl00_ContentPlaceHolder1_txtpincode2").val() == "") {
                    $("#ctl00_ContentPlaceHolder1_txtpincode2").addClass("texthover");
                    status = 0
                }
                if (document.getElementById('<%=ddlCountry2.ClientID %>').value == 0) {
                    document.getElementById('<%=ddlCountry2.ClientID %>').className = "texthover";

                    status = 0;
                }
                if (document.getElementById('<%=ddlState2.ClientID %>').value == 0) {
                    document.getElementById('<%=ddlState2.ClientID %>').className = "texthover";

                    status = 0;
                }
                if ($("#divforcurrentothercity").css("display") == "none") {
                    if (document.getElementById('<%=ddlCity2.ClientID %>').value == 0) {
                        document.getElementById('<%=ddlCity2.ClientID %>').className = "texthover";
                        status = 0;
                    }
                }
                else {
                    if (document.getElementById('<%=txtcurrentadd_othercity.ClientID %>').value == "") {
                        document.getElementById('<%=txtcurrentadd_othercity.ClientID %>').className = "texthover";
                        status = 0;
                    }
                }

                if (status == 0) {
                    return false;
                }

                if ($(this).is(':checked')) {

                    $("#ctl00_ContentPlaceHolder1_txtAddressLine").val($("#ctl00_ContentPlaceHolder1_txtcurrentaddress").val());
                    $("#ctl00_ContentPlaceHolder1_txtpermanentlandmark").val($("#ctl00_ContentPlaceHolder1_txtcurrentlandmark").val());
                    $("#ctl00_ContentPlaceHolder1_txtPincode").val($("#ctl00_ContentPlaceHolder1_txtpincode2").val());
                    cid = $("#ctl00_ContentPlaceHolder1_ddlCountry2").val();
                    $("#ctl00_ContentPlaceHolder1_ddlCountry").val(cid);
                    sid = $("#ctl00_ContentPlaceHolder1_ddlState2").val();
                    $("#<%= ddlState.ClientID %>").val(sid);
                    var ctid = $("#ctl00_ContentPlaceHolder1_ddlCity2").val();

                    $("#<%= ddlCity.ClientID %>").val(ctid);

                    $("#ctl00_ContentPlaceHolder1_ddlCountry").removeClass("texthover");

                    $("#ctl00_ContentPlaceHolder1_ddlState").removeClass("texthover");

                    $("#ctl00_ContentPlaceHolder1_ddlCity").removeClass("texthover");

                    $("#ctl00_ContentPlaceHolder1_txtAddressLine").removeClass("texthover");

                    $("#ctl00_ContentPlaceHolder1_txtPincode").removeClass("texthover");
                    var currentaddradio = $('#<%=rdbforcurrentaddresstype.ClientID %> input[type=radio]:checked').val();

                    if (parseInt(currentaddradio) == 1) {

                        if ($("#ctl00_ContentPlaceHolder1_rdbpermanentaddresstype_1").is(':checked')) {
                            document.getElementById('ctl00_ContentPlaceHolder1_rdbpermanentaddresstype_0').checked = true;
                            $("#ctl00_ContentPlaceHolder1_rdbpermanentaddresstype_1").attr('checked', false);

                        }
                        else {
                            $("#ctl00_ContentPlaceHolder1_rdbpermanentaddresstype_0").attr('checked', 'checked');
                        }

                    }
                    if (parseInt(currentaddradio) == 2) {
                        if ($("#ctl00_ContentPlaceHolder1_rdbpermanentaddresstype_0").is(':checked')) {
                            document.getElementById('ctl00_ContentPlaceHolder1_rdbpermanentaddresstype_1').checked = true;
                            $("#ctl00_ContentPlaceHolder1_rdbpermanentaddresstype_0").attr('checked', false);

                        }
                        else {
                            $("#ctl00_ContentPlaceHolder1_rdbpermanentaddresstype_1").attr('checked', 'checked');

                        }
                    }
                    if ($("#ctl00_ContentPlaceHolder1_txtcurrentadd_othercity").val() != "") {
                        $("#divforpermanentothercity").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_txtothercity2").val($("#ctl00_ContentPlaceHolder1_txtcurrentadd_othercity").val());
                        $("#divforpermcity").css("display", "none");
                    }

                }
                else {
                    $("#divforpermanentothercity").css("display", "none");
                    $("#divforpermcity").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_txtothercity2").val("");
                    $("#ctl00_ContentPlaceHolder1_txtAddressLine").val("");
                    $("#ctl00_ContentPlaceHolder1_txtpermanentlandmark").val("");
                    $("#ctl00_ContentPlaceHolder1_txtPincode").val("");
                    $("#ctl00_ContentPlaceHolder1_ddlCountry").val(0);
                    $("#<%= ddlState.ClientID %>").val(0);
                    $("#<%= ddlCity.ClientID %>").val(0);
                }

            });

            $("#ctl00_ContentPlaceHolder1_txtContactNo").blur(function () {
                if (document.getElementById('<%= txtContactNo.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtContactNo").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";
                        alertify.error("Mobile number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtPhoneNo").blur(function () {
                if (document.getElementById('<%= txtPhoneNo.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtPhoneNo").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtPhoneNo.ClientID %>').className = "texthover";
                        alertify.error("Phone number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtf1mobileno").blur(function () {
                if (document.getElementById('<%= txtf1mobileno.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtf1mobileno").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtf1mobileno.ClientID %>').className = "texthover";
                        alertify.error("Father contact number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").blur(function () {
                if (document.getElementById('<%= txtfatheralternateno.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtfatheralternateno.ClientID %>').className = "texthover";
                        alertify.error("Father alternate number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtmothermobileno").blur(function () {
                if (document.getElementById('<%= txtmothermobileno.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtmothermobileno").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtmothermobileno.ClientID %>').className = "texthover";
                        alertify.error("Mother contact number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtReContact1").blur(function () {
                if (document.getElementById('<%= txtReContact1.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtReContact1").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtReContact1.ClientID %>').className = "texthover";
                        alertify.error("First Reference contact number should not be less than 10 digits.");

                    }
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtRefContact2").blur(function () {
                if (document.getElementById('<%= txtRefContact2.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtRefContact2").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtRefContact2.ClientID %>').className = "texthover";
                        alertify.error("Second Reference contact number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforcv1").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforcv1.ClientID %>'), "resume", "divforresume");

            });
            $("#ctl00_ContentPlaceHolder1_fileuploadforexperienceltr").blur(function () {

                cv_validation(document.getElementById('<%= fileuploadforexperienceltr.ClientID %>'), "experience", "divfileuploadforexperienceltr");

            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforsalaryslip").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforsalaryslip.ClientID %>'), "salary slip", "divfileuploadforsalaryslip");

            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforappointmentleter").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforappointmentleter.ClientID %>'), "appointment letter", "divfileuploadforappointmentleter");

            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforresignationltr").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforresignationltr.ClientID %>'), "resignation letter", "divfileuploadforresignationltr");

            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforofferletter").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforofferletter.ClientID %>'), "offer letter", "divfileuploadforofferletter");

            });

            $("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").change(function () {
                comparedojandctcapplied();

            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforid").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforid.ClientID %>'), "identity proof", "div7");

            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforresidential").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforresidential.ClientID %>'), "residential proof", "div10");

            });

            $("#ctl00_ContentPlaceHolder1_txtEmailid").blur(function () {

                if (document.getElementById('<%= txtEmailid.ClientID %>').value.trim() != "") {
                    var z = document.getElementById('<%= txtEmailid.ClientID %>').value;
                    if (!z.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                        $("#ctl00_ContentPlaceHolder1_txtEmailid").focus();
                        document.getElementById('<%= txtEmailid.ClientID %>').className = "texthover";
                        alertify.error("Please enter the correct email address.");
                    }
                }

            });
            $("#ctl00_ContentPlaceHolder1_txtfatheremailid").blur(function () {

                if (document.getElementById('<%= txtfatheremailid.ClientID %>').value.trim() != "") {
                    var z = document.getElementById('<%= txtfatheremailid.ClientID %>').value;
                    if (!z.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                        document.getElementById('<%= txtfatheremailid.ClientID %>').className = "texthover";
                        alertify.error("Please enter the correct father E-mail address.");
                    }
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtfatheremailid").focus(function () { $("#ctl00_ContentPlaceHolder1_txtfatheremailid").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_txtDatejoining").change(function () {
                comparedojandctcapplied1();

            });
            $("#ctl00_ContentPlaceHolder1_txtRefNo").change(function () {
                checkstatusofrefno($(this).val());
            });
            $("#ctl00_ContentPlaceHolder1_btnrefresh").click(function () {
                Captcha();
                return false;

            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforpic").change(function () {
                var picdata = document.getElementById('<%= fileuploadforpic.ClientID %>');
                var FileUploadPath1 = picdata.value;

                if (FileUploadPath1 != '') {
                    var Extension1 = FileUploadPath1.substring(FileUploadPath1.lastIndexOf('.') + 1).toLowerCase();

                    if (Extension1 == "jpg" || Extension1 == "jpeg" || Extension1 == "bmp" || Extension1 == "gif" || Extension1 == "png" || Extension1 == "thm" || Extension1 == "psd") {
                        $("#divforimg").css("display", "block");
                    }

                    else {
                        document.getElementById('divforpicture').className = "texthover";
                        $("#divforimg").css("display", "none");
                        alertify.alert("You can not upload " + Extension1 + " file. You can only upload .jpg, .jpeg, .bmp, .gif, .png, .thm or .psd file for photo.");
                        status = 0;
                    }

                }

            });

            Captcha();
        });

        function Captcha() {
            var alpha = new Array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0');
            var i;
            for (i = 0; i < 6; i++) {
                var a = alpha[Math.floor(Math.random() * alpha.length)];
                var b = alpha[Math.floor(Math.random() * alpha.length)];
                var c = alpha[Math.floor(Math.random() * alpha.length)];
                var d = alpha[Math.floor(Math.random() * alpha.length)];

            }
            var code = a + b + c + d;
            document.getElementById("ctl00_ContentPlaceHolder1_txtforcaptch").value = code;
        }

        function checkstatusofrefno(refno) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-new-appoint-letter.aspx/checkstatus",
                data: "{'refno':'" + refno + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (parseInt(data.d) == 1) {
                        fillallcontrols(refno);
                    }
                    else if (parseInt(data.d) == 2) {
                        alertify.error("This Employee has already been joined.");
                        resetcontrols();
                    }
                    else if (parseInt(data.d) == 3) {
                        alertify.error("Only offered and re-offered candidate can be an employee.");
                        resetcontrols();
                    }
                    else {
                        alertify.error("No offer has been given to this offered refrence number");
                        resetcontrols();

                    }
                    call_progressbar("end");
                },

                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function resetcontrols() {
            $("#ctl00_ContentPlaceHolder1_txtRefNo").val("");
            $("#ctl00_ContentPlaceHolder1_ddlTitle").val("0");
            $("#ctl00_ContentPlaceHolder1_txtFName").val("");
            $("#ctl00_ContentPlaceHolder1_txtdob").val("");
            $("#ctl00_ContentPlaceHolder1_txtMName").val("");
            document.getElementById('ctl00_ContentPlaceHolder1_rdGender_0').checked = true;
            $("#ctl00_ContentPlaceHolder1_txtLName").val("");
            $("#ctl00_ContentPlaceHolder1_txtcurrentaddress").val("");
            $("#ctl00_ContentPlaceHolder1_txtpincode2").val("");
            $("#ctl00_ContentPlaceHolder1_txtDatejoining").val("");
            $("#ctl00_ContentPlaceHolder1_txtdoi").val("");
            $("#ctl00_ContentPlaceHolder1_txtannualctc").val("");
            $("#ctl00_ContentPlaceHolder1_txtinhandsalary").val("");
            $("#ctl00_ContentPlaceHolder1_txtHrName").val("");
            $("#ctl00_ContentPlaceHolder1_txtContactNo").val("");
            $("#ctl00_ContentPlaceHolder1_txtEmailid").val("");
            $("#ctl00_ContentPlaceHolder1_ddlCountry2").val("0");
            $("#ctl00_ContentPlaceHolder1_ddlCountry").val("0");
            $("#ctl00_ContentPlaceHolder1_ddlState2").val("0");
            $("#ctl00_ContentPlaceHolder1_ddlState").val("0");
            $("#ctl00_ContentPlaceHolder1_ddlCity2").val("0");
            $("#ctl00_ContentPlaceHolder1_ddlCity").val("0");
            $("#ctl00_ContentPlaceHolder1_ddl_dept").val("0");
            $("#ctl00_ContentPlaceHolder1_ddlDesigNation").val("0");
            remove_txthover();
        }
        function fillallcontrols(refno) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-new-appoint-letter.aspx/Fill_allControls",
                data: "{'refno':'" + refno + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        Onreturnsucces(data);
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function Onreturnsucces(data) {
            $.each(data.d, function (key, value) {
                $("#ctl00_ContentPlaceHolder1_ddlTitle").val(value.title);
                $("#ctl00_ContentPlaceHolder1_txtFName").val(value.fname);
                $("#ctl00_ContentPlaceHolder1_txtdob").val(value.DOB);
                $("#ctl00_ContentPlaceHolder1_txtMName").val(value.mname);
                if (value.gender == "1") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdGender_0').checked = true;
                }
                else { document.getElementById('ctl00_ContentPlaceHolder1_rdGender_1').checked = true; }
                $("#ctl00_ContentPlaceHolder1_txtLName").val(value.lname);
                $("#ctl00_ContentPlaceHolder1_txtcurrentaddress").val(value.address);
                $("#ctl00_ContentPlaceHolder1_txtpincode2").val(value.pincode);
                $("#ctl00_ContentPlaceHolder1_txtDatejoining").val(value.doj);
                $("#ctl00_ContentPlaceHolder1_txtdoi").val(value.dateofinterview);
                $("#ctl00_ContentPlaceHolder1_txtannualctc").val(value.annualCTC);
                $("#ctl00_ContentPlaceHolder1_rdblistforemployee").val(value.emplyeetype);
                $("#ctl00_ContentPlaceHolder1_txtinhandsalary").val(value.inhandsalary);
                $("#ctl00_ContentPlaceHolder1_txtHrName").val(value.hrname);
                $("#ctl00_ContentPlaceHolder1_txtContactNo").val(value.mobile);
                $("#ctl00_ContentPlaceHolder1_txtEmailid").val(value.emailid);
                $("#ctl00_ContentPlaceHolder1_ddlCountry2").val(value.cid);
                $("#ctl00_ContentPlaceHolder1_ddlCountry").val(value.cid);
                cid = value.cid;
                bindcountryfrom = 2;
                fillstate();
                $("#ctl00_ContentPlaceHolder1_ddlState2").val(value.sid);
                $("#ctl00_ContentPlaceHolder1_ddlState").val(value.sid);
                sid = value.sid;
                fillcity();
                $("#ctl00_ContentPlaceHolder1_ddlCity2").val(value.ctid);
                $("#ctl00_ContentPlaceHolder1_ddlCity").val(value.ctid);
                $("#ctl00_ContentPlaceHolder1_ddl_dept").val(value.deptid);
                did = value.deptid;
                filldisig();
                $("#ctl00_ContentPlaceHolder1_ddlDesigNation").val(value.desigtype);
                remove_txthover();
            });
        }

        function remove_txthover() {
            $("#ctl00_ContentPlaceHolder1_ddlTitle").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtFName").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtdob").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtMName").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtLName").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtcurrentaddress").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtpincode2").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtDatejoining").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtdoi").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtannualctc").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtinhandsalary").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtHrName").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtContactNo").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_txtEmailid").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_ddlCountry2").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_ddlCountry").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_ddlState2").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_ddlState").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_ddlCity2").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_ddlCity").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_ddl_dept").removeClass("texthover");
            $("#ctl00_ContentPlaceHolder1_ddlDesigNation").removeClass("texthover");
        }

        function comparedojandctcapplied1() {
            if ($("#ctl00_ContentPlaceHolder1_txtDatejoining").val() != "") {
                var doj = $.datepicker.parseDate('dd/mm/yy', $("#ctl00_ContentPlaceHolder1_txtDatejoining").val());
                var doi = $.datepicker.parseDate('dd/mm/yy', $("#ctl00_ContentPlaceHolder1_txtdoi").val());

                if (doj < doi) {
                    alertify.error("Date of joining can not be less than date of interview.");
                    document.getElementById('ctl00_ContentPlaceHolder1_txtDatejoining').className = "texthover";
                    return false;
                }
            }

        }
        //======= this code is for binding drop down for qualification at runtime start here ==========
        function filldisig2() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-new-appoint-letter.aspx/bind_qualification",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        if (txtqualification != "") {
                            $("#" + txtqualification + "").append($("<option></option>").val(value.qid).html(value.name));
                        }
                        else {
                            $("#ctl00_ContentPlaceHolder1_ddlqualification1").append($("<option></option>").val(value.qid).html(value.name));

                        }

                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });

        }
        //======= this code is for binding drop down at runtime end here ==========

        function comparedojandctcapplied() {
            if ($("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").val() != "") {
                var applieddate = $.datepicker.parseDate('dd/mm/yy', $("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").val());
                var doj = $.datepicker.parseDate('dd/mm/yy', $("#ctl00_ContentPlaceHolder1_txtDatejoining").val());

                if (applieddate < doj) {
                    alertify.error("CTC applied date can not be less than D.O.J.");
                    document.getElementById('ctl00_ContentPlaceHolder1_txtctcappliedfrom').className = "texthover";
                    return false;
                }
            }

        }
        function FillCtcOnPageLoad() {
            roll = $('#<%=rdblistforemployee.ClientID %> input[type=radio]:checked').val();
            if (annualctc == 0) {
                annualctc = $("#ctl00_ContentPlaceHolder1_txtannualctc").val();
            }
            if (roll == 1) {
                $("#divforprobationperiod").css("display", "none");
                $("#divforpfno").css("display", "block");
                $("#divforesino").css("display", "block");
            }
            else {
                $("#divforprobationperiod").css("display", "block");
                $("#divforpfno").css("display", "none");
                $("#divforesino").css("display", "none");
            }
            if ($("#ctl00_ContentPlaceHolder1_txtannualctc").val() != "") {
                getting_inhand_monthly_salary();
            }
        }

        function openemphistroydiv() {
            if (year > 0 || month > 0 || day > 0) {
                $("#ctl00_ContentPlaceHolder1_divforemploymenthistory").css("display", "block");
            }
            else {
                $("#ctl00_ContentPlaceHolder1_divforemploymenthistory").css("display", "none");
            }
        }

        function fillstate() {
            call_progressbar("start");
            $.ajax(
                 {

                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-new-offer-letter.aspx/bindstate",
                     data: "{'cid':'" + cid + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {

                         if (bindcountryfrom == 1) {
                             $("#ctl00_ContentPlaceHolder1_ddlState").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlState").append($("<option></option>").val(value.SID).html(value.stateName));
                             });
                         }
                         if (bindcountryfrom == 2) {
                             $("#ctl00_ContentPlaceHolder1_ddlState2").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlState2").append($("<option></option>").val(value.SID).html(value.stateName));
                             });
                             $("#ctl00_ContentPlaceHolder1_ddlState").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlState").append($("<option></option>").val(value.SID).html(value.stateName));
                             });

                         }
                         if (bindcountryfrom == 3) {
                             $("#ctl00_ContentPlaceHolder1_ddlPstate").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlPstate").append($("<option></option>").val(value.SID).html(value.stateName));
                             });
                         }
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                         return false;
                     }
                 });
        }

        function fillcity() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-new-offer-letter.aspx/bindcity",
                     data: "{'sid':'" + sid + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         if (bindcountryfrom == 1) {
                             $("#ctl00_ContentPlaceHolder1_ddlCity").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlCity").append($("<option></option>").val(value.ctId).html(value.cityname));
                             });
                         }
                         if (bindcountryfrom == 2) {
                             $("#ctl00_ContentPlaceHolder1_ddlCity2").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlCity2").append($("<option></option>").val(value.ctId).html(value.cityname));
                             });
                             $("#ctl00_ContentPlaceHolder1_ddlCity").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlCity").append($("<option></option>").val(value.ctId).html(value.cityname));
                             });
                         }
                         if (bindcountryfrom == 3) {
                             $("#ctl00_ContentPlaceHolder1_ddlPCity").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlPCity").append($("<option></option>").val(value.ctId).html(value.cityname));
                             });
                         }
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                         return false;
                     }
                 });
        }

        function filldisig() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-new-appoint-letter.aspx/binddesignation",
                     data: "{'did':'" + did + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddlDesigNation").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlDesigNation").append($("<option></option>").val(value.desigid).html(value.designame));
                         });
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                         return false;
                     }
                 });

        }

        function getting_inhand_monthly_salary() {

            call_progressbar("start");
            $.ajax(
              {
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "create-new-offer-letter.aspx/getmonthlysalary",
                  data: "{'annualctc':'" + annualctc + "','roll':'" + roll + "'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d.length > 0) {
                          $("#divforsalarydetails").css("display", "block");
                          for (var i = 0; i < data.d.length; i++) {
                              $("#<%=hidden.ClientID %>").val(data.d[i].net_monthly_salary);
                              $("#ctl00_ContentPlaceHolder1_txtinhandsalary").val(data.d[i].net_monthly_salary);
                              $("#ctl00_ContentPlaceHolder1_lblgrossannualctc").text(data.d[i].gross_annual_ctc);
                              $("#ctl00_ContentPlaceHolder1_lblnetannualctc").text(data.d[i].net_annual_ctc);
                              $("#ctl00_ContentPlaceHolder1_lblgrossmonthlysalary").text(data.d[i].gross_monthly_salary);
                              $("#ctl00_ContentPlaceHolder1_lblnetmonthlysalary").text(data.d[i].net_monthly_salary);

                              if (parseInt(data.d[i].roll) == 1) {
                                  $("#trfortds").css("display", "none");
                                  $("#trfortdspercent").css("display", "none");

                                  $("#trforpf").css("display", "block");
                                  $("#trforesi").css("display", "block");
                                  $("#trforpfpercent").css("display", "block");
                                  $("#trforesipercent").css("display", "block");

                                  $("#ctl00_ContentPlaceHolder1_lblmonthlyesiamount").text(data.d[i].monthly_esi_amount);
                                  $("#ctl00_ContentPlaceHolder1_lblmonthlypfamount").text(data.d[i].monthly_pf_amount);

                                  $("#ctl00_ContentPlaceHolder1_lblpfpercent").text(data.d[i].pf_percent + " %");
                                  $("#ctl00_ContentPlaceHolder1_lblesipercent").text(data.d[i].esi_percent + " %");

                              }
                              if (parseInt(data.d[i].roll) == 2) {

                                  $("#ctl00_ContentPlaceHolder1_lblmonthlytdsamount").text(data.d[i].monthly_tds_amount);
                                  $("#ctl00_ContentPlaceHolder1_lbltdspercent").text(data.d[i].tds_percent + " %");
                                  $("#trfortds").css("display", "block");
                                  $("#trfortdspercent").css("display", "block");

                                  $("#trforpf").css("display", "none");
                                  $("#trforesi").css("display", "none");
                                  $("#trforpfpercent").css("display", "none");
                                  $("#trforesipercent").css("display", "none");

                              }
                          }

                          roll = 0;
                      }
                      else {
                          $("#divforsalarydetails").css("display", "none");
                      }
                      call_progressbar("end");
                  },
                  error: function (result) {
                      call_progressbar("end");
                      return false;
                  }
              });

          }
    </script>

    <script type="text/javascript">

        function cv_validation(controlid, name, divname) {

            var wordlength = 0;
            //====this code is for cv validation ====================

            var FileUploadPath = controlid.value;

            if (FileUploadPath != '') {
                var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (Extension == "doc" || Extension == "docx" || Extension == "pdf" || Extension == "jpg" || Extension == "jpeg" || Extension == "odt") {
                    if (Extension == "doc" || Extension == "docx" || Extension == "odt") {
                        wordlength = controlid.files.length;

                        if (wordlength > 1) {
                            document.getElementById(divname).className = "texthover";
                            alertify.alert("You can not upload multiple " + Extension + " files for " + name + ". You can only upload single .odt, .doc or .docx file.");
                            return false;
                        }
                    }

                }
                else {
                    document.getElementById(divname).className = "texthover";
                    alertify.alert("You can not upload " + Extension + " file for " + name + ". You can only upload .odt, .doc, .docx, .jpg, jpeg, or pdf  file.");

                    return false;
                }

            }

        }
        function getvalue() {

            var noofrows = document.getElementById('ctl00_ContentPlaceHolder1_tbl').rows.length;

            var quali = "", board = "", year = "", percent = "", status = "0", session = "", rollnumber = "", instituteaddress = "";

            if (noofrows > 1) {
                for (var i = 1; i < noofrows; i++) {
                    var noofcells = document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells.length;

                    if (noofcells > 0) {
                        var ddlvalue = document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[0].getElementsByTagName("select")[0].value;
                        if (ddlvalue != "0") {
                            for (var j = 1; j < 7; j++) {
                                var txt = document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[j].getElementsByTagName("input")[0].value;
                                if (txt == "") {
                                    document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[j].getElementsByTagName("input")[0].className = "texthover";
                                    status = "1"; quali = ""; board = ""; year = ""; session = ""; rollnumber = ""; percent = ""; instituteaddress = "";
                                }
                            }
                            if (status != "1") {
                                quali += document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[0].getElementsByTagName("select")[0].value + "~";
                                board += document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[1].getElementsByTagName("input")[0].value + "~";
                                year += document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[2].getElementsByTagName("input")[0].value + "~";
                                session += document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[3].getElementsByTagName("input")[0].value + "~";
                                rollnumber += document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[4].getElementsByTagName("input")[0].value + "~";
                                percent += document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[5].getElementsByTagName("input")[0].value + "~";
                                instituteaddress += document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[6].getElementsByTagName("input")[0].value + "~";
                            }
                        }

                    }
                    $("#ctl00_ContentPlaceHolder1_txtqualification").val(quali);
                    $("#ctl00_ContentPlaceHolder1_txtboard").val(board);
                    $("#ctl00_ContentPlaceHolder1_txtyear").val(year);
                    $("#ctl00_ContentPlaceHolder1_txtsession").val(session);
                    $("#ctl00_ContentPlaceHolder1_txtrollnumber").val(rollnumber);
                    $("#ctl00_ContentPlaceHolder1_txtpercent").val(percent);
                    $("#ctl00_ContentPlaceHolder1_txtinstituteaddress").val(instituteaddress);
                }
            }
            if (status == "1") {
                $("#ctl00_ContentPlaceHolder1_txtqualification").val("0");
                $("#ctl00_ContentPlaceHolder1_txtboard").val("");
                $("#ctl00_ContentPlaceHolder1_txtyear").val("");
                $("#ctl00_ContentPlaceHolder1_txtsession").val("");
                $("#ctl00_ContentPlaceHolder1_txtrollnumber").val("");
                $("#ctl00_ContentPlaceHolder1_txtpercent").val("");
                $("#ctl00_ContentPlaceHolder1_txtinstituteaddress").val("");
                return false;
            }

        }

        function check() {
            var iselect = 0, jselect = 0;
            var length = $('#ctl00_ContentPlaceHolder1_tbl tr:gt(0)').length;
            for (var i = 1; i <= length; i++) {
                iselect = $('#ctl00_ContentPlaceHolder1_tbl tr:eq(' + i + ') td:eq(0) select').val();
                for (var j = 1; j <= length; j++) {
                    jselect = $('#ctl00_ContentPlaceHolder1_tbl tr:eq(' + j + ') td:eq(0) select').val();
                    if (i != j) {
                        if (iselect == jselect) {
                            $('#ctl00_ContentPlaceHolder1_tbl tr:eq(' + i + ') td:eq(0)').css("border", "1px solid red");
                            $('#ctl00_ContentPlaceHolder1_tbl tr:eq(' + j + ') td:eq(0)').css("border", "1px solid red");
                            alertify.error('Selected qualifications should not be same.');
                            return false;
                        }
                    }
                }
            }

            var st = confirm("Are you sure you want submit ?");
            if (st == false) {
                return false;
            }
            else {
                var st2 = valid();
                if (st2 == false) {
                    return false;
                }
                else {
                    return true;
                }
            }

        }

        function valid() {
            var status = 1;
            var statofvalue = getvalue();

            if (statofvalue == false) {
                status = 0;
            }

            if (document.getElementById('<%=ddlTitle.ClientID %>').value == 0) {
                document.getElementById('<%= ddlTitle.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=txtFName.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtFName.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=txtLName.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtLName.ClientID %>').className = "texthover";

                status = 0;
            }

            //================this code is for Photo uploading control=========================

            var picdata = document.getElementById('<%= fileuploadforpic.ClientID %>');
            var FileUploadPath1 = picdata.value;

            if (FileUploadPath1 != '') {
                var Extension1 = FileUploadPath1.substring(FileUploadPath1.lastIndexOf('.') + 1).toLowerCase();

                if (Extension1 == "jpg" || Extension1 == "jpeg" || Extension1 == "bmp" || Extension1 == "gif" || Extension1 == "png" || Extension1 == "thm" || Extension1 == "psd") {

                }

                else {
                    document.getElementById('divforpicture').className = "texthover";
                    alertify.alert("You can not upload " + Extension1 + " file. You can only upload .jpg, .jpeg, .bmp, .gif, .png, .thm or .psd file for photo.");
                    status = 0;
                }

            }
            //================this code is for uploading resume control===========================

            if (document.getElementById('<%=ddlidproof.ClientID %>').value > 0) {
                if (document.getElementById('<%=txtidproof.ClientID %>').value.trim() == "") {
                    document.getElementById('<%= txtidproof.ClientID %>').className = "texthover";
                    status = 0;
                }

            }

            if (document.getElementById('<%=ddlresidentioalproof.ClientID %>').value > 0) {
                if (document.getElementById('<%=txtresidenceproof.ClientID %>').value.trim() == "") {
                    document.getElementById('<%= txtresidenceproof.ClientID %>').className = "texthover";
                    status = 0;
                }

            }

            var cvstatus = cv_validation(document.getElementById('<%= fileuploadforcv1.ClientID %>'), "resume", "divforresume");
            if (cvstatus == false) {
                status = 0
            }

            if (document.getElementById('<%=txtdob.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtdob.ClientID %>').className = "texthover";

                status = 0;
            }

            <%--if (document.getElementById('<%=txtdoi.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtdoi.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=txtDatejoining.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtDatejoining.ClientID %>').className = "texthover";

                status = 0;
            }--%>

            if (document.getElementById('<%=txtContactNo.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%= txtContactNo.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtContactNo").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";
                    alertify.error("Mobile number should not be less than 10 digits.");
                    status = 0;

                }
            }

            if (document.getElementById('<%= txtPhoneNo.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtPhoneNo").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtPhoneNo.ClientID %>').className = "texthover";
                    alertify.error("Phone number should not be less than 10 digits.");
                    status = 0;

                }
            }

            if (document.getElementById('<%=txtAddressLine.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtAddressLine.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=ddlCountry.ClientID %>').value == 0) {
                document.getElementById('<%=ddlCountry.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=ddlState.ClientID %>').value == 0) {
                document.getElementById('<%=ddlState.ClientID %>').className = "texthover";

                status = 0;
            }

            if ($("#divforpermanentothercity").css("display") == "none") {
                if (document.getElementById('<%=ddlCity.ClientID %>').value == 0) {
                    document.getElementById('<%=ddlCity.ClientID %>').className = "texthover";
                    status = 0;
                }
            }
            else {
                if (document.getElementById('<%=txtothercity2.ClientID %>').value == "") {
                    document.getElementById('<%=txtothercity2.ClientID %>').className = "texthover";
                    status = 0;
                }
            }

            if (document.getElementById('<%=txtPincode.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtPincode.ClientID %>').className = "texthover";

                status = 0;
            }
            if (document.getElementById('<%=txtcurrentaddress.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtcurrentaddress.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=ddlCountry2.ClientID %>').value == 0) {
                document.getElementById('<%=ddlCountry2.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=ddlState2.ClientID %>').value == 0) {
                document.getElementById('<%=ddlState2.ClientID %>').className = "texthover";

                status = 0;
            }

            if ($("#divforcurrentothercity").css("display") == "none") {
                if (document.getElementById('<%=ddlCity2.ClientID %>').value == 0) {
                    document.getElementById('<%=ddlCity2.ClientID %>').className = "texthover";
                    status = 0;
                }
            }
            else {
                if (document.getElementById('<%=txtcurrentadd_othercity.ClientID %>').value == "") {
                    document.getElementById('<%=txtcurrentadd_othercity.ClientID %>').className = "texthover";
                    status = 0;
                }
            }

            if (document.getElementById('<%=txtpincode2.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtpincode2.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=txtF1name.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtF1name.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%= txtf1mobileno.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtf1mobileno").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtf1mobileno.ClientID %>').className = "texthover";
                    alertify.error("Father contact number should not be less than 10 digits.");
                    status = 0;
                }

            }

            if (document.getElementById('<%= txtfatheralternateno.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtfatheralternateno.ClientID %>').className = "texthover";
                    alertify.error("Father alternate number should not be less than 10 digits.");
                    status = 0;
                }

            }

            if (document.getElementById('<%= txtfatherannualincome.ClientID %>').value.trim() != "") {
                var annuminc = document.getElementById('<%= txtfatherannualincome.ClientID %>').value;
                if (!annuminc.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {
                    document.getElementById('<%= txtfatherannualincome.ClientID %>').className = "texthover";
                    status = 0;
                }
            }

            if (document.getElementById('<%= txtmothermobileno.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtmothermobileno").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtmothermobileno.ClientID %>').className = "texthover";
                    alertify.error("Mother contact number should not be less than 10 digits.");
                    status = 0;
                }

            }

            if (document.getElementById('<%=txtEmailid.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtEmailid.ClientID %>').className = "texthover";
                status = 0;
            }

            var z = document.getElementById('<%= txtEmailid.ClientID %>').value;
            if (!z.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                document.getElementById('<%= txtEmailid.ClientID %>').className = "texthover";
                status = 0;
            }

            <%--if (document.getElementById('<%=ddl_dept.ClientID %>').value == 0) {
                document.getElementById('<%=ddl_dept.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=ddlDesigNation.ClientID %>').value == 0) {
                document.getElementById('<%=ddlDesigNation.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=ddlBranch.ClientID %>').value == 0) {
                document.getElementById('<%=ddlBranch.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=txtmonthlysalary.ClientID %>').value.trim() == "") {
                document.getElementById('<%=txtmonthlysalary.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=txtmonthlysalary.ClientID %>').value.trim() != "") {
                var z = document.getElementById('<%= txtmonthlysalary.ClientID %>').value;
                if (!z.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {
                    document.getElementById('<%= txtmonthlysalary.ClientID %>').className = "texthover";
                    status = 0;
                }
            }

            if (document.getElementById('<%=txtctcappliedfrom.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtctcappliedfrom.ClientID %>').className = "texthover";

                status = 0;
            }--%>

            var comapredt = comparedojandctcapplied();
            if (comapredt == false) {
                status = 0;
            }

           <%-- if (document.getElementById('<%=txtHrName.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtHrName.ClientID %>').className = "texthover";

                status = 0;
            }--%>

            roll = $('#<%=rdblistforemployee.ClientID %> input[type=radio]:checked').val();
            <%--if (roll == 2) {

                if (document.getElementById('<%=ddlProbationPeriod.ClientID %>').value == 0) {
                    document.getElementById('<%=ddlProbationPeriod.ClientID %>').className = "texthover";

                    status = 0;
                }
            }--%>
            //================this code is for uploading experience salary slip, appointment, resignation, offer letter upload=================
            var expstatus = cv_validation(document.getElementById('<%= fileuploadforexperienceltr.ClientID %>'), "experience letter", "divfileuploadforexperienceltr");
            if (expstatus == false) {
                status = 0
            }

            var salaryslipstatus = cv_validation(document.getElementById('<%= fileuploadforsalaryslip.ClientID %>'), "salary slip", "divfileuploadforsalaryslip");
            if (salaryslipstatus == false) {
                status = 0
            }

            var Appointmentstatus = cv_validation(document.getElementById('<%= fileuploadforappointmentleter.ClientID %>'), "appointment letter", "divfileuploadforappointmentleter");
            if (Appointmentstatus == false) {
                status = 0
            }
            var Resignationstatus = cv_validation(document.getElementById('<%= fileuploadforresignationltr.ClientID %>'), "resignation letter", "divfileuploadforresignationltr");
            if (Resignationstatus == false) {
                status = 0
            }

            var Offerstatus = cv_validation(document.getElementById('<%= fileuploadforofferletter.ClientID %>'), "offer letter", "divfileuploadforofferletter");
            if (Offerstatus == false) {
                status = 0
            }

            if (document.getElementById('<%= txtReContact1.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtReContact1").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtReContact1.ClientID %>').className = "texthover";
                    alertify.error("First Reference contact number should not be less than 10 digits.");
                    status = 0;
                }
            }

            if (document.getElementById('<%= txtRefContact2.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtRefContact2").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtRefContact2.ClientID %>').className = "texthover";
                    alertify.error("Second Reference contact number should not be less than 10 digits.");
                    status = 0;

                }

            }

            if (status == 1) {
                if (document.getElementById('ctl00_ContentPlaceHolder1_txtforcaptch2').value.trim() == "") {
                    document.getElementById('<%= txtforcaptch2.ClientID %>').className = "texthover";
                    alertify.error("Please enter the security code.");
                    return false;
                }
                var string1 = document.getElementById('ctl00_ContentPlaceHolder1_txtforcaptch').value.trim();
                var string2 = document.getElementById('ctl00_ContentPlaceHolder1_txtforcaptch2').value.trim();
                if (string1 != string2) {
                    alertify.error("You have not entered the correct security code.");
                    return false;
                }
            }

            if (status == 0) {
                alertify.error("Correct all above red marked fields.");
                $("html, body").animate({ scrollTop: 0 }, 1000);

                return false;
            }

        }
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_rdblistfornationality").click(function () {
                var nationval = $('#<%=rdblistfornationality.ClientID %> input[type=radio]:checked').val();
                if (nationval == 2) {
                    $("#ctl00_ContentPlaceHolder1_divfornationality").css("display", "block");
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_divfornationality").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtothernationality").val("");
                }

            });

            $("#ctl00_ContentPlaceHolder1_rblMStatus").click(function () {
                var mstatus = $('#<%=rblMStatus.ClientID %> input[type=radio]:checked').val();

                if (mstatus == 2) {
                    $("#ctl00_ContentPlaceHolder1_divfordependents").css("display", "block");
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_divfordependents").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtChild").val("");
                }

            });

            //this code is remove the red css from controls
            $("#ctl00_ContentPlaceHolder1_txtforcaptch2").focus(function () { $("#ctl00_ContentPlaceHolder1_txtforcaptch2").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtothercity2").focus(function () { $("#ctl00_ContentPlaceHolder1_txtothercity2").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtcurrentadd_othercity").focus(function () { $("#ctl00_ContentPlaceHolder1_txtcurrentadd_othercity").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtfatheroccupation").focus(function () { $("#ctl00_ContentPlaceHolder1_txtfatheroccupation").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtfatherannualincome").focus(function () { $("#ctl00_ContentPlaceHolder1_txtfatherannualincome").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtidproof").focus(function () { $("#ctl00_ContentPlaceHolder1_txtidproof").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtresidenceproof").focus(function () { $("#ctl00_ContentPlaceHolder1_txtresidenceproof").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtdoi").focus(function () { $("#ctl00_ContentPlaceHolder1_txtdoi").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").focus(function () { $("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtEmailid").focus(function () { $("#ctl00_ContentPlaceHolder1_txtEmailid").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlBranch").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlBranch").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtdob").focus(function () { $("#ctl00_ContentPlaceHolder1_txtdob").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").focus(function () { $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtRefNo").focus(function () { $("#ctl00_ContentPlaceHolder1_txtRefNo").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlTitle").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlTitle").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtFName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtFName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtLName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtLName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlDOBDay").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDOBDay").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlDOBMonth").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDOBMonth").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlDOBYear").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDOBYear").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtDatejoining").focus(function () { $("#ctl00_ContentPlaceHolder1_txtDatejoining").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtAddressLine").focus(function () { $("#ctl00_ContentPlaceHolder1_txtAddressLine").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlCountry").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlCountry").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlState").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlState").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlCity").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlCity").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtPincode").focus(function () { $("#ctl00_ContentPlaceHolder1_txtPincode").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtContactNo").focus(function () { $("#ctl00_ContentPlaceHolder1_txtContactNo").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtcurrentaddress").focus(function () { $("#ctl00_ContentPlaceHolder1_txtcurrentaddress").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlCountry2").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlCountry2").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlState2").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlState2").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlCity2").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlCity2").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtpincode2").focus(function () { $("#ctl00_ContentPlaceHolder1_txtpincode2").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtF1name").focus(function () { $("#ctl00_ContentPlaceHolder1_txtF1name").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtf1mobileno").focus(function () { $("#ctl00_ContentPlaceHolder1_txtf1mobileno").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtMotherName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtMotherName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtmothermobileno").focus(function () { $("#ctl00_ContentPlaceHolder1_txtmothermobileno").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtparentsaddress").focus(function () { $("#ctl00_ContentPlaceHolder1_txtparentsaddress").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddl_dept").focus(function () { $("#ctl00_ContentPlaceHolder1_ddl_dept").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddl_dept").focus(function () { $("#ctl00_ContentPlaceHolder1_ddl_dept").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlDesigNation").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDesigNation").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlProbationPeriod").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlProbationPeriod").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").focus(function () { $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtHrName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtHrName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtPhoneNo").focus(function () { $("#ctl00_ContentPlaceHolder1_txtPhoneNo").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").focus(function () { $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtReContact1").focus(function () { $("#ctl00_ContentPlaceHolder1_txtReContact1").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtRefContact2").focus(function () { $("#ctl00_ContentPlaceHolder1_txtRefContact2").removeClass("texthover"); });
            $("#divfileuploadforexperienceltr").click(function () { $("#divfileuploadforexperienceltr").removeClass("texthover"); });
            $("#divfileuploadforsalaryslip").click(function () { $("#divfileuploadforsalaryslip").removeClass("texthover"); });
            $("#divfileuploadforappointmentleter").click(function () { $("#divfileuploadforappointmentleter").removeClass("texthover"); });
            $("#divfileuploadforresignationltr").click(function () { $("#divfileuploadforresignationltr").removeClass("texthover"); });
            $("#divfileuploadforofferletter").click(function () { $("#divfileuploadforofferletter").removeClass("texthover"); });
            $("#div7").click(function () { $("#div7").removeClass("texthover"); });
            $("#div10").click(function () { $("#div10").removeClass("texthover"); });
            $("#divforpicture").click(function () { $("#divforpicture").removeClass("texthover"); });
            $("#divforresume").click(function () { $("#divforresume").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_txtPincode").keyup(function () {
                var pin = document.getElementById('ctl00_ContentPlaceHolder1_txtPincode').value;
                if (!pin.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtPincode').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtpincode2").keyup(function () {
                var pin2 = document.getElementById('ctl00_ContentPlaceHolder1_txtpincode2').value;
                if (!pin2.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtpincode2').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtContactNo").keyup(function () {
                var contno = document.getElementById('ctl00_ContentPlaceHolder1_txtContactNo').value;
                if (!contno.match(/^\d+$/)) {
                    document.getElementById('ctl00_ContentPlaceHolder1_txtContactNo').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtPhoneNo").keyup(function () {
                var phoneno = document.getElementById('ctl00_ContentPlaceHolder1_txtPhoneNo').value;
                if (!phoneno.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtPhoneNo').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtf1mobileno").keyup(function () {
                var fmobile = document.getElementById('ctl00_ContentPlaceHolder1_txtf1mobileno').value;
                if (!fmobile.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtf1mobileno').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtmothermobileno").keyup(function () {
                var mmobile = document.getElementById('ctl00_ContentPlaceHolder1_txtmothermobileno').value;
                if (!mmobile.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtmothermobileno').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").keyup(function () {
                var annualctc = document.getElementById('ctl00_ContentPlaceHolder1_txtmonthlysalary').value;
                if (!annualctc.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtmonthlysalary').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtPPincode").keyup(function () {
                var ppin = document.getElementById('ctl00_ContentPlaceHolder1_txtPPincode').value;
                if (!ppin.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtPPincode').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtPsalary").keyup(function () {
                var salary = document.getElementById('ctl00_ContentPlaceHolder1_txtPsalary').value;
                if (!salary.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtPsalary').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtDuration").keyup(function () {
                var duration = document.getElementById('ctl00_ContentPlaceHolder1_txtDuration').value;
                if (!duration.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtDuration').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtPexperience").keyup(function () {
                var exp = document.getElementById('ctl00_ContentPlaceHolder1_txtPexperience').value;
                if (!exp.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtPexperience').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtReContact1").keyup(function () {
                var contact1 = document.getElementById('ctl00_ContentPlaceHolder1_txtReContact1').value;
                if (!contact1.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtReContact1').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtRefContact2").keyup(function () {
                var contact2 = document.getElementById('ctl00_ContentPlaceHolder1_txtRefContact2').value;
                if (!contact2.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtRefContact2').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtAccountNo").keyup(function () {
                var accnt = document.getElementById('ctl00_ContentPlaceHolder1_txtAccountNo').value;
                if (!accnt.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtAccountNo').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtChild").keyup(function () {
                var accnt = document.getElementById('ctl00_ContentPlaceHolder1_txtChild').value;
                if (!accnt.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtChild').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").keyup(function () {
                var alternate = document.getElementById('ctl00_ContentPlaceHolder1_txtfatheralternateno').value;
                if (!alternate.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtfatheralternateno').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtfatherannualincome").keyup(function () {
                var anualinc = document.getElementById('ctl00_ContentPlaceHolder1_txtfatherannualincome').value;
                if (!anualinc.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtfatherannualincome').value = "";
                }
            });

        });
    </script>

    <script type="text/javascript">
        function toggle5(showHideDiv, switchImgTag) {
            var ele = document.getElementById(showHideDiv);
            var imageEle = document.getElementById(switchImgTag);
            if (ele.style.display == "block") {
                ele.style.display = "none";
                imageEle.innerHTML = '<img src="../../images/addd11.png" style=" margin-left:0px;" />';
            }
            else {
                ele.style.display = "block";
                imageEle.innerHTML = '<img src="../../images/Green_Minus.gif" style=" margin-left:0px;">';
            }
        }
        function preview(input) {
            if (input.files && input.files[0]) {
                var ImageDir = new FileReader();
                ImageDir.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_empimage').attr('src', e.target.result);

                }
                ImageDir.readAsDataURL(input.files[0]);
            }

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
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a class="active">Add New Employee</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div id="divAppoinmentLetter" runat="server">

            <div id="headerDivImg">
            </div>
            <h4 class="page-title txtblue ">

                <a id="imageDivLink" href="javascript:toggle5('contentDivImg', 'imageDivLink');">
                    <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                </a><span id="Span1" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">General Details </span>
            </h4>
            <div class="separator bg-blue"></div>

            <div id="contentDivImg" style="display: block;">
                <div id="divforimg" class="user_phot_frame" style="float: right!important; margin-left: 100px!important; width: 209px; display: none">
                    <asp:Image ID="empimage" runat="server" Width="110" Height="120" Style="border: 3px solid #306b33" />
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Offered Refrence No.</label>
                    <asp:TextBox ID="txtRefNo" runat="server" placeholder="Offered Refrence No." MaxLength="12"></asp:TextBox>

                    <%--<asp:TextBox ID="txtRefNo" runat="server" placeholder="Offered Refrence No." MaxLength="12" OnTextChanged="txtRefNo_TextChanged" AutoPostBack="true"></asp:TextBox>--%>
                    <%--<asp:Label ID="lblalreadyexistmsg" runat="server" Text="Offered refrence no already joined."  style="display:block" Font-Bold="true" Font-Size="10pt" ForeColor="Red"></asp:Label>--%>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Title<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlTitle" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtFName" runat="server" PlaceHolder="First Name" Width="87" MaxLength="50" CssClass="fname"></asp:TextBox>
                    <asp:TextBox ID="txtMName" runat="server" PlaceHolder="Middle Name" Width="87" MaxLength="50" CssClass="mname"></asp:TextBox>
                    <asp:TextBox ID="txtLName" runat="server" PlaceHolder="Last Name" Width="87" MaxLength="50" CssClass="lname"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Gender<span style="color: #ff0066">*</span></label>
                    <asp:RadioButtonList ID="rdGender" runat="server" CssClass="forlabel" RepeatDirection="Horizontal">

                        <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                        <asp:ListItem Value="0">Female</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Date Of Birth<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtdob" PlaceHolder="Date of Birth" runat="server" MaxLength="50" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Birth Place</label>
                    <asp:TextBox ID="txtforbirthplace" PlaceHolder="Birth Place" runat="server" MaxLength="50"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Nationality</label>
                    <asp:RadioButtonList ID="rdblistfornationality" runat="server" CssClass="forlabel" RepeatDirection="Horizontal">

                        <asp:ListItem Value="1" Selected="True">Indian</asp:ListItem>
                        <asp:ListItem Value="2">Other</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div id="divfornationality" runat="server" class="for_sigle_row_form" style="display: none">
                    <label>
                        Other Nationality</label>
                    <asp:TextBox ID="txtothernationality" PlaceHolder="Other Nationality" runat="server" MaxLength="50"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Marital Status<span style="color: Red;">*</span></label>
                    <div id="divgender">
                        <asp:RadioButtonList runat="server" ID="rblMStatus" RepeatDirection="Horizontal"
                            CssClass="forlabel">
                            <asp:ListItem Value="1" Selected="True">Unmarried</asp:ListItem>
                            <asp:ListItem Value="2">Married</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div id="divfordependents" class="for_sigle_row_form" runat="server" style="display: none">
                    <label>
                        No. of Dependents</label>
                    <asp:TextBox ID="txtChild" PlaceHolder="No. of Dependents" runat="server" MaxLength="1" Style="text-transform: none !important"></asp:TextBox>&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Identity Proof
                    </label>
                    <asp:DropDownList ID="ddlidproof" runat="server">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtidproof" PlaceHolder="ID Proof No." runat="server" MaxLength="10" Style="display: none; width: 168px; float: right; margin-right: 329px; text-transform: uppercase !important;"></asp:TextBox>
                </div>

                <div id="divforidupload" style="display: none" class="for_sigle_row_form">
                    <label>
                        Upload Identity Proof</label>
                    <div id="div7" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="fileuploadforid" />
                    </div>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Residential Proof</label>
                    <asp:DropDownList ID="ddlresidentioalproof" runat="server">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtresidenceproof" runat="server" PlaceHolder="Residential Proof No." MaxLength="10" Style="display: none; width: 168px; float: right; margin-right: 329px; text-transform: uppercase !important;"></asp:TextBox>
                </div>

                <div id="divforresproofupload" style="display: none" class="for_sigle_row_form">
                    <label>
                        Upload Residential Proof</label>
                    <div id="div10" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="fileuploadforresidential" />
                    </div>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Upload Photo</label>
                    <div id="divforpicture" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="fileuploadforpic" onchange="preview(this)" />
                    </div>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Upload Resume</label>
                    <div id="divforresume" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="fileuploadforcv1" AllowMultiple="true" />&nbsp;
                        
                    </div>
                </div>

                <div class="for_sigle_row_form" id="divresume" runat="server" visible="false">
                    <label>
                        Uploaded Resume</label>
                    <asp:GridView ID="gridforimagename" AutoGenerateColumns="false" Width="312px" runat="server"
                        HeaderStyle-Height="30px" BorderWidth="0" GridLines="None">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" Text='<%#Eval("ID") %>' runat="server" CssClass="Row_num"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="File" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblimagename" Text='<%#Eval("ImageName") %>' Style="color: black" runat="server" ForeColor="Chocolate" CssClass="refNo"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Download" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbldateofinterview" Text='<%#Eval("Download") %>' OnClick="lbldateofinterview_Click" runat="server" CssClass="date"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Documents Submitted</label>
                    <div style="margin-top: 7px; margin-bottom: 20px;" class="" id="divamenities">
                        <div class="SingleCheckbox">
                            <asp:CheckBoxList ID="chkboxlistfordocuments" runat="server" CssClass="forlabel" RepeatDirection="Horizontal" RepeatColumns="2">
                                <asp:ListItem Value="1" Text="10th Marksheet"></asp:ListItem>
                                <asp:ListItem Value="2" Text="12th Marksheet"></asp:ListItem>
                                <asp:ListItem Value="3" Text="Graduate Degree"></asp:ListItem>
                                <asp:ListItem Value="4" Text="Post Graduate Degree"></asp:ListItem>
                                <asp:ListItem Value="5" Text="Diploma"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                    </div>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Comments</label>
                    <asp:TextBox ID="txtComment" PlaceHolder="Comments" runat="server" TextMode="MultiLine" MaxLength="200"></asp:TextBox>
                </div>
            </div>

            <h4 class="page-title txtblue ">

                <a id="A9" href="javascript:toggle5('divforeducation', 'A9');">
                    <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                </a><span id="Span4" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Educational Details </span>
            </h4>
            <div class="separator bg-blue"></div>

            <div id="divforeducation" style="display: block;">
                <div class="user_phot_frame" style="float: right!important; margin-left: 100px!important; width: 209px; display: none">
                    <asp:Image ID="Image1" runat="server" Width="110" Height="120" Style="border: 3px solid #306b33" />
                </div>

                <div class="for_sigle_row_form">
                    <%--<label>
                    </label>--%>
                    <div style="float: right; margin-top: 7px; margin-right: 160px!important">
                        <img class="imgclass" src="../../images/addd.png" style="width: 15px; height: 15px; cursor: pointer" />
                    </div>

                    <div style="width: 80%; margin-left:0">
                        <table id="tbl" runat="server" style="border: 0px solid #808080; width: 100%">
                            <tr class="trqualification">
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Qualification</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Board/University</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Passing Year</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important;">Session</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Roll Number</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Percentage</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important; width: 30%!important">College/Institute Address</td>
                            </tr>

                            <tr class="trqualification">
                                <td class="tdfortrqualification">
                                    <asp:DropDownList ID="ddlqualification1" runat="server" Width="125" CssClass="eductabletxt" Style="font-size: 12px; text-transform: none!important"></asp:DropDownList></td>

                                <td class="tdfortrqualification">
                                    <asp:TextBox ID="txtboard1" runat="server" Width="120" placeholder="eg. UP Board" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                <td class="tdfortrqualification">
                                    <asp:TextBox ID="txtyear1" runat="server" Width="120" placeholder="eg. 2010" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                <td class="tdfortrqualification">
                                    <asp:TextBox ID="txtsession1" runat="server" Width="120" placeholder="eg. 2010-2012" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                <td class="tdfortrqualification">
                                    <asp:TextBox ID="txtrollnumber1" runat="server" Width="150" placeholder="eg. 14354514" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                <td class="tdfortrqualification">
                                    <asp:TextBox ID="txtpercentage1" runat="server" Width="150" placeholder="eg. 70%" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                <td class="tdfortrqualification">
                                    <asp:TextBox ID="txtinsituteaddress1" runat="server" Width="150" placeholder="eg. B-143 South Ex." CssClass="eductabletxt" Style="text-transform: none!important">
                                    </asp:TextBox></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div8">

                    <a id="A8" href="javascript:toggle5('divforcurrentaddress', 'A8');">
                        <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                    </a>
                    <span id="Span9" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Current Address Details </span>
                </div>
            </h4>
            <div class="separator bg-blue"></div>
            <div id="divforcurrentaddress">

                <div class="for_sigle_row_form">
                    <label>
                        Address Type</label>
                    <asp:RadioButtonList ID="rdbforcurrentaddresstype" runat="server" CssClass="forlabel" RepeatDirection="Horizontal">
                        <asp:ListItem Value="1" Selected="True">Own</asp:ListItem>
                        <asp:ListItem Value="2">Rent</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Mobile No. <span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtContactNo" PlaceHolder="Mobile No." runat="server" MaxLength="10"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Phone No.</label>
                    <asp:TextBox ID="txtPhoneNo" PlaceHolder="Phone No." runat="server" MaxLength="10"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        E-mail ID <span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtEmailid" PlaceHolder="E-mail ID" runat="server" Style="text-transform: none !important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Country<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlCountry2" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        State/Province<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlState2" runat="server" AppendDataBoundItems="True">
                        <asp:ListItem Value="0">---Select State/Province---</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div id="divforcitycurrent" class="for_sigle_row_form">
                    <label>
                        City<span style="color: #ff0066">*</span></label>

                    <asp:DropDownList ID="ddlCity2" runat="server" AppendDataBoundItems="True">
                        <asp:ListItem Value="0">---Select City---</asp:ListItem>
                    </asp:DropDownList>
                    <asp:LinkButton ID="btnothercitycurrentadd" runat="server" Style="font-size: 11px; color: chocolate; text-decoration: none" Text="Other"></asp:LinkButton>
                </div>
                <div id="divforcurrentothercity" style="display: none" class="for_sigle_row_form">
                    <label>
                        Other City<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtcurrentadd_othercity" PlaceHolder="Other City" runat="server" Style="text-transform: none !important"></asp:TextBox>
                    <asp:LinkButton ID="lnkcancel" runat="server" Style="font-size: 11px; color: chocolate; text-decoration: none" Text="Cancel"></asp:LinkButton>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Land Mark</label>
                    <asp:TextBox ID="txtcurrentlandmark" PlaceHolder="Land Mark" runat="server" Style="text-transform: none !important"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Address Line 1<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtcurrentaddress" PlaceHolder="Address Line 1" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtpincode2" PlaceHolder="Pin/Zip Code" runat="server" MaxLength="6"></asp:TextBox>&nbsp;
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div1">

                    <a id="A1" href="javascript:toggle5('contentDivImg111', 'A1');">
                        <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                    </a>
                    <span id="Span2" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Permanent Address Details </span>
                </div>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="contentDivImg111" style="display: block;">

                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <asp:CheckBox ID="lnkbtnsameas" CssClass="forlabel" runat="server" Style="font-size: 10pt" Text="Same as above" />
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Address Type</label>
                    <asp:RadioButtonList ID="rdbpermanentaddresstype" runat="server" CssClass="forlabel" RepeatDirection="Horizontal">
                        <asp:ListItem Value="1" Selected="True">Own</asp:ListItem>
                        <asp:ListItem Value="2">Rent</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Country<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        State/Province<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlState" runat="server" AppendDataBoundItems="True">
                        <asp:ListItem Value="0">---Select State/Province---</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div id="divforpermcity" class="for_sigle_row_form">
                    <label>
                        City<span style="color: #ff0066">*</span></label>

                    <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True">
                        <asp:ListItem Value="0">---Select City---</asp:ListItem>
                    </asp:DropDownList>
                    <asp:LinkButton ID="lnkbtnforpermothercity" runat="server" Style="font-size: 11px; color: chocolate; text-decoration: none" Text="Other"></asp:LinkButton>
                </div>

                <div id="divforpermanentothercity" style="display: none" class="for_sigle_row_form">
                    <label>
                        Other City<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtothercity2" PlaceHolder="Other City" runat="server" Style="text-transform: none !important"></asp:TextBox>
                    <asp:LinkButton ID="lnkbutton2" runat="server" Style="font-size: 11px; color: chocolate; text-decoration: none" Text="Cancel"></asp:LinkButton>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Land Mark</label>
                    <asp:TextBox ID="txtpermanentlandmark" PlaceHolder="Land Mark" runat="server" Style="text-transform: none !important"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Address Line 1<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtAddressLine" PlaceHolder="Address Line 1" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtPincode" PlaceHolder="Pin/Zip Code" runat="server" MaxLength="6"></asp:TextBox>
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div6">

                    <a id="A7" href="javascript:toggle5('divforgardians', 'A7');">
                        <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                    </a>
                    <span id="Span8" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Gardian Details </span>
                </div>
            </h4>
            <div class="separator bg-blue"></div>

            <div id="divforgardians" style="display: block;">
                <div class="for_sigle_row_form">
                    <label>
                        Father Name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtF1name" PlaceHolder="Father Name" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Father Mobile No.
                    </label>
                    <asp:TextBox ID="txtf1mobileno" PlaceHolder="Father Mobile No" runat="server" MaxLength="10"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Father Alternate Mobile No.
                    </label>
                    <asp:TextBox ID="txtfatheralternateno" PlaceHolder="Father Alternate Mobile No" runat="server" MaxLength="10"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Father E-mail ID</label>
                    <asp:TextBox ID="txtfatheremailid" PlaceHolder="Father E-mail ID" runat="server" MaxLength="50" Style="text-transform: none!important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Father Occupation
                    </label>
                    <asp:TextBox ID="txtfatheroccupation" PlaceHolder="Father Occupation" runat="server" MaxLength="50" Style="text-transform: none!important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Father Annual Income</label>
                    <asp:TextBox ID="txtfatherannualincome" PlaceHolder="Father Annual Income" runat="server" MaxLength="10" Style="text-transform: none!important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Mother Name</label>
                    <asp:TextBox ID="txtMotherName" PlaceHolder="Mother Name" runat="server"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Mother Mobile No.</label>
                    <asp:TextBox ID="txtmothermobileno" PlaceHolder="Mother Mobile No" runat="server" MaxLength="10"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Address Line 1</label>
                    <asp:TextBox ID="txtparentsaddress" PlaceHolder="Address Line 1" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div3">

                    <a id="A2" href="javascript:toggle5('contentDivImg3333', 'A2');">
                        <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                    </a>
                    <span id="Span3" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Employment Details </span>
                </div>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="contentDivImg3333" style="display: block;">
                <div class="for_sigle_row_form">
                    <label>
                        Department
                        <%--<span style="color: #ff0066">*</span>--%>
                    </label>
                    <asp:DropDownList ID="ddl_dept" runat="server">
                    </asp:DropDownList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Designation<%--<span style="color: #ff0066">*</span>--%></label>
                    <asp:DropDownList ID="ddlDesigNation" runat="server" AppendDataBoundItems="True">
                        <asp:ListItem Value="0">---Select Designation---</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Branch<%--<span style="color: #ff0066">*</span>--%></label>
                    <asp:DropDownList ID="ddlBranch" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        PAN Card No.</label>
                    <asp:TextBox ID="txtPanNo" PlaceHolder="PAN Card No." runat="server" MaxLength="10" Style="text-transform: uppercase !important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Date of Interview<%--<span style="color: #ff0066">*</span>--%></label>
                    <asp:TextBox ID="txtdoi" PlaceHolder="Date of Interview" runat="server" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Date of Joining<%--<span style="color: #ff0066">*</span>--%></label>
                    <asp:TextBox ID="txtDatejoining" PlaceHolder="Date of Joining" runat="server" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Type of Employment
                    </label>
                    <asp:RadioButtonList ID="rdblistforemployee" runat="server" CssClass="forlabel" RepeatDirection="Horizontal">
                        <asp:ListItem Value="1">On Roll</asp:ListItem>
                        <asp:ListItem Value="2" Selected="True">Off Roll</asp:ListItem>
                    </asp:RadioButtonList>
                    <div id="divforsalarydetails" style="width: 285px; float: right; margin-right: 195px; border: 2px solid; border-color: #306b33; padding: 10px 10px 10px 10px; display: none">
                        <table id="tblforsalarydetails">
                            <tr>
                                <td style="width: 150px; padding: 5px 0px 4px 4px">Gross Annual CTC:</td>
                                <td style="width: 150px;">
                                    <asp:Label ID="lblgrossannualctc" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px; padding: 5px 0px 4px 4px">Net Annual CTC: </td>
                                <td style="width: 150px;">
                                    <asp:Label ID="lblnetannualctc" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px; padding: 5px 0px 4px 4px">Gross Monthly Salary:</td>
                                <td>
                                    <asp:Label ID="lblgrossmonthlysalary" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>

                            <tr id="trfortds" style="display: none">
                                <td style="width: 150px; padding: 5px 0px 4px 4px">Monthly TDS Amount:</td>
                                <td style="width: 150px;">
                                    <asp:Label ID="lblmonthlytdsamount" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trfortdspercent" style="display: none">
                                <td style="width: 150px; padding: 5px 0px 4px 4px">TDS:</td>
                                <td style="width: 150px;">
                                    <asp:Label ID="lbltdspercent" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>

                            <tr id="trforpf" style="display: none">
                                <td style="width: 150px; padding: 5px 0px 4px 4px">Monthly PF Amount:</td>
                                <td>
                                    <asp:Label ID="lblmonthlypfamount" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trforesi" style="display: none">
                                <td style="width: 150px; padding: 5px 0px 4px 4px">Monthly ESI Amount:</td>
                                <td>
                                    <asp:Label ID="lblmonthlyesiamount" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trforpfpercent" style="display: none">
                                <td style="width: 150px; padding: 5px 0px 4px 4px">PF:</td>
                                <td>
                                    <asp:Label ID="lblpfpercent" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trforesipercent" style="display: none">
                                <td style="width: 150px; padding: 5px 0px 4px 4px">ESI:</td>
                                <td>
                                    <asp:Label ID="lblesipercent" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 2px; width: 100%; background-color: #006EB8"></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; padding: 5px 0px 4px 4px">Inhand/Net Monthly Salary:</td>
                                <td>
                                    <asp:Label ID="lblnetmonthlysalary" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div id="divforprobationperiod" class="for_sigle_row_form" style="display: block">
                    <label>
                        Probation Period(In Month)<%--<span style="color: #ff0066">*</span>--%></label>
                    <asp:DropDownList ID="ddlProbationPeriod" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Monthly Salary<%--<span style="color: #ff0066">*</span>--%></label>
                    <asp:TextBox ID="txtmonthlysalary" PlaceHolder="Inhand salary" runat="server" MaxLength="6"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Inhand Salary (Per Month)</label>
                    <asp:TextBox ID="txtinhandsalary" PlaceHolder="Inhand salary" runat="server" MaxLength="10" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Current CTC (Per Annum)</label>
                    <asp:TextBox ID="txtannualctc" PlaceHolder="Current CTC (Per Annum)" runat="server" MaxLength="10" ReadOnly="true"></asp:TextBox>
                    <asp:HiddenField ID="hidden" runat="server" />
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Above CTC Applied From<%--<span style="color: #ff0066">*</span>--%></label>
                    <asp:TextBox ID="txtctcappliedfrom" PlaceHolder="Above CTC Applied From" runat="server" MaxLength="20"></asp:TextBox>
                </div>

                <div id="div5" class="for_sigle_row_form" style="display: block">
                    <label>
                        TDS Account No.</label>
                    <asp:TextBox ID="txttdsaccntno" PlaceHolder="TDS Account No." runat="server" MaxLength="20" Style="text-transform: uppercase !important"></asp:TextBox>
                </div>

                <div id="divforpfno" class="for_sigle_row_form" style="display: none">
                    <label>
                        PF Account No.</label>
                    <asp:TextBox ID="txtpfno" PlaceHolder="PF Account No." runat="server" MaxLength="20" Style="text-transform: uppercase !important"></asp:TextBox>
                </div>

                <div id="divforesino" class="for_sigle_row_form" style="display: none">
                    <label>
                        ESI Account No.</label>
                    <asp:TextBox ID="txtesino" PlaceHolder="ESI Account No." runat="server" MaxLength="20" Style="text-transform: uppercase !important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Office E-mail ID
                    </label>
                    <asp:TextBox ID="txtEmailAlloted" PlaceHolder="Office E-mail ID" runat="server" MaxLength="50" Style="text-transform: none !important;"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Managing Director<%--<span style="color: #ff0066">*</span>--%></label>
                    <asp:TextBox ID="txtHrName" PlaceHolder="Managing Director" Text="" runat="server" MaxLength="50"></asp:TextBox>
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="div345">

                    <a id="A3" href="javascript:toggle5('divforemployement', 'A3');">
                        <img src="../../images/Green_Minus.gif" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important" />
                    </a>
                    <span id="Span10" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Employment History </span>
                </div>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="divforemployement" style="display: block;">
                <div class="for_sigle_row_form">
                    <label>
                        Total Experience</label>
                    <asp:DropDownList ID="ddlyear" runat="server" AppendDataBoundItems="True" Style="width: 155px">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlmonth" runat="server" AppendDataBoundItems="True" Style="width: 155px">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlday" runat="server" AppendDataBoundItems="True" Style="width: 106px" Visible="false">
                    </asp:DropDownList>
                </div>
                <div id="divforemploymenthistory" runat="server" style="display: none">

                    <div class="for_sigle_row_form">
                        <label>
                            Organization Name
                        </label>
                        <asp:TextBox ID="txtPorganisation" PlaceHolder="Organisation Name" runat="server" MaxLength="50"></asp:TextBox>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Country</label>
                        <asp:DropDownList ID="ddlPCountry" runat="server" AppendDataBoundItems="True">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            State/Province</label><asp:DropDownList ID="ddlPstate" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Value="0">---State/Province---</asp:ListItem>
                            </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            City</label>
                        <asp:DropDownList ID="ddlPCity" runat="server" AppendDataBoundItems="True">
                            <asp:ListItem Value="0">---City---</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Address Line 1</label>
                        <asp:TextBox ID="txtPaddress" PlaceHolder="Address Line 1 " TextMode="MultiLine" runat="server" MaxLength="200"></asp:TextBox>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Pin/Zip Code</label>
                        <asp:TextBox ID="txtPPincode" PlaceHolder="Pin Code" runat="server" MaxLength="6"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Designation</label>
                        <asp:TextBox ID="txtPdesignation" PlaceHolder="Designation" runat="server" MaxLength="50"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Salary (Per Month)</label>
                        <asp:TextBox ID="txtPsalary" PlaceHolder="Salary (Per Month) " runat="server" MaxLength="7"></asp:TextBox>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Upload Experience letter</label>
                        <div id="divfileuploadforexperienceltr" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                            <asp:FileUpload runat="server" ID="fileuploadforexperienceltr" AllowMultiple="true" />
                            <asp:HiddenField ID="hfforexperienceletter" runat="server" />
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Upload Salary Slip</label>
                        <div id="divfileuploadforsalaryslip" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                            <asp:FileUpload runat="server" ID="fileuploadforsalaryslip" AllowMultiple="true" />
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Upload Appointment Letter</label>
                        <div id="divfileuploadforappointmentleter" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                            <asp:FileUpload runat="server" ID="fileuploadforappointmentleter" AllowMultiple="true" />
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Upload Resignation Letter</label>
                        <div id="divfileuploadforresignationltr" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                            <asp:FileUpload runat="server" ID="fileuploadforresignationltr" AllowMultiple="true" />
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Upload Offer Letter</label>
                        <div id="divfileuploadforofferletter" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                            <asp:FileUpload runat="server" ID="fileuploadforofferletter" AllowMultiple="true" />
                        </div>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            First Refrence Name</label>
                        <asp:TextBox ID="txtRef1Name" PlaceHolder="First Reference Name" runat="server" MaxLength="50"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Contact No.</label>
                        <asp:TextBox ID="txtReContact1" PlaceHolder="First Reference Contact No" runat="server" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Second Refrence Name</label>
                        <asp:TextBox ID="txtRef2Name" PlaceHolder="Second Reference Name" runat="server" MaxLength="50"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Contact No.</label>
                        <asp:TextBox ID="txtRefContact2" PlaceHolder="Second Reference No" runat="server" MaxLength="10"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <br />
            </div>
            <h4 class="page-title txtblue ">
                <div id="Div2">

                    <a id="A4" href="javascript:toggle5('divforMedical', 'A4');">
                        <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                    </a><span id="Span5" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Medical Details </span>
                </div>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="divforMedical" style="display: block;">
                <div class="for_sigle_row_form">
                    <label>
                        Blood Group
                    </label>
                    <asp:DropDownList ID="ddlbloodgroup" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Medical Condition</label>
                    <asp:TextBox ID="txtmedicalCondition" PlaceHolder="Medical Condition" runat="server" MaxLength="50" Style="text-transform: none !important"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Past Diseases</label>
                    <asp:TextBox ID="txtPastDisease" PlaceHolder="Past Disease" runat="server" MaxLength="50" Style="text-transform: none !important"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Genetic Disease</label>
                    <asp:TextBox ID="txtGeneticDisease" PlaceHolder="Genetic Disease" runat="server" MaxLength="50" Style="text-transform: none !important"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Any Allergy</label>
                    <asp:TextBox ID="txtAnyEllergy" PlaceHolder="Any Allergy" runat="server" MaxLength="50" Style="text-transform: none !important"></asp:TextBox>
                </div>
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <br />
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div662">

                    <a id="A5" href="javascript:toggle5('divforAccount', 'A5');">
                        <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                    </a><span id="Span6" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Account Details </span>
                </div>
            </h4>
            <div class="separator bg-blue"></div>

            <div id="divforAccount" style="display: block;">
                <div class="for_sigle_row_form" align="center">
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Bank Name</label>
                    <asp:TextBox ID="txtBankName" PlaceHolder="Bank Name" runat="server" MaxLength="100"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Account No.</label>
                    <asp:TextBox ID="txtAccountNo" PlaceHolder="Account No" runat="server" MaxLength="20"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Branch Name</label>
                    <asp:TextBox ID="txtBranchName" PlaceHolder="Branch Name" runat="server" MaxLength="50"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Branch ID</label>
                    <asp:TextBox ID="txtBranchCode" PlaceHolder="Branch ID" runat="server" MaxLength="10" Style="text-transform: none !important"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        IFSC Code</label>
                    <asp:TextBox ID="txtIFSCCode" PlaceHolder="IFSC Code" runat="server" MaxLength="20" Style="text-transform: uppercase !important"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div4">
                    <a id="A6" href="javascript:toggle5('divforofficeuse', 'A6');">
                        <img src="../../images/Green_Minus.gif" style="margin-left: 0px;" />
                    </a><span id="Span7" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">For Office Use Only </span>
                </div>
            </h4>
            <div class="separator bg-blue"></div>
            <div id="divforofficeuse" style="display: block;">
                <div class="for_sigle_row_form" align="center">
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Bio-Metric Details</label>
                    <asp:TextBox ID="txtbiometricdetails" PlaceHolder="Biometric Details" runat="server" MaxLength="10" Style="text-transform: none !important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                </div>
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <div style="background-color: #E2E2E2; width: 314px; margin-left: 239px; height: 50px; padding-top: 10px;">

                    <asp:TextBox ID="txtforcaptch2" placeholder="Security code" Style="width: 87px!important; text-transform: none!important; margin-left: 5px; height: 25px!important;" AutoCompleteType="None" runat="server"></asp:TextBox>
                    <asp:TextBox ID="txtforcaptch" CssClass="captchaclass" Style="text-transform: none!important; margin: 0px 6px;" Enabled="false" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="btnrefresh" runat="server" Style="float: right; height: 37px ! important; width: 38px ! important; margin-top: -4px; margin-right: 3px;" ImageUrl="~/images/refresh.png" />
                </div>
            </div>

            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button_save" OnClientClick="return check();" OnClick="btnSubmit_Click2" />
                <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="button2" Style="height: 35px!important" OnClick="Cancel_Click"
                    CausesValidation="false" />
            </div>

            <asp:TextBox ID="txtqualification" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtboard" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtyear" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtsession" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtrollnumber" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtpercent" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtinstituteaddress" Style="display: none" runat="server"></asp:TextBox>

            <div id="divProgressBar" class="progress"></div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear() + 1;
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtDatejoining").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2022:' + y,
                    dateFormat: "dd/mm/yy",
                });
                $("#ctl00_ContentPlaceHolder1_txtdob").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "dd/mm/yy",
                    maxDate: new Date(2010, 1, 18)
                });
                $("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2022:' + y,
                    dateFormat: "dd/mm/yy",
                });

                $("#ctl00_ContentPlaceHolder1_txtdoi").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2022:' + y,
                    dateFormat: "dd/mm/yy",
                });

            });
        });
    </script>
</asp:Content>