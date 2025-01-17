﻿<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="RegExam.aspx.cs" Inherits="StudentPanel_RegExam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .main-content {
             min-height: 0px !important; 
        }
        .examactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }

         .examactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }
          .side-bar-wrapper .side-menu > li .examactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }
        .side-bar-wrapper .side-menu > li .examactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }

        .clsstarscolored {
            color: #e65124 !important;
        }

        *, *::before, *::after {
            box-sizing: border-box;
        }

        .rating > span:hover:before,
        .rating > span:hover ~ span:before {
            content: "☆" !important;
            position: absolute;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
            font-size: 11px !important;
            font-weight: normal !important;
        }

        .for_sigle_row_form label {
            width: 20%;
            text-align: right;
            font-size: 14px;
            font-weight: 500;
            font-family: Arial;
            margin-right: 20px;
        }

        .for_sigle_row_form textarea {
            width: 33%;
            height: 80px;
            border: 1px solid #ccc;
            color: #454545;
            font-family: Arial;
            padding: 5px;
            font-size: 12px;
        }

        .for_sigle_row_form select {
            background: #fff none repeat scroll 0 0;
            border: 1px solid #ccc;
            border-radius: 0;
            box-shadow: none;
            color: #676767;
            margin-bottom: 0;
            outline: medium none;
            padding: 6px 5px;
            width: 33%;
        }

        .btnClrStars {
            background-color: #49c0f0;
            background-image: linear-gradient(to bottom, #49c0f0, #2cafe3);
            border: 1px solid #15aeec;
            color: #ffffff;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 11px;
            font-weight: bold;
            padding: 3px 9px 4px;
            text-decoration: none;
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }
        .content-wrapper .content-inner {
            -webkit-box-shadow: 0px 2px 2px 2px rgba(0, 0, 0, 0.8);
            /* box-shadow: 0px 2px 40px 2px rgba(0, 0, 0, 0.8); */
            /* border-radius: 4px; */
        }
    </style>
        <script type="text/javascript">
            var year = 2018;
            $(document).ready(function () {
                BindFieldOnTheBehalfOfCheckUnCheck();
                Collapse();
                $('#imgbtnforcollapseorexpend').click(function () {
                    if ($(this).attr('src') == '../../images/Expend.png') {
                        Expende();
                        $(this).attr('src', '../../images/CollapseAllImages.png');
                    }
                    else {
                        Collapse();
                        $(this).attr('src', '../../images/Expend.png');
                    }
                });
                $("#ctl00_head_txtstudentdob,#ctl00_head_txtparentdateofbirth,#ctl00_head_txtsecondaryparentdateofbirth,#ctl00_head_txtregistrationdate,#ctl00_head_txtchkddneftrefdate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + year,
                    dateFormat: 'dd MM yy'
                });

               <%-- $('#<%=fileuploaderofstudentphotograph.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#stuphotograph').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test();

                }
            
            $('#<%=fileuploaderofbirthcertificate.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#stucertifiacte').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test2();

                }
            });
            $('#<%=fileuploaderofparentphotograph.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#parentfirstphoto').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test3();

                }
            });
            $('#<%=fileuploadforsecondaryparentphotograph.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#secondaryparentphoto').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test4();

                }
            });--%>
                $('#ctl00_head_rbtnlistnationality input').change(function () {
                    if ($(this).val() == '1') {
                        $('#divforothercountry').css('display', 'none');
                        $('#ctl00_head_txtcountryname').val('India');
                    }
                    else {
                        $('#divforothercountry').css('display', 'block');
                        $('#ctl00_head_txtcountryname').val('');
                    }
                });
                $('#ctl00_head_ddlregistrationsession').change(function () {
                    $('#ctl00_head_ddlapplyingforclass').html('');
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "REgExam.aspx/BindClassDDL",
                        data: "{'Fyid':'" + $(this).val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            $('#ctl00_head_ddlapplyingforclass').html('<option value="0">--Select Class--</option>');
                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    $('#ctl00_head_ddlapplyingforclass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                                }
                            }
                        }
                    });
                });
                $('#ctl00_head_ddlapplyingforclass').change(function () {
                    var ClassId = $('#ctl00_head_ddlapplyingforclass').val();
                    var Fyid = $('#ctl00_head_ddlregistrationsession').val();
                    if (parseInt(Fyid) == 0) {
                        alertify.error("Select Session First.");
                        $('#ctl00_head_ddlapplyingforclass').val('0');
                        return false;
                    }
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "REgExam.aspx/ProcessIT",
                        data: "{'ClassId':'" + ClassId + "','Fyid':'" + Fyid + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != '')
                                $('#ctl00_head_txtregistrationfee').val(data.d);
                            else
                                $('#ctl00_head_txtregistrationfee').val('0.00');
                        }
                    });
                });
                $('#ctl00_head_btnforgenAdmit').click(function () {
                    window.open('AdmitCard.aspx', '_newtab');
                    return false;
                });
                $('#ctl00_head_btnforupdateorsave').click(function () {
                    if ($('#ctl00_head_ddlregistrationsession').val() == '0') {
                        alertify.error('Select registration  session please.');
                        $('#ctl00_head_ddlregistrationsession').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtstudentfirstname').val() == '') {
                        alertify.error('Enter student first name please.');
                        $('#ctl00_head_txtstudentfirstname').focus();
                        return false;
                    }
                    if ($('#ctl00_head_ddlsection').val() == '0') {
                        alertify.error('Select Section please.');
                        $('#ctl00_head_ddlsection').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtstudentdob').val() == '') {
                        alertify.error('Select Date of birth please,');
                        $('#ctl00_head_txtstudentdob').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtOldRegNo').val() != '') {
                        $.ajax({
                            type: 'POST',
                            contentType: "application/json; charset=utf-8",
                            url: "REgExam.aspx/checlOldAdmNo",
                            data: "{'RefAdmNo':'" + $('#ctl00_head_txtOldRegNo').val() + "'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d.length > 0) {
                                    alertify.error('Enter Student Aadhaar Car No.');
                                    $('#ctl00_head_txtOldRegNo').focus();
                                    return false;
                                }
                            }
                        });
                    }
                    else if ($('#ctl00_head_txtstudentUid').val() != '') {
                        if ($('#ctl00_head_txtstudentUid').val().length != 12) {
                            alertify.error('Student Aadhaar Card No. only 12 Digits');
                            $('#ctl00_head_txtstudentUid').focus();
                            return false;
                        }
                    }
                    else if ($('#ctl00_head_txtreligion').val() == '') {
                        alertify.error('Enter religion please.');
                        $('#ctl00_head_txtreligion').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_ddlapplyingforclass').val() == '0') {
                        alertify.error('Select class please.');
                        $('#ctl00_head_ddlapplyingforclass').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtaddress').val() == '') {
                        alertify.error('Enter address please.');
                        $('#ctl00_head_txtaddress').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtaddress').val().indexOf(',') !== -1) {
                        alertify.error('Comma is not allows in address .');
                        $('#ctl00_head_txtaddress').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtcity').val() == '') {
                        alertify.error('Enter city please.');
                        $('#ctl00_head_txtcity').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtstate').val() == '') {
                        alertify.error('Enter state please.');
                        $('#ctl00_head_txtstate').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtpiorzipcode').val() == '') {
                        alertify.error('Enter pincode/zipcode please.');
                        $('#ctl00_head_txtpiorzipcode').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtcountry').val() == '') {
                        alertify.error('Enter country please.');
                        $('#ctl00_head_txtcountry').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_ddlparenttype').val() == '0') {
                        alertify.error('Select primary parent type please.');
                        $('#ctl00_head_ddlparenttype').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtparentfirstname').val() == '') {
                        alertify.error('Enter primary parent first name please.');
                        $('#ctl00_head_txtparentfirstname').focus();
                        return false;
                    }
                        //else if ($('#ctl00_head_txtparentlastname').val() == '') {
                        //    alertify.error('Enter primary parent last name please.');
                        //    $('#ctl00_head_txtparentlastname').focus();
                        //    return false;
                        //}
                    else if ($('#ctl00_head_txtregistrationfee').val() == '') {
                        alertify.error('Enter Registration Fee Please.');
                        $('#ctl00_head_txtregistrationfee').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtparentmobileno').val() == '') {
                        alertify.error('Enter Parent Mobile No.');
                        $('#ctl00_head_txtparentmobileno').focus();
                        return false;
                    }
                    else if ($('#ctl00_head_txtparentemailid').val() == '0') {
                        alertify.error('Enter Parent Email ID please.');
                        $('#ctl00_head_txtparentemailid').focus();
                        return false;
                    }
                    else 
                    if (parseInt($('#ctl00_head_ddlpaymentmode').val()) > 1) {
                        if ($('#ctl00_head_txtchkddneftbankname').val() == '') {
                            alertify.error('Enter bank name please.');
                            $('#ctl00_head_txtchkddneftbankname').focus();
                            return false;
                        }
                        else if ($('#ctl00_head_txtchkddneftbranchname').val() == '') {
                            alertify.error('Enter bank brach name please.');
                            $('#ctl00_head_txtchkddneftbranchname').focus();
                            return false;
                        }
                        else if ($('#ctl00_head_txtchkddneftrefno').val() == '') {
                            alertify.error('Enter refrence number please.');
                            $('#ctl00_head_txtchkddneftrefno').focus();
                            return false;
                        }
                        else if ($('#ctl00_head_txtchkddneftrefdate').val() == '') {
                            alertify.error('Select refrence date please.');
                            $('#ctl00_head_txtchkddneftrefdate').focus();
                            return false;
                        }
                    }
                    else if ($('#ctl00_head_txtregistrationdate').val() == '') {
                        alertify.error('Select registration date please.');
                        $('#ctl00_head_txtregistrationdate').focus();
                        return false;
                    }
                });
                $('#ctl00_head_ddlpaymentmode').change(function () {
                    if (parseInt($(this).val()) > 1)
                        $('#ctl00_head_divbankname,#ctl00_head_divbranchname,#ctl00_head_divrefnumber,#ctl00_head_divrefdate').css('display', 'block');
                    else
                        $('#ctl00_head_divbankname,#ctl00_head_divbranchname,#ctl00_head_divrefnumber,#ctl00_head_divrefdate').css('display', 'none');
                });
                $("#ctl00_head_txtparentemailid,#ctl00_head_txtsecondaryparentemailid").blur(function () {
                    var emailid = $(this).val();
                    if (emailid != '') {
                        var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
                        if (!reg.test(emailid)) {
                            alertify.error('Please Enter Valid Email-Id ( ie: amitsharma@awapal.com).');
                            document.getElementById('<%=txtparentemailid.ClientID%>').value = '';

                        return false;
                    }
                }
            });
                $('#ctl00_head_txtregistrationdate').change(function () {
                    $.ajax({
                        type: "POST",
                        url: "REgExam.aspx/IsReadyForAction",
                        data: "{'Date':'" + $(this).val() + "','Fyid':'" + $('#ctl00_head_ddlregistrationsession').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != 1) {
                                $('#ctl00_head_txtregistrationdate').val('');
                                alert('Registartion Process Is Off For The Selected Session And Registration Date.\nPlease Select Valid Session And Registration Date.');
                            }
                        },
                    });
                });
            });
        function test() {

    <%--       // var uploadControl = document.getElementById('<%=fileuploaderofstudentphotograph.ClientID%>');--%>
            uploadControl.value = "";
        }
        function test2() {

<%--            //var uploadControl = document.getElementById('<%=fileuploaderofbirthcertificate.ClientID%>');--%>
            uploadControl.value = "";
        }
        function test3() {

          <%-- // var uploadControl = document.getElementById('<%=fileuploaderofparentphotograph.ClientID%>');--%>
            uploadControl.value = "";
        }
        function test4() {

   <%--       //  var uploadControl = document.getElementById('<%=fileuploadforsecondaryparentphotograph.ClientID%>');--%>
            uploadControl.value = "";
        }
        function ShowpImagePreviewstudentphotograph(input) {


            $('#ctl00_head_stuphotograph').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_head_imguser').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImagePreviewshowbirthcertificate(input) {
            $('#ctl00_head_stucertifiacte').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_head_Image1').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImageParentphotograph(input) {
            $('#ctl00_head_parentfirstphoto').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_head_Image2').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImageParentphotographsecond(input) {
            $('#ctl00_head_secondaryparentphoto').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_head_Image3').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function BindFieldOnTheBehalfOfCheckUnCheck() {
            $.ajax({
                type: "POST",
                url: "REgExam.aspx/CheckCheckboxOnTheBehalfOfPermission",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        if (value.Displaystatus == 'none') {
                            $('#' + value.DivName + '').remove();
                        }
                        else {
                            $('#' + value.DivName + '').css('display', 'block');
                        }
                    });
                },
            });
        }
        //-------function for used validation----------
        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
          ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
          (charCode < 97 || charCode > 122)) {
                alertify.error("Please Enter Character Only.");
                return false;
            }
            else
                return true;
        };
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            else
                return true;
        }
        //-----------------------------------------------
        function Collapse() {
            $('#AdmissionNo,#StudentMiddleName,#BirthPlace,#MotherTongue,#NoOfSiblings,#TransportationRequired,#DocumentSubmitted,#AdditionalInformation,#BirthCertificate,#BloodGroup' +
            ',#SchoolName,#SchoolBoard,#SchoolMedium,#SchoolPreviousClassName,#SchoolPercentageInPreviousClass,#SchoolAddress,#SchoolContactNo,#SchoolAlternateContactNo,#SchoolWebsite' +
            ',PrimaryParentDOB,#PrimaryParentNationality,#PrimaryHighestQualification,#PrimaryParentOccupation,#PrimaryDesignation,#PrimaryNameOfOrganization,#PrimaryAddressOfOfficeBusiness,#PrimaryParentAnnualIncome,#PrimaryAddress,#PrimaryCity,#PrimaryState,#PrimaryPinZipCode,#PrimaryCountry,#PrimaryPhoneNo,#PrimaryEmailId,#PrimaryParentDOB,#PrimaryUploadParentPhotograph' +
            ',#SecondarySelectParentType,#SecondaryParentFirstName,#SecondaryParentMiddleName,#SecondaryParentLastName,#SecondaryParentDOB,#SecondaryParentNationality,#SecondaryHighestQualification,#SecondaryParentOccupation,#SecondaryDesignation,#SecondaryNameOfOrganization,SecondaryAddressOfOfficeBusiness,SecondaryParentAnnualIncome,#SecondaryAddress,#SecondaryCity,#SecondaryState,#SecondaryPinZipCode,#SecondaryCountry,#SecondaryPhoneNo,#SecondaryMobileNo,#SecondaryEmailId,#SecondaryUploadParentPhotograph,#SecondaryAddressOfOfficeBusiness,#SecondaryParentAnnualIncome' +
            ',#EmergencyName,#EmergencyMobileNo,#EmergencyAlternateMobileNo,#EmergencyPhoneNo,#EmergencyAddress,#EmergencyCity, EmergencyState,#EmergencyPinZipCode,#EmergencyCountry,#EmergencyState' +
            ',#Comment').css("display", "none");
        }
        function Expende() {
            $('#AdmissionNo,#StudentMiddleName,#BirthPlace,#MotherTongue,#NoOfSiblings,#TransportationRequired,#DocumentSubmitted,#AdditionalInformation,#BirthCertificate,#BloodGroup' +
            ',#SchoolName,#SchoolBoard,#SchoolMedium,#SchoolPreviousClassName,#SchoolPercentageInPreviousClass,#SchoolAddress,#SchoolContactNo,#SchoolAlternateContactNo,#SchoolWebsite' +
            ',PrimaryParentDOB,#PrimaryParentNationality,#PrimaryHighestQualification,#PrimaryParentOccupation,#PrimaryDesignation,#PrimaryNameOfOrganization,#PrimaryAddressOfOfficeBusiness,#PrimaryParentAnnualIncome,#PrimaryAddress,#PrimaryCity,#PrimaryState,#PrimaryPinZipCode,#PrimaryCountry,#PrimaryPhoneNo,#PrimaryEmailId,#PrimaryParentDOB,#PrimaryUploadParentPhotograph' +
            ',#SecondarySelectParentType,#SecondaryParentFirstName,#SecondaryParentMiddleName,#SecondaryParentLastName,#SecondaryParentDOB,#SecondaryParentNationality,#SecondaryHighestQualification,#SecondaryParentOccupation,#SecondaryDesignation,#SecondaryNameOfOrganization,SecondaryAddressOfOfficeBusiness,SecondaryParentAnnualIncome,#SecondaryAddress,#SecondaryCity,#SecondaryState,#SecondaryPinZipCode,#SecondaryCountry,#SecondaryPhoneNo,#SecondaryMobileNo,#SecondaryEmailId,#SecondaryUploadParentPhotograph,#SecondaryAddressOfOfficeBusiness,#SecondaryParentAnnualIncome' +
            ',#EmergencyName,#EmergencyMobileNo,#EmergencyAlternateMobileNo,#EmergencyPhoneNo,#EmergencyAddress,#EmergencyCity, EmergencyState,#EmergencyPinZipCode,#EmergencyCountry,#EmergencyState' +
            ',#Comment').css("display", "block");
        }
        function CalculateAge() {

            var chunks = $('#ctl00_head_txtstudentdob').val().split(' ');
            var CalculateDate = chunks[2] + '-' + chunks[1] + '-' + chunks[0];
            //$('#ctl00_head_txtdob1').val(CalculateDate);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "REgExam.aspx/GetYearMonthDate",
                data: "{'Date':'" + CalculateDate + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == '0') {
                        alertify.error('Enter Valid Date Please.')
                        $('#ctl00_head_txtstudentdob').val('');
                        $('#ctl00_head_txtstudentdob').focus();
                        return false;
                    }
                    $('#lblAge').html(data.d);
                    $('#lblAge').css("", "");
                }
            });
        }
    </script>

    <div class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="clearfix">
                    </div>
                    <h1>
                        <i class="fa fa-edit"></i>
                        REGISTRATION
                    </h1>
                </div>
            </div>
            <div class="main-content" style="width: 100%;">
                <div class="for_sigle_row_form" runat="server" visible="false">
                    <label>
                        Registered No:</label>
                    <asp:TextBox runat="server" ID="txtOldRegNo" placeholder="Enter Student First Name"></asp:TextBox>
                </div>
                <div class="clear"></div>                
                <div class="for_sigle_row_form">
                    <label>
                        Registration Session: <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlregistrationsession" runat="server" Style="width: 28%; height: 30px;">
                    </asp:DropDownList>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Branch Name: <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlBranch" runat="server" Style="width: 28%; height: 30px;">
                    </asp:DropDownList>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Student First Name: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtstudentfirstname" placeholder="Enter Student First Name"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Student Middle Name:</label>
                    <asp:TextBox runat="server" ID="txtstudentmiddlename" placeholder="Enter Student Middle Name"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Student Last Name:</label>
                    <asp:TextBox runat="server" ID="txtstudentlastname" placeholder="Enter Student Last Name"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Student D.O.B: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtstudentdob" placeholder="Enter Student DOB"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Student Aadhaar Card(UID) No:</label>
                    <asp:TextBox runat="server" ID="txtstudentUid" placeholder="Enter Student Aadhaar Card(UID) No" onkeypress="return isNumberKey(event)" maxlength="12"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label class="col-sm-4">
                        Gender:</label>
                    <asp:RadioButtonList ID="rbtnlistgender" runat="Server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Male" Value="1" Selected></asp:ListItem>
                        <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label class="col-sm-4">
                        Nationality:</label>
                    <asp:RadioButtonList ID="rbtnlistnationality" runat="Server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Indian" Value="1" Selected></asp:ListItem>
                        <asp:ListItem Text="Other" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="clear"></div>
                 <div class="for_sigle_row_form">
                    <label>
                        Religion:<span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtreligion" placeholder="Enter Student Aadhaar Card(UID) No"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label class="col-sm-4">
                        Cast/Category:</label>
                    <asp:RadioButtonList ID="rbtnlistcast" runat="Server" RepeatDirection="Horizontal"  Width="30%">
                        <asp:ListItem Text="General" Value="1" Selected></asp:ListItem>
                        <asp:ListItem Text="OBC" Value="2"></asp:ListItem>
                        <asp:ListItem Text="SC" Value="3"></asp:ListItem>
                        <asp:ListItem Text="ST" Value="4"></asp:ListItem>
                        <asp:ListItem Text="Minority" Value="5"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="clear"></div>
                 <div class="for_sigle_row_form">
                    <label>
                        Applying For Class: <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlapplyingforclass" runat="server" Style="width: 28%; height: 30px;">
                    </asp:DropDownList>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Address: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtaddress" Height="100px" placeholder="Enter Address"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        City: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtcity" placeholder="Enter City"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        State: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtstate" placeholder="Enter State"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtpiorzipcode" placeholder="Enter Pin/Zip Code" maxlength="6" onkeypress="return isNumberKey(event)"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Country: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtcountryname" placeholder="Enter Student DOB"></asp:TextBox>
                </div>
                <div class="clear"></div>

            </div>
            <div class="content-inner">
                <div class="page-header">
                    <div class="clearfix">
                    </div>
                    <h1>
                        <i class="fa fa-edit"></i>
                        Student Parent Details
                    </h1>
                </div>
            </div>
            <div class="main-content" style="width: 100%;">
                <div class="for_sigle_row_form">
                    <label>
                        Select Parent Type: <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlparenttype" runat="server" Style="width: 28%; height: 30px;">
                    </asp:DropDownList>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent First Name: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtparentfirstname" placeholder="Enter Student First Name"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Middle Name:</label>
                    <asp:TextBox runat="server" ID="txtparentmiddlename" placeholder="Enter Student Middle Name"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Last Name:</label>
                    <asp:TextBox runat="server" ID="txtparentlastname" placeholder="Enter Student Last Name"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Mobile No: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtparentmobileno" placeholder="Enter Parent Mobile No" onkeypress="return isNumberKey(event)" maxlength="10"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Email ID: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtparentemailid" placeholder="Enter Parent Email ID"></asp:TextBox>
                </div>
                <div class="clear"></div>
            </div>
            <!--<div class="content-inner">
                <div class="page-header">
                    <div class="clearfix">
                    </div>
                    <h1>
                        <i class="fa fa-edit"></i>
                        Registration Fee Details
                    </h1>
                </div>
            </div>--!>
            <!--<div class="main-content" style="width: 100%;">
                <div class="for_sigle_row_form">
                    <label>
                        Registration Fee: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtregistrationfee" placeholder="Enter Registration Fee" onkeypress="return isNumberKey(event)"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Payment Mode: <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlpaymentmode" runat="server" Style="width: 28%; height: 30px;">
                        <asp:ListItem Value="1" Text="Cash"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Cheque"></asp:ListItem>
                        <asp:ListItem Value="3" Text="DD"></asp:ListItem>
                        <asp:ListItem Value="3" Text="NEFT"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Exam Mode: <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlExamMode" runat="server" Style="width: 28%; height: 30px;">
                        <asp:ListItem Value="1" Text="Online"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Offline" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="clear"></div>
               <div class="for_sigle_row_form" id="divbankname" style="display: none" runat="server">
                        <label>
                            Bank Name</label>
                        <asp:TextBox ID="txtchkddneftbankname" runat="server" MaxLength="25" Placeholder="Enter Bank Name"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form" id="divbranchname" style="display: none" runat="server">
                        <label>
                            Branch Name</label>
                        <asp:TextBox ID="txtchkddneftbranchname" MaxLength="25" runat="server" Placeholder="Enter Branch Name"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form" id="divrefnumber" style="display: none" runat="server">
                        <label>
                            Cheque Number</label>
                        <asp:TextBox ID="txtchkddneftrefno" MaxLength="25" runat="server" Placeholder="Enter Refrence Number"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form" id="divrefdate" style="display: none" runat="server">
                        <label>
                            Cheque Date</label>
                        <asp:TextBox ID="txtchkddneftrefdate" onkeypress="return false" runat="server" Placeholder="Enter Refrence Date"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="clear"></div>
            </div>
            <div class="content-inner">
                <div class="page-header">
                    <div class="clearfix">
                    </div>
                    <h1>
                        <i class="fa fa-edit"></i>
                        For Office Use Only
                    </h1>
                </div>
            </div>
            <div class="main-content" style="width: 100%;">
                <div class="for_sigle_row_form">
                    <label>
                        Registration Date: <span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtregistrationdate" placeholder="Enter Registration Date"></asp:TextBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" runat="server" visible="false">
                    <label>
                        Is Required Admit Card: <span style="color: Red">*</span></label>
                    <asp:CheckBox runat="server" ID="chkReceipt"></asp:CheckBox>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>Save/Update
                    </label>
                    <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" CssClass="button_save" Style="padding-top: 4px; padding-bottom: 4px;" OnClick="btnforupdateorsave_Click" />

                    <asp:Button ID="btnforupdateorreset" runat="server" Text="cancel" ToolTip="Click here for cancel" CssClass="button_save" Style="padding-top: 4px; padding-bottom: 4px;" Visible="true" OnClick="btnforreset_Click" />

                    <asp:Button ID="btnforgenAdmit" runat="server" Text="Generate Admit Card" ToolTip="Click here for cancel" CssClass="button_save" Style="padding-top: 4px; padding-bottom: 4px;" Visible="false" />
                </div>
            </div>--!>
        </div>
    </div>
    <link href="../css/stylesheet.css" rel="stylesheet" />
    <link href="../css/product-listing.css" rel="stylesheet" />
</asp:Content>


