<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserReg.aspx.cs" enableEventValidation="false" Inherits="UserReg" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <link id="favicon" rel="shortcut icon" type="image/ico" runat="server" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <%-- <title><%=ConfigurationManager.AppSettings["titleBar"].ToString()%></title>--%>
    <title>St. Francis Academy Motihari</title>
    <link href="css/softwares_style.css" rel="stylesheet" type="text/css" />
    <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0' />
    <link href="css/font.css" rel="stylesheet" />
    <link href="css/app.v1.css" rel="stylesheet" />
    <link href="css/responsive.css" rel="stylesheet" />
    <link href="css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.8.2.js" type="text/javascript"></script>
    <script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="js/alertify.js" type="text/javascript"></script>
    <%--Old Script Start Here--%>
    <link href="js/1.8-themes-base-jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <%--Old Script End Here--%>

     <script src="https://cdn.syncfusion.com/ej2/dist/ej2.min.js"></script>
    <link href="https://cdn.syncfusion.com/ej2/material.css" rel="stylesheet">

    <style type="text/css">
        #loader {
            position: relative;
            top: 10%;
        }

        .progress {
            display: none;
        }

        .stm a, .stm2 a, input[type=submit], img {
            cursor: pointer !important;
        }

        .progressAdd {
            display: block;
            position: fixed;
            background: -moz-linear-gradient(center top, #fff, #fff) repeat scroll 0 0 rgba(0, 0, 0, 0);
            z-index: 2147483647 !important;
            opacity: 0.8;
            overflow: hidden;
            text-align: center;
            top: 0;
            left: 0;
            height: 100%;
            vertical-align: middle;
            width: 100%;
            padding-top: 20%;
        }
    </style>
     <style type="text/css">
        .mydatagrid {
            width: 100%;
            border: solid 2px black;
            min-width: 80%;
        }

        .header {
            background-color: #646464;
            font-family: Arial;
            color: White;
            border: none 0px transparent;
            height: 25px;
            text-align: left;
            font-size: 16px;
            border-right-color: black;
        }

        .rows {
            background-color: #fff;
            font-family: Arial;
            font-size: 14px;
            color: #000;
            min-height: 25px;
            text-align: left;
            border: none 0px transparent;
        }

            .rows:hover {
                background-color: #ff8000;
                font-family: Arial;
                color: #fff;
                text-align: left;
            }

        .selectedrow {
            background-color: #ff8000;
            font-family: Arial;
            color: #fff;
            font-weight: bold;
            text-align: left;
        }

        .mydatagrid a /** FOR THE PAGING ICONS  **/ {
            background-color: Transparent;
            padding: 5px 5px 5px 5px;
            color: #fff;
            text-decoration: none;
            font-weight: bold;
        }

            .mydatagrid a:hover /** FOR THE PAGING ICONS  HOVER STYLES**/ {
                background-color: #c9c9c9;
                color: #fff;
            }

        .mydatagrid span /** FOR THE PAGING ICONS CURRENT PAGE INDICATOR **/ {
            /*background-color: #c9c9c9;*/
            color: #000;
            padding: 5px 5px 5px 5px;
        }

        .pager {
            background-color: #646464;
            font-family: Arial;
            color: White;
            height: 30px;
            text-align: left;
        }

        .mydatagrid td {
            padding: 5px;
        }

        .mydatagrid th {
            padding: 5px;
        }

        .BorderRight {
            border-right-color: black;
        }

        .input_content hr {
            border: none;
            height: 1px;
            color: #717171;
            background-color: #000;
        }

        .content_pane_cont span {
            font-weight: bold;
            color: #000;
        }

        .clear {
            clear: both;
        }

        .student_sty {
            border-top: 1px dashed #454545;
            margin: 0 10px;
            padding-top: 10px;
        }

        .ml10 {
            margin-left: 10px;
        }

        .amnt_img {
            background: url(../../images/amountbox.png) no-repeat left -13px;
            width: 267px;
        }
    </style>
        <%-- <script src="../../js/jquery-1.11.1.min.js"></script>--%>
</head>
<body>
    <form id="form1" runat="server">
         
        <asp:ScriptManager ID="ScriptManager2" runat="server">
        </asp:ScriptManager>
        <%--<center>--%>
        <style type="text/css">
            .trqualification {
                margin-top: 0px;
                height: 30px;
                border: 2px solid #CCCCCC !important;
                text-align: center;
                padding-left: 5px;
            }

            .tdfortrqualification {
                width: 20%;
                border: 0px solid #CCCCCC !important;
            }

            .upload {
                float: right;
                margin: 11px 149px 0 34px;
            }
        </style>
        <%--<script>
            $(function () {
                $("#txtdob").datepicker({
                    dateFormat: "dd MM yy",
                    changeMonth: true,
                    changeYear: true
                });
            });
      </script>--%>
        <script type="text/javascript">
            var schoolname = "", result = "";
            function ShowpImagePreview(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#imguser').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            function ShowpImagePreviewParent(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#Image1').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            function showschool() {
                $('#div_schoolt').show();
                $('#div_schoold').hide();
                return false;
            }
            function showschool1() {
                $('#div_schoolt').hide();
                $('#div_schoold').show();
                return false;
            }
            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    alertify.error("Please Enter Only Numeric Value.");
                    return false;
                }
                return true;
            }
            function noAlphabets(event) {
                var charCode = (event.which) ? event.which : event.keyCode
                if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                      && (charCode <= 90))
                    return false;

                return true;
            };
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
            }
            function getemailid(emailid) {
                var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
                if (!reg.test(emailid)) {
                    alertify.error('Please Enter Valid e-Mail Id.');
                    document.getElementById('<%=txtFEmailid.ClientID%>').value = "";
                    document.getElementById('<%=txtFEmailid.ClientID%>').focus();
                    return false;

                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "NewRegistration.aspx/Getemailid",
                        data: "{'emailid':'" + emailid + "'}",
                        dataType: "json",
                        success: function (data) {
                            var amount = data.d;
                            if (amount > 0) {
                                alertify.error("This student is already exists on the behalf of emailid.");

                                alertify.confirm("Are you want to add this student with same emailid.", function (e) {
                                    if (e) {
                                        $("#txtFEmailid").focus();
                                    }
                                    else {
                                        $("#txtFEmailid").val("");
                                        $("#txtFEmailid").focus();
                                    }
                                });
                            }
                        },
                        error: function (response) {
                            alertify.error("Some Error Occured While Email Is Validating.");
                            return false;
                        }
                    });
                }
            }
            function getpaidamt(mobile) {
                if (mobile == "") {
                    alertify.error('please enter mobile number')
                    return false;
                }
                else
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "NewRegistration.aspx/Getmobileno",
                        data: "{'mobile':'" + mobile + "'}",
                        dataType: "json",
                        success: function (data) {
                            var amount = data.d;
                            if (amount > 0) {
                                alertify.error("This student is already exists on the behalf of mobile number.");

                                alertify.confirm("Are you sure to add this student with same mobile no.", function (e) {
                                    if (e) {
                                        $("#txtLandline").focus();
                                    }
                                    else {
                                        $("#txtmob").val("");
                                        $("#txtmob").focus();
                                    }
                                })
                            }
                        },
                        error: function (response) {
                            alertify.error("Some Error Occured While Mobile No Is ValiDating.");
                            return false;
                        }
                    });
            }

        </script>

        <asp:UpdatePanel ID="NameApplicant" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="content_pane_cont input_content" id="contentPane">
                    <div class="main-div-tbl" style="width: 80%; margin-left: 10%;">
                        <div class="tbl-top-heading" style="height:140px;" >
                            
                            <div >
                                <%--<tr>--%>
                                    <div style="width: 15%;float:left;">
                                        <div style="float: left; padding: 5px 5px 0" id="divforlogo" runat="server">
                                            <asp:Image ID="btnlogoforrecipt" runat="server" Width="100%" />
                                        </div>
                                    </div>
                                    <div style="width: 60%; text-align: center">
                                        <span style="font-size: 25px; text-align: center; font-family: Arial; color: #424546; font-weight: 600;"><span runat="server" id="schoolName2"></span></span>
                                        <br />
                                        <span id="insaddress" runat="server" style="font-size: 16px; font-weight: 700; text-align: center; font-family: Arial; color: #424546;">
                                            <asp:Label runat="server" ID="spanaddress"></asp:Label></span>
                                        <h3 id="insservicetaxno" runat="server" visible="false" style="font-size: 12px; text-align: center; font-family: Arial; color: #424546;">Affiliation No :
                                    <asp:Label runat="server" ID="lblSchoolAffi" Visible="false"></asp:Label></h3>
                                    </div>
                                    <div style="width: 25%;float:right;margin-right:5px">
                                        <div class="receiptwrapper_add" style="float: right; text-align: right; font-size: 12px; font-family: Arial; color: #656d70;">
                                            <p id="inscontact" runat="server" style="padding: 0px; margin: 2px 0;">
                                                Ph.: 
                                    <asp:Label runat="server" ID="lblcontact"></asp:Label>
                                            </p>
                                            <p id="inscontact2" runat="server" style="padding: 0px; margin: 2px 0;">
                                                Mob : 
                                    <asp:Label runat="server" ID="lblMob"></asp:Label>
                                            </p>
                                            <p id="instin" runat="server" style="padding: 0px; margin: 2px 0;">
                                                <asp:Label runat="server" ID="lblservicetax"></asp:Label>
                                            </p>
                                            <p id="P1" rpayment receiptunat="server" style="padding: 0px; margin: 2px 0;">
                                                <asp:Label runat="server" ID="lblEmailID"></asp:Label>
                                            </p>
                                        </div>
                                    </div>
                                <%--</tr>--%>
                            </div>
                            <%--<div class="upload">
                                <i class="glyphicon-headphones"><b class="bg-info"></b></i>
                                <asp:Button ID="Button2" runat="server" PostBackUrl="~/BranchPanel/commonpage/UploadData.aspx" Text="Upload Data" />
                            </div>--%>
                        </div>
                        <style type="text/css">
                            .new-registration .sub-heading {
                                margin: 5px;
                                border-bottom: 1px dashed #3ebaeb;
                                color: #3ebaeb;
                                width: 70%;
                            }
                        </style>
                        <div class="clearfix"></div>
                        <div class="new-registration">
                            <div class="sub-heading">
                                Student Information
                            </div>
                            <div id="abc1" runat="server">
                                <div class="for_sigle_row_form" id="RegistrationSession">
                                    <label>
                                        Please Select Reg. Session<span style="color: Red; font-weight: bold">*</span></label>
                                    <asp:DropDownList ID="ddlregistrationsession" runat="server">
                                        <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                                    </asp:DropDownList>&nbsp;                   
                                </div>

                                <div class="for_sigle_row_form" runat="server" visible="true">
                                    <label>Branch Name</label>
                                    <asp:DropDownList runat="server" ID="ddlBrid" AutoPostBack="true" OnSelectedIndexChanged="ddlBrid_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    &nbsp;
                                </div>
                                <div class="for_sigle_row_form" id="stutype" runat="server" visible="false">
                                    <label>
                                        Student Type<span style="color: Red">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlStudtype" AutoPostBack="true" OnSelectedIndexChanged="ddlStudtype_SelectedIndexChanged">
                                        <asp:ListItem Value="0">--Select Student Type--</asp:ListItem>
                                        <asp:ListItem Value="1" Selected="True">AST</asp:ListItem>
                                        <asp:ListItem Value="2">NVST</asp:ListItem>
                                    </asp:DropDownList>
                                    &nbsp;
                                </div>
                                <div class="for_sigle_row_form" runat="server" visible="false">
                                    <label>
                                        Roll No<span style="color: Red">*</span></label>
                                    <asp:TextBox ID="txtRollNo" runat="server" AutoPostBack="true" OnTextChanged="txtRollNo_TextChanged"
                                        ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="for_sigle_row_form" style="display:none;">
                                    <label>Select Title</label>
                                    <asp:DropDownList ID="ddltitle" runat="server">
                                        <asp:ListItem Value="0">--Select Title--</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="for_sigle_row_form three-cols-form">
                                    <label>
                                        Name <span style="color: #ff0066">*</span></label>
                                    <asp:TextBox ID="txtFiName" runat="server" placeholder="First Name" onkeypress="return lettersOnly(event)" Style="text-transform: capitalize"></asp:TextBox>
                                    <asp:TextBox ID="txtMname" runat="server" placeholder="Middle Name" onkeypress="return lettersOnly(event)" Style="text-transform: capitalize"></asp:TextBox>
                                    <asp:TextBox ID="txtLName" runat="server" placeholder="Last Name" onkeypress="return lettersOnly(event)" Style="text-transform: capitalize"></asp:TextBox>
                                </div>
                                <div class="for_sigle_row_form">
                                    <label style="padding-top: 4px;">
                                        Gender<span style="color: Red">*</span></label>
                                    <div style="width: 171px; height: 20px; float: left;">
                                        <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                                            <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                                            <asp:ListItem Value="0">Female</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Date of Birth<span style="color: Red">*</span></label>
                                    <asp:TextBox ID="txtdob" runat="server" onchange="CalculateAge(this)" placeholder="Select Date Of Birth Please."></asp:TextBox>
                                    <asp:Label runat="server" ID="DateTimeLabel" ForeColor="Black" Font-Size="10px" Text=""></asp:Label>
                                    <asp:HiddenField ID="txtdob1" runat="server" />
                                    <span id="lblAge" style="font-weight: bold; color: red"></span>
                                </div>
                                <div class="for_sigle_row_form" id="div_schoold">
                                    <label>
                                        Class<span style="color: Red">*</span></label>
                                    <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                                        <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                                    </asp:DropDownList>&nbsp;

                                    <asp:DropDownList runat="server" ID="ddlsChool" Visible="false">
                                    </asp:DropDownList>

                                    <asp:Button runat="server" ID="btnSchool" Visible="false" Text="Other" CssClass="button_save select-shool" CausesValidation="false"
                                        ToolTip="Click here to add your school details." OnClientClick="return showschool();" />
                                </div>
                                <div class="for_sigle_row_form" style="display: none" id="div_schoolt">
                                    <label>
                                        Enter School Name</label>
                                    <asp:TextBox ID="txt_newschoolname" runat="server" placeholder="Enter School Name Please"></asp:TextBox>
                                    <asp:HiddenField ID="hfCustomerId" runat="server" />

                                    <asp:Button runat="server" ID="btn_backschool" Text="Back to select school" CssClass="button2 select-shool" CausesValidation="false"
                                        OnClientClick="return showschool1();" />
                                </div>
                                <div class="for_sigle_row_form select-two-row" style="display: none" >
                                    <label>
                                        Board/University and  Medium
                                    </label>
                                    <asp:DropDownList ID="txtboard" runat="server">
                                        <asp:ListItem Value="0" Text="Select Board/University"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="CBSE"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="GSEB"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="ICSE"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="OTHER"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="txtmediam" runat="server">
                                        <asp:ListItem Value="0" Text="Select Medium"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="ENG"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="GUJ"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="HIN"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="OTHER"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="for_sigle_row_form" style="display: none" >
                                    <label>
                                        Student Address
                                    </label>
                                    <asp:TextBox ID="txtPAddress" runat="server" placeholder="Enter Address" TextMode="MultiLine"></asp:TextBox>
                                </div>

                                <div class="for_sigle_row_form" style="display: none;">
                                    <label>
                                        Select State
                                    </label>
                                    <asp:DropDownList ID="ddlState" runat="server">
                                    </asp:DropDownList>
                                    &nbsp;
                        <asp:Label runat="server" ID="lblStateMsg" EnableViewState="false" ForeColor="Chocolate"
                            Text=""></asp:Label>
                                </div>
                                <div class="for_sigle_row_form" style="display: none;">
                                    <label>
                                        Select City
                                    </label>
                                    <asp:DropDownList ID="ddlCity" runat="server">
                                    </asp:DropDownList>
                                    &nbsp;
                                </div>
                                <div class="for_sigle_row_form" runat="server" visible="false">
                                    <label>
                                        Area 1</label>
                                    <asp:DropDownList runat="server" ID="ddlArea1">
                                        <asp:ListItem Value="0">select</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="for_sigle_row_form" runat="server" visible="false">
                                    <label>
                                        Area 2</label>
                                    <asp:DropDownList runat="server" ID="ddlArea2">
                                        <asp:ListItem Value="0">select</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:LinkButton ID="lnkaddsubarea" runat="server" Font-Size="12px" Font-Underline="true"
                                        Text="Add Sub area " CausesValidation="false" OnClick="lnkaddsubarea_Click"></asp:LinkButton>
                                </div>
                                <div class="for_sigle_row_form" >
                                    <label>
                                        Student Mobile No for SMS<span style="color: Red">*</span></label>
                                    <asp:TextBox ID="txtmob" runat="server" placeholder="Enter Mobile Number Please" onkeypress="return isNumberKey(event)" maxlength="10"
                                        plaseholder="Enter Mobile Number Please"></asp:TextBox>&nbsp;
                                </div>
                                <div class="for_sigle_row_form" style="display: none" >
                                    <label>
                                        Student Alternate Mobile No</label>
                                    <asp:TextBox ID="txtaltnumber" runat="server" placeholder="Enter Mobile Number Please" onkeypress="return isNumberKey(event)"
                                        plaseholder="Enter Mobile Number Please"></asp:TextBox>&nbsp;
                                </div>
                                <div class="for_sigle_row_form" style="display: none" >
                                    <label>
                                        Student Enrollment No</label>
                                    <asp:TextBox ID="txtLandline" runat="server" onkeypress="return isbothNumberKey(event)" placeholder="Enter Enrollment Number"></asp:TextBox>
                                </div>
                                <div class="for_sigle_row_form" style="display: none" >
                                    <label>
                                        Enter Email Id:</label>
                                    <asp:TextBox ID="txtFEmailid" runat="server" placeholder="Enter Email-Id"></asp:TextBox>
                                    <asp:Label runat="server" ID="lblFemail" ForeColor="Red"></asp:Label>
                                </div>
                            </div>
                            <div id="divadd" runat="server" visible="false">
                                <div class="for_sigle_row_form">
                                    <label>
                                        Sub Area</label>
                                    <asp:TextBox ID="txtareea" runat="server"></asp:TextBox>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Active:</label>
                                        <asp:CheckBox ID="chkcountrye" runat="server" />
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <div style="margin-left: 210px;">
                                            <asp:Button ID="btn1" CssClass="button_save" runat="server" Text="Save" OnClick="btn1_Click" />
                                            <asp:Button ID="Button1" CssClass="button_save" runat="server" Text="Back" OnClick="Button1_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>

                            
                            <div class="clear"></div>
                            <div id="divs" runat="server" style="display: inline-block;">

                                <div class="for_sigle_row_form" style="display:none;">
                                    <label>
                                        Source of Student</label>
                                    <asp:DropDownList runat="server" ID="DropDownList1">
                                        <asp:ListItem Value="0">--select--</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="sub-heading" style="display:none;">
                                    Student Educational Details
                                </div>
                                <div id="divforeducation" style="display: none;">
                                    <div class="user_phot_frame" style="float: right!important; margin-left: 100px!important; width: 209px; display: none">
                                        <asp:Image ID="Image2" runat="server" Width="110" Height="120" Style="border: 3px solid #306b33" />
                                    </div>

                                    <div class="for_sigle_row_form" id="edit">
                                        <%--<label>
                    </label>--%>

                                        <div style="float: right; margin-top: 7px; margin-right: 100px">
                                        </div>
                                        <div style="width: 70%; margin-left: 4px; overflow: scroll">

                                            <table id="tbl" runat="server" style="border: 0px solid #808080; width: 100%">
                                                <tr class="trqualification">
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Qualification</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Board/University</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Passing Year</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Roll Number</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Total Marks</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Obtained Marks</td>
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
                                                        <asp:TextBox ID="txtrollnumber1" runat="server" Width="150" placeholder="eg. 14354514" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                                    <td class="tdfortrqualification">
                                                        <asp:TextBox ID="txttotalmarks1" runat="server" Width="150" placeholder="eg. 2010-2012" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                                    <td class="tdfortrqualification">
                                                        <asp:TextBox ID="txtobtainedmarks1" runat="server" Width="150" placeholder="eg. 2010-2012" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>


                                                    <td class="tdfortrqualification">
                                                        <asp:TextBox ID="txtpercentage1" runat="server" Width="150" placeholder="eg. 70%" CssClass="eductabletxt" Style="text-transform: none!important"></asp:TextBox></td>

                                                    <td class="tdfortrqualification">
                                                        <asp:TextBox ID="txtinsituteaddress1" runat="server" Width="150" placeholder="eg. B-143 South Ex." CssClass="eductabletxt" Style="text-transform: none!important">
                                                        </asp:TextBox>
                                                    </td>
                                                    <td class="tdfortrqualification">
                                                        <img class="imgclass" src="../../images/add.png" style="width: 15px; height: 15px; cursor: pointer" /></td>
                                                </tr>
                                            </table>

                                        </div>
                                    </div>
                                </div>
                                <div class="sub-heading">
                                    Guardian Information
                                </div>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Guardian Type<span style="color: Red">*</span></label>
                                    <asp:DropDownList ID="ddlrel" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="for_sigle_row_form">
                                    <label id="lblgaurdianname">
                                        Name<span style="color: Red">*</span></label>
                                    <asp:TextBox ID="txtgname" runat="server" placeholder="Enter Name Please"></asp:TextBox>
                                </div>
                                <div class="for_sigle_row_form" style="position: relative; " >
                               
                                <!--<label style="padding-top: 0px;">
                                    Upload Student Photo</label>
                                <div id="divforpicture" class="uploadin-form">
                                    <asp:FileUpload ID="fuPhoto" runat="server" onchange="ShowpImagePreview(this)" Style="cursor: pointer" />
                                </div>--!>
                                    <br />
                                    <div class="clearfix"></div>
                                    <!-- <div class="user_phot_frame" style="position:relative;margin-top:20px;margin-bottom:20px;height:100px;">
                                    <asp:Image ID="imguser" runat="server" ImageUrl="~/images/9update.png" Width="100px" Height="100px" Style="position: absolute" />
                                </div>--!>
                                <div class="df0" >
                                    <div class="df">
                                        <ul>
                                            <li>
                                               <!-- <img src="../../images/questionmark.png" />--!>
                                                <ul>
                                                    <li>Only .jpeg,.png,.giff image files supported.</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                    <div class="clearfix"></div>
                            </div>
                                <div class="for_sigle_row_form" id="Address">
                    <label style="padding-top: 4px;">
                        Address<span style="color: Red; font-weight: bold">*</span></label>
                    <textarea id="txtaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>
                </div>
                <div class="for_sigle_row_form" id="City">
                    <label>
                        City<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtcity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter City Please"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="State">
                    <label>
                        State<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtstate" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter State Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="Pin">
                    <label>
                        Pin/Zip Code<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtpiorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" placeholder="Enter Pin/Zip Code Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="Country">
                    <label>
                        Country<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtcountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter Country Please"></asp:TextBox>&nbsp;                     
                </div>
                                <div class="for_sigle_row_form" style="display:none;">
                                    <label id="Label2">
                                        Mother Name</label>
                                    <asp:TextBox ID="txtmother" runat="server" placeholder="Enter Name Please"></asp:TextBox>
                                </div>
                                <div class="for_sigle_row_form" style="position: relative; display:none;">
                                    <div class="user_phot_frame">
                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/9update.png" Width="100px" Height="100px" Style="position: absolute" />
                                    </div>
                                    <label style="padding-top: 0px;" id="lblfatherphoto">
                                        Upload Father photo</label>

                                    <div id="div1" class="uploadin-form">
                                        <asp:FileUpload ID="FileUpload1" runat="server" onchange="ShowpImagePreviewParent(this)" Style="cursor: pointer" />
                                    </div>
                                    <div class="df0" style="left: 480px;">
                                        <div class="df">
                                            <ul>
                                                <li>
                                                    <img src="../../images/questionmark.png" />
                                                    <ul>
                                                        <li>Only .jpeg,.png,.giff image files supported.</li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="for_sigle_row_form" style="display:none;">
                                    <label id="lblfathermobileno">
                                        Father Mobile No. for SMS</label>
                                    <asp:TextBox ID="txtFMobile" runat="server" onkeypress="return  isNumberKey(event)" placeholder="Enter Mobile Number"> </asp:TextBox>
                                    <img class="addmorecontact" style="height: 20px; width: 20px; cursor: pointer" src="../../images/addmore.png" title="click here to add another mobile no." id="addmorecontact" alt="No Image" />
                                    <dt class="add-mob">Add Another Mobile No.</dt>
                                </div>
                                <div class="for_sigle_row_form" id="alternetmobile" style="display: none">
                                    <label id="lblalternatemobilenooffather">
                                        Alternet Mobile</label>
                                    <asp:TextBox ID="txtalternet" runat="server" onkeypress="return  isNumberKey(event)" placeholder="Enter Mobile Number"> </asp:TextBox>
                                    <input type="image" class="addmorecontact" style="height: 20px; width: 20px; border-width: 0px;" src="../../images/remove.png" title="click here to remove this mobile no." id="removealternet" />
                                    <dt class="add-mob">Remove this Mobile No.</dt>
                                </div>
                                <asp:UpdatePanel runat="server" ID="upd123" style="display:none;">
                                    <ContentTemplate>
                                        <div class="for_sigle_row_form">
                                            <label id="lblfatheremailid">
                                                Father Email ID</label>
                                            <asp:TextBox ID="guardianmail" runat="server" placeholder="Enter Email Id"></asp:TextBox>&nbsp;
                                    &nbsp;<asp:Label runat="server" ID="Label1" ForeColor="Red"></asp:Label>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="for_sigle_row_form" style="display:none;">
                                    <label id="lblfatheremailaddress">
                                        Father Address</label>
                                    <asp:TextBox ID="guardianaddress" runat="server" TextMode="MultiLine" placeholder="Enter Address"></asp:TextBox>
                                </div>
                                <div class="clear"></div>
                                <div class="for_sigle_row_form">
                                    <label style="margin-top: 0px;">
                                    </label>
                                    <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="button_save" ToolTip="Click here to submit details."
                                        OnClick="btnSubmit_Click" />
                                    <a href="NewStudents.aspx" class="button2">Back </a>
                                    <br />
                                    <br />
                                </div>
                            </div>
                        </div>
                        <asp:TextBox ID="txtqualification" Style="display: none" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txtqname" runat="server" Style="display: none"></asp:TextBox>
                        <asp:TextBox ID="txtboardlist" Style="display: none" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txtyear" Style="display: none" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txtrollnumber" Style="display: none" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txttotalmarks" Style="display: none" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txtobtainedmarks" Style="display: none" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txtpercent" Style="display: none" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txtinstituteaddress" Style="display: none" runat="server"></asp:TextBox>
                    </div>
                </div>
          
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnsubmit" />

            </Triggers>
        </asp:UpdatePanel>

        <script type="text/javascript">
            var txtqualification = "";
            var ctr = 1;
            var year = new Date()
            year = year.getFullYear();
            //year = parseInt(year) - 3;
            var date = new Date();
            var month = date.getMonth()
            date = date.getDate();
            $("#txtdob").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:' + year,
                maxDate: new Date((month + 1) + '/' + date + '/' + year),
                dateFormat: 'dd/mm/yy'
            });
            $('#ddlregistrationsession').change(function () {
                $('#ddlapplyingforclass').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "UserReg.aspx/BindClassDDL",
                    data: "{'Fyid':'" + $(this).val() + "','Brid':'" + $('#ddlBrid').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ddlapplyingforclass').html('<option value="0">--Select Class--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ddlapplyingforclass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                            }
                        }
                    }
                });
            });
            $('#ddlBrid').change(function () {
                $('#ddlapplyingforclass').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "UserReg.aspx/BindClassDDL",
                    data: "{'Fyid':'" + $('#ddlregistrationsession').val() + "','Brid':'" + $(this).val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ddlapplyingforclass').html('<option value="0">--Select Class--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ddlapplyingforclass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                            }
                        }
                    }
                });
            });
            $('#ddlapplyingforclass').change(function () {
                var ClassId = $('#ddlapplyingforclass').val();
                var Fyid = $('#ddlregistrationsession').val();
                if (parseInt(Fyid) == 0) {
                    alertify.error("Select Session First.");
                    $('#ddlapplyingforclass').val('0');
                    return false;
                }
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "UserReg.aspx/ProcessIT",
                    data: "{'ClassId':'" + $('#ddlapplyingforclass').val() + "','Fyid':'" + Fyid + "','Brid':'" + $('#ddlBrid').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != '')
                            $('#txtregistrationfee').val(data.d);
                        else
                            $('#txtregistrationfee').val('0.00');
                    }
                });
            });
            $("#btnSubmit").click(function () {
                if ($('#txtFiName').val() == '') {
                    alertify.error('Please Enter First Name');
                    $('#txtFiName').focus();
                    return false;
                }

                if ($('#txtdob').val() == '') {
                    alertify.error('Please Enter DOB');
                    $('#txtdob').focus();
                    return false;
                }

                if ($('#ddlClass').val() == '0') {
                    alertify.error('Please Select Class');
                    $('#ddlClass').focus();
                    return false;
                }

                if ($('#txtmob').val() == '') {
                    alertify.error('Please Enter Mobile No');
                    $('#txtmob').focus();
                    return false;
                }

                if ($('#txtgname').val() == '') {
                    alertify.error('Please Enter Guardian Name');
                    $('#txtgname').focus();
                    return false;
                }
            });
            $('#addmorecontact').click(function () {
                $('#alternetmobile').show(500);
                $(this).hide(500)
            })
            $('#removealternet').click(function () {
                $('#alternetmobile').hide(500);
                $('#addmorecontact').show(500)
                return false
            })

            $("#txtFiName").focus(function () { $("#txtFiName").removeClass("texthover"); });

            //$("#txtLName").focus(function () { $("#txtLName").removeClass("texthover"); });

            $("#txtdob").focus(function () { $("#txtdob").removeClass("texthover"); });

            $("#txtmob").focus(function () { $("#txtmob").removeClass("texthover"); });

            $("#txtFEmailid").focus(function () { $("#txtFEmailid").removeClass("texthover"); });


            $("#txtFEmailid").live("change", function () {
                var emailid = $(this).val();
                if (emailid != "") {
                    getemailid(emailid);
                }
            });

            $("#ddlState").live("change", function () {

                var sid = document.getElementById("ddlState").value;
                if (sid == "0") {
                    $('#ddlCity').children('option:not(:first)').remove();
                    return;
                }
                else {
                    $('#ddlCity').children().remove();
                }
                $.ajax(
                   {
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "NewRegistration.aspx/bindcity",
                       data: "{'sid':'" + sid + "'}",
                       dataType: "json",
                       success: function (data) {
                           $("#ddlCity").html("");
                           $.each(data.d, function (key, value1) {
                               $("#ddlCity").append($("<option></option>").val(value1.CTID).html(value1.cityName));
                           });
                       },
                       error: function (result) {
                           alertify.error("Some Error Occue While City Is Updating.");
                           return false;
                       }
                   });
            });

            //$("#txtmob").live('paste blur', function () {
            //    getpaidamt($("#txtmob").val());
            //});

            //$('#ddlrel').change(function () {
            //    var gaurdiantype = $(this).find('option:selected').text();
            //    $('#lblgaurdianname').html(gaurdiantype + ' Name');
            //    $('#lblfatherphoto').html('Upload ' + gaurdiantype + ' photo');
            //    $('#lblfathermobileno').html(gaurdiantype + ' Mobile No. For SMS');
            //    $('#lblfatheremailid').html(gaurdiantype + ' Email-Id');
            //    $('#lblfatheremailaddress').html(gaurdiantype + ' Address');
            //});

            $(".imgclass").click(function () {
                var rowstatus = checkrowempty();
                if (rowstatus != false) {
                    ctr++;
                    txtqualification = "txtqualification" + ctr;
                    var txtboard = "txtboard" + ctr;
                    var txtyear = "txtyear" + ctr;

                    var txtrollnumber = "txtrollnumber" + ctr;
                    var totalmarks = "totalmarks" + ctr;
                    var obtainedmarks = "obtainedmarks" + ctr;
                    var txtpercent = "txtpercent" + ctr;
                    var remove = "removebtn" + ctr;

                    var instituladdress = "txtinstituteaddress" + ctr;

                    var newTr = '<tr><td style="border: 0px solid #CCCCCC!important"><select style="font-size:12px;width:125px;text-transform:none!important" CssClass="qualification" placeholder="eg. 10th" id=' + txtqualification +
                        '></select></td><td style="border: 0px solid #CCCCCC!important"><input style="width:120px;text-transform:none!important" placeholder="eg. UP Board" type="text" id=' + txtboard
                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:120px;text-transform:none!important" placeholder="eg. 2010" type="text" id=' + txtyear

                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:150px;text-transform:none!important" placeholder="eg. 14354514" type="text" id=' + txtrollnumber
                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:150px;text-transform:none!important" placeholder="eg. 2010-2012" type="text" id=' + totalmarks
                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:150px;text-transform:none!important" placeholder="eg. 2010-2012" type="text" id=' + obtainedmarks
                        + ' /></td><td style="border: 0px solid #CCCCCC!important"><input style="width:150px;text-transform:none!important" placeholder="eg. 70%"  type="text" id=' + txtpercent
                        + ' /></td><td style="border:0px solid #CCCCCC!important"><input style="width:150px;text-transform:none!important" placeholder="eg. B-143 South Ex."  type="text" id=' + instituladdress
                        + ' /></td><td style="width:74px"><img style="width:15px;height:15px;cursor:pointer;" class="deleteButton" src="../../images/subb.png"   id=' + remove
                        + ' /></td></tr>';
                    $('#tbl').append(newTr);
                    filldisig2();
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

            function checkrowempty() {
                var noofrows = document.getElementById('tbl').rows.length;
                if (noofrows > 1) {
                    for (var i = 1; i < noofrows; i++) {
                        var noofcells = document.getElementById("tbl").rows[i].cells.length;
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

                                ddlvalue = document.getElementById("tbl").rows[i].cells[0].getElementsByTagName("select")[0].value;
                                //txt = document.getElementById("tbl").rows[i].cells[j].getElementsByTagName("input")[0].value;
                                if (ddlvalue == "0") {
                                    alertify.error("Please fill at least Qualification first.");
                                    return false;
                                }
                            }
                        }
                    }
                }
            }

            function CalculateAge() {
                var chunks = $('#txtdob').val().split('/');
                var CalculateDate = chunks[2] + '-' + chunks[1] + '-' + chunks[0];
                $('#txtdob1').val(CalculateDate);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "NewRegistration.aspx/GetYearMonthDate",
                    data: "{'Date':'" + CalculateDate + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == '0') {
                            alertify.error('Enter Valid Date Please.')
                            $('#txtdob').val('');
                            $('#txtdob').focus();
                            return false;
                        }
                        $('#lblAge').html(data.d);
                        $('#lblAge').css("", "");
                    }
                });
            }
            function filldisig2() {

                //call_progressbar("start");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "NewRegistration.aspx/bind_qualification",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $.each(data.d, function (key, value) {

                            if (txtqualification != "") {
                                $("#" + txtqualification + "").append($("<option></option>").val(value.qid).html(value.name));
                            }
                            else {
                                $("#ddlqualification1").append($("<option></option>").val(value.qid).html(value.name));


                            }

                        });
                        //call_progressbar("end");
                    },
                    error: function (result) {
                        //call_progressbar("end");
                        return false;
                    }
                });

            }

            function getvalue() {

                var noofrows = document.getElementById('tbl').rows.length;

                var quali = "", board = "", year = "", percent = "", status = "0", totalmarks = "", obtainedmarks = "", rollnumber = "", instituteaddress = "", quname = '';

                if (noofrows > 1) {
                    for (var i = 1; i < noofrows; i++) {
                        var noofcells = document.getElementById("tbl").rows[i].cells.length;
                        if (noofcells > 0) {
                            var ddlvalue = document.getElementById("tbl").rows[i].cells[0].getElementsByTagName("select")[0].value;
                            if (ddlvalue != "0") {
                                //for (var j = 1; j < 7; j++) {
                                //    var txt = document.getElementById("tbl").rows[i].cells[j].getElementsByTagName("input")[0].value;
                                //    if (txt == "") {
                                //        document.getElementById("tbl").rows[i].cells[j].getElementsByTagName("input")[0].className = "texthover";
                                //        status = "1"; quali = ""; board = ""; year = ""; session = ""; rollnumber = ""; percent = ""; instituteaddress = "";
                                //    }
                                //}
                                if (status != "1") {
                                    quali += document.getElementById("tbl").rows[i].cells[0].getElementsByTagName("select")[0].value + ",";
                                    quname += $('#tbl').find('tr:eq(' + i + ')').find('td:eq(0)').find('option:selected').text() + ",";
                                    board += document.getElementById("tbl").rows[i].cells[1].getElementsByTagName("input")[0].value + ",";
                                    year += document.getElementById("tbl").rows[i].cells[2].getElementsByTagName("input")[0].value + ",";
                                    //session += document.getElementById("tbl").rows[i].cells[3].getElementsByTagName("input")[0].value + ",";
                                    rollnumber += document.getElementById("tbl").rows[i].cells[3].getElementsByTagName("input")[0].value + ",";
                                    totalmarks += document.getElementById("tbl").rows[i].cells[4].getElementsByTagName("input")[0].value + ",";
                                    obtainedmarks += document.getElementById("tbl").rows[i].cells[5].getElementsByTagName("input")[0].value + ",";
                                    percent += document.getElementById("tbl").rows[i].cells[6].getElementsByTagName("input")[0].value + ",";
                                    instituteaddress += document.getElementById("tbl").rows[i].cells[7].getElementsByTagName("input")[0].value + ",";
                                }
                            }
                        }
                        $("#txtqualification").val(quali);
                        $("#txtqname").val(quname);
                        $("#txtboardlist").val(board);
                        $("#txtyear").val(year);
                        //$("#txtsession").val(session);
                        $("#txtrollnumber").val(rollnumber);
                        $("#txttotalmarks").val(totalmarks);
                        $("#txtobtainedmarks").val(obtainedmarks);
                        $("#txtpercent").val(percent);
                        $("#txtinstituteaddress").val(instituteaddress);
                    }
                }
                if (status == "1") {
                    $("#txtqualification").val("0");
                    $("#txtqualificationname").val("");
                    $("#txtboardlist").val("");
                    $("#txtyear").val("");
                    //$("#txtsession").val("");
                    $("#txtrollnumber").val("");
                    $("#txttotalmarks").val("");
                    $("#txtobtainedmarks").val("");
                    $("#txtpercent").val("");
                    $("#txtinstituteaddress").val("");
                    return false;
                }

            }

            function check() {
                var iselect = 0, jselect = 0;
                var length = $('#ContentPlaceHolder1_tbl tr:gt(0)').length;
                for (var i = 1; i <= length; i++) {
                    iselect = $('#ContentPlaceHolder1_tbl tr:eq(' + i + ') td:eq(0) select').val();
                    for (var j = 1; j <= length; j++) {
                        jselect = $('#ContentPlaceHolder1_tbl tr:eq(' + j + ') td:eq(0) select').val();
                        if (i != j) {
                            if (iselect == jselect) {
                                $('#ContentPlaceHolder1_tbl tr:eq(' + i + ') td:eq(0)').css("border", "1px solid red");
                                $('#ContentPlaceHolder1_tbl tr:eq(' + j + ') td:eq(0)').css("border", "1px solid red");
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
                        var GroupShiftId = '';
                        ////Block Of Code For Get GroupShiftId Start Here
                        $('.SingleCheckboxForShift').find('input[type="checkbox"]').each(function () {
                            if ($(this).prop('checked') == true) {
                                GroupShiftId = GroupShiftId + ',' + $(this).val();
                            }
                        });
                        GroupShiftId = GroupShiftId.slice(1, GroupShiftId.length);
                        $('#ContentPlaceHolder1_hfforGroupShiftId').val(GroupShiftId);
                        ////Block Of Code For Get GroupShiftId End Here
                        return true;
                    }
                }

            }
            filldisig2();
        </script>
     <%-- </center>--%>
    <%--<script type="text/javascript">
        $(document).ready(function () {
            $('input[type="submit"]').live('click', function () {               
                var Temp = 0;
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "Common/Default.aspx/CheckUserPermission",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (parseInt(data.d) == 0) {
                            //alert('Your Account Deactivated By The Admin.Please Conatct To Admin');
                            //window.location.href = "../../Logout.aspx?Id=2";
                            Temp = 1;
                        }
                        else {
                            Temp = 1;
                        }
                    }
                });
                if (Temp == 1)
                    return true;
                else
                    return false;
            });
            Setmenu();
        });

        function Setmenu() {
            var mainurl = '', pageurl = '';
            var URL = $(location).attr('href').split('/');
            mainurl = URL[URL.length - 1];
            $('#ctl00_divMenu').find('a').each(function () {
                var Menu = $(this).attr('href').split('/');
                pageurl = Menu[Menu.length - 1];
                if (mainurl.toLowerCase() == pageurl.toLowerCase()) {
                    $(this).css("background-color", "#F4F1F1");
                    $(this).css("color", "#25405D");
                    $(this).addClass('active');
                    $(this).parent('li').parent('ul').parent('li').addClass('active');
                }
            });
        }
    </script>--%>

    </form>
</body>
</html>
