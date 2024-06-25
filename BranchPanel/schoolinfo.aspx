<%@ Page Title="School Information" Language="C#" AutoEventWireup="true" CodeFile="schoolinfo.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_schoolinfo" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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

        /*img {
    /*border: 0 none;
    height: auto;*/
        /*max-width: 34% !important;*/
        /*vertical-align: middle;*/
        /*}*/
    </style>
    <script type="text/javascript">
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
        };
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
        function IsValidEmail(email) {
            var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            return expr.test(email);
        };
    </script>

    <script type="text/javascript">

        function check() {

            if (document.getElementById('<%=txtscname.ClientID %>').value.trim() == "") {
                alert("Please enter school name!");
                document.getElementById('<%=txtscname.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlcuntry.ClientID %>').value == 0) {
                alert("Please select country from dropdown!");
                document.getElementById('<%=ddlcuntry.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlstate.ClientID %>').value == 0) {
                alert("Please select State against selected country!");
                document.getElementById('<%=ddlstate.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlcity.ClientID %>').value == 0) {
                alert("Please select city against selected state!");
                document.getElementById('<%=ddlcity.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtemail.ClientID %>').value.trim() == "") {
                alert("Please enter email!");
                document.getElementById('<%=txtemail.ClientID %>').focus();
                return false;
            }

            var email = document.getElementById('<%= txtemail.ClientID %>').value;
            //alert(email);
            if (!IsValidEmail(email)) {
                alert("Please enter valid email.");
                document.getElementById('<%= txtmob.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%= txtcnprson.ClientID %>').value.trim() == "") {
                alert("Please enter contact person name!");
                document.getElementById('<%= txtcnprson.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= txtmob.ClientID %>').value.trim() == "") {
                alert("Please enter mobile number!");
                document.getElementById('<%= txtmob.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlclassfrm.ClientID %>').value == 0) {
                alert("Please Input class Range in dropdown!");
                document.getElementById('<%=ddlclassfrm.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlclassTo.ClientID %>').value == 0) {
                alert("Please Input class Range in dropdown!");
                document.getElementById('<%=ddlclassTo.ClientID %>').focus();
                return false;
            }
            var skillsSelect = document.getElementById('<%=ddlclassfrm.ClientID %>');
            var selectedText = skillsSelect.options[skillsSelect.selectedIndex].text;
            var skillsSelect1 = document.getElementById('<%=ddlclassTo.ClientID %>');
            var selectedText1 = skillsSelect1.options[skillsSelect1.selectedIndex].text;
            if (selectedText == selectedText1) {
                alert("From class and to class cannot be same!!");
                return false;
            }

            if (document.getElementById('<%=ddacadyr.ClientID %>').value == 0) {
                alert("Please Supply Academic year range!");
                document.getElementById('<%=ddacadyr.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=ddToyr.ClientID %>').value == 0) {
                alert("Please Input year Upto!");
                document.getElementById('<%=ddToyr.ClientID %>').focus();
                return false;
            }

            var skillsSelect = document.getElementById('<%=ddacadyr.ClientID %>');
            var selectedText = skillsSelect.options[skillsSelect.selectedIndex].text;
            var skillsSelect1 = document.getElementById('<%=ddToyr.ClientID %>');
            var selectedText1 = skillsSelect1.options[skillsSelect1.selectedIndex].text;

            if (selectedText == selectedText1) {
                alert(" from Academicyear and to Academicyear cannot be same!!");
                return false;
            }

            var skillsSelect = document.getElementById('<%=ddtimings.ClientID %>');
            var selectedText = skillsSelect.options[skillsSelect.selectedIndex].text;
            var skillsSelect1 = document.getElementById('<%=ddtimingTo.ClientID %>');
            var selectedText1 = skillsSelect1.options[skillsSelect1.selectedIndex].text;
            if (selectedText == selectedText1) {
                alert("School from time and to time cannot be same!!");
                return false;
            }

            if (document.getElementById('<%=txtWrkdays.ClientID %>').value.trim() == "") {
                alert("Please enter weekly working days!");
                document.getElementById('<%=txtWrkdays.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=ddstrtday.ClientID %>').value == 0) {
                alert("Please Input Starting Day of week!");
                document.getElementById('<%=ddstrtday.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddweekoff.ClientID %>').value == 0) {
                alert("Please enter week off day !");
                document.getElementById('<%=ddweekoff.ClientID %>').focus();
                return false;
            }

            var skillsSelect = document.getElementById('<%=ddweekoff.ClientID %>');
            var selectedText = skillsSelect.options[skillsSelect.selectedIndex].text;
            var skillsSelect1 = document.getElementById('<%=ddhalfday.ClientID %>');
            var selectedText1 = skillsSelect1.options[skillsSelect1.selectedIndex].text;
            if (selectedText == selectedText1) {
                alert("Weekly off and  HalfDay off cannot be same!!");
                return false;
            }

            if (document.getElementById('<%=  txtperiod.ClientID %>').value.trim() == "") {
                alert("Please enter no of periods !");
                document.getElementById('<%=  txtperiod.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=  txtToDate.ClientID %>').value.trim() == "") {
                alert("Please enter re-opening date!");
                document.getElementById('<%=  txtToDate.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=ddhalfday.ClientID %>').value != 0) {
                var skillsSelect = document.getElementById('<%=ddtimings.ClientID %>');
                var selectedText = skillsSelect.options[skillsSelect.selectedIndex].text;
                var skillsSelect1 = document.getElementById('<%=ddtiminghlfdyTo.ClientID %>');
                var selectedText1 = skillsSelect1.options[skillsSelect1.selectedIndex].text;
                if (selectedText == selectedText1) {
                    alert("Halfday from time and to time cannot be same!!");
                    return false;
                }
            }

        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Master Setting</a></li>
            <li><a>School Setting</a></li>
            <%--            <li style="background: none;"><a class="active" href="#">Complete Admission</a></li>--%>
        </ul>
    </div>

    <%--<asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>--%>
    <div class="content_pane_cont input_content" id="contentPane">
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <br />

                <div id="headerDivImg">

                    <a id="imageDivLink" href="javascript:toggle5('contentDivImg', 'imageDivLink');">
                        <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
                    </a>
                </div>
                <h4 class="page-title txtblue ">

                    <div class="icons border-blue radius">

                        <i class="fa fa-calendar-o txtblue">
                            <img src="../images/stude.png" />
                        </i>
                    </div>
                    <span id="Span1" style="margin-left: 10px;">General Information </span>
                    <h4></h4>
                    <div class="separator bg-blue">
                    </div>
                    <div id="contentDivImg" style="display: block;">
                        <div class="for_sigle_row_form">
                            <div class="for_sigle_row_form">
                            </div>
                            <div class="for_sigle_row_form">
                            </div>
                            <h3>&nbsp;&nbsp;General Information :</h3>
                            <br />
                            <label>
                                School Id :<span style="color: red">*</span></label>
                            <asp:TextBox ID="txtscid" runat="server" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                School Name<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtscname" runat="server" onkeypress="ValidateAlpha()"></asp:TextBox>
                            &nbsp;
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Country:<span style="color: red">*</span></label>
                            <asp:DropDownList ID="ddlcuntry" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlcuntry_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                State: <span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlstate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                City: <span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlcity" runat="server">
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Area Zipcode:</label>
                            <asp:TextBox ID="txtzip" runat="server" AutoCompleteType="HomeZipCode" onkeypress="return noAlphabets(event)" TextMode="SingleLine"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Established on :</label>
                            <asp:DropDownList ID="ddlEstd" runat="server">
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Email id:<span style="color: red">*</span></label>
                            <asp:TextBox ID="txtemail" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Contact Person : <span style="color: #ff0066">*</span>
                            </label>
                            <asp:TextBox ID="txtcnprson" runat="server" AutoCompleteType="FirstName" onkeypress="ValidateAlpha()"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Phone no :<span style="color: #ff0066">*</span></label>
                            <asp:TextBox ID="txtmob" runat="server" AutoCompleteType="Cellular" onkeypress="return noAlphabets(event)"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Fax no :</label>
                            <asp:TextBox ID="txtfax" runat="server" AutoCompleteType="Cellular" onkeypress="return noAlphabets(event)"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Class From :<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlclassfrm" runat="server">
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Class To :<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlclassTo" runat="server">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                        </label>
                        <br />
                    </div>
                    <div id="Div1">
                        <a id="A1" href="javascript:toggle5('contentDivImg11', 'A1');">
                            <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
                        </a>
                    </div>
                    <h4 class="page-title txtblue ">
                        <div class="icons border-blue radius">
                            <i class="fa fa-calendar-o txtblue">
                                <img src="../images/stude.png" />
                            </i>
                        </div>
                        <span id="Span2" style="margin-left: 10px;">School Academic Info </span>
                        <h4></h4>
                        <div class="separator bg-blue">
                        </div>
                        <div id="contentDivImg11" style="display: block;">
                            <label>
                                <h3>&nbsp; &nbsp;School Academic Information :</h3>
                            </label>
                            <div class="for_sigle_row_form">
                            </div>
                            <div class="for_sigle_row_form">
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Academic Year :<span style="color: #ff0066">*</span></label>
                                <asp:DropDownList ID="ddacadyr" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    To :<span style="color: red">*</span></label>
                                <asp:DropDownList ID="ddToyr" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    School Timing :<span style="color: #ff0066">*</span></label>
                                <asp:DropDownList ID="ddscTiming" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    To :<span style="color: red">*</span></label>
                                <asp:DropDownList ID="ddtimingTo" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Weekly Working Days :<span style="color: red">*</span></label>
                                <asp:TextBox ID="txtWrkdays" runat="server" onkeypress="return noAlphabets(event)"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Starting Day of week :<span style="color: red">*</span></label>
                                <asp:DropDownList ID="ddstrtday" runat="server">
                                    <asp:ListItem Text="---- Select Days ----" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Sunday" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Monday" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Tuesday" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Wednesday" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Thrusday" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Friday" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="Saturday" Value="7"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Weekly Off :<span style="color: #ff0066">*</span></label>
                                <asp:DropDownList ID="ddweekoff" runat="server">
                                    <asp:ListItem Text="---- Select off Day ----" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Sunday" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Monday" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Tuesday" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Wednesday" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Thrusday" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Friday" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="Saturday" Value="7"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Half Day :</label>
                                <asp:DropDownList ID="ddhalfday" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddhalfday_SelectedIndexChanged">
                                    <asp:ListItem Text="-- Select Day as Half day --" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Sunday" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Monday" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Tuesday" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Wednesday" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Thrusday" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Friday" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="Saturday" Value="7"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Periods :<span style="color: red">*</span></label>
                                <asp:TextBox ID="txtperiod" runat="server"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Long Break / Duration :</label>
                                <asp:TextBox ID="txtbreak" runat="server" onkeypress="return noAlphabets(event)"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Short Break / Duration :</label>
                                <asp:TextBox ID="txtshortbrek" runat="server" onkeypress="return noAlphabets(event)"></asp:TextBox>
                            </div>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <br />
                        </div>
                        <div id="Div2">
                            <a id="A2" href="javascript:toggle5('contentDivImg22', 'A2');">
                                <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
                            </a>
                        </div>
                        <h4 class="page-title txtblue ">
                            <div class="icons border-blue radius">
                                <i class="fa fa-calendar-o txtblue">
                                    <img src="../images/stude.png" style="max-width: 34% !important;" />
                                </i>
                            </div>
                            <span id="Span3" style="margin-left: 10px;">Facilities </span>
                            <h4></h4>
                            <div class="separator bg-blue">
                            </div>
                            <div id="contentDivImg22" style="display: block;">
                                <label>
                                    <h3>&nbsp;&nbsp;Facilities :</h3>
                                </label>
                                <div class="for_sigle_row_form">
                                    <%-- <asp:CheckBoxList ID="chkbxfacility" RepeatDirection="Vertical" runat="server">
                    <asp:ListItem Text="Hostel" Value="0" Enabled="true"></asp:ListItem>
                    <asp:ListItem Text="Library" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Transport" Value="2"></asp:ListItem>
                </asp:CheckBoxList>--%>
                                    <label>
                                    </label>
                                    <asp:CheckBox ID="chk1" runat="server" Text="Hostel" />
                                    <asp:CheckBox ID="chk2" runat="server" Text="Library" />
                                    <asp:CheckBox ID="chk3" runat="server" Text="Transport" />
                                </div>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Re-Open Date :<span style="color: #ff0066">*</span></label>
                                    <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                                </div>
                                <div class="for_sigle_row_form">
                                    <asp:CheckBoxList ID="chkbxautogenrte" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Auto Generate Employee Enrollment Id" Value="0" Enabled="true"></asp:ListItem>
                                        <asp:ListItem Text="Auto Generate Student Admission No." Value="1"></asp:ListItem>
                                    </asp:CheckBoxList>
                                    <label>
                                    </label>
                                    <asp:CheckBox ID="chk4" runat="server" Text="Auto Generate Employee Enrollment Id" />
                                    <asp:CheckBox ID="chk5" runat="server" Text="Auto Generate Student Admission No." />
                                </div>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                </label>
                                <br />
                            </div>
                            <div id="gd" runat="server">
                                <div id="Div3">
                                    <a id="A3" href="javascript:toggle5('contentDivImg33', 'A3');">
                                        <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
                                    </a>
                                </div>
                                <h4 class="page-title txtblue ">
                                    <div class="icons border-blue radius">
                                        <i class="fa fa-calendar-o txtblue">
                                            <img src="../images/stude.png" />
                                        </i>
                                    </div>
                                    <span id="Span4" style="margin-left: 10px;">Half-Day Period Info </span>
                                    <h4></h4>
                                    <div class="separator bg-blue">
                                    </div>
                                    <div id="contentDivImg33" style="display: block;">
                                        <h3>&nbsp;&nbsp;Half-Day Period Information :</h3>
                                        <div class="for_sigle_row_form">
                                            <label>
                                                Timings :<span style="color: red">*</span></label>
                                            <asp:DropDownList ID="ddtimings" runat="server">
                                                <asp:ListItem Text="--Select Start Time--" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="for_sigle_row_form">
                                            <label>
                                                To :<span style="color: red">*</span></label>
                                            <asp:DropDownList ID="ddtiminghlfdyTo" runat="server">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="for_sigle_row_form">
                                            <label>
                                                Periods :</label>
                                            <asp:TextBox ID="txtperiods" runat="server" AutoCompleteType="Cellular"></asp:TextBox>
                                        </div>
                                        <div class="for_sigle_row_form">
                                            <label>
                                                Long Break / Duration :</label>
                                            <asp:TextBox ID="txtbreak2" runat="server" onkeypress="return noAlphabets(event)"></asp:TextBox>
                                        </div>
                                        <div class="for_sigle_row_form">
                                            <label>
                                                Short Break / Duration :</label>
                                            <asp:TextBox ID="txtShrtbrek" runat="server" onkeypress="return noAlphabets(event)"></asp:TextBox>
                                        </div>
                                    </div>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                    <h4></h4>
                                </h4>
                            </div>
                            <div class="for_sigle_row_form">
                            </div>
                            <br />
                            <div class="for_sigle_row_form">
                                <center>
                                    <asp:Button ID="btn_Update" runat="server" CssClass="button_save" Height="30px" OnClick="btn_Update_Click" OnClientClick="return check()" Text="Submit" Width="90px" />
                                </center>
                            </div>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                            <h4></h4>
                        </h4>
                    </h4>
                </h4>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>