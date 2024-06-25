<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="institute-master.aspx.cs" Inherits="branchpanel_master_company_master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #ctl00_ContentPlaceHolder1_fileuploadforlogo, #ctl00_ContentPlaceHolder1_fileuploadforfavicon {
            border: 1px solid #CCCCCC;
            width: 350px;
            height: 28px;
        }
    </style>
    <script src="../js/jquery-1.8.3.min.js"></script>

    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">School Master</span>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="clear"></div>
        <table style="width: 100%">
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            School Name :<span style="color: Red;"></span>
                        </label>
                        <asp:TextBox ID="txtinstitutename" runat="server" placeholder="Enter Institute Name"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Service TAX No. :<span style="color: Red;"></span>
                        </label>
                        <asp:TextBox ID="txtServicetax" runat="server" placeholder="Enter Service Tax Number"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            TIN :<span style="color: Red;"> </span>
                        </label>
                        <asp:TextBox ID="txtTin" onkeypress="return  isNumberKey(event)" runat="server" placeholder="Enter TIN Number"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            VAT No. :<span style="color: Red;"> </span>
                        </label>
                        <asp:TextBox ID="txtVat" runat="server" placeholder="Enter Vat Number"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Landline No. :</label>
                        <asp:TextBox ID="txtLandline" runat="server" MaxLength="15" onkeypress="return  isNumberKey(event)" placeholder="Enter Landline Number"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Mobile No. :<span style="color: Red"></span></label>
                        <asp:TextBox ID="txtmob" runat="server" MaxLength="12" onkeypress="return  isNumberKey(event)" placeholder="Enter Mobile Number"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Address :<span style="color: Red;"> </span>
                        </label>
                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" runat="server" placeholder="Enter Address"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            URL :<span style="color: Red;"></span>
                        </label>
                        <asp:TextBox ID="txturl" runat="server" placeholder="Enter Url"></asp:TextBox>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            School Logo :
                        </label>
                        <asp:FileUpload ID="fileuploadforlogo" runat="server" onchange="ShowpImagePreviewOfLogo(this,'#ctl00_ContentPlaceHolder1_fileuploadforlogo');"
                            ToolTip="Select" />
                        <div id="divbgcolorforlogo" class="navbar-header aside-md" style="background: #25405D; float: right; margin-right: 360px;">
                            <a class="navbar-brand" data-toggle="fullscreen" href="#">
                                <img id="imglogo" class="m-r-sm" style="display: none" />
                            </a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Logo Background :
                        </label>
                        <input type="color" id="bgcolor" />
                        <a id="Dbgcolor" style="text-decoration: underline; cursor: pointer; font-weight: 800; font-size: 13px">Default color</a>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Favicon Image :
                        </label>
                        <asp:FileUpload ID="fileuploadforfavicon" runat="server" onchange="ShowpImagePreviewOfFavicon(this,'#ctl00_ContentPlaceHolder1_fileuploadforfavicon');"
                            ToolTip="Select" />
                        <img id="imgfavicon" style="border: 1px solid #000; display: none" width="16" height="16" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label></label>
                        <input type="submit" id="buttoninputinstitute" class="button_save" value="Save" />
                        <a href="../Common/Default.aspx" class="button2 inputinstitute">Cancel</a>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                //alert("Please Enter Only Numeric Value:");
                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            return true;
        }

        var fileuploadcontrolid = "", filenameoflogo = "", filenameoffavicon = "", ImageLogoByteCode = "", ImagefaviconByteCode = "";
        var institutename = "", url = "", servicetax = "", TIN = "", VAT = "", Phoneno = "", Mobileno = "", address = "", background = "", brid = '';

        $(document).ready(function () {
            brid = '0';
            getdata();
        })
        function getdata() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "institute-master.aspx/getdata",
                data: "{'brid':'" + brid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    var data = data.d.split('^')
                    $("#ctl00_ContentPlaceHolder1_txtinstitutename").val(data[0])
                    $("#ctl00_ContentPlaceHolder1_txtServicetax").val(data[1])
                    $("#ctl00_ContentPlaceHolder1_txtTin").val(data[2])
                    $("#ctl00_ContentPlaceHolder1_txtVat").val(data[3])
                    $("#ctl00_ContentPlaceHolder1_txtLandline").val(data[4])
                    $("#ctl00_ContentPlaceHolder1_txtmob").val(data[5])
                    $("#ctl00_ContentPlaceHolder1_txtAddress").val(data[6])
                    $("#ctl00_ContentPlaceHolder1_txturl").val(data[7])
                    $("#imglogo").attr('src', '../images/' + data[8]).show(500)
                    $("#imgfavicon").attr('src', '../images/' + data[9]).show(500)
                    $("#bgcolor").val(data[10]);
                    $('#divbgcolorforlogo').css('background', data[10])
                    filenameoflogo = data[8];
                    filenameoffavicon = data[9];

                },
                error: function (response) {
                }
            });
        }
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_txtinstitutename').focus(function () { $(this).css("border", "1px solid #CCCCCC") });
            $('#ctl00_ContentPlaceHolder1_txtServicetax').focus(function () { $(this).css("border", "1px solid #CCCCCC") });
            $('#ctl00_ContentPlaceHolder1_txtTin').focus(function () { $(this).css("border", "1px solid #CCCCCC") });
            $('#ctl00_ContentPlaceHolder1_txtVat').focus(function () { $(this).css("border", "1px solid #CCCCCC") });
            $('#ctl00_ContentPlaceHolder1_txtLandline').focus(function () { $(this).css("border", "1px solid #CCCCCC") });
            $('#ctl00_ContentPlaceHolder1_txtmob').focus(function () { $(this).css("border", "1px solid #CCCCCC") });
            $('#ctl00_ContentPlaceHolder1_txtAddress').focus(function () { $(this).css("border", "1px solid #CCCCCC") });
            $('#ctl00_ContentPlaceHolder1_txturl').focus(function () { $(this).css("border", "1px solid #CCCCCC") });
            $('#bgcolor').focus(function () { $(this).css("border", "1px solid #CCCCCC") });

            $('#buttoninputinstitute').click(function () {
                FillField();
                instituteinfo();
                return false;
            });
            function instituteinfo() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "institute-master.aspx/callmethod",
                    data: "{'institutename':'" + institutename.split("'").join("~") + "','Service_tax_no':'" + servicetax + "','TIN':'" + TIN + "','VAT':'" + VAT + "','Landline':'" + Phoneno + "','Mobile':'" + Mobileno + "','address':'" + address.replace("'", "~") + "', 'url':'" + url + "','filenameoflogo':'" + filenameoflogo + "','ImageLogoByteCode':'" + ImageLogoByteCode + "','filenameoffavicon':'" + filenameoffavicon + "','ImagefaviconByteCode':'" + ImagefaviconByteCode + "','LogoBgColor':'" + background + "','brid':'" + brid + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            alertify.success("Institute Details Updated Successfully.");
                            return false;
                        }
                        return false;
                    },
                    error: function (result) {
                        alertify.error("Error");
                        return false;
                    }
                });
            }
            $('#bgcolor').change(function () {
                $('#divbgcolorforlogo').css('background', $(this).val())
            })
        });
        $('#Dbgcolor').click(function () {
            background = $('#bgcolor').val('#25405D');
            $('#divbgcolorforlogo').css('background', '#25405D');
        })

        function FillField() {
            institutename = $('#ctl00_ContentPlaceHolder1_txtinstitutename').val();
            servicetax = $('#ctl00_ContentPlaceHolder1_txtServicetax').val();
            TIN = $('#ctl00_ContentPlaceHolder1_txtTin').val();
            VAT = $('#ctl00_ContentPlaceHolder1_txtVat').val();
            Phoneno = $('#ctl00_ContentPlaceHolder1_txtLandline').val();
            Mobileno = $('#ctl00_ContentPlaceHolder1_txtmob').val();
            address = $('#ctl00_ContentPlaceHolder1_txtAddress').val();
            url = $('#ctl00_ContentPlaceHolder1_txturl').val();
            background = $('#bgcolor').val();
            brid = '0';
        }

        function Logo_Validation(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            var FileUploadPath = fuData.value;
            if (FileUploadPath != '') {
                var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (Extension == "png") {
                    return true;
                }
                else {
                    alertify.alert("You can not upload " + Extension + " file for company logo. You can only upload .png  file.");
                    return false;
                }

            }
        }
        function Favicon_Validation(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            var FileUploadPath = fuData.value;
            if (FileUploadPath != '') {
                var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (Extension == "ico" || Extension == "png") {
                    return true;
                }
                else {
                    alertify.alert("You can not upload " + Extension + " file for favicon image. You can only upload .ico & .png  file for favicon image.");
                    return false;
                }

            }
        }
        //function validation() {
        //    var tempforvalidation = 0;
        //    if ($('#ctl00_ContentPlaceHolder1_txtinstitutename').val() == "") {
        //        $('#ctl00_ContentPlaceHolder1_txturl').css("border", "1px solid red")
        //        tempforvalidation = 1;
        //    }

        //    if (tempforvalidation == 1) {
        //        return false;
        //    }
        //    else {
        //        return true;
        //    }
        //}

        function ShowpImagePreviewOfLogo(input, controlId) {
            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    filenameoflogo = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        ImageLogoByteCode = e.target.result;
                        $('#imglogo').attr('src', e.target.result);
                        $('#imglogo').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        function ShowpImagePreviewOfFavicon(input, controlId) {
            var stat = Favicon_Validation(controlId);

            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filefavicon) {
                    filenameoffavicon = filefavicon['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        ImagefaviconByteCode = e.target.result;
                        $('#imgfavicon').attr('src', e.target.result);
                        $('#imgfavicon').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);

                }
            }
        }
    </script>
</asp:Content>