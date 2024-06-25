<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="create-new-offer-letter.aspx.cs" Inherits="BranchPanel_create_new_offer_letter" %>

<%@ Register Src="~/BranchPanel/employee/employe-management.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery-1.11.1.min.js"></script>

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <script src="../../Calender/js/jquery-ui-1.8.19.custom.min.js"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />st
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style type="text/css">
        .for {
            border-bottom: 1px solid #f5f5f5;
            height: auto;
            margin-bottom: 0;
            margin-left: 842px !important;
            margin-right: auto;
            padding: 5px 0;
            position: absolute;
            width: 250px !important;
        }

        .stm_head th {
            border-left: none !important;
            font-size: 14px !important;
            font-style: italic !important;
            padding: 0px 5px 0px 5px !important;
        }

        #ctl00_ContentPlaceHolder1_img {
            border: 3px solid green !important;
            height: 120px;
            width: 120px;
        }

        .activecreateoffer {
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

        #ctl00_ContentPlaceHolder1_gridforimagename tr td {
            padding: 5px;
        }

        #ctl00_ContentPlaceHolder1_chkboxlistforemails td {
            width: 40px !important;
        }

        #ctl00_ContentPlaceHolder1_rdbemployementtype label {
            float: none !important;
            margin-left: 10px !important;
        }

        #ctl00_ContentPlaceHolder1_rdbemployementtype input {
            margin-left: 10px !important;
        }

        #ctl00_ContentPlaceHolder1_chkboxlistforemails label {
            float: left !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-top: 0px;
            min-width: 67px;
            padding-top: 2px;
            text-align: left;
            width: auto !important;
        }

        .textfocus {
            border: solid 1px #99cc00 !important;
            box-shadow: 0 0 5px 1px #bce0fe !important;
        }

        .radiovalidate {
            border: 1px solid;
        }

        .texthover {
            border: solid 1px red !important;
        }

        #ctl00_ContentPlaceHolder1_rdGender label {
            width: 50px !important;
            margin-right: 5px!important;
            margin-top: -5px!important;
            padding-left: 12px!important;
        }

        .ui-datepicker-header {
            width: 245px!important;
            height: 23px!important;
        }
    </style>

    <script type="text/javascript">
        var cid = "0", sid = "0", did = "0", callfrom = 0, annualctc = 0, roll = 0;

        $(document).ready(function () {

            document.title = 'Create Offer Letter';

            $("#ctl00_ContentPlaceHolder1_lnkbtnforpermothercity").click(function () {

                alertify.confirm("Are you sure you want to enter other city? This city name will be permanently saved.", function (e) {
                    if (e) {
                        $("#ctl00_ContentPlaceHolder1_ddlCity").val("0");
                        $("#ctl00_ContentPlaceHolder1_divforpermanentothercity").css("display", "block");
                        $("#divforddlcity").css("display", "none");

                        return false;
                    }
                });

                return false;
            });

            $("#ctl00_ContentPlaceHolder1_lnkcancel").click(function () {
                $("#ctl00_ContentPlaceHolder1_txtothercity2").val("");
                $("#ctl00_ContentPlaceHolder1_divforpermanentothercity").css("display", "none");
                $("#divforddlcity").css("display", "block");
                return false;
            });

            if ($("#ctl00_ContentPlaceHolder1_hfvalue").val() != "") {
                $(".activecreateoffer").text("Edit Offer Letter");
            }
            else {
                $(".activecreateoffer").text("Create Offer Letter");
            }

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
            $("#ctl00_ContentPlaceHolder1_ddlcountry").change(function () {
                cid = $(this).val();

                fillstate();
            });
            $("#ctl00_ContentPlaceHolder1_ddlState").change(function () {
                sid = $(this).val();
                fillcity();
            });
            $("#ctl00_ContentPlaceHolder1_ddl_dept").change(function () {
                did = $(this).val();
                filldisig();

            });

            $("#ctl00_ContentPlaceHolder1_ddlDesigNation").change(function () {
                var ss = document.getElementById("ctl00_ContentPlaceHolder1_ddlDesigNation").value;

            });

            $("#ctl00_ContentPlaceHolder1_txtContactNo").on("change", function () {
                callfrom = 1;
                checkduplicaterecord();

            });

            $("#ctl00_ContentPlaceHolder1_txtEmailid").on("change", function () {
                callfrom = 2;
                checkduplicaterecord();

            });
            $("#ctl00_ContentPlaceHolder1_txtannualctc").on("change blur", function () {
                annualctc = $(this).val();

            });
            //===========this code is for file upload for picture blur==========
            $("#ctl00_ContentPlaceHolder1_fileuploadforpic").change(function () {
                var picdata = document.getElementById('<%= fileuploadforpic.ClientID %>');
                var FileUploadPath1 = picdata.value;

                if (FileUploadPath1 != '') {
                    var Extension1 = FileUploadPath1.substring(FileUploadPath1.lastIndexOf('.') + 1).toLowerCase();

                    if (Extension1 == "jpg" || Extension1 == "jpeg" || Extension1 == "bmp" || Extension1 == "gif" || Extension1 == "png" || Extension1 == "thm" || Extension1 == "psd") {
                        $("#ctl00_ContentPlaceHolder1_img").css("display", "block");

                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_img").css("display", "none");
                        document.getElementById('divforpicture').className = "texthover";
                        alertify.alert("You can not upload " + Extension1 + " file for picture. You can only upload .jpg, .jpeg, .bmp, .gif, .png, .thm or .psd file.");

                    }

                }
            });

            $("#ctl00_ContentPlaceHolder1_fileuploadforcv").blur(function () {
                cv_validation();

            });

            //====Email Validation==
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

            $("#ctl00_ContentPlaceHolder1_txtContactNo").blur(function () {
                if (document.getElementById('<%= txtContactNo.ClientID %>').value.trim() != "") {
                    var lnth = $("#ctl00_ContentPlaceHolder1_txtContactNo").val().length;
                    if (lnth < 10) {
                        document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";
                        alertify.error("Mobile number should not be less than 10 digits.");

                    }
                }
            });

        });

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
                         $("#ctl00_ContentPlaceHolder1_ddlState").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlState").append($("<option></option>").val(value.SID).html(value.stateName));
                         });
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
                         $("#ctl00_ContentPlaceHolder1_ddlCity").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlCity").append($("<option></option>").val(value.ctId).html(value.cityname));
                         });
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
                     url: "create-new-offer-letter.aspx/binddesignation",
                     data: "{'did':'" + did + "'}",
                     dataType: "json",
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

        function checkduplicaterecord() {

            var hidden = $("#ctl00_ContentPlaceHolder1_hfvalue").val();
            if (hidden == "") {
                var mob = document.getElementById("ctl00_ContentPlaceHolder1_txtContactNo").value;
                var email = document.getElementById("ctl00_ContentPlaceHolder1_txtEmailid").value;
                $.ajax(
                      {
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "create-new-offer-letter.aspx/checkrecord",
                          data: "{'mob':'" + mob + "','email':'" + email + "'}",
                          dataType: "json",
                          success: function (data) {

                              if (parseInt(data.d) > 0) {
                                  var name = $("#ctl00_ContentPlaceHolder1_txtFName").val() + " " + $("#ctl00_ContentPlaceHolder1_txtMName").val() + " " + $("#ctl00_ContentPlaceHolder1_txtLName").val();
                                  alertify.confirm("" + name + " has already been offered. Do you still want to offer?", function (e) {

                                      if (e == false) {
                                          if (callfrom == 1) {
                                              $("#ctl00_ContentPlaceHolder1_txtContactNo").val("");
                                              $("#ctl00_ContentPlaceHolder1_txtContactNo").focus();

                                          }
                                          else if (callfrom == 2) {
                                              $("#ctl00_ContentPlaceHolder1_txtEmailid").val("");
                                              $("#ctl00_ContentPlaceHolder1_txtEmailid").focus();
                                          }
                                      }
                                      callfrom = 0;

                                      return false;

                                  });
                              }

                          },

                      });
            }

        }

        //===this function is for cv validation and on blur====
        function cv_validation() {
            var fuData = document.getElementById('<%= fileuploadforcv.ClientID %>');
            var FileUploadPath = fuData.value;

            if (FileUploadPath != '') {
                var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

                if (Extension == "doc" || Extension == "docx" || Extension == "pdf" || Extension == "jpg" || Extension == "jpeg") {
                    if (Extension == "doc" || Extension == "docx") {
                        var wordlength = document.getElementById('<%= fileuploadforcv.ClientID %>').files.length;
                        if (wordlength > 1) {
                            document.getElementById('divforresume').className = "texthover";
                            alertify.alert("You can not upload multiple " + Extension + " files. You can only upload only single .doc or .docx file.");
                            return false;
                        }
                    }

                }
                else {
                    document.getElementById('divforresume').className = "texthover";
                    alertify.alert("You can not upload " + Extension + " file for resume. You can only upload .doc, .docx, .jpg, jpeg, or pdf  file.");
                    return false;
                }

            }
        }

        function check() {

            var st = confirm("Are you sure you want to submit ?");

            if (st == false) {
                return false;
            }
            else {
                var st2 = validationcheckSubmit();
                if (st2 == false) {
                    return false;
                }
                else {
                    return true;
                }
            }
        }

        function validationcheckSubmit() {

            var status = 1;

            var stat = comparedojandctcapplied();
            if (stat == false) {
                status = 0;
            }

            if (document.getElementById('<%= ddlTitle.ClientID %>').selectedIndex == 0) {
                document.getElementById('<%= ddlTitle.ClientID %>').className = "texthover";
                status = 0;
            }
            if (document.getElementById('<%= txtFName.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtFName.ClientID %>').className = "texthover";
                status = 0;
            }
            if (document.getElementById('<%= txtLName.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtLName.ClientID %>').className = "texthover";
                status = 0;
            }

            //===========this validation is for picture=================

            var picdata = document.getElementById('<%= fileuploadforpic.ClientID %>');
            var FileUploadPath1 = picdata.value;

            if (FileUploadPath1 != '') {
                var Extension1 = FileUploadPath1.substring(FileUploadPath1.lastIndexOf('.') + 1).toLowerCase();

                if (Extension1 == "jpg" || Extension1 == "jpeg" || Extension1 == "bmp" || Extension1 == "gif" || Extension1 == "png" || Extension1 == "thm" || Extension1 == "psd") { }
                else
                {
                    document.getElementById('divforpicture').className = "texthover";
                    alertify.alert("You can not upload " + Extension1 + " file. You can only upload .png, bmp, gif, png, thm, psd, .jpg or .jpeg file.");
                    status = 0;
                }

            }

            //===========this validation is for picture=================
            var status2 = cv_validation();
            if (status2 == false) {
                status = 0;
            }

            if (document.getElementById('<%= txtdob.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtdob.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= txtAddress.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtAddress.ClientID %>').className = "texthover";
                status = 0;
            }
            if (document.getElementById('<%= ddlcountry.ClientID %>').selectedIndex == 0) {
                document.getElementById('<%= ddlcountry.ClientID %>').className = "texthover";
                status = 0;
            }
            if (document.getElementById('<%= ddlState.ClientID %>').selectedIndex == 0) {
                document.getElementById('<%= ddlState.ClientID %>').className = "texthover";
                status = 0;
            }

            if ($("#ctl00_ContentPlaceHolder1_divforpermanentothercity").css("display") == "none") {
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

            if (document.getElementById('<%= txtPinCode.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtPinCode.ClientID %>').className = "texthover";
                status = 0;
            }

            var z = document.getElementById('<%= txtPinCode.ClientID %>').value;
            if (!z.match(/^[0-9]*$/)) {
                document.getElementById('<%= txtPinCode.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= ddl_dept.ClientID %>').selectedIndex == 0) {
                document.getElementById('<%= ddl_dept.ClientID %>').className = "texthover";
                status = 0;
            }
            if (document.getElementById('<%= ddlDesigNation.ClientID %>').selectedIndex == 0) {
                document.getElementById('<%= ddlDesigNation.ClientID %>').className = "texthover";
                status = 0;
            }
            if (document.getElementById('<%= txtdoi.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtdoi.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= txtDatejoining.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtDatejoining.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= ddlprobation.ClientID %>').selectedIndex == 0) {
                document.getElementById('<%= ddlprobation.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= txtannualctc.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtannualctc.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= txthrname.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txthrname.ClientID %>').className = "texthover";
                status = 0;
            }

            var z = document.getElementById('<%= txtannualctc.ClientID %>').value;
            if (!z.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {
                document.getElementById('<%= txtannualctc.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= txtContactNo.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= txtContactNo.ClientID %>').value.trim() != "") {
                var z = document.getElementById('<%= txtContactNo.ClientID %>').value;
                if (!z.match(/^[0-9]*$/)) {
                    document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";
                    status = 0;
                }
            }
            if (document.getElementById('<%= txtContactNo.ClientID %>').value.trim() != "") {
                var lnth = $("#ctl00_ContentPlaceHolder1_txtContactNo").val().length;
                if (lnth < 10) {
                    document.getElementById('<%= txtContactNo.ClientID %>').className = "texthover";
                    alertify.error("Mobile number should not be less than 10 digits.");
                    status = 0;
                }
            }

            if (document.getElementById('<%= txtEmailid.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtEmailid.ClientID %>').className = "texthover";
                status = 0;
            }

            var z = document.getElementById('<%= txtEmailid.ClientID %>').value;
            if (!z.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                document.getElementById('<%= txtEmailid.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%= ddlstatus.ClientID %>').selectedIndex == 0) {
                document.getElementById('<%= ddlstatus.ClientID %>').className = "texthover";
                status = 0;
            }

            if (status == 0) {
                alertify.error("Correct all above red marked fields.");
                $("html, body").animate({ scrollTop: 0 }, 2000);
                //$('#ctl00_ContentPlaceHolder1_lblmessageofvalidation').css("display", "block");
                return false;
            }
        }
        //=============this ready funcation is for remove validation of control focus==================
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_rdbemployementtype').click(function () {
                document.getElementById("divforradio").style.borderColor = "transparent";
            });

            $("#ctl00_ContentPlaceHolder1_chkboxlistforemails_2").click(function () {
                $('#ctl00_ContentPlaceHolder1_chkboxlistforemails_0').attr('checked', false);
                $('#ctl00_ContentPlaceHolder1_chkboxlistforemails_1').attr('checked', false);

            });

            $("#ctl00_ContentPlaceHolder1_txtContactNo").keyup(function () {
                var contactno = document.getElementById('ctl00_ContentPlaceHolder1_txtContactNo').value;
                if (!contactno.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtContactNo').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtannualctc").keyup(function () {
                var annualctc = document.getElementById('ctl00_ContentPlaceHolder1_txtannualctc').value;
                if (!annualctc.match(/^[1-9]\d*(?:\.\d{0,2})?$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtannualctc').value = "";
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtPinCode").keyup(function () {
                var pin = document.getElementById('ctl00_ContentPlaceHolder1_txtPinCode').value;
                if (!pin.match(/^\d+$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtPinCode').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtothercity2").focus(function () { $("#ctl00_ContentPlaceHolder1_txtothercity2").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlprobation").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlprobation").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlTitle").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlTitle").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtFName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtFName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtLName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtLName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtAddress").focus(function () { $("#ctl00_ContentPlaceHolder1_txtAddress").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlcountry").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlcountry").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlState").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlState").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlCity").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlCity").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtPinCode").focus(function () { $("#ctl00_ContentPlaceHolder1_txtPinCode").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddl_dept").focus(function () { $("#ctl00_ContentPlaceHolder1_ddl_dept").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlDesigNation").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDesigNation").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlstatus").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlstatus").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtdob").focus(function () { $("#ctl00_ContentPlaceHolder1_txtdob").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtdoi").focus(function () { $("#ctl00_ContentPlaceHolder1_txtdoi").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtDatejoining").focus(function () { $("#ctl00_ContentPlaceHolder1_txtDatejoining").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtannualctc").focus(function () { $("#ctl00_ContentPlaceHolder1_txtannualctc").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtContactNo").focus(function () { $("#ctl00_ContentPlaceHolder1_txtContactNo").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtEmailid").focus(function () { $("#ctl00_ContentPlaceHolder1_txtEmailid").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txthrname").focus(function () { $("#ctl00_ContentPlaceHolder1_txthrname").removeClass("texthover"); });
            $("#divforresume").click(function () { $("#divforresume").removeClass("texthover"); });
            $("#divforpicture").click(function () { $("#divforpicture").removeClass("texthover"); });

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
        function preview(input) {
            if (input.files && input.files[0]) {
                var ImageDir = new FileReader();
                ImageDir.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_img').attr('src', e.target.result);
                }
                ImageDir.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Offer Job</a></li>
            <li style="background: none;"><a class="active" href="#">Create Offer Letter</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
    </div>

    <div align="center" class="input_content" style="border: none; padding: 0px; margin-top: 0px;" id="divCreate" runat="server">
        <table class="MainTable" cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr>
                <td class="containerHeadline" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;">
                    <asp:Label ID="lblheading1" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

        <table style="width: 100%" id="FieldsetCreateBranch" runat="server">
            <tr>
                <td align="center">&nbsp;
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for">
                        <label>
                        </label>
                        <asp:ImageButton ID="img" Style="display: none" runat="server" OnClick="img_Click" />
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Title<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlTitle" runat="server" AppendDataBoundItems="True">
                        </asp:DropDownList>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Name<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtFName" runat="server" PlaceHolder="First Name" Style="width: 85px !important;"></asp:TextBox>&nbsp
                        <asp:TextBox ID="txtMName" runat="server" PlaceHolder="Middle Name" Style="width: 85px !important;"></asp:TextBox>&nbsp
                        <asp:TextBox ID="txtLName" runat="server" PlaceHolder="Last Name" Style="width: 85px !important;"></asp:TextBox>&nbsp
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Gender<span style="color: #ff0066">*</span></label>
                        <div style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px">
                            <asp:RadioButtonList ID="rdGender" runat="server" RepeatDirection="Horizontal" Width="200">
                                <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                                <asp:ListItem Value="0">Female</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            DOB<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtdob" runat="server" PlaceHolder="Date Of Birth" ReadOnly="true"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Upload Picture</label>
                        <div id="divforpicture" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px">
                            <asp:FileUpload ID="fileuploadforpic" runat="server" onchange="preview(this)" />
                            <asp:HiddenField ID="hfforpicture" runat="server" />
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Upload Resume</label>
                        <div id="divforresume" style="width: 312px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px; padding-bottom: 3px">
                            <asp:FileUpload ID="fileuploadforcv" runat="server" AllowMultiple="true" />
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form" id="divresume" runat="server" visible="false">
                        <label>
                            Uploaded Resume</label>
                        <asp:GridView ID="gridforimagename" AutoGenerateColumns="false" Width="312px" runat="server"
                            HeaderStyle-Height="30px" BorderWidth="0" GridLines="None">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSNo" Text='<%#Eval("Rownumber") %>' runat="server" CssClass="Row_num"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="File" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRefno" Text='<%#Eval("imagename") %>' Style="color: black" runat="server" ForeColor="Chocolate" CssClass="refNo"></asp:Label>
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
                </td>
            </tr>

            <tr>
                <td>
                    <asp:UpdatePanel ID="updatepanalRegion" runat="server">
                        <ContentTemplate>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <div class="for_sigle_row_form">
                                            <label>
                                                Country<span style="color: #ff0066">*</span></label>
                                            <asp:DropDownList ID="ddlcountry" runat="server">
                                            </asp:DropDownList>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="for_sigle_row_form">
                                            <label>
                                                State<span style="color: #ff0066">*</span></label>
                                            <asp:DropDownList ID="ddlState" runat="server">
                                                <asp:ListItem Value="0">---Select State---</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="divforddlcity" class="for_sigle_row_form">
                                            <label>
                                                City<span style="color: #ff0066">*</span></label>
                                            <asp:DropDownList ID="ddlCity" runat="server">
                                                <asp:ListItem Value="0">---Select City---</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:LinkButton ID="lnkbtnforpermothercity" runat="server" Style="font-size: 11px; color: chocolate; text-decoration: none" Text="Other"></asp:LinkButton>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="divforpermanentothercity" runat="server" style="display: none" class="for_sigle_row_form">
                                            <label>
                                                Other City<span style="color: #ff0066">*</span></label>
                                            <asp:TextBox ID="txtothercity2" PlaceHolder="Other City" runat="server" Style="text-transform: none !important"></asp:TextBox>
                                            <asp:LinkButton ID="lnkcancel" runat="server" Style="font-size: 11px; color: chocolate; text-decoration: none" Text="Cancel"></asp:LinkButton>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Address Line 1<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Pin/Zip Code<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtPinCode" PlaceHolder="Pin/Zip Code" runat="server" MaxLength="6"></asp:TextBox>&nbsp&nbsp
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Department<span style="color: #ff0066">*</span></label>
                                    <asp:DropDownList ID="ddl_dept" runat="server">
                                        <asp:ListItem Value="0">---Select Department---</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Designation<span style="color: #ff0066">*</span></label>
                                    <asp:DropDownList ID="ddlDesigNation" runat="server">
                                        <asp:ListItem Value="0">---Select Designation---</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Date of Interview:<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtdoi" PlaceHolder="Date of interview" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Offered D.O.J:<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtDatejoining" PlaceHolder="Date of joining" runat="server" ReadOnly="true"></asp:TextBox>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Probation Period:<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlprobation" runat="server"></asp:DropDownList>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Current CTC (Per Annum):<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtannualctc" PlaceHolder="Current CTC (Per Annum)" MaxLength="7" runat="server"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Managing Director:<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txthrname" PlaceHolder="Managing Director" ReadOnly="true" Text="XYZ" runat="server"></asp:TextBox>&nbsp&nbsp&nbsp
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Candidate Contact No.<span style="color: Red;">*</span></label>
                        <asp:TextBox ID="txtContactNo" PlaceHolder="Contact No." runat="server" MaxLength="10"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Candidate E-mail ID <span style="color: Red;">*</span></label>
                        <asp:TextBox ID="txtEmailid" PlaceHolder="Email ID" runat="server" Style="text-transform: none!important"></asp:TextBox>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Status<span style="color: #ff0066">*</span></label>
                                    <asp:DropDownList ID="ddlstatus" Enabled="false" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                        </label>
                        <asp:Label ID="lblSuccessMsg" runat="server" Text="" Font-Size="15px" EnableViewState="false"
                            ForeColor="Green"></asp:Label>
                    </div>
                </td>
            </tr>
            <tr id="TrSubmit" runat="server">
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                        </label>
                        <asp:Button ID="btnSubmit" runat="server" CssClass="button_save" Text="Submit" OnClientClick="return check()" OnClick="btnSubmit_Click" />
                        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" Text="Cancel"
                            CssClass="button2" Style="height: 34px!important" OnClick="btnCancel_Click"></asp:Button>
                    </div>
                </td>
            </tr>

            <tr id="TrUpdate" runat="server" visible="false">
                <td align="center" colspan="7">
                    <asp:Label ID="lblMs2g" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <div id="divProgressBar" class="progress"></div>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hfvforsortlist" runat="server" />
    <asp:HiddenField ID="hfvalue" runat="server" />
    <script type="text/javascript">

        var a = jQuery.noConflict();

        a(function () {
            var d = new Date();
            var y = d.getFullYear() + 1;

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                a("#ctl00_ContentPlaceHolder1_txtDatejoining").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy"
                    //minDate: new Date()
                });

                a("#ctl00_ContentPlaceHolder1_txtdob").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "dd/mm/yy",
                    maxDate: new Date(1996, 1, 18)
                });

                a("#ctl00_ContentPlaceHolder1_txtdoi").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",

                });

                a("#ctl00_ContentPlaceHolder1_txtDatejoining").change(function () {

                    comparedojandctcapplied();
                });
            });

        });

        function comparedojandctcapplied() {

            if (a("#ctl00_ContentPlaceHolder1_txtDatejoining").val() != "") {

                var doj = a.datepicker.parseDate('dd/mm/yy', a("#ctl00_ContentPlaceHolder1_txtDatejoining").val());
                var doi = a.datepicker.parseDate('dd/mm/yy', a("#ctl00_ContentPlaceHolder1_txtdoi").val());

                if (doj < doi) {
                    alertify.error("Date of joining can not be less than date of interview.");
                    document.getElementById('ctl00_ContentPlaceHolder1_txtDatejoining').className = "texthover";
                    return false;
                }
            }
        }
    </script>
</asp:Content>