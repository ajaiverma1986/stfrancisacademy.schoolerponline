<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="emp-profile.aspx.cs" Inherits="BranchPanel_emp_profile" %>

<%@ Register Src="employee-panel.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />
    <style type="text/css">
        .alertify {
            z-index: 2147483647 !important;
        }

        .activeprofile {
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
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
        }

        .for_sigle_row_form {
            margin-left: 0 !important;
        }

        .textfocus {
            border: solid 1px #99cc00 !important;
            box-shadow: 0 0 5px 1px #bce0fe !important;
        }

        .texthover {
            border: solid 1px red !important;
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

        .lblMessage {
            color: #FF5217;
            font-style: italic;
            font-size: 20px;
            font-family: sans-serif;
        }

        .t1 {
            height: 30px;
            padding-top: 15px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 25px;
            text-align: left !important;
        }
        /*.ui-datepicker {
            top:1006px!important;
        }*/

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 10px;
            text-align: left !important;
            width: 40px!important;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 70px!important;
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
            border: 10px solid #8CBF26;
            border-radius: 5px;
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

        .changecolor {
            border: solid 2px #008060 !important;
        }

        .changecolor2 {
            border: solid 2px #0032FB !important;
        }

        .removeclass {
            border: solid 1px #CCCCCC !important;
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

        #ctl00_ContentPlaceHolder1_grdOfferLetter tr {
            height: 35px!important;
        }
    </style>
    <script type="text/javascript">
        var status = "", comment = "", suspensiondate = "", resumptiondate = "", terminationdate = "", noticePeriodDate = "", noofdaysinnoticeperiod = "", workingDate = "", leavedate = "";
        var cid = "0", sid = "0", bindcountryfrom = 0, annualctc = 0, roll = 0, year = 0, month = 0, day = 0, currentstatus = "", isvalidate = "0", txtqualification = "";
        var ctr = 1;

        function pageLoad() {
            $('#contentDivImg').css("display", "none");
            $('#contentDivImg111').css("display", "none");
            $('#divforgardians').css("display", "none");
            $('#divforemployement').css("display", "none");
            $('#divforMedical').css("display", "none");
            $('#divforAccount').css("display", "none");
            $('#divforofficeuse').css("display", "none");
            $('#divforcurrentaddress').css("display", "none");
            $('#divforeducation').css("display", "none");

            document.title = 'Employee Profile';
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
                        $("#ctl00_ContentPlaceHolder1_ddlqualification1").append($("<option></option>").val(value.qid).html(value.name));
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

        function add_Row() {
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
            //jQuery.ajaxSetup({ async: false });
            filldisig2();
            //jQuery.ajaxSetup({ async: true });
        }

        function bind_table_runtime() {
            if (document.getElementById('<%= qualification.ClientID %>').value != "") {
                var Qualifction = document.getElementById('<%= qualification.ClientID %>').value.split("~");
                var brd = document.getElementById('<%= bord.ClientID %>').value.split("~");
                var yr = document.getElementById('<%= passingyear.ClientID %>').value.split("~");
                var sesion = document.getElementById('<%= session.ClientID %>').value.split("~");
                var rllnum = document.getElementById('<%= rollnumber.ClientID %>').value.split("~");
                var perecnt = document.getElementById('<%= percentage.ClientID %>').value.split("~");
                var add = document.getElementById('<%= institute_address.ClientID %>').value.split("~");
                var noofrows = document.getElementById('ctl00_ContentPlaceHolder1_tbl').rows.length - 1;

                if (noofrows < Qualifction.length - 1) {
                    for (var a = 0; a < Qualifction.length - 2; a++) {
                        add_Row();
                    }
                }
                var totalrows = document.getElementById('ctl00_ContentPlaceHolder1_tbl').rows.length;
                if (totalrows > 1) {
                    var j = 0;

                    for (var i = 1; i < totalrows; i++) {

                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[0].getElementsByTagName("select")[0].value = Qualifction[j];
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[1].getElementsByTagName("input")[0].value = brd[j];
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[2].getElementsByTagName("input")[0].value = yr[j];
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[3].getElementsByTagName("input")[0].value = sesion[j];
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[4].getElementsByTagName("input")[0].value = rllnum[j];
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[5].getElementsByTagName("input")[0].value = perecnt[j];
                        document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[6].getElementsByTagName("input")[0].value = add[j];
                        j++;
                    }

                }
            }
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

        $(document).ready(function () {
            filldisig2();

            bind_table_runtime();

            $(".imgclass").click(function () {
                var rowstatus = checkrowempty();
                if (rowstatus != false) {

                    add_Row();
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

            $("#ctl00_ContentPlaceHolder1_btnedit").click(function () {
                alertify.confirm("Are you sure you want to change the education details?", function (e) {
                    if (e) {
                        $("#ctl00_ContentPlaceHolder1_btnedit").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_btncancel").css("display", "block");
                        $("#divforeducationdetails").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_divforgrid").css("display", "none");
                        return false;
                    }
                });
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btncancel").click(function () {
                alertify.confirm("Please check the record carefully as this detail will be updated in employee records permanently.", function (e) {
                    if (e) {
                        $("#ctl00_ContentPlaceHolder1_btncancel").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_btnedit").css("display", "block");
                        $("#divforeducationdetails").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divforgrid").css("display", "block");
                        return false;
                    }

                });
                return false;
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

            $("#ctl00_ContentPlaceHolder1_txtContactNo").blur(function () {
                if (document.getElementById('<%= txtContactNo.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtContactNo").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";
                        alertify.alert("Mobile number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtPhoneNo").blur(function () {
                if (document.getElementById('<%= txtPhoneNo.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtPhoneNo").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtPhoneNo.ClientID %>').className = "texthover";
                        alertify.alert("Phone number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtf1mobileno").blur(function () {
                if (document.getElementById('<%= txtf1mobileno.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtf1mobileno").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtf1mobileno.ClientID %>').className = "texthover";
                        alertify.alert("Father contact number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").blur(function () {
                if (document.getElementById('<%= txtfatheralternateno.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtfatheralternateno.ClientID %>').className = "texthover";
                        alertify.alert("Father alternate number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtmothermobileno").blur(function () {
                if (document.getElementById('<%= txtmothermobileno.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtmothermobileno").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtmothermobileno.ClientID %>').className = "texthover";
                        alertify.alert("Mother contact number should not be less than 10 digits.");

                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtReContact1").blur(function () {
                if (document.getElementById('<%= txtReContact1.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtReContact1").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtReContact1.ClientID %>').className = "texthover";
                        alertify.alert("First Reference contact number should not be less than 10 digits.");

                    }
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtRefContact2").blur(function () {
                if (document.getElementById('<%= txtRefContact2.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtRefContact2").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtRefContact2.ClientID %>').className = "texthover";
                        alertify.alert("Second Reference contact number should not be less than 10 digits.");

                    }
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

            //===========this code is for file upload for picture blur==========
            $("#ctl00_ContentPlaceHolder1_fileuploadforpic").change(function () {
                var picdata = document.getElementById('<%= fileuploadforpic.ClientID %>');
                var FileUploadPath1 = picdata.value;

                if (FileUploadPath1 != '') {
                    var Extension1 = FileUploadPath1.substring(FileUploadPath1.lastIndexOf('.') + 1).toLowerCase();

                    if (Extension1 == "jpg" || Extension1 == "jpeg" || Extension1 == "bmp" || Extension1 == "gif" || Extension1 == "png" || Extension1 == "thm" || Extension1 == "psd") {
                        $("#ctl00_ContentPlaceHolder1_img").css("display", "block");
                        $("#divforimg").css("display", "block");
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_img").css("display", "none");
                        $("#divforimg").css("display", "none");
                        document.getElementById('divforpicture').className = "texthover";
                        alertify.alert("You can not upload " + Extension1 + " file for picture. You can only upload .jpg, .jpeg, .bmp, .gif, .png, .thm or .psd file photo.");

                    }

                }
            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforcv").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforcv.ClientID %>'), "resume", "divforresume");

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
            $("#ctl00_ContentPlaceHolder1_fileuploadforid").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforid.ClientID %>'), "identity proof", "div7");

            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforresidential").blur(function () {
                cv_validation(document.getElementById('<%= fileuploadforresidential.ClientID %>'), "residential proof", "div10");

            });

            $("#ctl00_ContentPlaceHolder1_txtfatherannualincome").keyup(function () {
                var anualinc = document.getElementById('ctl00_ContentPlaceHolder1_txtfatherannualincome').value;
                if (!anualinc.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtfatherannualincome').value = "";
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

        });

        function preview(input) {
            if (input.files && input.files[0]) {
                var ImageDir = new FileReader();
                ImageDir.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_empimage').attr('src', e.target.result);

                }
                ImageDir.readAsDataURL(input.files[0]);
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

                         }
                         if (bindcountryfrom == 3) {
                             $("#ctl00_ContentPlaceHolder1_ddlPCity").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlPCity").append($("<option></option>").val(value.ctId).html(value.cityname));
                             });
                         }
                         bindcountryfrom = 0;
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
                            alertify.alert("You can not upload multiple " + Extension + " files for " + name + ". You can only upload single .doc, .docx or .odt file.");
                            return false;
                        }
                    }

                }
                else {
                    document.getElementById(divname).className = "texthover";
                    alertify.alert("You can not upload " + Extension + " file for " + name + ". You can only upload .doc, .docx, .odt, .jpg, jpeg, or pdf  file.");

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

            if (document.getElementById('<%=txtRefNo.ClientID %>').value == 0) {
                document.getElementById('<%= txtRefNo.ClientID %>').className = "texthover";
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
            //=====================================================================
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

            //================this code is for uploading resume control===========================
            var cvstatus = cv_validation(document.getElementById('<%= fileuploadforcv.ClientID %>'), "resume", "divforresume");
            if (cvstatus == false) {
                status = 0
            }

            if (document.getElementById('<%=txtContactNo.ClientID %>').value.trim() == 0) {
                document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%= txtContactNo.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtContactNo").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";
                    alertify.alert("Mobile number should not be less than 10 digits.");
                    status = 0;

                }
            }

            if (document.getElementById('<%= txtPhoneNo.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtPhoneNo").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtPhoneNo.ClientID %>').className = "texthover";
                    alertify.alert("Phone number should not be less than 10 digits.");
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

            if (document.getElementById('<%=ddlCity.ClientID %>').value == 0) {
                document.getElementById('<%=ddlCity.ClientID %>').className = "texthover";
                if ($("#ctl00_ContentPlaceHolder1_divforpermanentothercity").css("display") == "block") {
                    alertify.error("You can update permanent address city from other city field.");
                }
                status = 0;
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

            if (document.getElementById('<%=ddlCity2.ClientID %>').value == 0) {
                if ($("#ctl00_ContentPlaceHolder1_divforcurrentothercity").css("display") == "block") {
                    alertify.error("You can update current address city from other city field.");
                }
                document.getElementById('<%=ddlCity2.ClientID %>').className = "texthover";

                status = 0;
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
                    alertify.alert("Father contact number should not be less than 10 digits.");
                    status = 0;
                }

            }

            if (document.getElementById('<%= txtfatheralternateno.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtfatheralternateno.ClientID %>').className = "texthover";
                    alertify.alert("Father alternate number should not be less than 10 digits.");
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
                    alertify.alert("Mother contact number should not be less than 10 digits.");
                    status = 0;
                }
            }

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
                    alertify.alert("First Reference contact number should not be less than 10 digits.");
                    status = 0;
                }
            }

            if (document.getElementById('<%= txtRefContact2.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtRefContact2").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtRefContact2.ClientID %>').className = "texthover";
                    alertify.alert("Second Reference contact number should not be less than 10 digits.");
                    status = 0;

                }
            }

            if (status == 0) {
                alertify.error("Correct all above red marked fields.");
                $("html, body").animate({ scrollTop: 0 }, 3000);
                return false;
            }

        }

        $(document).ready(function () {

            //this code is remove the red css from controls
            $("#div7").click(function () { $("#div7").removeClass("texthover"); });
            $("#div10").click(function () { $("#div10").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_txtidproof").focus(function () { $("#ctl00_ContentPlaceHolder1_txtidproof").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtresidenceproof").focus(function () { $("#ctl00_ContentPlaceHolder1_txtresidenceproof").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_txtfatheroccupation").focus(function () { $("#ctl00_ContentPlaceHolder1_txtfatheroccupation").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtfatherannualincome").focus(function () { $("#ctl00_ContentPlaceHolder1_txtfatherannualincome").removeClass("texthover"); });

            $("#divforresume").click(function () { $("#divforresume").removeClass("texthover"); });
            $("#divforpicture").click(function () { $("#divforpicture").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_txtRefNo").focus(function () { $("#ctl00_ContentPlaceHolder1_txtRefNo").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_ddlTitle").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlTitle").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_txtFName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtFName").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_txtLName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtLName").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_ddlDOBDay").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDOBDay").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_ddlDOBMonth").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDOBMonth").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_ddlDOBYear").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDOBYear").removeClass("texthover"); });

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

            $("#ctl00_ContentPlaceHolder1_txtPhoneNo").focus(function () { $("#ctl00_ContentPlaceHolder1_txtPhoneNo").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").focus(function () { $("#ctl00_ContentPlaceHolder1_txtfatheralternateno").removeClass("texthover"); });

            $("#ctl00_ContentPlaceHolder1_txtReContact1").focus(function () { $("#ctl00_ContentPlaceHolder1_txtReContact1").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtRefContact2").focus(function () { $("#ctl00_ContentPlaceHolder1_txtRefContact2").removeClass("texthover"); });

            $("#divfileuploadforexperienceltr").click(function () { $("#divfileuploadforexperienceltr").removeClass("texthover"); });

            $("#divfileuploadforsalaryslip").click(function () { $("#divfileuploadforsalaryslip").removeClass("texthover"); });

            $("#divfileuploadforappointmentleter").click(function () { $("#divfileuploadforappointmentleter").removeClass("texthover"); });

            $("#divfileuploadforresignationltr").click(function () { $("#divfileuploadforresignationltr").removeClass("texthover"); });

            $("#divfileuploadforofferletter").click(function () { $("#divfileuploadforofferletter").removeClass("texthover"); });

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

            $("#ctl00_ContentPlaceHolder1_txtPPincode").keyup(function () {
                var ppin = document.getElementById('ctl00_ContentPlaceHolder1_txtPPincode').value;
                if (!ppin.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtPPincode').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtPsalary").keyup(function () {
                var salary = document.getElementById('ctl00_ContentPlaceHolder1_txtPsalary').value;
                if (!salary.match(/^[1-9]\d*(?:\.\d{0,2})?$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtPsalary').value = "";
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
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Employee Profile</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div id="divAppoinmentLetter" runat="server">

            <div id="headerDivImg">
            </div>
            <h4 class="page-title txtblue ">

                <a id="imageDivLink" href="javascript:toggle5('contentDivImg', 'imageDivLink');">
                    <img src="../../images/addd11.png" style="margin-left: 0px;" />
                </a><span id="Span1" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">General Details </span>
            </h4>
            <div class="separator bg-blue"></div>

            <div id="contentDivImg" style="display: block;">
                <div id="divforimg" class="user_phot_frame" style="float: right!important; margin-left: 100px!important; width: 209px; display: none">
                    <asp:Image ID="empimage" runat="server" Width="110" Height="120" Style="border: 3px solid #306b33" />
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Employee Code<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtRefNo" runat="server" placeholder="Employee Code" MaxLength="12"></asp:TextBox>
                    <asp:Label ID="lblinvalidrefno" runat="server" Text="Invalid refrence no." Visible="false" Font-Bold="true" Font-Size="10pt" ForeColor="Red"></asp:Label>
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
                    <asp:TextBox ID="txtFName" runat="server" PlaceHolder="First Name" Width="87" MaxLength="50" CssClass="fname"></asp:TextBox>&nbsp
                <asp:TextBox ID="txtMName" runat="server" PlaceHolder="Middle Name" Width="87" MaxLength="50" CssClass="mname"></asp:TextBox>&nbsp
                <asp:TextBox ID="txtLName" runat="server" PlaceHolder="Last Name" Width="87" MaxLength="50" CssClass="lname"></asp:TextBox>&nbsp
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
                    <asp:TextBox ID="txtChild" PlaceHolder="No. of Dependents" runat="server" MaxLength="1"></asp:TextBox>&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Identity Proof
                    </label>
                    <asp:DropDownList ID="ddlidproof" runat="server">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtidproof" PlaceHolder="ID Proof No" runat="server" MaxLength="10" Width="132" Style="width: 168px; float: right; margin-right: 329px; display: none; text-transform: uppercase !important;"></asp:TextBox>
                </div>

                <div id="divforidupload" style="display: none" class="for_sigle_row_form">
                    <label>
                        Upload Identity Proof</label>
                    <div id="div7" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="fileuploadforid" />
                        <asp:HiddenField ID="hdvforidproofupload" runat="server" />
                    </div>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Residential Proof</label>
                    <asp:DropDownList ID="ddlresidentioalproof" runat="server">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtresidenceproof" runat="server" PlaceHolder="Residential Proof No." MaxLength="10" Width="132" Style="width: 168px; float: right; margin-right: 329px; display: none; text-transform: uppercase !important;"></asp:TextBox>
                </div>

                <div id="divforresproofupload" style="display: none" class="for_sigle_row_form">
                    <label>
                        Upload Residential Proof</label>
                    <div id="div10" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="fileuploadforresidential" />
                        <asp:HiddenField ID="hdvforresidentialproofupload" runat="server" />
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
                        <asp:FileUpload runat="server" ID="fileuploadforcv" AllowMultiple="true" />&nbsp;
                        <asp:HiddenField ID="hfforresume" runat="server" />
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
            <%--================================code for education details start here===================================--%>
            <h4 class="page-title txtblue ">

                <a id="A9" href="javascript:toggle5('divforeducation', 'A9');">
                    <img src="../../images/addd11.png" style="margin-left: 0px;" />
                </a><span id="Span4" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Educational Details </span>
            </h4>
            <div class="separator bg-blue"></div>

            <div id="divforeducation" style="display: block;">

                <div id="divforgridview" runat="server" class="for_sigle_row_form">
                    <%--<label>
                    </label>--%>

                    <div id="divforgrid" runat="server" style="display: none; width: 97%; margin-left: 4px; border: 1px solid #CCCCCC">
                        <asp:GridView ID="grdOfferLetter" AutoGenerateColumns="false" Width="100%" runat="server"
                            HeaderStyle-Height="30px" BorderWidth="0">

                            <Columns>
                                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSNo" Text='<%#Eval("Rownumber") %>' runat="server" CssClass="Row_num"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Qualification" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblqualification" Text='<%#Eval("qualification") %>' Style="color: black" runat="server" ForeColor="Chocolate"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Board/University" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblboard" Text='<%#Eval("education_board") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Passing Year" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblpassingyear" Text='<%#Eval("passing_year") %>' Style="color: black" runat="server" CssClass="Name"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Session" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblsession" Text='<%#Eval("session") %>' Style="color: black" runat="server" CssClass="mobile"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Roll Number" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblrollnumber" Text='<%#Eval("rollnumber") %>' runat="server" CssClass="department"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Percentage" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblpercentage" Text='<%#Eval("percentage") %>' Style="color: black" runat="server" CssClass="mobile"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="College/Institute Address" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblcollgaddress" Text='<%#Eval("institute_address") %>' Style="color: black; cursor: pointer" runat="server" CssClass="mobile" ToolTip='<%#Eval("institute_address_complete") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_dark" />
                            <HeaderStyle CssClass="stm_head" />
                        </asp:GridView>
                    </div>

                    <asp:Button ID="btnedit" Style="display: none; float: right; margin-right: 25px; margin-top: 6px" runat="server" Text="Edit" CssClass="button2" />
                </div>

                <div id="divforeducationdetails" style="display: none" class="for_sigle_row_form">
                    <%--<label>
                    </label>--%>
                    <div style="float: right; margin-top: 7px; margin-right: 22px">
                        <img class="imgclass" src="../../images/addd.png" style="width: 15px; height: 15px; cursor: pointer" />
                    </div>

                    <div style="width: 97%; margin-left: 8px">
                        <table id="tbl" runat="server" style="border: 0px solid #808080; width: 100%">
                            <tr class="trqualification">

                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Qualification</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Board/University</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Passing Year</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Session</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Roll Number</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Percentage</td>
                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important; width: 30%!important">College/Institute Address</td>
                            </tr>

                            <tr class="trqualification">
                                <td class="tdfortrqualification">
                                    <asp:DropDownList ID="ddlqualification1" runat="server" Width="125" CssClass="eductabletxt" Style="font-size: 12px; text-transform: none!important"></asp:DropDownList></td>

                                <td class="tdfortrqualification">
                                    <asp:TextBox ID="txtboard1" runat="server" Width="120" placeholder="eg. UP Board" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                <td class="tdfortrqualification" style="width: 80px!important">
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
                        <asp:Button ID="btncancel" Style="display: none; float: right; margin-right: 12px; margin-top: 5px;" runat="server" Text="Cancel" CssClass="button2" />
                    </div>
                </div>
            </div>
            <asp:HiddenField ID="qualification" runat="server" />
            <asp:HiddenField ID="bord" runat="server" />
            <asp:HiddenField ID="passingyear" runat="server" />
            <asp:HiddenField ID="session" runat="server" />
            <asp:HiddenField ID="rollnumber" runat="server" />
            <asp:HiddenField ID="percentage" runat="server" />

            <asp:HiddenField ID="institute_address" runat="server" />

            <%--=============================== code for education end here=======================--%>

            <h4 class="page-title txtblue ">
                <div id="Div8">

                    <a id="A8" href="javascript:toggle5('divforcurrentaddress', 'A8');">
                        <img src="../../images/addd11.png" style="margin-left: 0px;" />
                    </a>
                    <span id="Span9" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Current Address Details </span>
                </div>
            </h4>
            <div class="separator bg-blue"></div>
            <div id="divforcurrentaddress">
                <div class="for_sigle_row_form">
                    <label>
                        Address Type<span style="color: #ff0066">*</span></label>
                    <asp:RadioButtonList ID="rdbforcurrentaddresstype" runat="server" CssClass="forlabel" RepeatDirection="Horizontal">
                        <asp:ListItem Value="1" Selected="True">Own</asp:ListItem>
                        <asp:ListItem Value="2">Rent</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Mobile No. <span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtContactNo" PlaceHolder="Mobile No." runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Phone No.</label>
                    <asp:TextBox ID="txtPhoneNo" PlaceHolder="Phone No." runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        E-mail ID<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtEmailid" PlaceHolder="E-mail ID" runat="server" Style="text-transform: none !important"></asp:TextBox>&nbsp;
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
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        City<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlCity2" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>

                <div id="divforcurrentothercity" runat="server" style="display: none" class="for_sigle_row_form">
                    <label>
                        Other City<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtcurrentadd_othercity" PlaceHolder="Other City" runat="server" Style="text-transform: none !important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Address Line 1<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtcurrentaddress" PlaceHolder="Address Line 1" TextMode="MultiLine" runat="server"></asp:TextBox>&nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Land Mark</label>
                    <asp:TextBox ID="txtcurrentlandmark" PlaceHolder="Land Mark" runat="server"></asp:TextBox>&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtpincode2" PlaceHolder="Pin Code" runat="server" MaxLength="6"></asp:TextBox>&nbsp;
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div1">

                    <a id="A1" href="javascript:toggle5('contentDivImg111', 'A1');">
                        <img src="../../images/addd11.png" style="margin-left: 0px;" />
                    </a>
                    <span id="Span2" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Permanent Address Details </span>
                </div>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="contentDivImg111" style="display: block;">
                <div class="for_sigle_row_form">
                    <label>
                        Address Type <span style="color: #ff0066">*</span></label>
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
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        City<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>
                <div id="divforpermanentothercity" runat="server" style="display: none" class="for_sigle_row_form">
                    <label>
                        Other City<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtothercity2" PlaceHolder="Other City" runat="server" Style="text-transform: none !important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Address Line 1<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtAddressLine" PlaceHolder="Address Line 1" TextMode="MultiLine" runat="server"></asp:TextBox>&nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Land Mark</label>
                    <asp:TextBox ID="txtpermanentlandmark" PlaceHolder="Land Mark" runat="server"></asp:TextBox>&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtPincode" PlaceHolder="Pin Code" runat="server" MaxLength="6"></asp:TextBox>&nbsp;
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div6">

                    <a id="A7" href="javascript:toggle5('divforgardians', 'A7');">
                        <img src="../../images/addd11.png" style="margin-left: 0px;" />
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
                    <asp:TextBox ID="txtf1mobileno" PlaceHolder="Father Mobile No" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Alternate Mobile No.
                    </label>
                    <asp:TextBox ID="txtfatheralternateno" PlaceHolder="Father Alternate Mobile No" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
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
                    <asp:TextBox ID="txtmothermobileno" PlaceHolder="Mother Mobile No." runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Address Line 1</label>
                    <asp:TextBox ID="txtparentsaddress" PlaceHolder="Address Line 1" runat="server" TextMode="MultiLine"></asp:TextBox>&nbsp;
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="div345">

                    <a id="A3" href="javascript:toggle5('divforemployement', 'A3');">
                        <img src="../../images/addd11.png" style="margin-left: 0px; font-size: 13pt; color: #006EB8!important" />
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
                            </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            City</label>
                        <asp:DropDownList ID="ddlPCity" runat="server" AppendDataBoundItems="True">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Address Line 1</label>
                        <asp:TextBox ID="txtPaddress" PlaceHolder="Address Line 1" TextMode="MultiLine" runat="server" MaxLength="200"></asp:TextBox>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Pin/Zip Code</label>
                        <asp:TextBox ID="txtPPincode" PlaceHolder="Pin Code" runat="server" MaxLength="6"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Designation</label>
                        <asp:TextBox ID="txtPdesignation" PlaceHolder="Designation" runat="server" MaxLength="50"></asp:TextBox>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Salary (Per Month)</label>
                        <asp:TextBox ID="txtPsalary" PlaceHolder="Salary" runat="server" MaxLength="7"></asp:TextBox>&nbsp;
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Upload Experience letter</label>
                        <div id="divfileuploadforexperienceltr" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                            <asp:FileUpload runat="server" ID="fileuploadforexperienceltr" AllowMultiple="true" />
                            <asp:HiddenField ID="hfforexperienceletter" runat="server" />
                            <asp:HiddenField ID="hfforsalaryslip" runat="server" />
                            <asp:HiddenField ID="hfforappointment" runat="server" />
                            <asp:HiddenField ID="hfforresignation" runat="server" />
                            <asp:HiddenField ID="hfforofferletter" runat="server" />
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
                        <asp:TextBox ID="txtRef1Name" PlaceHolder="First Reference Name" runat="server"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Contact No.</label>
                        <asp:TextBox ID="txtReContact1" PlaceHolder="Contact No." runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Second Refrence Name</label>
                        <asp:TextBox ID="txtRef2Name" PlaceHolder="Second Reference Name" MaxLength="50" runat="server"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Contact No.</label>
                        <asp:TextBox ID="txtRefContact2" PlaceHolder="Contact No." runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                    </div>
                </div>
            </div>

            <h4 class="page-title txtblue ">
                <div id="Div2">

                    <a id="A4" href="javascript:toggle5('divforMedical', 'A4');">
                        <img src="../../images/addd11.png" style="margin-left: 0px;" />
                    </a><span id="Span5" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Medical Details </span>
                </div>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="divforMedical" style="display: block;">
                <div class="for_sigle_row_form">
                    <label>
                        Blood Group
                    </label>
                    <asp:TextBox ID="txtBGroup" PlaceHolder="Blood Group" MaxLength="6" runat="server"></asp:TextBox>
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

            <h4 class="page-title txtblue ">
                <div id="Div662">

                    <a id="A5" href="javascript:toggle5('divforAccount', 'A5');">
                        <img src="../../images/addd11.png" style="margin-left: 0px;" />
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
                    <asp:TextBox ID="txtBankName" PlaceHolder="Bank Name" runat="server" MaxLength="50"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Account No.</label>
                    <asp:TextBox ID="txtAccountNo" PlaceHolder="Account No" runat="server" MaxLength="20"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Branch Name</label>
                    <asp:TextBox ID="txtBranchName" PlaceHolder="Branch Name" MaxLength="40" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Branch ID</label>
                    <asp:TextBox ID="txtBranchCode" PlaceHolder="Branch ID" runat="server" MaxLength="15" Style="text-transform: none !important"></asp:TextBox>
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
                        <img src="../../images/addd11.png" style="margin-left: 0px;" />
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
                    <asp:TextBox ID="txtbiometricdetails" PlaceHolder="Biometric Details" runat="server" MaxLength="25" Style="text-transform: uppercase !important"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                </div>
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <br />
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button_save" OnClientClick="return check();" OnClick="btnSubmit_Click2" />
                <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="button2" Style="height: 35px!important" OnClick="Cancel_Click"
                    CausesValidation="false" />
            </div>
        </div>

        <asp:TextBox ID="txtqualification" Style="display: none" runat="server"></asp:TextBox>
        <asp:TextBox ID="txtboard" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtyear" runat="server" Width="124px" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtsession" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtrollnumber" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtpercent" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtinstituteaddress" runat="server" Style="display: none"></asp:TextBox>
    </div>
    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear() + 1;
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {

                $("#ctl00_ContentPlaceHolder1_txtdob").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "dd/mm/yy",

                });
                $(".DatePickerForTextBox").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy",

                });

            });

        });
    </script>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>