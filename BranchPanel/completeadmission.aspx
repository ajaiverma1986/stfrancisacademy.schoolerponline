<%@ Page Title="Complete Admission" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="completeadmission.aspx.cs" Inherits="BranchPanel_completeadmission" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function toggle5(showHideDiv, switchImgTag) {
            var ele = document.getElementById(showHideDiv);
            var imageEle = document.getElementById(switchImgTag);

            if (ele.style.display == "block") {
                ele.style.display = "none";
                imageEle.innerHTML = '<img src="../images/addd11.png" style=" margin-left:900px;" />';
            }
            else {
                ele.style.display = "block";
                imageEle.innerHTML = '<img src="../images/Green_Minus.gif" style=" margin-left:900px;">';
            }
        }
    </script>

    <style>
        .active8 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }
    </style>

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
                $("#ctl00_ContentPlaceHolder1_txtDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
                $("#ctl00_ContentPlaceHolder1_txtMDOB").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
            });

        });
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active" href="#">Complete Admission</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>
    <div class="clear"></div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="Stu1" />
        <br />
        <br />
        <div id="headerDivImg">

            <a id="imageDivLink" href="javascript:toggle5('contentDivImg', 'imageDivLink');">
                <img src="../images/addd11.png" style="margin-left: 900px;" />
            </a>
        </div>
        <h4 class="page-title txtblue ">
            <span id="Span1" style="margin-left: 10px;">Student Details </span>
        </h4>

        <div class="separator bg-blue"></div>

        <div id="contentDivImg" style="display: none;">

            <div class="for_sigle_row_form">
                <div class="user_phot_frame">
                    <asp:Image runat="server" ID="imgstu" />
                </div>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Admission No.(for reference)</label>
                <asp:TextBox ID="txtRegNo" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Name of Student<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="TextBox11" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtLName" runat="server" CssClass="lname"></asp:TextBox>&nbsp
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Date of Birth<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Gender<span style="color: Red">*</span></label>
                <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                    <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                    <asp:ListItem Value="0">Female</asp:ListItem>
                </asp:RadioButtonList>
                &nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Nationality<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtNation" runat="server"></asp:TextBox>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Birth Place<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtBirthPlace" runat="server"></asp:TextBox>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Religion</label>
                <asp:TextBox ID="txtReligion" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Mother Tongue</label>
                <asp:TextBox ID="txtMotherTongue" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Blood Group<span style="color: Red">*</span></label>
                <asp:DropDownList runat="server" ID="ddlBloodGroup">
                    <asp:ListItem Value="0" Selected="True">--Select one--</asp:ListItem>
                    <asp:ListItem Value="1">O-</asp:ListItem>
                    <asp:ListItem Value="2">A+</asp:ListItem>
                    <asp:ListItem Value="3">A-</asp:ListItem>
                    <asp:ListItem Value="4">B+</asp:ListItem>
                    <asp:ListItem Value="5">B-</asp:ListItem>
                    <asp:ListItem Value="6">AB+</asp:ListItem>
                    <asp:ListItem Value="7">AB-</asp:ListItem>
                    <asp:ListItem Value="8">O+</asp:ListItem>
                </asp:DropDownList>
                &nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Category<span style="color: Red">*</span></label>
                <asp:DropDownList runat="server" ID="ddlCategory">
                    <asp:ListItem Value="0" Selected="True">--Select one--</asp:ListItem>
                    <asp:ListItem Value="1">General</asp:ListItem>
                    <asp:ListItem Value="2">OBC</asp:ListItem>
                    <asp:ListItem Value="3">SC</asp:ListItem>
                    <asp:ListItem Value="4">ST</asp:ListItem>
                </asp:DropDownList>
                &nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Applying for Class<span style="color: Red">*</span></label>
                <asp:DropDownList runat="server" ID="ddlClass">
                </asp:DropDownList>
                &nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Transportation required<span style="color: Red">*</span></label>
                <asp:RadioButtonList runat="server" ID="rbTransport" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                </asp:RadioButtonList>
                &nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Upload photograph(500KB max)</label>
                <asp:FileUpload runat="server" ID="fuPhoto" />&nbsp;
                                        <asp:Label ID="lblimg1" runat="server" ForeColor="Red">Upload only .jpg,.jpeg,.png,.gif Image file"</asp:Label>
                <asp:Label runat="server" ID="lblStuPhoto" ForeColor="Chocolate" Text="" Visible="false"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Upload Birth Certificate</label>
                <asp:FileUpload runat="server" ID="fuBirCet" />&nbsp;
                                        <asp:Label runat="server" ID="lblBC" ForeColor="Chocolate" Text="" Visible="false"></asp:Label>
                <asp:LinkButton runat="server" ID="lbCertificate"
                    Text="Download Birth Certificate" Visible="false" Font-Bold="true"
                    Font-Underline="true" OnClick="lbCertificate_Click"></asp:LinkButton>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Documents submitted</label>
                <asp:TextBox ID="txtDocSubmitted" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Additional Information</label>
                <asp:TextBox ID="txtAddInfo" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <br />
        </div>
        <div id="cont123" runat="server">
            <div id="titleTextImg"></div>

            <a id="A3" href="javascript:toggle5('cont123', 'A3');">
                <img src="../images/addd11.png" style="margin-left: 900px;" />
            </a>
        </div>
        <h4 class="page-title txtblue ">
            <span id="Span3" style="margin-left: 10px;">Parent Details </span>
        </h4>

        <div class="separator bg-blue"></div>

        <div id="cont123" style="display: none;">

            <div class="for_sigle_row_form">
                <div class="user_phot_frame">
                    <asp:Image runat="server" ID="imgFather" />
                </div>
            </div>
            <div class="for_sigle_row_form">
                <label style="font-weight: bold;">
                    Father Details</label>
                <br />
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Father's Name<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtFFname" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtFMname" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtFLname" runat="server" CssClass="lname"></asp:TextBox>&nbsp
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Date of Birth</label>
                <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Nationality</label>
                <asp:TextBox ID="txtFNation" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Academic Qualification<span style="color: Red">*</span></label>
                <asp:DropDownList runat="server" ID="ddlQualifiaction1">
                    <asp:ListItem Value="0">--Select one--</asp:ListItem>
                    <asp:ListItem Value="1">10th</asp:ListItem>
                    <asp:ListItem Value="2">12th</asp:ListItem>
                    <asp:ListItem Value="3">Graduate</asp:ListItem>
                    <asp:ListItem Value="4">Post Graduate and higher</asp:ListItem>
                </asp:DropDownList>
                &nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Occupation<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtFOccup" runat="server"></asp:TextBox>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Designation</label>
                <asp:TextBox ID="txtFDesig" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Name of Organization</label>
                <asp:TextBox ID="txtFON" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Office/Business Address</label>
                <asp:TextBox runat="server" ID="txtAddressF" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Phone No.<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtFPhone"
                        MaxLength="10" runat="server"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="rqd" ControlToValidate="txtFPhone"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Mobile No.<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtFMobile" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="rqd" ControlToValidate="txtFMobile"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <asp:UpdatePanel runat="server" ID="upd123">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            EmailId</label>
                        <asp:TextBox ID="txtFEmailid" runat="server" AutoPostBack="true"
                            OnTextChanged="txtFEmailid_TextChanged"></asp:TextBox>&nbsp;
                                        <asp:Label runat="server" ID="lblFemail" ForeColor="Red"></asp:Label>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    Upload photo</label>
                <asp:FileUpload runat="server" ID="fuFather" />&nbsp;
                                        <asp:Label ID="LBLIMG2" runat="server" ForeColor="Red">Upload only .jpg,.jpeg,.png,.gif Image file"</asp:Label>
                <asp:Label runat="server" ID="lblFather" ForeColor="Chocolate" Text="" Visible="false"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label style="font-weight: bold;">
                    Mother Details</label>
                <br />
            </div>
            <div class="for_sigle_row_form">
                <div class="user_phot_frame">
                    <asp:Image runat="server" ID="imgMother" />
                </div>
                <label>
                    Mother's Name<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtMFname" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtMMname" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtMLname" runat="server" CssClass="lname"></asp:TextBox>&nbsp
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Date of Birth</label>
                <asp:TextBox ID="txtMDOB" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Nationality</label>
                <asp:TextBox ID="txtMNation" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Academic Qualification<span style="color: Red">*</span></label>
                <asp:DropDownList runat="server" ID="DropDownList1">
                    <asp:ListItem Value="0">--Select one--</asp:ListItem>
                    <asp:ListItem Value="1">10th</asp:ListItem>
                    <asp:ListItem Value="2">12th</asp:ListItem>
                    <asp:ListItem Value="3">Graduate</asp:ListItem>
                    <asp:ListItem Value="4">Post Graduate and higher</asp:ListItem>
                </asp:DropDownList>
                &nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Occupation<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtMOccup" runat="server"></asp:TextBox>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Designation</label>
                <asp:TextBox ID="txtMDesig" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Name of Organization</label>
                <asp:TextBox ID="txtMON" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Office/Business Address</label>
                <asp:TextBox runat="server" ID="txtAddressM" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Phone No.<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtMPhone"
                        MaxLength="10" runat="server"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" CssClass="rqd" ControlToValidate="txtMPhone"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Mobile No.<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtMMobile"
                        runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtMMobile"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <asp:UpdatePanel runat="server" ID="upd1234">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            EmailId</label>
                        <asp:TextBox ID="txtMEmailid" runat="server" AutoPostBack="true"
                            OnTextChanged="txtMEmailid_TextChanged"></asp:TextBox>&nbsp;
                                        <asp:Label runat="server" ID="lblMemail" ForeColor="Red"></asp:Label>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    Upload photo</label>
                <asp:FileUpload runat="server" ID="FileUpload1" />&nbsp;
                                        <asp:Label ID="lblimg3" runat="server" ForeColor="Red">Upload only .jpg,.jpeg,.png,.gif Image file"</asp:Label>
                <asp:Label runat="server" ID="lblmother" ForeColor="Chocolate" Text="" Visible="false"></asp:Label>
            </div>

            <div class="for_sigle_row_form">
                <asp:UpdatePanel ID="up12" runat="server">
                    <ContentTemplate>
                        <label style="font-weight: bold;">
                            Guardian(if any)</label>
                        <asp:CheckBox runat="server" ID="CheckBox1" ToolTip="Check this if the details are same."
                            OnCheckedChanged="CheckBox1_CheckedChanged" AutoPostBack="true" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <asp:UpdatePanel runat="server" ID="UP1">
                <ContentTemplate>
                    <div class="for_sigle_row_form">

                        <label runat="server" id="l1">
                            Guardian's Name<span style="color: Red">*</span></label>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="fname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtmidnameg" runat="server" CssClass="mname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtlastg" runat="server" CssClass="lname"></asp:TextBox>
                    </div>

                    <div class="for_sigle_row_form">

                        <label runat="server" id="l2">
                            Nationality</label>
                        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="l3">
                            Academic Qualification<%--<span style="color:Red">*</span>--%></label><asp:DropDownList
                                runat="server" ID="DropDownList2">
                                <asp:ListItem Value="0">--Select one--</asp:ListItem>
                                <asp:ListItem Value="1">10th</asp:ListItem>
                                <asp:ListItem Value="2">12th</asp:ListItem>
                                <asp:ListItem Value="3">Graduate</asp:ListItem>
                                <asp:ListItem Value="4">Post Graduate and higher</asp:ListItem>
                            </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="l4">
                            Occupation<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="TextBox4"
                                runat="server"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="l5">
                            Designation</label>
                        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="l6">
                            Name of Organization</label>
                        <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="l7">
                            Office/Business Address</label>
                        <asp:TextBox runat="server" ID="TextBox7" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="l8">
                            Phone No.<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="TextBox8"
                                MaxLength="10" runat="server"></asp:TextBox>&nbsp;
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" CssClass="rqd" ControlToValidate="TextBox8"
                                                    runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="l9">
                            Mobile No.<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtGISD" runat="server" Width="43px" ToolTip="Enter your country code here"></asp:TextBox>
                        <asp:TextBox ID="TextBox9" runat="server" MaxLength="10" Width="239px"></asp:TextBox>&nbsp;
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="rqd" ControlToValidate="TextBox9"
                                                    runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="l10">
                            EmailId</label>
                        <asp:TextBox ID="TextBox10" runat="server" AutoPostBack="true"
                            OnTextChanged="TextBox10_TextChanged"></asp:TextBox>&nbsp;
                                               <asp:Label runat="server" ID="lblGemail" ForeColor="Red"></asp:Label>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <br />
        </div>

        <div id="asi123">
            <div id="Div4"></div>
            <a id="A2" href="javascript:toggle5('contentDivImg111', 'A2');">
                <img src="../images/addd11.png" style="margin-left: 900px;" />
            </a>
        </div>
        <h4 class="page-title txtblue ">
            <span id="Span2" style="margin-left: 10px;">Address Details </span>
        </h4>

        <div class="separator bg-blue"></div>

        <div id="contentDivImg111" style="display: none;">

            <div class="for_sigle_row_form">
                <label style="font-weight: bold;">
                    Permanent Address</label>
                <br />
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Address Line<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine"></asp:TextBox>&nbsp;
            </div>
            <asp:UpdatePanel runat="server" ID="UP2">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Country<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlCountry1" AutoPostBack="true" OnSelectedIndexChanged="ddlCountry1_SelectedIndexChanged">
                        </asp:DropDownList>
                        &nbsp;
                                                 <asp:Label runat="server" ID="lblCountryMsg1" ForeColor="Chocolate" Text=""></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            State/Province<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlState1" AutoPostBack="true" OnSelectedIndexChanged="ddlState1_SelectedIndexChanged">
                        </asp:DropDownList>
                        &nbsp;
                                                <asp:Label runat="server" ID="lblStateMsg1" ForeColor="Chocolate" Text=""></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            City<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlCity1">
                        </asp:DropDownList>
                        &nbsp;
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    PIN/ZIP code<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtPZIP" runat="server" MaxLength="6"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" CssClass="rqd" ControlToValidate="txtPZIP"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label style="font-weight: bold;">
                    Temporary Address</label>
                <br />
            </div>
            <div class="for_sigle_row_form">
                <%--<asp:UpdatePanel runat="server" ID="UP3">
                                                    <ContentTemplate>--%>

                <label>
                    Select if same as above</label>
                <asp:CheckBox runat="server" ID="cb1" OnCheckedChanged="cb1_CheckedChanged" AutoPostBack="true" /><br />
                <%--  </ContentTemplate>
                                                </asp:UpdatePanel>--%>
            </div>
            <asp:UpdatePanel runat="server" ID="upd12">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="t1">
                            Address Line<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtTAddress" runat="server" TextMode="MultiLine"></asp:TextBox>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="t2">
                            Country<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlcountry2" AutoPostBack="true" OnSelectedIndexChanged="ddlcountry2_SelectedIndexChanged">
                        </asp:DropDownList>
                        &nbsp;
                                        <asp:Label runat="server" ID="lblCountryMSg2" ForeColor="Chocolate"></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="t3">
                            State/Province<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlState2" AutoPostBack="true" OnSelectedIndexChanged="ddlState2_SelectedIndexChanged">
                        </asp:DropDownList>
                        &nbsp;
                                        <asp:Label runat="server" ID="lblState2" ForeColor="Chocolate"></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="t4">
                            City<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlCity2">
                        </asp:DropDownList>
                        &nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="t5">
                            PIN/ZIP code<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtTZIP" runat="server" MaxLength="6"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" CssClass="rqd" ControlToValidate="txtTZIP"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="for_sigle_row_form">
            <label>
            </label>
            <br />
        </div>

        <div id="Divashu">
            <div id="Div1234"></div>
            <a id="A4" href="javascript:toggle5('contentDivImg222', 'A4');">
                <img src="../images/addd11.png" style="margin-left: 900px;" />
            </a>
        </div>
        <h4 class="page-title txtblue ">
            <span id="Span4" style="margin-left: 10px;">Previous History </span>
        </h4>

        <div class="separator bg-blue"></div>

        <div id="contentDivImg222" style="display: none;">

            <div class="for_sigle_row_form">
                <label>
                    Current School Name<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtPreSchool"
                        runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Class studying in</label>
                <asp:DropDownList runat="server" ID="ddlcurrentclass">
                    <asp:ListItem Value="0">--Select Class--</asp:ListItem>
                    <asp:ListItem Value="1">L.K.G.</asp:ListItem>
                    <asp:ListItem Value="2">U.K.G.</asp:ListItem>
                    <asp:ListItem Value="3">Ist</asp:ListItem>
                    <asp:ListItem Value="4">IInd</asp:ListItem>
                    <asp:ListItem Value="5">III rd</asp:ListItem>
                    <asp:ListItem Value="6">IV th</asp:ListItem>
                    <asp:ListItem Value="7">V th</asp:ListItem>
                    <asp:ListItem Value="8">VI th</asp:ListItem>
                    <asp:ListItem Value="9">VII th</asp:ListItem>
                    <asp:ListItem Value="10">VIII th</asp:ListItem>
                    <asp:ListItem Value="11">IX th</asp:ListItem>
                    <asp:ListItem Value="12">X th</asp:ListItem>
                    <asp:ListItem Value="13">XI th</asp:ListItem>
                    <asp:ListItem Value="14">XII th</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Academic Year</label>
                <asp:TextBox ID="txtAcaYear" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Total Percentage</label>
                <asp:DropDownList runat="server" ID="ddlPErcentage">
                    <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    <asp:ListItem Value="1">30-40%</asp:ListItem>
                    <asp:ListItem Value="2">40-50%</asp:ListItem>
                    <asp:ListItem Value="3">50-60%</asp:ListItem>
                    <asp:ListItem Value="4">60-70%</asp:ListItem>
                    <asp:ListItem Value="5">70-80%</asp:ListItem>
                    <asp:ListItem Value="6">80-90%</asp:ListItem>
                    <asp:ListItem Value="7">90-100%</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Reason for leaving<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtReason"
                        runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Upload latest progress card</label>
                <asp:FileUpload runat="server" ID="fuProcard" />
                &nbsp;
                                        <asp:Label runat="server" ID="lblReport" ForeColor="Chocolate" Text="" Visible="false"></asp:Label>
                <asp:LinkButton runat="server" ID="lbPRogress" Text="Download Report Card"
                    Visible="false" Font-Bold="true" Font-Underline="true"
                    OnClick="lbPRogress_Click"></asp:LinkButton>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <br />
        </div>

        <div id="Div1ank">
            <div id="Div2"></div>
            <a id="A5" href="javascript:toggle5('contentDivImg333', 'A5');">
                <img src="../images/addd11.png" style="margin-left: 900px;" />
            </a>
        </div>
        <h4 class="page-title txtblue ">
            <span id="Span5" style="margin-left: 10px;">Other Details </span>
        </h4>

        <div class="separator bg-blue"></div>

        <div id="contentDivImg333" style="display: none;">
            <asp:UpdatePanel runat="server" ID="UP4">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            If any of the parent is an ex-student of the school,please mention year and branch<span
                                style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlExStudent" AutoPostBack="true" OnSelectedIndexChanged="ddlExStudent_SelectedIndexChanged">
                            <asp:ListItem Value="-1">--Select One--</asp:ListItem>
                            <asp:ListItem Value="1">Yes</asp:ListItem>
                            <asp:ListItem Value="0">No</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;
                    </div>
                    <br />
                    <br />
                    <div class="for_sigle_row_form">
                        <label runat="server" id="ll1">
                            Passing Year</label>
                        <asp:TextBox ID="txtPPyear" runat="server" ToolTip="Year in which you completed the schooling"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="ll2">
                            Branch Address</label>
                        <asp:TextBox ID="txtPEBRAddress" runat="server" ToolTip="Branch where you completed schooling"></asp:TextBox>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <asp:UpdatePanel runat="server" ID="upd24">
                    <ContentTemplate>
                        <label>
                            If staff child,please select</label>
                        <asp:RadioButtonList runat="server" ID="rbStaff" RepeatDirection="Vertical"
                            AutoPostBack="true" OnSelectedIndexChanged="rbStaff_SelectedIndexChanged">
                            <asp:ListItem Value="1">Yes</asp:ListItem>
                            <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="for_sigle_row_form">
                <asp:UpdatePanel runat="server" ID="upd45">
                    <ContentTemplate>
                        <label runat="server" id="ll6">
                            Staff Member Name<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtStaffMem" runat="server"></asp:TextBox>&nbsp;
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <br />
            <br />
            <asp:UpdatePanel runat="server" ID="UP5">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Details of sibling,if any, studying in the school</label>
                        <asp:RadioButtonList runat="server" ID="rblSibling" RepeatDirection="Vertical" AutoPostBack="true"
                            OnSelectedIndexChanged="rblSibling_SelectedIndexChanged">
                            <asp:ListItem Value="1">Yes</asp:ListItem>
                            <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <br />
                    <div class="for_sigle_row_form">
                        <label runat="server" id="sib2">
                            Class<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="txtCSsibling" AutoPostBack="true"
                            OnSelectedIndexChanged="txtCSsibling_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="Label1">
                            Section<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="DropDownList3"></asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label runat="server" id="sib1">
                            Name of the student<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtsibling" runat="server"></asp:TextBox>&nbsp;
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <br />
        </div>

        <div id="Divrrr">
            <div id="Div34"></div>
            <a id="A6" href="javascript:toggle5('contentDivImg444', 'A6');">
                <img src="../images/addd11.png" style="margin-left: 900px;" />
            </a>
        </div>
        <h4 class="page-title txtblue ">
            <span id="Span6" style="margin-left: 10px;">For Office Use Only  </span>
        </h4>

        <div class="separator bg-blue"></div>

        <div id="contentDivImg444" style="display: none;">

            <div class="for_sigle_row_form">
                <label>
                    Admission No.<%--<span style="color:Red">*</span>--%></label>
                <asp:TextBox ID="txtadmNo" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Admission Date<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtAdmDate"
                        ReadOnly="true" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Class<%--<span style="color:Red">*</span>--%></label><asp:TextBox runat="server"
                        ReadOnly="true" ID="txtClassSec"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Branch Name<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtOfficer"
                        runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <b>
                    <asp:Label runat="server" ID="lblMsg"></asp:Label></b>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
        </div>

        <div class="form-actions clearfix">
            <div class="for_sigle_row_form">
                <label></label>
                <%-- <a href="javascript:;" class="btn button-previous"><i class="icon-angle-left"></i>Back
                                        </a>--%>
                <%--<asp:LinkButton ID="lnk1" runat="server" CssClass="btn btn-primary blue button-next">
                                 Continue <i class="icon-angle-right"></i>
                            </asp:LinkButton>--%>
                <%--<a href="javascript:;" class="btn btn-primary blue button-next"><i class="icon-angle-left"></i>Continue </a>--%><a id="A1" href="javascript:;" class="btn btn-success button-submit "
                    runat="server" onserverclick="btnsubmit_Click">Update <i class="icon-ok"></i>
                </a>
            </div>
        </div>
    </div>
</asp:Content>