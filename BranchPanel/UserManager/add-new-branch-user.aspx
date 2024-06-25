﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="add-new-branch-user.aspx.cs" Inherits="BranchPanel_UserManager_add_new_branch_user" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style>
        #ctl00_ContentPlaceHolder1_radiobuttonlistformanageotpodp input {
            float: left !important;
            width: 15px !important;
            margin-left: 5px;
        }

        #ctl00_ContentPlaceHolder1_radiobuttonlistformanageotpodp label {
            width: 50px !important;
            padding-top: 0px !important;
        }

        #ctl00_ContentPlaceHolder1_radioformailcheck input {
            float: left !important;
            width: 15px !important;
            margin-left: 5px;
        }

        #ctl00_ContentPlaceHolder1_radioformailcheck label {
            width: 50px !important;
            padding-top: 0px !important;
        }

        #ctl00_ContentPlaceHolder1_radiobuttonforsmscheck input {
            float: left !important;
            width: 15px !important;
            margin-left: 5px;
        }

        #ctl00_ContentPlaceHolder1_radiobuttonforsmscheck label {
            width: 50px !important;
            padding-top: 0px !important;
        }

        #ctl00_ctl00_ContentPlaceHolder1_CompareValidator1 {
            margin-left: 578px;
            left: 0;
            margin-top: 5px;
            position: absolute;
            width: 184px;
        }

        .for_sigle_row_form {
            margin-bottom: 0;
            margin-left: 10%;
            margin-right: auto;
            padding: 5px 0;
            width: 100%;
        }

        .for {
            border-bottom: 1px solid #f5f5f5;
            height: auto;
            margin-bottom: 0;
            margin-left: 842px !important;
            margin-right: auto;
            padding: 5px 0;
            position: absolute;
            width: 250px !important;
            margin-top: 15px;
        }

        #ctl00_ContentPlaceHolder1_rdGender label {
            width: 50px !important;
            padding-top: 0px !important;
        }

        .textfocus {
            border: solid 1px #99cc00 !important;
            box-shadow: 0 0 5px 1px #bce0fe !important;
            color: black;
            background-color: white !important;
        }

        .texthover {
            border: dotted 1px white !important;
            background-color: #FD3018 !important;
            color: white !important;
        }

        #result {
            margin-left: 5px;
        }

        #divforpassword .short {
            color: #FF0000;
        }

        #divforpassword .weak {
            color: #E66C2C;
        }

        #divforpassword .good {
            color: #2D98F3;
        }

        #divforpassword .strong {
            color: #006400;
        }
    </style>
    <style>
        .txtrePassstregthtooshortdiv, .txtrePassstregthweakdiv, .txtrePassstregthgooddiv, .txtrePassstregthstrongdiv, .txtPassstregthtooshortdiv, .txtPassstregthweakdiv, .txtPassstregthgooddiv, .txtPassstregthstrongdiv {
            width: 300px;
            height: 200px;
            border: 1px solid black;
            -webkit-animation: mymove 5s infinite; /* Chrome, Safari, Opera */
            animation: mymove 5s infinite;
        }

        /* Chrome, Safari, Opera */
        @-webkit-keyframes mymove {
            50% {
                border-radius: 50px;
            }
        }

        /* Standard syntax */
        @keyframes mymove {
            50% {
                border-radius: 50px;
            }
        }
    </style>
    <%--this script is for $(document).ready() function call start here--%>
     <script type="text/javascript">
         var cid = "0", sid = "0", did = "0";
         $(document).ready(function () {

             $('.imgforaddip').click(function () {
                 if ($('.chkforip').attr('checked') == 'checked') {
                     Divcontent = '<div class="for_sigle_row_form">' +
                     '<label style="padding-top: 1px;"> Identify User By IP</label>' +
                     '<input class="txtipforlogin" type="text" placeholder="Enter The IP Adress Please">' +
                     '<img class="imgsubforip" src="../../images/minus.png" style="width: 16px;cursor: pointer;margin-top:-6px" alt="No Image">' +
                     '</div>'
                     $(this).parent('div').parent('div').append(Divcontent);
                 }
                 else {
                     alertify.error('Please Check The Checkbox First.');
                 }
                 return false;
             });
             $('.imgsubforip').live('click', function () {
                 $(this).parent('div').remove();
                 return false;
             });
             $('.imgfroaddmac').click(function () {
                 if ($('.chkformac').attr('checked') == 'checked') {
                     Divcontent = '<div class="for_sigle_row_form">' +
                     '<label style="padding-top: 1px;"> Identify User By MAC</label>' +
                     '<input class="txtmacforlogin" type="text" placeholder="Enter The MAC Adress Please">' +
                     '<img class="imgsubformac" src="../../images/minus.png" style="width: 16px;cursor: pointer;margin-top:-6px" alt="No Image">' +
                     '</div>'
                     $(this).parent('div').parent('div').append(Divcontent);
                 }
                 else {
                     alertify.error('Please Check The Checkbox First.');
                 }
                 return false;
             });
             $('.imgsubformac').live('click', function () {
                 $(this).parent('div').remove();
                 return false;
             });
             $("input[type=radio][id*=radiobuttonlistformanageotpodp]").change(function () {
                 if (parseInt($(this).val()) == 1 || parseInt($(this).val()) == 2) {
                     $('.tractivewhenotpodtselected').css("display", "block");
                     if (parseInt($(this).val()) == 1) {
                         $('#lblotpotpemail').html('Email OTP');
                         $('#lblotpotpsms').html('Sms OTP');
                     }
                     else {
                         $('#lblotpotpemail').html('Email ODP');
                         $('#lblotpotpsms').html('Sms ODP');
                     }
                 }
                 else if (parseInt($(this).val()) == 3) {
                     $('.tractivewhenotpodtselected').css("display", "none");
                 }
             });
             $('#ctl00_ContentPlaceHolder1_txtrefno').blur(function () {
                 FillDetailsOnTheBehalfOfRefNo();
             });
             $("#ctl00_ContentPlaceHolder1_txtemailaddress").blur(function () {
                 if (document.getElementById('<%= txtemailaddress.ClientID %>').value.trim() != "") {
                    var z = document.getElementById('<%= txtemailaddress.ClientID %>').value;
                    if (!z.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                        document.getElementById('<%= txtemailaddress.ClientID %>').className = "texthover";
                        alertify.error("Please enter the correct email address.");
                    }
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtRePass").blur(function () {
                if ($("#ctl00_ContentPlaceHolder1_txtPass").val().trim() != "" && $(this).val().trim() != "") {
                    var pass = document.getElementById('<%= txtPass.ClientID %>').value.trim();
                    var repass = document.getElementById('<%= txtRePass.ClientID %>').value.trim();
                    if (pass != repass) {
                        alertify.error("Password and confirm password should be same.");
                        $("#divforpassword").addClass("texthover");
                        $("#divforconfirmpassword").addClass("texthover");
                    }
                }
                return false;
            });

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
            $("#ctl00_ContentPlaceHolder1_ddlcountry").change(function () { cid = $(this).val(); fillstate(); });
            $("#ctl00_ContentPlaceHolder1_ddlState").change(function () { sid = $(this).val(); fillcity(); });
            $("#ctl00_ContentPlaceHolder1_txtmobile").keyup(function () { prevent_alphabet($(this).val(), $(this).attr('id')); });
            $("#ctl00_ContentPlaceHolder1_txtPinCode").keyup(function () { prevent_alphabet($(this).val(), $(this).attr('id')); });
            $("#ctl00_ContentPlaceHolder1_txtmobile").keyup(function () { prevent_alphabet($(this).val(), $(this).attr('id')); });
            $("#ctl00_ContentPlaceHolder1_txtmobile").blur(function () { if ($(this).val() != "") { check_length($(this).attr('id'), $(this).val().length, 'Mobile'); } });
            $("#ctl00_ContentPlaceHolder1_txtemailaddress").focus(function () { $("#ctl00_ContentPlaceHolder1_txtemailaddress").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtUserName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtUserName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtFName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtFName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtLName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtLName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtmobile").focus(function () { $("#ctl00_ContentPlaceHolder1_txtmobile").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtcountry").focus(function () { $("#ctl00_ContentPlaceHolder1_txtcountry").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtstate").focus(function () { $("#ctl00_ContentPlaceHolder1_txtstate").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtcity").focus(function () { $("#ctl00_ContentPlaceHolder1_txtcity").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtaddress").focus(function () { $("#ctl00_ContentPlaceHolder1_txtaddress").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtPinCode").focus(function () { $("#ctl00_ContentPlaceHolder1_txtPinCode").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtPass").focus(function () { $("#ctl00_ContentPlaceHolder1_txtPass").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtRePass").focus(function () { $("#ctl00_ContentPlaceHolder1_txtRePass").removeClass("texthover"); });
            $("#divforpicture").click(function () { $("#divforpicture").removeClass("texthover"); });
            $("#divforpassword").click(function () { $("#divforpassword").removeClass("texthover"); });
            $("#divforconfirmpassword").click(function () { $("#divforconfirmpassword").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtUserName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtUserName").removeClass("texthover"); });
            $('#ctl00_ContentPlaceHolder1_txtsponserid').blur(function () {
                if ($(this).val() != "") {
                    CheckSponserId();
                }
                return false;
            });
            $('.chkforip').live('change', function () {
                if ($(this).attr('checked') != 'checked') {
                    $(this).parent('div').parent('div').find('div:gt(0)').remove();
                    $(this).parent('div').parent('div').find('div:eq(0) input[type=text]').val('');
                }
                $('.txtipforlogin').removeClass("texthover");
            });
            $('.txtipforlogin').live('focus', function () { $('.txtipforlogin').removeClass("texthover"); });
            $('.txtipforlogin').live('keyup', function () {
                if ($('.chkforip').attr('checked') != 'checked') {
                    $(this).val('');
                    alertify.error('Please Check The Checkbox First.');
                }
            });
            $('.chkformac').live('change', function () {
                if ($(this).attr('checked') != 'checked') {
                    $(this).parent('div').parent('div').find('div:gt(0)').remove();
                    $(this).parent('div').parent('div').find('div:eq(0) input[type=text]').val('');
                } $('.txtmacforlogin').removeClass("texthover");
            });
            $('.txtmacforlogin').live('focus', function () { $('.txtmacforlogin').removeClass("texthover"); });

            $('.txtmacforlogin').live('keyup', function () {
                if ($('.chkformac').attr('checked') != 'checked') {
                    $(this).val('');
                    alertify.error('Please Check The Checkbox First.');
                }
            });
            //assigning keyup event to password field
            //so everytime user type code will execute

            $('#ctl00_ContentPlaceHolder1_txtPass').keyup(function () {
                if ($('#ctl00_ContentPlaceHolder1_txtPass').val() != '') {
                    checkStrength($('#ctl00_ContentPlaceHolder1_txtPass').val());
                }
            })
            checkStrength($('#ctl00_ContentPlaceHolder1_txtPass').val());
            //Code For Confirm Password
            $('#ctl00_ContentPlaceHolder1_txtRePass').keyup(function () {
                if ($('#ctl00_ContentPlaceHolder1_txtRePass').val() != '') {
                    checkStrength_Confirm($('#ctl00_ContentPlaceHolder1_txtRePass').val());
                }
            })
            checkStrength_Confirm($('#ctl00_ContentPlaceHolder1_txtRePass').val());
        });
        //checkStrength is function which will do the
        //main password strength checking for us
        function checkStrength(password) {
            //initial strength
            var strength = 0

            //if the password length is less than 6, return message.
            if (password.length < 6) {
                //$('#result').removeClass()
                //$('#result').addClass('short')
                $('.txtPassstregthtooshortdiv').show();
                $('.txtPassstregthweakdiv').hide();
                $('.txtPassstregthgooddiv').hide();
                $('.txtPassstregthstrongdiv').hide();
                return 'Too short'
            }

            //length is ok, lets continue.

            //if length is 6 characters or more, increase strength value
            if (password.length > 5) strength += 1

            //if password contains both lower and uppercase characters, increase strength value
            if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1

            //if it has numbers and characters, increase strength value
            if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1

            //if it has one special character, increase strength value
            if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //if it has two special characters, increase strength value
            //if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //now we have calculated strength value, we can return messages

            //if value is less than 2
            if (strength < 2) {
                //$('#result').removeClass()
                //$('#result').addClass('weak')
                $('.txtPassstregthtooshortdiv').hide();
                $('.txtPassstregthweakdiv').show();
                $('.txtPassstregthgooddiv').hide();
                $('.txtPassstregthstrongdiv').hide();
                return 'Weak'
            }
            else if (strength == 2) {
                //$('#result').removeClass()
                //$('#result').addClass('good')
                $('.txtPassstregthtooshortdiv').hide();
                $('.txtPassstregthweakdiv').hide();
                $('.txtPassstregthgooddiv').show();
                $('.txtPassstregthstrongdiv').hide();
                return 'Good'
            }
            else {
                //$('#result').removeClass()
                //$('#result').addClass('strong')
                $('.txtPassstregthtooshortdiv').hide();
                $('.txtPassstregthweakdiv').hide();
                $('.txtPassstregthgooddiv').hide();
                $('.txtPassstregthstrongdiv').show();
                return 'Strong'
            }
        }
        function checkStrength_Confirm(password) {
            //initial strength
            var strength = 0

            //if the password length is less than 6, return message.
            if (password.length < 6) {
                $('.txtrePassstregthtooshortdiv').show();
                $('.txtrePassstregthweakdiv').hide();
                $('.txtrePassstregthgooddiv').hide();
                $('.txtrePassstregthstrongdiv').hide();
                return 'Too short'
            }

            //length is ok, lets continue.

            //if length is 6 characters or more, increase strength value
            if (password.length > 5) strength += 1

            //if password contains both lower and uppercase characters, increase strength value
            if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1

            //if it has numbers and characters, increase strength value
            if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1

            //if it has one special character, increase strength value
            if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //if it has two special characters, increase strength value
            //if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //now we have calculated strength value, we can return messages

            //if value is less than 2
            if (strength < 2) {
                $('.txtrePassstregthtooshortdiv').hide();
                $('.txtrePassstregthweakdiv').show();
                $('.txtrePassstregthgooddiv').hide();
                $('.txtrePassstregthstrongdiv').hide();
                return 'Weak'
            }
            else if (strength == 2) {
                $('.txtrePassstregthtooshortdiv').hide();
                $('.txtrePassstregthweakdiv').hide();
                $('.txtrePassstregthgooddiv').show();
                $('.txtrePassstregthstrongdiv').hide();
                return 'Good'
            }
            else {
                $('.txtrePassstregthtooshortdiv').hide();
                $('.txtrePassstregthweakdiv').hide();
                $('.txtrePassstregthgooddiv').hide();
                $('.txtrePassstregthstrongdiv').show();
                return 'Strong'
            }
        }
    </script>
    <script type="text/javascript">
        //===validation script start====
        function validationcheckSubmit() {
            var status = 1;
            if (document.getElementById('<%= txtUserName.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtUserName.ClientID %>').className = "texthover";
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

            //if (document.getElementById('<%= txtmobile.ClientID %>').value.trim() == "") {
            // document.getElementById('<%= txtmobile.ClientID %>').className = "texthover";
            // status = 0;
            //}

            //if (document.getElementById('<%= txtemailaddress.ClientID %>').value.trim() == "") {
            //  document.getElementById('<%= txtemailaddress.ClientID %>').className = "texthover";
            //  status = 0;
            // }

            if ($('#ctl00_ContentPlaceHolder1_chkforip').attr('checked') == 'checked') {
                if ($('#ctl00_ContentPlaceHolder1_txtipforlogin').val() == "") {
                    status = 0;
                    $('#ctl00_ContentPlaceHolder1_txtipforlogin').addClass('texthover');
                }
            }

            //if (document.getElementById('<%=  txtcountry.ClientID %>').value.trim() == "") {
            // document.getElementById('<%= txtcountry.ClientID %>').className = "texthover";
            //status = 0;
            // }

            //if (document.getElementById('<%= txtstate.ClientID %>').value.trim() == "") {
            // document.getElementById('<%= txtstate.ClientID %>').className = "texthover";
            // status = 0;
            //}

            //if (document.getElementById('<%= txtcity.ClientID %>').value.trim() == "") {
            // document.getElementById('<%= txtcity.ClientID %>').className = "texthover";
            //status = 0;
            //}

            //if (document.getElementById('<%= txtaddress.ClientID %>').value.trim() == "") {
            //  document.getElementById('<%= txtaddress.ClientID %>').className = "texthover";
            //  status = 0;
            //}

            // if (document.getElementById('<%= txtPinCode.ClientID %>').value.trim() == "") {
            //  document.getElementById('<%= txtPinCode.ClientID %>').className = "texthover";
            // status = 0;
            // }

            if ($('.chkforip').attr('checked') == 'checked') {
                if ($('.txtipforlogin').val() == "") {
                    status = 0;
                    $('.txtipforlogin').addClass('texthover');
                }
            }

            if ($('.chkformac').attr('checked') == 'checked') {
                if ($('.txtmacforlogin').val() == "") {
                    status = 0;
                    $('.txtmacforlogin').addClass('texthover');
                }
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
                    alertify.alert("You can not upload " + Extension1 + " file for picture. You can only upload .png, bmp, gif, png, thm, psd, .jpg or .jpeg file.");
                    status = 0;
                }

            }
            //===========this validation is for picture=================

            if (document.getElementById('<%= txtPass.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtPass.ClientID %>').className = "texthover";
                $("#divforpassword").addClass("texthover");
                status = 0;
            }

            if (document.getElementById('<%= txtRePass.ClientID %>').value.trim() == "") {
                document.getElementById('<%= txtRePass.ClientID %>').className = "texthover";
                $("#divforconfirmpassword").addClass("texthover");
                status = 0;
            }
            if (document.getElementById('<%= txtPass.ClientID %>').value.trim() != "" && document.getElementById('<%= txtRePass.ClientID %>').value.trim() != "") {
                var pass = document.getElementById('<%= txtPass.ClientID %>').value.trim();
                var repass = document.getElementById('<%= txtRePass.ClientID %>').value.trim();

                if (pass != repass) {
                    alertify.error("Password and confirm password should be same.");
                    $("#divforpassword").addClass("texthover");
                    $("#divforconfirmpassword").addClass("texthover");
                    status = 0;
                }
            }
            var IpFormat = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
            if ($('.chkforip').attr('checked') == 'checked') {
                if ($('.txtipforlogin').val() != "") {
                    if (!$('.txtipforlogin').val().match(IpFormat)) {
                        status = 0;
                        $('.txtipforlogin').val('');
                        alertify.error("Please Enter Valid Ip Adress.");
                    }
                }
                else {
                    alertify.error('Please Fill All The Text Box Of Ip Address Otherwise Remove It.')
                }
            }

            var VarmacFormat = /^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$/;
            if ($('.chkformac').attr('checked') == 'checked') {
                if ($('.txtmacforlogin').val() != "") {
                    if (!$('.txtmacforlogin').val().match(VarmacFormat)) {
                        status = 0;
                        $('.txtmacforlogin').val('');
                        alertify.error("Please Enter Valid MAC Adress.");
                    }
                }
                else {
                    alertify.error('Please Fill All The Text Box Of MAC Address Otherwise Remove It.')
                }
            }
            if (status == 0) {
                return false;
            }
            else {
                var allipaddress = '', allmacaddress = '';
                $('.trforip').find('td div div').each(function () {
                    if ($(this).find('input[type=text]').val() != "") {
                        allipaddress = allipaddress + ',' + $(this).find('input[type=text]').val();
                    }
                });
                $('.trformac').find('td div div').each(function () {
                    if ($(this).find('input[type=text]').val() != "") {
                        allmacaddress = allmacaddress + ',' + $(this).find('input[type=text]').val();
                    }
                });
                $('#ctl00_ContentPlaceHolder1_hfforipaddress').val(allipaddress);
                $('#ctl00_ContentPlaceHolder1_hfformacaddress').val(allmacaddress);
            }
        }
    </script>
    <script type="text/javascript">
        //======all function except validation functions=====
        function fillstate() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "Comman.aspx/bindstate",
                     data: "{'cid':'" + cid + "'}",
                     dataType: "json",
                     async: false,
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
                     url: "Comman.aspx/bindcity",
                     data: "{'sid':'" + sid + "'}",
                     dataType: "json",
                     async: false,
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

        function check_length(countrolid, lnth, msgvar) {
            if (lnth < 10) {
                document.getElementById(countrolid).className = "texthover";
                alertify.error("" + msgvar + " number should not be less than 10 digits.");
                return false;
            }
        }
        function prevent_alphabet(value, controlid) { if (!value.match(/^\d+$/)) { document.getElementById(controlid).value = ""; } }

        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
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

        function CheckSponserId() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-new-branch-user.aspx/Checksponserno",
                data: "{'Sponserid':'" + $('#ctl00_ContentPlaceHolder1_txtsponserid').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 0) {
                        alertify.error('Invalid Sponser Id.');
                        $('#ctl00_ContentPlaceHolder1_txtsponserid').val('');
                        call_progressbar("end");
                        return false;
                    }
                    else if (data.d == 2) {
                        alertify.error('You Are Not Authorised One For Make Him/Her Sponser.');
                        $('#ctl00_ContentPlaceHolder1_txtsponserid').val('');
                        call_progressbar("end");
                        return false;
                    }
                    else {
                        call_progressbar("end");
                        return false;
                    }
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function FillDetailsOnTheBehalfOfRefNo() {
            var refno = $('#ctl00_ContentPlaceHolder1_txtrefno').val();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-new-branch-user.aspx/BindGridByJs",
                data: "{'RefNo':'" + refno + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        if (parseInt(data.d[0].alreadyexists) == 5) {
                            alertify.error("User Already Exists On The Behalf Of Employee Code.")
                            $('#ctl00_ContentPlaceHolder1_txtrefno').val('');
                            call_progressbar("end");
                            return false;
                        }
                        $('#ctl00_ContentPlaceHolder1_txtFName').val(data.d[0].fName);
                        $('#ctl00_ContentPlaceHolder1_txtMName').val(data.d[0].mName);
                        $('#ctl00_ContentPlaceHolder1_txtLName').val(data.d[0].lName);
                        $('#ctl00_ContentPlaceHolder1_txtmobile').val(data.d[0].mobile);
                        $('#ctl00_ContentPlaceHolder1_txtemailaddress').val(data.d[0].emailID);
                        $('#ctl00_ContentPlaceHolder1_ddlcountry').val(data.d[0].cid);
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Comman.aspx/bindstate",
                            data: "{'cid':'" + data.d[0].cid + "'}",
                            dataType: "json",
                            async: false,
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
                        $('#ctl00_ContentPlaceHolder1_ddlState').val(data.d[0].sid);
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Comman.aspx/bindcity",
                            data: "{'sid':'" + data.d[0].sid + "'}",
                            dataType: "json",
                            async: false,
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
                        $('#ctl00_ContentPlaceHolder1_ddlCity').val(data.d[0].ctid);
                        $('#ctl00_ContentPlaceHolder1_txtaddress').val(data.d[0].address);
                        $('#ctl00_ContentPlaceHolder1_txtPinCode').val(data.d[0].pinCode);
                        return false;
                        call_progressbar("end");
                    }
                    else {
                        alertify.error('Given Employee Code Is Invalid.');
                        $('#ctl00_ContentPlaceHolder1_txtrefno').val('');
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                }
            });
        }
    </script>
     <div class="content_pane_cont" id="contentPane">
        <div class="cheadline1" style="width: 100%; margin-left: 0px">
            <span class="spanheading">Add New User</span>
        </div>
        <div class="clear">
        </div>
        <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">

            <table style="width: 100%; border-right: 1px solid #DDDDDD; margin-top: 10px;">

                <tr>
                    <td>
                        <div class="for">
                            <label>
                            </label>
                            <asp:ImageButton ID="img" Style="display: block" ImageUrl="~/images/9update.png" Height="150" Width="130" runat="server" Enabled="false" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form" id="divsponserid" runat="server">
                            <label>
                                Sponser ID</label>
                            <asp:TextBox ID="txtsponserid" runat="server" placeholder="Enter Sponser Id"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr style="display: none">
                    <td>
                        <div class="for_sigle_row_form" id="divforupdate" runat="server">
                            <label>
                                Reference No/Employee Code</label>
                            <asp:TextBox ID="txtrefno" placeholder="Reference No." runat="server" MaxLength="10"></asp:TextBox>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Name<span style="color: Red;">*</span></label>
                            <asp:TextBox ID="txtFName" runat="server" PlaceHolder="First Name" Style="width: 82px !important;"></asp:TextBox>&nbsp
                            <asp:TextBox ID="txtMName" runat="server" PlaceHolder="Middle Name" Style="width: 82px !important;"></asp:TextBox>&nbsp
                            <asp:TextBox ID="txtLName" runat="server" PlaceHolder="Last Name" Style="width: 82px !important;"></asp:TextBox>&nbsp
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Gender<%--<span style="color: #ff0066">*</span>--%></label>
                            <div style="width: 300px; border: 1px solid; border-color: #ccc; margin-left: 170px; height: 24px; padding-top: 3px">
                                <asp:RadioButtonList ID="rdGender" runat="server" RepeatDirection="Horizontal" Width="200">
                                    <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                                    <asp:ListItem Value="2">Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Address Line <%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtaddress" placeholder="Address Line " runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                City<%--<span style="color: Red;">*</span>--%>
                            </label>

                            <asp:TextBox ID="txtcity" runat="server" placeholder="Enter City Name Please"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                State<%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtstate" runat="server" placeholder="Enter State Name Please"></asp:TextBox>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                PIN Code<%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtPinCode" placeholder="PIN Code" runat="server" MaxLength="6"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Country<%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtcountry" runat="server" placeholder="Enter Country Name Please"></asp:TextBox>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Mobile No. <%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtmobile" placeholder="Mobile No." runat="server"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Email ID <%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtemailaddress" placeholder="E-mail ID" runat="server" Style="text-transform: none!important"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Photo Upload
                            </label>
                            <div id="divforpicture" style="width: 300px; border: 1px solid; border-color: #ccc; margin-left: 170px; height: 24px; padding-top: 3px; padding-bottom: 3px">
                                <asp:FileUpload ID="fileuploadforpic" runat="server" onchange="preview(this)" />
                            </div>
                        </div>
                        <hr />
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Login ID<span style="color: Red;">* </span>
                            </label>
                            <asp:TextBox ID="txtUserName" placeholder="Login ID" runat="server" Style="text-transform: none!important" MaxLength="8"></asp:TextBox>&nbsp&nbsp
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Password<span style="color: Red;">*</span></label>
                            <div id="divforpassword">
                                <asp:TextBox ID="txtPass" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                                <div class="txtPassstregthdiv" style="width: 400px; height: 10px; color: white; border: 2px solid; border-radius: 25px; float: right; margin-right: 150px">
                                    <div class="txtPassstregthtooshortdiv" style="background-color: red; height: 20px; width: 100px; float: left; display: none;"><span style="padding: 5px;">Too Short</span></div>
                                    <div class="txtPassstregthweakdiv" style="background-color: pink; height: 20px; width: 100px; float: left; display: none;"><span style="padding: 5px;">Weak</span></div>
                                    <div class="txtPassstregthgooddiv" style="background-color: yellow; height: 20px; width: 100px; float: left; display: none;"><span style="padding: 5px; color: black">Good</span></div>
                                    <div class="txtPassstregthstrongdiv" style="background-color: green; height: 20px; width: 100px; float: left; display: none;"><span style="padding: 5px;">Strong</span></div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Confirm Password<span style="color: Red;">*</span></label>
                            <div id="divforconfirmpassword">
                                <asp:TextBox ID="txtRePass" placeholder="Confirm Password" runat="server" TextMode="Password"></asp:TextBox>
                                <div class="txtrePassstregthdiv" style="width: 400px; height: 10px; color: white; border: 2px solid; border-radius: 25px; float: right; margin-right: 150px">
                                    <div class="txtrePassstregthtooshortdiv" style="background-color: red; height: 20px; width: 100px; float: left; display: none;"><span style="padding: 5px;">Too Short</span></div>
                                    <div class="txtrePassstregthweakdiv" style="background-color: pink; height: 20px; width: 100px; float: left; display: none;"><span style="padding: 5px;">Weak</span></div>
                                    <div class="txtrePassstregthgooddiv" style="background-color: yellow; height: 20px; width: 100px; float: left; display: none;"><span style="padding: 5px; color: black">Good</span></div>
                                    <div class="txtrePassstregthstrongdiv" style="background-color: green; height: 20px; width: 100px; float: left; display: none;"><span style="padding: 5px;">Strong</span></div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="divforradio" runat="server">
                            <div class="for_sigle_row_form">
                                <label style="padding-top: 1px;">
                                    Dual Authentication</label>
                                <div style="border: 1px solid #ccc; height: 24px; margin-left: 170px; padding-top: 3px; width: 300px;">
                                    <asp:RadioButtonList ID="radiobuttonlistformanageotpodp" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="1">OTP</asp:ListItem>
                                        <asp:ListItem Value="2">ODP</asp:ListItem>
                                        <asp:ListItem Value="3" Selected="True">NONE</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form tractivewhenotpodtselected" style="display: none" id="divforsendemail" runat="server">
                            <label style="padding-top: 1px;" id="lblotpotpemail">
                                Email OTP/ODP<span style="color: #ff0066">*</span></label>
                            <div style="border: 1px solid #ccc; height: 24px; margin-left: 170px; padding-top: 3px; width: 353px;">
                                <asp:RadioButtonList ID="radioformailcheck" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                    <asp:ListItem Value="2" Selected="True">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form tractivewhenotpodtselected" style="display: none" id="divforsendsms" runat="server">
                            <label style="padding-top: 1px;" id="lblotpotpsms">
                                Sms OTP/ODP</label>
                            <div style="border: 1px solid #ccc; height: 24px; margin-left: 170px; padding-top: 3px; width: 353px;">
                                <asp:RadioButtonList ID="radiobuttonforsmscheck" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                    <asp:ListItem Value="2" Selected="True">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr class="trforip">
                    <td>
                        <div id="divforidentifyuserbyIp" runat="server">
                            <div class="for_sigle_row_form">
                                <label style="padding-top: 1px;">
                                    Identify User by IP</label>
                                <input type="text" class="txtipforlogin" placeholder="Enter The IP Address Please" />
                                <input type="checkbox" class="chkforip" />
                                <img class="imgforaddip" alt="No Image" style="width: 16px; cursor: pointer; margin-top: -6px" src="../../images/add.png" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr class="trformac">
                    <td>
                        <div id="divforidentifyuserbymac" runat="server">
                            <div class="for_sigle_row_form">
                                <label style="padding-top: 1px;">
                                    Identify User by MAC</label>
                                <input type="text" class="txtmacforlogin" placeholder="Enter The MAC Address Please" />
                                <input type="checkbox" class="chkformac" />
                                <img class="imgfroaddmac" alt="No Image" style="width: 16px; cursor: pointer; margin-top: -6px" src="../../images/add.png" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="divforactive" runat="server">
                            <div class="for_sigle_row_form">
                                <label style="padding-top: 1px;">
                                    Active</label>
                                <asp:CheckBox ID="chkActive" runat="server" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                           <asp:Button ID="btSave" runat="server" Text="Submit" CssClass="button_save" OnClientClick="return validationcheckSubmit()" OnClick="btSave_Click" />
                            <asp:Button ID="Button4" runat="server" Text="Clear" CssClass="button2" OnClick="Button4_Click" Style="display: none" />
                            <asp:Button ID="lbtngotolist" runat="server" Text="Cancel" CssClass="button2" OnClick="lbtngotolist_Click" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="divProgressBar" class="progress"></div>
                    </td>
                </tr>
            </table>
        </div>
        <asp:HiddenField ID="hfforipaddress" runat="server" />
        <asp:HiddenField ID="hfformacaddress" runat="server" />
    </div>
     <script type="text/javascript">
         $('#ctl00_ContentPlaceHolder1_txtUserName').keyup(function () {
             var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
             var eid = 0
             for (var i = 0; i < url.length; i++) {
                 var urlparam = url[i].split('=');
                 if (urlparam[0] == 'eid') {
                     eid = urlparam[1];
                 }
             }
             var userName = $('#ctl00_ContentPlaceHolder1_txtUserName').val();
             if (userName != "") {
                 $.ajax({
                     type: 'POST',
                     contentType: "application/json; charset=utf-8",
                     url: "add-new-branch-user.aspx/checkUser",
                     data: "{'userName':'" + userName + "','eid' :'" + eid + "'}",
                     dataType: "json",
                     success: function (data) {
                         var amount = data.d;
                         if (amount > 0) {
                             alertify.error("This user name already exists.");
                             $('#ctl00_ContentPlaceHolder1_txtUserName').val('');
                             $('#ctl00_ContentPlaceHolder1_txtUserName').focus();
                         }
                     },
                     error: function (response) {
                         alertify.error("Some Error Occured.");
                     }
                 });
             }
         });
    </script>
</asp:Content>
