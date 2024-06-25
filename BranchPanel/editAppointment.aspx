<%@ Page Title="Edit Appoinment" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableViewState="true" AutoEventWireup="true" CodeFile="editAppointment.aspx.cs" Inherits="CreateAppoinmentLetter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function toggle5(showHideDiv, switchImgTag) {
            var ele = document.getElementById(showHideDiv);
            var imageEle = document.getElementById(switchImgTag);
            if (ele.style.display == "block") {
                ele.style.display = "none";
                imageEle.innerHTML = '<img src="../images/addd11.png" style=" margin-left:900px;margin-top:7px;" />';
            }
            else {
                ele.style.display = "block";
                imageEle.innerHTML = '<img src="../images/Green_Minus.gif" style=" margin-left:900px;margin-top:7px;">';
            }
        }
    </script>
    <script type="text/javascript">
    </script>

    <style type="text/css">
        .separator {
            display: block;
            height: 2px;
            background-color: #E6E6E6;
            margin: 10px 0 15px;
        }

        .bg-blue {
            background-color: #006EB8;
        }
    </style>

    <style type="text/css">
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
            border: 1px solid #1387A1;
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

        .header {
            background: url("../images/back-panel-title.png") repeat-x scroll left bottom rgba(0, 0, 0, 0);
            height: 41px;
            margin-top: -4px;
            width: 100%;
            line-height: 34px;
            color: #1387A1;
        }

        .bgborder {
            background-repeat: repeat-x;
            bottom: 0;
            height: 18px;
            margin-top: -17.5px;
            width: 100%;
        }

        #ctl00_ContentPlaceHolder1_rdGender_0 {
            margin-top: 14px;
        }

        #ctl00_ContentPlaceHolder1_rdGender_1 {
            margin-top: 14px;
        }

        #ctl00_ContentPlaceHolder1_rblMStatus_0 {
            margin-top: 14px;
        }

        #ctl00_ContentPlaceHolder1_rblMStatus_1 {
            margin-top: 14px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function checkPage(rptName, i, j, rptPage, chkmodule, chkpage) {
            var r = rptPage + "_ctl";
            var K;
            if (j < 10)
                K = "0" + j;
            else
                K = j;

            var s1 = document.getElementById(r + K + "_" + chkpage);
            if (s1.checked == true) {
                var s2 = document.getElementById(chkmodule);
                s2.checked = true;
            }
        }

        function checkModule(rptName, itemCount, rptPage, chkmodule, chkpage) {
            var s1 = document.getElementById(chkmodule);
            if (s1.checked == true) {
                for (i = 0; i < itemCount; i++) {
                    r = rptPage + "_ctl";
                    if (i <= 9) {
                        s2 = document.getElementById(r + "0" + i + "_" + chkpage);
                        s2.checked = true;
                    }
                    else {
                        s2 = document.getElementById(r + i + "_" + chkpage);
                        s2.checked = true;
                    }
                }
            }
            if (s1.checked == false) {
                for (i = 0; i < itemCount; i++) {
                    r = rptPage + "_ctl";
                    if (i <= 9) {
                        s2 = document.getElementById(r + "0" + i + "_" + chkpage);
                        s2.checked = false;
                    }
                    else {
                        s2 = document.getElementById(r + i + "_" + chkpage);
                        s2.checked = false;
                    }
                }
            }
        }
    </script>
    <%--<style type="text/css">
        .divContent
        {
            background-color: White;
            padding: 30px 30px 30px 30px;
            min-height: 800px;
        }
        .tblRectangleBorder
        {
            font-family: Arial,Helvetica,sans-serif;
            background-color: White;
            color: Black;
            -webkit-box-shadow: 0px 0px 1px 4px #fafafa;
            -moz-box-shadow: 0px 0px 1px 4px #F8A88D;
            box-shadow: 0 0 10px #D0D0D0 inset;
            border-radius: 7px;
            padding: 30px 20px 30px 20px;
            align: center;
        }
        .firstTD
        {
            margin-bottom: -0.75em;
            margin-top: -0.2em;
            height: auto;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 0px 0px 0px 20px;
            color: #1C6099;
            font-weight: normal;
            padding-right: 15px;
        }
        .secondTD
        {
            font-size: 14px;
            font-family: Arial,Helvetica,sans-serif;
            text-align: left;
            padding-left: 20px;
        }

        .ddl
        {
            margin-top: 5px;
            height: 29px;
            margin: 10 0 5px;
            padding: 5px;
            width: 243px;
            border-radius: 4px;
            margin-top: 7px;
        }
        .file_border
        {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }

        .aspButton
        {
            border: 1px solid #ff6262;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            font-size: 15px;
            font-family: arial, helvetica, sans-serif;
            padding: 3px 8px;
            text-decoration: none;
            display: inline-block;
            text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
            font-weight: bold;
            color: #FFFFFF;
            background-color: #ff3434;
            background-image: linear-gradient(to bottom, #ff9a9a, #ff4040);
        }

        .style1
        {
            margin-bottom: -0.75em;
            margin-top: -0.2em;
            height: 26px;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 14px;
            font-weight: normal;
            color: #1C6099;
            font-weight: normal;
            padding-right: 15px;
            padding-left: 20px;
            padding-top: 0px;
            padding-bottom: 0px;
        }
        .style2
        {
            font-size: 14px;
            font-family: Arial,Helvetica,sans-serif;
            text-align: left;
            padding-left: 20px;
            height: 26px;
        }
    </style>--%>
    <%--<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>--%>
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <%-- <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtDOB").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
            });

        });
    </script>

    <script type="text/javascript">

        function validate() {

            if (document.getElementById('<%=txtName.ClientID%>').value.trim() == "") {
                alert("Please Enter Applicant Name !");
                document.getElementById('<%=txtName.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtDOB.ClientID%>').value.trim() == "") {
                alert("Please Enter date of birth !");
                document.getElementById('<%=txtDOB.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtFname.ClientID%>').value.trim() == "") {
                alert("Please Enter father's name !");
                document.getElementById('<%=txtFname.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=rbgender.ClientID%>').selectedIndex == 0) {
                alert("Please Select Gender !");
                document.getElementById('<%=rbgender.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=ddl_Course.ClientID%>').selectedIndex == 0) {
                alert("Please Select a class !");
                document.getElementById('<%=ddl_Course.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtPAddress.ClientID%>').value.trim() == "") {
                alert("Please enter Address !");
                document.getElementById('<%=txtPAddress.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlCountry1.ClientID%>').selectedIndex == 0) {
                alert("Please Select Country !");
                document.getElementById('<%=ddlCountry1.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=ddl_state.ClientID%>').selectedIndex == 0) {
                alert("Please Select State !");
                document.getElementById('<%=ddl_state.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlCity1.ClientID%>').selectedIndex == 0) {
                alert("Please Select City !");
                document.getElementById('<%=ddlCity1.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtPZIP.ClientID%>').value.trim() == "") {
                alert("Please Enter PIN code !");
                document.getElementById('<%=txtPZIP.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlPayment.ClientID%>').selectedIndex == 0) {
                alert("Please Select Payment Option !");
                document.getElementById('<%=ddlPayment.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtReceipt.ClientID%>').value.trim() == "") {
                alert("Please Enter PAyment Receipt Number !");
                document.getElementById('<%=txtReceipt.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtadmNo.ClientID%>').value.trim() == "") {
                alert("Please Enter Admission number !");
                document.getElementById('<%=txtadmNo.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtAdmDate.ClientID%>').value.trim() == "") {
                alert("Please Enter Admission Date !");
                document.getElementById('<%=txtAdmDate.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtClassSec.ClientID%>').value.trim() == "") {
                alert("Please Enter Class and Section !");
                document.getElementById('<%=txtClassSec.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtOfficer.ClientID%>').value.trim() == "") {
                alert("Please Enter officer Name !");
                document.getElementById('<%=txtOfficer.ClientID%>').focus();
                return false;
            }

        }
    </script>--%>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">HR Mangement</a></li>
            <li style="background: none;"><a class="active" href="#">Staff Manager</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">

        <h4 class="page-title txtblue ">

            <div class="icons border-blue radius" style="margin-top:7px;margin-left:10px;">

                <i class="fa fa-calendar-o txtblue">
                    <img src="../images/stude.png" style="width:20px;height:20px" />
                </i>
            </div>
            <div class="header"  style="margin-top:-10px;">

                <span style="margin-top:7px;font-size:18px;"> Employee Details </span>
            <div id="headerDivImg" style="margin-top:-34px;">

            <a id="imageDivLink" href="javascript:toggle5('contentDivImg', 'imageDivLink');">
                <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
            </a>
        </div>
                </div>
        </h4>

        <div id="contentDivImg" style="display: block;">
            <div class="user_phot_frame">
                <asp:Image ID="empimage" runat="server" />
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Reference NO<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtRefNo" runat="server" OnTextChanged="txtRefNo_TextChanged" AutoPostBack="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Name<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtFName" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                            <asp:TextBox ID="txtMName" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                            <asp:TextBox ID="txtLName" runat="server" CssClass="lname"></asp:TextBox>&nbsp
                                            <asp:RequiredFieldValidator ID="rfvFname" runat="server" ControlToValidate="txtFName"
                                                ErrorMessage="Enter First Name" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                &nbsp<asp:RequiredFieldValidator ID="rfvLname" runat="server" ControlToValidate="txtLName"
                    ErrorMessage="Enter Last Name" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Title<span style="color: #ff0066">*</span></label>
                <asp:DropDownList ID="ddlTitle" runat="server" AutoPostBack="True" AppendDataBoundItems="True">
                </asp:DropDownList>
                &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                    ErrorMessage="Select Title" ControlToValidate="ddlTitle" InitialValue="0" CssClass="rqd"
                    Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Gender<span style="color: #ff0066">*</span></label>
                <asp:RadioButtonList ID="rdGender" runat="server" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                    <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                </asp:RadioButtonList>
                &nbsp;
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ErrorMessage="Please select gender"
                                                ControlToValidate="rdGender" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator><br />
            </div>
            <div class="for_sigle_row_form" style=" margin-top: -12px;">
                <label>
                    Date Of Birth<span style="color: #ff0066">*</span></label>
                <asp:DropDownList ID="ddlDOBDay" runat="server" AppendDataBoundItems="True" CssClass="ddlDD"
                    OnSelectedIndexChanged="ddlDOBDay_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlDOBMonth" runat="server" AppendDataBoundItems="True" CssClass="ddlMM">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlDOBYear" runat="server" AppendDataBoundItems="True" CssClass="ddlYY">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="Select Date of birth"
                    ControlToValidate="ddlDOBDay" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ErrorMessage="Select Year of birth"
                    ControlToValidate="ddlDOBYear" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Birth Place</label>
                <asp:TextBox ID="txtforbirthplace" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Nationality</label>
                <asp:TextBox ID="txtNationality" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    D.O.J<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtDatejoining" runat="server"></asp:TextBox>&nbsp;
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ErrorMessage="Please select date of joining."
                                                ControlToValidate="txtDatejoining" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Highest Qualification</label>
                        <asp:DropDownList ID="ddlHightqulification" runat="server" AppendDataBoundItems="True">
                        </asp:DropDownList>
                        &nbsp&nbsp&nbsp
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Select Highest Qualification"
                                                        ControlToValidate="ddlHightqulification" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Professional Qualification</label>
                        <asp:DropDownList ID="ddlprofessionalqulification" runat="server"
                            AppendDataBoundItems="True">
                        </asp:DropDownList>
                        &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ErrorMessage="Select Professional Qualification" ControlToValidate="ddlprofessionalqulification"
                            InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    Marital Status</label>
                <asp:RadioButtonList runat="server" ID="rblMStatus" RepeatDirection="Horizontal"
                    CssClass="labelfor_radio">
                    <asp:ListItem Value="1">Unmarried</asp:ListItem>
                    <asp:ListItem Value="2">Married</asp:ListItem>
                </asp:RadioButtonList>
                <%--<asp:TextBox ID="txtMaritalStatus" runat="server"></asp:TextBox>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    No. of Children</label>
                <asp:TextBox ID="txtChild" runat="server"></asp:TextBox>&nbsp;
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator8" CssClass="rqd" ControlToValidate="txtChild"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Father Name</label>
                <asp:TextBox ID="txtF1name" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Mother Name</label>
                <asp:TextBox ID="txtMotherName" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    PAN Card No.</label>
                <asp:TextBox ID="txtPanNo" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Voter ID No.</label>
                <asp:TextBox ID="txtVoterNo" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    ADHAR No.</label>
                <asp:TextBox ID="txtAdharno" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Driving Licence No.</label>
                <asp:TextBox ID="txtLicenseNo" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Passport No.</label>
                <asp:TextBox ID="txtPassportNo" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Upload Photo (500KBMax.)</label>
                <asp:FileUpload runat="server" ID="fuPhoto" />&nbsp;
                                            <asp:Label runat="server" ID="lblPhoto" Text="" Visible="false"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Upload CV<span style="color: #ff0066">*</span></label>
                <asp:FileUpload runat="server" ID="fuFather" />&nbsp;
                                            <asp:Label runat="server" ID="lblCV" Text="" Visible="false"></asp:Label>
                <%--  <asp:LinkButton ID="lbCertificate" Font-Bold="true" Text="Download CV Here"  runat="server"
                                            Font-Underline="true" onclick="lbCertificate_Click"></asp:LinkButton>
                --%>
                <asp:LinkButton ID="lblcertificte" Font-Bold="true" Text="Download CV here" Visible="false"
                    runat="server" Font-Underline="true" OnClick="lblcertificte_Click" CausesValidation="false"></asp:LinkButton>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Documents Submitted (Checkbox with upload)<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Comments<%--<span style="color: #ff0066">*</span>--%></label>
                <asp:TextBox ID="txtComment" runat="server"></asp:TextBox>
            </div>
        </div>

        <h4 class="page-title txtblue ">

                 <div class="icons border-blue radius" style="margin-top:7px;margin-left:10px;">

                <i class="fa fa-calendar-o txtblue">
                    <img src="../images/home1.png" style="width:20px;height:20px" />
                </i>
            </div>

              <div class="header"  style="margin-top:-10px;">

                <span style="margin-top:7px;font-size:18px;"">Address Details </span>
                    <div id="tty" style="margin-top:-34px;">

            <a id="A1" href="javascript:toggle5('fggfh', 'A1');">
                <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
            </a>
        </div>
            </div>
        </h4>

        <div id="fggfh" style="display: block;">
            <%-- <div class="tab-pane" id="tab2">--%>
            <div class="for_sigle_row_form">
                <label>
                    Mobile No. <span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtMobileNo2" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="rqd" ControlToValidate="txtMobileNo2"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Phone No.</label>
                <asp:TextBox ID="txtPhoneNo" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtPhoneNo"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>--%>
            </div>
            <asp:UpdatePanel runat="server" ID="upd1">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Email ID<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtEmailId" runat="server" AutoPostBack="true" OnTextChanged="txtEmailId_TextChanged"></asp:TextBox>&nbsp;
                                                    <asp:Label runat="server" ID="lblFemail" ForeColor="Red"></asp:Label>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    Instant Messenger<%--<span style="color: #ff0066">*</span>--%></label>
                <asp:TextBox ID="txtInstant" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Address Line<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtAddressLine" runat="server"></asp:TextBox>&nbsp;
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter address."
                                                ControlToValidate="txtAddressLine" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <asp:UpdatePanel ID="uid" runat="server">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Country<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Label runat="server" ID="lblCountryMsg2" ForeColor="Chocolate" Text=""></asp:Label>
                        &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                            ErrorMessage="Select Country" ControlToValidate="ddlCountry" InitialValue="0"
                            CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            State/Province<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                            OnSelectedIndexChanged="ddlState_SelectedIndexChanged2">
                            <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label runat="server" ID="lblStateMsg2" ForeColor="Chocolate" Text=""></asp:Label>
                        &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                            ErrorMessage="Select State" ControlToValidate="ddlState" InitialValue="0" CssClass="rqd"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            City<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                            ErrorMessage="Select City" ControlToValidate="ddlCity" InitialValue="0" CssClass="rqd"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    Pin/Zip Code<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtPincode" runat="server" MaxLength="6"></asp:TextBox>&nbsp;
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="rqd" ControlToValidate="txtPincode"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Address Line<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>&nbsp;
            </div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Country<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlCountry2" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                            OnSelectedIndexChanged="ddlCountry2_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Label runat="server" ID="lblcontymsg1" ForeColor="Chocolate" Text=""></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            State/Province<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlState2" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                            OnSelectedIndexChanged="ddlState2_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Label runat="server" ID="lblstatmsg1" ForeColor="Chocolate" Text=""></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            City<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlCity2" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                            OnSelectedIndexChanged="ddlCity2_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server"
                            ErrorMessage="Select City" ControlToValidate="ddlCity" InitialValue="0" CssClass="rqd"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    Pin/Zip Code<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="TextBox6" runat="server" MaxLength="6"></asp:TextBox>&nbsp;
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" CssClass="rqd" ControlToValidate="TextBox6"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
        </div>

         <h4 class="page-title txtblue ">

              <div class="icons border-blue radius"  style="margin-top:7px;margin-left:10px;">

                <i class="fa fa-calendar-o txtblue">
                    <img src="../images/prevhistory.png" style="width:20px;height:20px" />
                </i>
            </div>

              <div class="header"  style="margin-top:-10px;">

                     <span style="margin-top:7px;font-size:18px;"">Designation Details </span>
        <div id="dibgg"  style="margin-top:-34px;">

            <a id="A2" href="javascript:toggle5('fggfhyh', 'A2');">
                <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
            </a>
        </div>
            </div>
        </h4>

        <div id="fggfhyh" style="display: block;">
            <%-- <div class="tab-pane" id="tab3">--%>
            <asp:UpdatePanel ID="tab3update" runat="server">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Job Title<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtJobTitle" runat="server"></asp:TextBox>&nbsp;
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="Select job title"
                                                        ControlToValidate="txtJobTitle" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Designation<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlDesigNation" runat="server" AutoPostBack="True" AppendDataBoundItems="True">
                        </asp:DropDownList>
                        &nbsp;
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ErrorMessage="Select designation"
                                                        ControlToValidate="ddlDesigNation" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                   <%-- <div class="for_sigle_row_form">
                        <label>
                            Department <span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlDepartment1" runat="server" AutoPostBack="True" AppendDataBoundItems="True">
                        </asp:DropDownList>
                        &nbsp;
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ErrorMessage="Select Department"
                                                        ControlToValidate="ddlDepartment1" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>--%>
                    <div class="for_sigle_row_form">
                        <label>
                            Branch<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlBranch" runat="server" AutoPostBack="True" AppendDataBoundItems="True">
                        </asp:DropDownList>
                        &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server"
                            ErrorMessage="Select State" ControlToValidate="ddlState" InitialValue="0" CssClass="rqd"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Probation Period<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlProbationPeriod" runat="server" AutoPostBack="True" AppendDataBoundItems="True">
                        </asp:DropDownList>
                        &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server"
                            ErrorMessage="Select City" ControlToValidate="ddlCity" InitialValue="0" CssClass="rqd"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                   <%-- <div class="for_sigle_row_form">
                        <label>
                            Salary<span style="color: #ff0066">*</span></label>
                        <asp:TextBox ID="txtSalary" runat="server"></asp:TextBox>&nbsp;
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="rqd" ControlToValidate="txtSalary"
                                                        runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="^\d+(?:\.\d{0,2})?$"></asp:RegularExpressionValidator>
                    </div>--%>
                    <%-- <div class="for_sigle_row_form">
                                                    <label>
                                                        Status <span style="color: #ff0066">*</span></label>
                                                    <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" AppendDataBoundItems="True">
                                                    </asp:DropDownList>
                                                </div>--%>
                    <div class="for_sigle_row_form">
                        <label>
                            E-mail id
                        </label>
                        <asp:TextBox ID="txtEmailAlloted" runat="server"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            HR Manager Name
                                                        <%--<span style="color: #ff0066">*</span>--%></label>
                        <asp:TextBox ID="txtHrName" runat="server"></asp:TextBox>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <h4 class="page-title txtblue ">

            <div class="icons border-blue radius"  style="margin-top:7px;margin-left:10px;">

                <i class="fa fa-calendar-o txtblue">
                    <img src="../images/prevhistory.png" style="width:20px;height:20px" />
                </i>
            </div>
              <div class="header"  style="margin-top:-10px;">
            <span style="margin-top:7px;font-size:18px;">Previous job Details </span>

              <div id="div345" style="margin-top:-34px;">

            <a id="A3" href="javascript:toggle5('fggfhyh675', 'A3');">
                <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
            </a>
        </div>
                  </div>
        </h4>

        <div id="fggfhyh675" style="display: block;">
            <div class="for_sigle_row_form">
                <label>
                    Organiazation Name
                </label>
                <asp:TextBox ID="txtPorganisation" runat="server"></asp:TextBox>&nbsp;
                                          <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" ErrorMessage="Please enter organization name"
                                                ControlToValidate="txtPorganisation" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Address</label>
                <asp:TextBox ID="txtPaddress" runat="server"></asp:TextBox>&nbsp;
                                          <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ErrorMessage="Please enter address of branch"
                                                ControlToValidate="txtPaddress" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%>
            </div>
            <asp:UpdatePanel runat="server" ID="upd2">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Country</label>
                        <asp:DropDownList ID="ddlPCountry" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                            OnSelectedIndexChanged="ddlPCountry_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Label runat="server" ID="lblCountryMsg" ForeColor="Chocolate" Text=""></asp:Label>
                        &nbsp&nbsp&nbsp<%--<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server"
                                                        ErrorMessage="Select Country of Branch" ControlToValidate="ddlCountry" InitialValue="0"
                                                        CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%></div>
                    <div class="for_sigle_row_form">
                        <label>
                            State/Province<%--<span style="color: #ff0066">*</span>--%></label><asp:DropDownList ID="ddlPstate" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                                OnSelectedIndexChanged="ddlPstate_SelectedIndexChanged">
                            </asp:DropDownList>
                        <asp:Label runat="server" ID="lblStateMsg" ForeColor="Chocolate" Text=""></asp:Label>
                        &nbsp&nbsp&nbsp<%--<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server"
                                                        ErrorMessage="Select State of Branch" ControlToValidate="ddlState" InitialValue="0"
                                                        CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%></div>
                    <div class="for_sigle_row_form">
                        <label>
                            City</label>
                        <asp:DropDownList ID="ddlPCity" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                            OnSelectedIndexChanged="ddlPCity_SelectedIndexChanged">
                            <%--<asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>--%>
                        </asp:DropDownList>
                        &nbsp&nbsp&nbsp<%--<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server"
                                                        ErrorMessage="Select City of Branch" ControlToValidate="ddlCity" InitialValue="0"
                                                        CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%></div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    Pin/Zip Code</label>
                <asp:TextBox ID="txtPPincode" runat="server" MaxLength="6"></asp:TextBox>
                <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator5" CssClass="rqd" ControlToValidate="txtPPincode"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Designation</label>
                <asp:TextBox ID="txtPdesignation" runat="server"></asp:TextBox>&nbsp;
                                           <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ErrorMessage="Select designation"
                                                ControlToValidate="txtPdesignation" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Salary</label>
                <asp:TextBox ID="txtPsalary" runat="server"></asp:TextBox>&nbsp;
                                          <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator7" CssClass="rqd" ControlToValidate="txtPsalary"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="^\d+(?:\.\d{0,2})?$"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" ErrorMessage="Please enter salary"
                                                ControlToValidate="txtPsalary" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Duration(in months)</label>
                <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>&nbsp;
                                           <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ErrorMessage="Please enter duration"
                                                ControlToValidate="txtDuration" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Total Experience(in months)</label>
                <asp:TextBox ID="txtPexperience" runat="server"></asp:TextBox>&nbsp;
                                          <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" ErrorMessage="Please enter total experience"
                                                ControlToValidate="txtPexperience" InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    First Refrence Name</label>
                <asp:TextBox ID="txtRef1Name" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Contact No.</label>
                <asp:TextBox ID="txtReContact1" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                           <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator9" CssClass="rqd" ControlToValidate="txtReContact1"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Second Refrence Name</label>
                <asp:TextBox ID="txtRef2Name" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Contact No.</label>
                <asp:TextBox ID="txtRefContact2" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                      <%--      <asp:RegularExpressionValidator ID="RegularExpressionValidator10" CssClass="rqd"
                                                ControlToValidate="txtRefContact2" runat="server" ErrorMessage="Only Numbers allowed"
                                                ValidationExpression="\d+"></asp:RegularExpressionValidator>--%>
            </div>
        </div>

        <h4 class="page-title txtblue ">

            <div class="icons border-blue radius"  style="margin-top:7px;margin-left:10px;">

                <i class="fa fa-calendar-o txtblue">
                    <img src="../images/prevhistory.png"  style="width:20px;height:20px" />
                </i>
            </div>
              <div class="header"  style="margin-top:-10px;">
            <span style="margin-top:7px;font-size:18px;">Designation Details </span>

             <div id="Div1" style="margin-top:-34px;">

            <a id="A4" href="javascript:toggle5('fggfhyh12', 'A4');">
                <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
            </a>
        </div>
                  </div>
        </h4>

        <div id="fggfhyh12" style="display: block;">
            <div class="for_sigle_row_form">
                <label>
                    Blood Group
                </label>
                <asp:TextBox ID="txtBGroup" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Medical Condition</label>
                <asp:TextBox ID="txtmedicalCondition" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Past Diseases</label>
                <asp:TextBox ID="txtPastDisease" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Genetic Disease</label>
                <asp:TextBox ID="txtGeneticDisease" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Any Allergy</label>
                <asp:TextBox ID="txtAnyEllergy" runat="server"></asp:TextBox>
            </div>
        </div>

        <h4 class="page-title txtblue ">

            <div class="icons border-blue radius" style="margin-top:7px;margin-left:10px;">

                <i class="fa fa-calendar-o txtblue">
                    <img src="images/officeuse.png" style="width:20px;height:20px" />
                </i>
            </div>

               <div class="header"  style="margin-top:-10px;">
            <span style="margin-top:7px;font-size:18px; ">For Office Use Only </span>

             <div id="Div662"  style="margin-top:-34px;">

            <a id="A5" href="javascript:toggle5('fggfhyh1662', 'A5');">
                <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
            </a>
        </div>
                   </div>
        </h4>

        <div id="fggfhyh1662" style="display: block;">
            <div class="for_sigle_row_form" align="center">
                <asp:Label ID="lbl" runat="server" ForeColor="red"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Bank Name</label>
                <asp:TextBox ID="txtBankName" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Account No.</label>
                <asp:TextBox ID="txtAccountNo" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Branch Name</label>
                <asp:TextBox ID="txtBranchName" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Branch Code</label>
                <asp:TextBox ID="txtBranchCode" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    IFSC Code</label>
                <asp:TextBox ID="txtIFSCCode" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
            </div>
        </div>

        <%-- <a href="javascript:;" class="btn button-previous"><i class="icon-angle-left"></i>Back--%>

        <%--   <a href="javascript:;" class="btn btn-success button-submit">--%>
        <div class="for_sigle_row_form" style="margin-left:13.2%; margin-top: -5px">
            <label>
            </label>
            <asp:Button ID="btnAdd" runat="server" Text="Submit" ValidationGroup="g1" CssClass="button_save" OnClick="btnAdd_Click" />
        </div>
        <%--   </a>
        --%>
    </div>

    <%--  </div>--%>
</asp:Content>