<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="AdmissionHome.aspx.cs" Inherits="AdmissionBeforeLogin_AdmissionHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <link id="favicon" rel="shortcut icon" type="image/ico" runat="server" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=ConfigurationManager.AppSettings["titleBar"].ToString()%></title>
    <link href="../css/softwares_style.css" rel="stylesheet" type="text/css" />
    <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0' />
    <link href="../css/font.css" rel="stylesheet" />
    <link href="../css/app.v1.css" rel="stylesheet" />
    <link href="../css/responsive.css" rel="stylesheet" />
    <link href="../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.8.2.js" type="text/javascript"></script>
    <%-- <script src="../../js/jquery-1.8.2.min.js" type="text/javascript"></script>--%>
    <script src="../js/alertify.js" type="text/javascript"></script>
    <%--Old Script Start Here--%>
    <link href="../css/1.8-themes-base-jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <%--Old Script End Here--%>
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

        .input_content {
            padding-bottom: 0px !important;
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
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-112013300-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag() { dataLayer.push(arguments); }
        gtag('js', new Date());

        gtag('config', 'UA-112013300-1');

        function ShowPopup() {
            $("#dialog").dialog();
        }
    </script>

</head>
<body id="MasterBody" runat="server">
    <form id="form1" runat="server">        
        <asp:ScriptManager ID="ScriptManager2" runat="server">
        </asp:ScriptManager>
        <div id="dialog" title="Basic dialog">
            <p><asp:Label runat="server" ID="lblLoginID" Text=""></asp:Label></p>
        </div>
        <section class="vbox">
            <header id="asdsmaster" class="bg-dark dk header navbar navbar-fixed-top-xs">
                <div class="navbar-header aside-md" id="logobgcolor" runat="server">
                    <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html"><i class="fa fa-bars"></i></a>
                    <a href="#" class="navbar-brand" data-toggle="fullscreen">
                        <asp:Image ID="logo" runat="server" />
                        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".nav-user"><i class="fa fa-cog"></i></a>
                </div>
                <%--          <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user">
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="thumb-sm avatar pull-left">
                        <asp:Image ID="btnprofilelogin" runat="server" AlternateText="No Image" />
                    </span>
                        <asp:Label ID="lblAdmin" runat="server">Amit Sharma</asp:Label><b class="caret"></b></a>
                        <ul class="dropdown-menu animated fadeInRight">
                            <span class="arrow top"></span>
                            <li style="display: none;"><a href="#">Settings</a> </li>
                            <li><a href="#" id="adprofile" runat="server">Profile</a> </li>
                            <li style="display: none;"><a href="#"><span class="badge bg-danger pull-right">3</span> Notifications </a></li>
                            <li style="display: none;"><a href="docs.html">Help</a> </li>
                            <li class="divider"></li>
                            <li><a href="../../Logout.aspx?s=<%= Session["BrRoleID"] %>">Logout</a> </li>

                        </ul>
                    </li>
                </ul>--%>
            </header>
            <section>
                <section class="hbox stretch">
                    <section id="content">
                        <section class="vbox">
                            <section class="scrollable padder">
                                <div id="content_pane" style="width: 50%; margin-left: 25%;">
                                    <div class="content_pane_cont input_content" id="contentPane">
                                        <div class="main-div-tbl">
                                            <div class="new-registration">
                                                <div class="sub-heading">
                                                    Student Information
                <img src="../../images/Expend.png" id="imgbtnforcollapseorexpend" title="Click here to expend or collapse all field." style="float: right; margin-right: 20px; margin-top: -2px; width: 20px;" alt="No Image" />
                                                </div>
                                               <!-- <div class="for_sigle_row_form">
                                                    <label>
                                                        Discount Code(If Apllicable)</label>
                                                    <asp:TextBox ID="txtdiscountcode" runat="server" MaxLength="15" placeholder="Enter Discount Code If Exists" OnTextChanged="txtdiscountcode_TextChanged" AutoPostBack="true"></asp:TextBox>&nbsp;                  
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Registration No(If Apllicable)</label>
                                                    <asp:TextBox ID="txtregistrationno" runat="server" MaxLength="15" placeholder="Enter Reference Registration No If Exists" OnTextChanged="txtregistrationno_TextChanged" AutoPostBack="true"></asp:TextBox>&nbsp;                  
                                                </div>--!>
                                                <div class="for_sigle_row_form" id="AdmissionNo" style="display: none">
                                                    <label>
                                                        Admission No.(For Reference)</label>
                                                    <asp:TextBox ID="txtadmissionreferenceno" runat="server" MaxLength="15" placeholder="Enter Admission No Please"></asp:TextBox>&nbsp;                  
                                                </div>

                                                <div class="for_sigle_row_form" id="RegistrationSession">
                                                    <label>
                                                        Admission Session<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:DropDownList ID="ddlregistrationsession" runat="server">
                                                        <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;                   
                                                </div>
                                                <div class="clear"></div>

                                                 <div class="for_sigle_row_form" id="branchNAme">
                                                    <label>
                                                        Branch Name Session<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:DropDownList ID="ddlBranchID" runat="server">
                                                        <asp:ListItem Value="0">--Select Branch--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;                   
                                                </div>
                                                <div class="clear"></div>

                                                <div class="for_sigle_row_form" id="StudentOldRegNo">
                                                    <label>
                                                        Reference Registration No</label>
                                                    <asp:TextBox ID="txtOldRegNo" runat="server" MaxLength="15" placeholder="Enter Admission No Please"></asp:TextBox>&nbsp;                  
                                                </div>
                                                <div class="for_sigle_row_form" id="StudentFirstName">
                                                    <label>
                                                        Student First Name<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:TextBox ID="txtstudentfirstname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student First Name"></asp:TextBox>&nbsp;                   
                                                </div>
                                                <div class="for_sigle_row_form" id="StudentMiddleName">
                                                    <label>
                                                        Student Middle Name</label>
                                                    <asp:TextBox ID="txtstudentmiddlename" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student Middle Name"></asp:TextBox>&nbsp;                   
                                                </div>
                                                <div class="for_sigle_row_form" id="StudentLastName">
                                                    <label>
                                                        Student Last Name</label>
                                                    <asp:TextBox ID="txtstudentlastname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student Last Name"></asp:TextBox>&nbsp;                    
                                                </div>
                                                <div class="for_sigle_row_form" id="StudentDOB">
                                                    <label>
                                                        Select Student D.O.B<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:TextBox ID="txtstudentdob" onchange="CalculateAge(this)" onkeypress="return false" runat="server" placeholder="Select Student D.O.B"></asp:TextBox><span class="dob-formate">(DD/MM/YYYY)</span>&nbsp;          
                    <span id="lblAge" style="font-weight: bold; color: red"></span>
                                                </div>
                                                <div class="for_sigle_row_form" id="StudentUID">
                                                    <label>
                                                        Student Aadhaar Card(UID) No</label>
                                                    <asp:TextBox ID="txtstudentUid" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Student Aadhaar Card(UID) No"></asp:TextBox>&nbsp;     
                    <span id="lblUid" style="font-weight: bold; color: red"></span>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="Hostal">
                                                    <label style="padding-top: 4px;">
                                                        Hostel</label>
                                                    <div style="width: 171px; height: 20px; float: left;">
                                                        <asp:RadioButtonList runat="server" ID="rbtnlistHostal" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="house">
                                                    <label>
                                                        House Name</label>
                                                    <asp:DropDownList ID="ddlHouse" runat="server">
                                                        <asp:ListItem Value="0">--Select House Name--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;                   
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="Gender">
                                                    <label style="padding-top: 4px;">
                                                        Gender<span style="color: Red; font-weight: bold">*</span></label>
                                                    <div style="width: 171px; height: 20px; float: left;">
                                                        <asp:RadioButtonList runat="server" ID="rbtnlistgender" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                                                            <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                                                            <asp:ListItem Value="2">Female</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="Nationality">
                                                    <label style="padding-top: 4px;">
                                                        Nationality<span style="color: Red; font-weight: bold">*</span></label>
                                                    <div style="width: 171px; height: 20px; float: left;">
                                                        <asp:RadioButtonList runat="server" ID="rbtnlistnationality" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                                                            <asp:ListItem Value="1" Selected="True">Indian</asp:ListItem>
                                                            <asp:ListItem Value="2">Other</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" style="display: none" id="divforothercountry">
                                                    <label>
                                                        Country Name</label>
                                                    <asp:TextBox ID="txtcountryname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Country Name Please" Text="India"></asp:TextBox>&nbsp;                    
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="BirthPlace">
                                                    <label>
                                                        Birth Place</label>
                                                    <asp:TextBox ID="txtbirthplace" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Birth place"></asp:TextBox>&nbsp;                   
                                                </div>
                                                <div class="for_sigle_row_form" id="Religion">
                                                    <label>
                                                        Religion<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:TextBox ID="txtreligion" runat="server" onkeypress="return lettersOnly(event)" MaxLength="15" placeholder="Enter Religion Please"></asp:TextBox>&nbsp;                 
                                                </div>
                                                <div class="for_sigle_row_form" id="MotherTongue">
                                                    <label>
                                                        Mother Tongue</label>
                                                    <asp:TextBox ID="txtmothertongue" runat="server" onkeypress="return lettersOnly(event)" MaxLength="15" placeholder="Enter Mother Tongue"></asp:TextBox>&nbsp;                   
                                                </div>
                                                <div class="for_sigle_row_form" id="NoOfSiblings">
                                                    <label>
                                                        No Of Siblings</label>
                                                    <asp:TextBox ID="txtnoofsibbling" onkeypress="return isNumberKey(event)" MaxLength="2" runat="server" placeholder="Enter No Of Siblings"></asp:TextBox>&nbsp;                      
                                                </div>
                                                <div class="for_sigle_row_form" id="CastCategory">
                                                    <label style="padding-top: 4px;">
                                                        Cast/Category<span style="color: Red; font-weight: bold">*</span></label>
                                                    <div style="width: 350px; height: 20px; float: left;">
                                                        <asp:RadioButtonList runat="server" ID="rbtnlistcast" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                                                            <asp:ListItem Value="1" Selected="True">General </asp:ListItem>
                                                            <asp:ListItem Value="2">OBC</asp:ListItem>
                                                            <asp:ListItem Value="3">SC</asp:ListItem>
                                                            <asp:ListItem Value="4">ST</asp:ListItem>
                                                            <asp:ListItem Value="5">Minority</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Class For Admission<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                                                        <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label>
                                                        Section  For Admission</label>
                                                    <asp:DropDownList ID="ddlsection" runat="server">
                                                        <asp:ListItem Value="0">--Select  Section--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;
                                                </div>
                                                <div class="for_sigle_row_form" id="TransportationRequired">
                                                    <label style="padding-top: 4px;">
                                                        Transportation Required</label>
                                                    <div style="width: 171px; height: 20px; float: left;">
                                                        <asp:RadioButtonList runat="server" ID="rbtntransportationrequired" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                                                            <asp:ListItem Value="1">Yes </asp:ListItem>
                                                            <asp:ListItem Value="2" Selected="True">No</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="StudentPhotograph">
                                                    <label style="padding-top: 4px;">
                                                        Upload Student Photograph</label>
                                                    <asp:FileUpload ID="fileuploaderofstudentphotograph" runat="server" onchange="ShowpImagePreviewstudentphotograph(this)" />
                                                    <div class="user_phot_frame">
                                                        <div id="stuphotograph" style="display: none; position: absolute; margin-top: -62px">
                                                            <span style="color: black; font-weight: bold; padding-top: 20px;">
                                                                <center><u>Student Photograph</u></center>
                                                            </span>
                                                            <asp:Image ID="imguser" runat="server" ImageUrl="~/images/9update.png" Width="150px" Height="150px" />
                                                        </div>
                                                        <div id="stucertifiacte" style="display: none; position: absolute; margin-left: 175px; margin-top: -62px">
                                                            <span style="color: black; font-weight: bold; padding-top: 20px;">
                                                                <center><u>Student Certificate</u></center>
                                                            </span>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/9update.png" Width="150px" Height="150px" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="for_sigle_row_form" id="BirthCertificate">
                                                    <label style="padding-top: 4px;">
                                                        Upload Birth Certificate</label>
                                                    <asp:FileUpload ID="fileuploaderofbirthcertificate" onchange="ShowpImagePreviewshowbirthcertificate(this);" runat="server" />
                                                </div>
                                                <div class="for_sigle_row_form" id="DocumentSubmitted">
                                                    <label style="padding-top: 4px;">
                                                        Document Submitted</label>
                                                    <textarea id="txttotalsubmiteddocument" onkeypress="return lettersOnly(event)" runat="server" rows="3" cols="3" placeholder="Enter Document Submitted By Student"></textarea>
                                                </div>
                                                <div class="for_sigle_row_form" id="AdditionalInformation">
                                                    <label style="padding-top: 4px;">
                                                        Additional Information</label>
                                                    <textarea id="txtadditionalinformation" runat="server" rows="3" cols="3" placeholder="Enter Additional Information"></textarea>
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
                                                <div class="clear"></div>
                                                <div class="sub-heading">
                                                    Student Medical Details
                                                </div>
                                                <div class="for_sigle_row_form" id="BloodGroup">
                                                    <label>
                                                        Blood Group</label>
                                                    <asp:DropDownList ID="ddlbloodgroup" runat="server">
                                                        <asp:ListItem Value="0">--Select  Blood Group--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;                    
                                                </div>
                                                <div class="clear"></div>
                                                <div class="clear"></div>
                                                <div class="sub-heading">
                                                    Student Previous School Details
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="SchoolName">
                                                    <label>
                                                        School Name</label>
                                                    <asp:TextBox ID="txtschoolname" runat="server" onkeypress="return lettersOnly(event)" MaxLength="25" placeholder="Enter School Name Please"></asp:TextBox>&nbsp;                     
                                                </div>
                                                <div class="for_sigle_row_form" id="SchoolBoard">
                                                    <label>
                                                        Board</label>
                                                    <asp:TextBox ID="txtboard" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                                                </div>
                                                <div class="for_sigle_row_form" id="SchoolMedium">
                                                    <label>
                                                        Medium</label>
                                                    <asp:TextBox ID="txtmedium" runat="server" MaxLength="25" placeholder="Enter Medium Please"></asp:TextBox>&nbsp;                      
                                                </div>
                                                <div class="for_sigle_row_form" id="SchoolPreviousClassName">
                                                    <label>
                                                        Previous Class Name</label>
                                                    <asp:TextBox ID="txtclassname" runat="server" MaxLength="25" placeholder="Enter Previous Class Name"></asp:TextBox>&nbsp;                      
                                                </div>
                                                <div class="for_sigle_row_form" id="SchoolPercentageInPreviousClass">
                                                    <label>
                                                        Percentage In Previous Class</label>
                                                    <asp:TextBox ID="txtpreviusclsspercentage" runat="server" MaxLength="3" placeholder="Enter Percentage In Previous Class"></asp:TextBox>&nbsp;                       
                                                </div>
                                                <div class="for_sigle_row_form" id="SchoolAddress">
                                                    <label>
                                                        Address</label>
                                                    <textarea id="txtschooladdress" runat="server" placeholder="Enter Address Please" rows="3" cols="3"></textarea>&nbsp;                        
                                                </div>
                                                <div class="for_sigle_row_form" id="SchoolContactNo">
                                                    <label>
                                                        Contact No</label>
                                                    <asp:TextBox ID="txtcontactno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Contact No Please"></asp:TextBox>&nbsp;                       
                                                </div>
                                                <div class="for_sigle_row_form" id="SchoolAlternateContactNo">
                                                    <label>
                                                        Alternate Contact No</label>
                                                    <asp:TextBox ID="txtalternatecontactno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Alternate Contact No Please"></asp:TextBox>&nbsp;                      
                                                </div>
                                                <div class="for_sigle_row_form" id="SchoolWebsite">
                                                    <label>
                                                        School Website</label>
                                                    <asp:TextBox ID="txtwesite" runat="server" placeholder="Enter Website Please"></asp:TextBox>&nbsp;                       
                                                </div>
                                                <div class="clear"></div>
                                                <div class="sub-heading">
                                                    Primary Parent Details                   
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="PrimarySelectParentType">
                                                    <label>
                                                        Select Parent Type<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:DropDownList ID="ddlparenttype" runat="server">
                                                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;                    
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryParentFirstName">
                                                    <label>
                                                        Parent First Name<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:TextBox ID="txtparentfirstname" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="First Name Please"></asp:TextBox>&nbsp;                      
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryParentMiddleName">
                                                    <label>
                                                        Parent Middle Name</label>
                                                    <asp:TextBox ID="txtparentmiddlename" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Middle Name Please"></asp:TextBox>&nbsp;                     
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryParentLastName">
                                                    <label>
                                                        Parent Last Name</label>
                                                    <asp:TextBox ID="txtparentlastname" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Last Name Please"></asp:TextBox>&nbsp;                    
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryMobileNo">
                                                    <label>
                                                        Mobile No<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:TextBox ID="txtparentmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryParentDOB">
                                                    <label>
                                                        Parent D.O.B</label>
                                                    <asp:TextBox ID="txtparentdateofbirth" onkeypress="return false" runat="server" placeholder="Select D.O.B Please"></asp:TextBox>&nbsp;
                       
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryParentNationality">
                                                    <label>
                                                        Parent Nationality</label>
                                                    <asp:TextBox ID="txtparentnationality" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Enter Nationality Please"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryHighestQualification">
                                                    <label>
                                                        Highest Qualification</label>
                                                    <asp:DropDownList ID="ddlparentqualification" runat="server">
                                                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;
                       
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryParentOccupation">
                                                    <label>
                                                        Parent Occupation</label>
                                                    <asp:TextBox ID="txtparentoccupation" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Occupation Please"></asp:TextBox>&nbsp;
                       
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryDesignation">
                                                    <label>
                                                        Designation</label>
                                                    <asp:TextBox ID="txtparentdesignation" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Designation Please"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryNameOfOrganization">
                                                    <label>
                                                        Name Of Organization</label>
                                                    <asp:TextBox ID="txtparentorganization" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Name Of Organization"></asp:TextBox>&nbsp;
                       
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryAddressOfOfficeBusiness">
                                                    <label>
                                                        Address Of Office/Business</label>
                                                    <asp:TextBox ID="txtofficeaddress" runat="server" placeholder="Address Of Office/Business"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryParentAnnualIncome">
                                                    <label>
                                                        Parent Annual Income</label>
                                                    <asp:TextBox ID="txtannualincome" onkeypress="return isNumberKey(event)" MaxLength="12" runat="server" placeholder="Parent Annual Income"></asp:TextBox>&nbsp;
                       
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryAddress">
                                                    <label style="padding-top: 4px;">
                                                        Address</label>
                                                    <textarea id="txtparentaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>&nbsp;
                       
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryCity">
                                                    <label>
                                                        City</label>
                                                    <asp:TextBox ID="txtparentcity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter City Please"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryState">
                                                    <label>
                                                        State</label>
                                                    <asp:TextBox ID="txtparentstate" runat="server" MaxLength="25" placeholder="Enter State Please"></asp:TextBox>&nbsp;
                       
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryPinZipCode">
                                                    <label>
                                                        Pin/Zip Code</label>
                                                    <asp:TextBox ID="txtparentpincodeorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" placeholder="Enter Pin/Zip Code Please"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryCountry">
                                                    <label>
                                                        Country</label>
                                                    <asp:TextBox ID="txtparentcountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter Country Please"></asp:TextBox>&nbsp;
                       
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryPhoneNo">
                                                    <label>
                                                        Phone No</label>
                                                    <asp:TextBox ID="txtparentphoneno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryEmailId">
                                                    <label>
                                                        Email-Id</label>
                                                    <asp:TextBox ID="txtparentemailid" runat="server" MaxLength="35" placeholder="Enter Email-Id Please"></asp:TextBox>&nbsp;
                                         
                                                </div>
                                                <div class="for_sigle_row_form" id="PrimaryUploadParentPhotograph">
                                                    <label style="padding-top: 4px;">
                                                        Upload Parent Photograph</label>
                                                    <asp:FileUpload ID="fileuploaderofparentphotograph" onchange="ShowpImageParentphotograph(this);" runat="server" />&nbsp;
                     <div class="user_phot_frame">
                         <div id="parentfirstphoto" style="display: none; width: 150px; position: absolute; margin-top: -90px">
                             <span style="color: black; font-weight: bold; padding-top: 20px;">
                                 <center><u>Parent Photograph</u></center>
                             </span>
                             <asp:Image ID="Image2" runat="server" ImageUrl="~/images/9update.png" AlternateText="No Attachment" Height="150px" Width="150px" />
                         </div>
                     </div>
                                                </div>




                                                <div class="sub-heading">
                                                    Student Document Details                  
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form">
                                                    <label style="margin-top: -.8%;">Aadhar card</label>
                                                    <asp:CheckBox ID="chkAadharCard" runat="server" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label style="margin-top: -.8%;">Birth certificate</label>
                                                    <asp:CheckBox ID="ChkBirthCertificate" runat="server" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label style="margin-top: -.8%;">Migration certificate</label>
                                                    <asp:CheckBox ID="chkMigrationCertificate" runat="server" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label style="margin-top: -.8%;">Caste certificate</label>
                                                    <asp:CheckBox ID="chkCasteCertificate" runat="server" />
                                                </div>
                                                <div class="for_sigle_row_form">
                                                    <label style="margin-top: -.8%;">Last year marksheet</label>
                                                    <asp:CheckBox ID="chkLastYearMarksheet" runat="server" />
                                                </div>



                                                <div class="clear"></div>
                                                <div class="sub-heading">
                                                    Secondary Parent Details
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="SecondarySelectParentType">
                                                    <label>
                                                        Select Parent Type</label>
                                                    <asp:DropDownList ID="ddlsecondaryparenttype" runat="server">
                                                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryParentFirstName">
                                                    <label>
                                                        Parent First Name</label>
                                                    <asp:TextBox ID="txtsecondaryparentfirstname" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter First Name Please"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryParentMiddleName">
                                                    <label>
                                                        Parent Middle Name</label>
                                                    <asp:TextBox ID="txtsecondaryparentmiddlename" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Middle Name Please"></asp:TextBox>&nbsp;
                   
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryParentLastName">
                                                    <label>
                                                        Parent Last Name</label>
                                                    <asp:TextBox ID="txsecondaryparentlastname" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Last Name Please"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryParentDOB">
                                                    <label>
                                                        Parent D.O.B</label>
                                                    <asp:TextBox ID="txtsecondaryparentdateofbirth" onkeypress="return false" runat="server" Placeholder="Select D.O.B"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryParentNationality">
                                                    <label>
                                                        Parent Nationality</label>
                                                    <asp:TextBox ID="txtsecondaryparentnationality" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Nationality Please"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryHighestQualification">
                                                    <label>
                                                        Highest Qualification</label>
                                                    <asp:DropDownList ID="ddlsecondaryparenthighestqualification" runat="server">
                                                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryParentOccupation">
                                                    <label>
                                                        Parent Occupation</label>
                                                    <asp:TextBox ID="txtsecondaryparentoccupation" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Occupation Please"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryDesignation">
                                                    <label>
                                                        Designation</label>
                                                    <asp:TextBox ID="txtsecondaryparentdesignation" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Designation Please"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryNameOfOrganization">
                                                    <label>
                                                        Name Of Organization</label>
                                                    <asp:TextBox ID="txtnameoforganizationofsecondayparent" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Name Of Organization"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryAddressOfOfficeBusiness">
                                                    <label>
                                                        Address Of Office/Business</label>
                                                    <textarea id="txtbusinessorofficeaddressofsecondayparent" runat="server" rows="3" cols="3" placeholder="Address Of Office/Business"></textarea>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryParentAnnualIncome">
                                                    <label>
                                                        Parent Annual Income</label>
                                                    <asp:TextBox ID="txtsecondaryparentannualincome" onkeypress="return isNumberKey(event)" MaxLength="12" runat="server" Placeholder="Annual Income Please"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryAddress">
                                                    <label style="padding-top: 4px;">
                                                        Address</label>
                                                    <textarea id="txsecondayparentaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>
                                                    &nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryCity">
                                                    <label>
                                                        City</label>
                                                    <asp:TextBox ID="txtsecondaryparentcity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter City Please"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryState">
                                                    <label>
                                                        State</label>
                                                    <asp:TextBox ID="txtsecondaryparentstate" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter State Please"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryPinZipCode">
                                                    <label>
                                                        Pin/Zip Code</label>
                                                    <asp:TextBox ID="txtsecondayparentpinorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" Placeholder="Enter Pin/Zip Code"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryCountry">
                                                    <label>
                                                        Country</label>
                                                    <asp:TextBox ID="txsecondaryparentcountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Country Please"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryPhoneNo">
                                                    <label>
                                                        Phone No</label>
                                                    <asp:TextBox ID="txtsecondaryparentphoneno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryMobileNo">
                                                    <label>
                                                        Mobile No</label>
                                                    <asp:TextBox ID="txtsecondaryparentmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryEmailId">
                                                    <label>
                                                        Email-Id</label>
                                                    <asp:TextBox ID="txtsecondaryparentemailid" runat="server" MaxLength="35" Placeholder="Enter Email-Id Please"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="SecondaryUploadParentPhotograph">
                                                    <label style="padding-top: 4px;">
                                                        Upload Parent Photograph</label>
                                                    <asp:FileUpload ID="fileuploadforsecondaryparentphotograph" onchange="ShowpImageParentphotographsecond(this);" runat="server" />&nbsp;
                    <div class="user_phot_frame">
                        <div id="secondaryparentphoto" style="display: none; width: 150px; position: absolute; margin-top: -90px">
                            <span style="color: black; font-weight: bold; padding-top: 20px;">
                                <center><u>Parent Photograph</u></center>
                            </span>
                            <asp:Image ID="Image3" runat="server" ImageUrl="~/images/9update.png" AlternateText="No Attachment" Height="150px" Width="150px" />
                        </div>
                    </div>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="sub-heading">
                                                    Emergency Contact Person (OTHER THAN PARENTS)
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form" id="EmergencyName">
                                                    <label style="padding-top: 4px;">
                                                        Name</label>
                                                    <asp:TextBox ID="txtnameofcontactpersonincaseofemergency" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Name Please"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="EmergencyMobileNo">
                                                    <label style="padding-top: 4px;">
                                                        Mobile No</label>
                                                    <asp:TextBox ID="txtemergencymobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="EmergencyAlternateMobileNo">
                                                    <label style="padding-top: 4px;">
                                                        Alternate Mobile No</label>
                                                    <asp:TextBox ID="txtemergencyalternatemobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Alternate Mobile No Please"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="EmergencyPhoneNo">
                                                    <label style="padding-top: 4px;">
                                                        Phone No</label>
                                                    <asp:TextBox ID="txtemegencycontactpersonphoneno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="EmergencyAddress">
                                                    <label style="padding-top: 4px;">
                                                        Address</label>
                                                    <textarea id="txtemergencycontactpersonaddress" runat="server" rows="3" cols="3" placeholder="Enter Address"></textarea>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="EmergencyCity">
                                                    <label>
                                                        City</label>
                                                    <asp:TextBox ID="txtemergencycontactpersoncity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter City"></asp:TextBox>&nbsp;
                      
                                                </div>
                                                <div class="for_sigle_row_form" id="EmergencyState">
                                                    <label>
                                                        State</label>
                                                    <asp:TextBox ID="txtemergencycontactpersonstate" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter State"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="EmergencyPinZipCode">
                                                    <label>
                                                        Pin/Zip Code</label>
                                                    <asp:TextBox ID="txtemergencycontactpersonpinorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" Placeholder="Enter Pin/Zip Code"></asp:TextBox>&nbsp;
                    
                                                </div>
                                                <div class="for_sigle_row_form" id="EmergencyCountry">
                                                    <label>
                                                        Country</label>
                                                    <asp:TextBox ID="txtemergencycontactpersoncountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Country"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="clear"></div>
                                                <div class="sub-heading">
                                                    For Office Use Only
                                                </div>
                                                <div class="for_sigle_row_form" id="RegistrationDate">
                                                    <label>
                                                        Admission Date<span style="color: Red; font-weight: bold">*</span></label>
                                                    <asp:TextBox ID="txtregistrationdate" onkeypress="return false" runat="server" Placeholder="Select Admission Date"></asp:TextBox>&nbsp;
                     
                                                </div>
                                                <div class="for_sigle_row_form" id="Comment">
                                                    <label style="padding-top: 4px;">
                                                        Comment</label>
                                                    <textarea id="txtcomment" runat="server" rows="3" cols="3" placeholder="Your Comment Please"></textarea>&nbsp;                   
                                                </div>
                                                <div class="clear"></div>
                                                <div class="for_sigle_row_form">
                                                    <label style="padding-top: 4px;">
                                                        Save/Update</label>
                                                    <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" OnClick="btnforupdateorsave_Click1" CssClass="button_save" />
                                                    <asp:Button ID="btnforcancel" runat="server" Text="Cancel" OnClick="btnforcancel_Click" CssClass="button_cancel" />
                                                </div>
                                                <br />
                                                <br />
                                            </div>
                                            <asp:Label ID="lblStudentPhotograph" Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                                            <asp:Label ID="lblStudentcertificate" Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                                            <asp:Label ID="lblparentfirstphoto" Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                                            <asp:Label ID="lblparentsecondphoto" Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </section>
                        <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen, open" data-target="#nav,html"></a>
                    </section>
                    <aside class="bg-light lter b-l aside-md hide" id="notes">
                        <div class="wrapper">Notification</div>
                    </aside>
                </section>
            </section>
        </section>
    </form>
    <script type="text/javascript" src="../js/app.v1.js"></script>
    <script type="text/javascript">
        var year = 2020;
        $(document).ready(function () {
            getClassList();
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
            $("#txtstudentdob,#txtparentdateofbirth,#txtsecondaryparentdateofbirth,#txtregistrationdate,#txtchkddneftrefdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:2020',
                dateFormat: 'dd MM yy'
            });

            $('#<%=fileuploaderofstudentphotograph.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#stuphotograph').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test();
                    $('#stuphotograph').hide();
                }
            });
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
            });

            $('#rbtnlistnationality input').change(function () {
                if ($(this).val() == '1') {
                    $('#divforothercountry').css('display', 'none');
                    $('#txtcountryname').val('India');
                }
                else {
                    $('#divforothercountry').css('display', 'block');
                    $('#txtcountryname').val('');
                }
            });
            $('#btnforupdateorsave').click(function () {
                if ($('#ddlregistrationsession').val() == '0') {
                    alertify.error('Select admission  session please.');
                    $('#ddlregistrationsession').focus();
                    return false;
                }
                if ($('#ddlsection').val() == '0') {
                    alertify.error('Select Section please.');
                    $('#ddlsection').focus();
                    return false;
                }
                else if ($('#txtstudentfirstname').val() == '') {
                    alertify.error('Enter student first name please.');
                    $('#txtstudentfirstname').focus();
                    return false;
                }
                //else if ($('#txtstudentlastname').val() == '') {
                //    alertify.error('Enter student middle name please');
                //    $('#txtstudentlastname').focus();
                //    return false;
                //}
                else if ($('#txtstudentdob').val() == '') {
                    alertify.error('Select Date of birth please,');
                    $('#txtstudentdob').focus();
                    return false;
                }
                //else if ($('#txtstudentUid').val() == '') {
                //    alertify.error('Enter Student Aadhaar Car No.');
                //    $('#txtstudentUid').focus();
                //    return false;
                //}
                else if ($('#txtparentmobileno').val() == '') {
                    alertify.error('Enter Parent Mobile No.');
                    $('#txtparentmobileno').focus();
                    return false;
                }
                else if ($('#txtstudentUid').val() != '') {
                    if ($('#txtstudentUid').val().length != 12) {
                        alertify.error('Student Aadhaar Card No. only 12 Digits');
                        $('#txtstudentUid').focus();
                        return false;
                    }
                }
                else if ($('#txtreligion').val() == '') {
                    alertify.error('Enter religion please.');
                    $('#txtreligion').focus();
                    return false;
                }
                else if ($('#ddlapplyingforclass').val() == '0') {
                    alertify.error('Select class please.');
                    $('#ddlapplyingforclass').focus();
                    return false;
                }
                else if ($('#txtaddress').val() == '') {
                    alertify.error('Enter address please.');
                    $('#txtaddress').focus();
                    return false;
                }
                else if ($('#txtaddress').val().indexOf(',') !== -1) {
                    alertify.error('Comma is not allows in address .');
                    $('#txtaddress').focus();
                    return false;
                }
                else if ($('#txtcity').val() == '') {
                    alertify.error('Enter city please.');
                    $('#txtcity').focus();
                    return false;
                }
                else if ($('#txtstate').val() == '') {
                    alertify.error('Enter state please.');
                    $('#txtstate').focus();
                    return false;
                }
                else if ($('#txtpiorzipcode').val() == '') {
                    alertify.error('Enter pincode/zipcode please.');
                    $('#txtpiorzipcode').focus();
                    return false;
                }
                else if ($('#txtcountry').val() == '') {
                    alertify.error('Enter country please.');
                    $('#txtcountry').focus();
                    return false;
                }
                else if ($('#ddlparenttype').val() == '0') {
                    alertify.error('Select primary parent type please.');
                    $('#ddlparenttype').focus();
                    return false;
                }
                else if ($('#txtparentfirstname').val() == '') {
                    alertify.error('Enter primary parent first name please.');
                    $('#txtparentfirstname').focus();
                    return false;
                }
                //else if ($('#txtparentlastname').val() == '') {
                //    alertify.error('Enter primary parent last name please.');
                //    $('#txtparentlastname').focus();
                //    return false;
                //}               
                else if ($('#txtregistrationdate').val() == '') {
                    alertify.error('Select admission date please.');
                    $('#txtregistrationdate').focus();
                    return false;
                }
            });
            $('#ddlpaymentmode').change(function () {
                if (parseInt($(this).val()) > 1)
                    $('#divbankname,#divbranchname,#divrefnumber,#divrefdate').css('display', 'block');
                else
                    $('#divbankname,#divbranchname,#divrefnumber,#divrefdate').css('display', 'none');
            });
            $("#txtparentemailid,#txtsecondaryparentemailid").blur(function () {
                var emailid = $(this).val();
                if (emailid != '') {
                    var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
                    if (!reg.test(emailid)) {
                        alertify.error('Please Enter Valid Email-Id ( ie: abcd@gmail.com).');
                        document.getElementById('<%=txtparentemailid.ClientID%>').value = '';
                        return false;
                    }
                }
            });
            $('#ddlregistrationsession').change(function () {
                $('#ddlapplyingforclass').html('');
                getClassList();
            });

             $('#ddlBranchID').change(function () {
                $('#ddlapplyingforclass').html('');
                getClassList();
            });


            $('#ddlapplyingforclass').change(function () {
                $('#ddlsection').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "AdmissionHome.aspx/BindSectionDDL",
                    data: "{'Classid':'" + $(this).val() + "', 'Brid':'" + $('#ddlBranchID').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ddlsection').html('<option value="0">--Select Section--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ddlsection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
                            }
                        }
                    }
                });
            });
            $('#txtregistrationdate').change(function () {
                $.ajax({
                    type: "POST",
                    url: "BranchPanel/Admission/new-admission.aspx/IsReadyForAction",
                    data: "{'Date':'" + $(this).val() + "','Fyid':'" + $('#ddlregistrationsession').val() + "','Registration_No':'" + $('#txtregistrationno').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != '1') {
                            if (data.d == '0') {
                                $('#txtregistrationdate').val('');
                                alert('Admission Process Is Off For The Selected Session And Admission Date.\nPlease Select Valid Session And Admission Date.\nOR Contact To Admin.');
                            }
                            else if (data.d == '2') {
                                $('#txtregistrationdate').val('');
                                alert('Only Shortlisted Candidate Can Take The Admission.\nOR Contact To Admin.');
                            }
                            else if (data.d == '3') {
                                $('#txtregistrationdate').val('');
                                alert('Admission Can Be Done If Student Is Registered.\nSo Please Enter The Registration No.\nOR Contact To Admin.');
                            }
                            else if (data.d == '4') {
                                $('#txtregistrationdate').val('');
                                alert('Registered Student Can Not Take The Admission.\nContact To Admin.');
                            }
                            else if (data.d == '5') {
                                $('#txtregistrationdate').val('');
                                alert('Admission Can Be Done If Student Is Registered.\nSo Please Enter The Registration No.\nOR Contact To Admin.');
                            }
                        }
                    },
                });
            });

            $('input[type="radio"][name="ctl00$ContentPlaceHolder1$rbtntransportationrequired"]').change(function () {
                if ($(this).val() == '1') {
                    alert('You Can Decide The Route Or Stopage For Transportaion Facility From.\nStudent Management Module.');
                }
            });

        });

        function getClassList() {
             $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "AdmissionHome.aspx/BindClassDDL",
                    data: "{'Fyid':'" + $('#ddlregistrationsession').val() + "', 'Brid':'" + $('#ddlBranchID').val() + "'}",
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
        }

        function test() {

            var uploadControl = document.getElementById('<%=fileuploaderofstudentphotograph.ClientID%>');
            uploadControl.value = "";
        }
        function test2() {

            var uploadControl = document.getElementById('<%=fileuploaderofbirthcertificate.ClientID%>');
            uploadControl.value = "";
        }
        function test3() {

            var uploadControl = document.getElementById('<%=fileuploaderofparentphotograph.ClientID%>');
            uploadControl.value = "";
        }
        function test4() {

            var uploadControl = document.getElementById('<%=fileuploadforsecondaryparentphotograph.ClientID%>');
            uploadControl.value = "";
        }
        function ShowpImagePreviewstudentphotograph(input) {

            $('#stuphotograph').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imguser').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImagePreviewshowbirthcertificate(input) {
            $('#stucertifiacte').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#Image1').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImageParentphotograph(input) {
            $('#parentfirstphoto').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#Image2').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImageParentphotographsecond(input) {
            $('#secondaryparentphoto').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#Image3').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function BindFieldOnTheBehalfOfCheckUnCheck() {
            $.ajax({
                type: "POST",
                url: "BranchPanel/Admission/new-admission.aspx/CheckCheckboxOnTheBehalfOfPermission",
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
            $('#AdmissionNo,#StudentMiddleName,#BirthPlace,#MotherTongue,#NoOfSiblings,#DocumentSubmitted,#AdditionalInformation,#BirthCertificate,#BloodGroup' +
                ',#SchoolName,#SchoolBoard,#SchoolMedium,#SchoolPreviousClassName,#SchoolPercentageInPreviousClass,#SchoolAddress,#SchoolContactNo,#SchoolAlternateContactNo,#SchoolWebsite' +
                ',PrimaryParentDOB,#PrimaryParentNationality,#PrimaryHighestQualification,#PrimaryParentOccupation,#PrimaryDesignation,#PrimaryNameOfOrganization,#PrimaryAddressOfOfficeBusiness,#PrimaryParentAnnualIncome,#PrimaryAddress,#PrimaryCity,#PrimaryState,#PrimaryPinZipCode,#PrimaryCountry,#PrimaryPhoneNo,#PrimaryEmailId,#PrimaryParentDOB,#PrimaryUploadParentPhotograph' +
                ',#SecondarySelectParentType,#SecondaryParentFirstName,#SecondaryParentMiddleName,#SecondaryParentLastName,#SecondaryParentDOB,#SecondaryParentNationality,#SecondaryHighestQualification,#SecondaryParentOccupation,#SecondaryDesignation,#SecondaryNameOfOrganization,SecondaryAddressOfOfficeBusiness,SecondaryParentAnnualIncome,#SecondaryAddress,#SecondaryCity,#SecondaryState,#SecondaryPinZipCode,#SecondaryCountry,#SecondaryPhoneNo,#SecondaryMobileNo,#SecondaryEmailId,#SecondaryUploadParentPhotograph,#SecondaryAddressOfOfficeBusiness,#SecondaryParentAnnualIncome' +
                ',#EmergencyName,#EmergencyMobileNo,#EmergencyAlternateMobileNo,#EmergencyPhoneNo,#EmergencyAddress,#EmergencyCity, EmergencyState,#EmergencyPinZipCode,#EmergencyCountry,#EmergencyState' +
                ',#Comment').css("display", "none");
        }
        function Expende() {
            $('#AdmissionNo,#StudentMiddleName,#BirthPlace,#MotherTongue,#NoOfSiblings,#DocumentSubmitted,#AdditionalInformation,#BirthCertificate,#BloodGroup' +
                ',#SchoolName,#SchoolBoard,#SchoolMedium,#SchoolPreviousClassName,#SchoolPercentageInPreviousClass,#SchoolAddress,#SchoolContactNo,#SchoolAlternateContactNo,#SchoolWebsite' +
                ',PrimaryParentDOB,#PrimaryParentNationality,#PrimaryHighestQualification,#PrimaryParentOccupation,#PrimaryDesignation,#PrimaryNameOfOrganization,#PrimaryAddressOfOfficeBusiness,#PrimaryParentAnnualIncome,#PrimaryAddress,#PrimaryCity,#PrimaryState,#PrimaryPinZipCode,#PrimaryCountry,#PrimaryPhoneNo,#PrimaryEmailId,#PrimaryParentDOB,#PrimaryUploadParentPhotograph' +
                ',#SecondarySelectParentType,#SecondaryParentFirstName,#SecondaryParentMiddleName,#SecondaryParentLastName,#SecondaryParentDOB,#SecondaryParentNationality,#SecondaryHighestQualification,#SecondaryParentOccupation,#SecondaryDesignation,#SecondaryNameOfOrganization,SecondaryAddressOfOfficeBusiness,SecondaryParentAnnualIncome,#SecondaryAddress,#SecondaryCity,#SecondaryState,#SecondaryPinZipCode,#SecondaryCountry,#SecondaryPhoneNo,#SecondaryMobileNo,#SecondaryEmailId,#SecondaryUploadParentPhotograph,#SecondaryAddressOfOfficeBusiness,#SecondaryParentAnnualIncome' +
                ',#EmergencyName,#EmergencyMobileNo,#EmergencyAlternateMobileNo,#EmergencyPhoneNo,#EmergencyAddress,#EmergencyCity, EmergencyState,#EmergencyPinZipCode,#EmergencyCountry,#EmergencyState' +
                ',#Comment').css("display", "block");
        }
        function CalculateAge() {
            var chunks = $('#txtstudentdob').val().split(' ');
            var CalculateDate = chunks[2] + '-' + chunks[1] + '-' + chunks[0];
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "BranchPanel/Student-Registration/student-registration.aspx/GetYearMonthDate",
                data: "{'Date':'" + CalculateDate + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == '0') {
                        alertify.error('Enter Valid Date Please.')
                        $('#txtstudentdob').val('');
                        $('#txtstudentdob').focus();
                        return false;
                    }
                    $('#lblAge').html(data.d);
                    $('#lblAge').css("", "");
                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
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
                    $(this).css("background-color", "#65BD77");
                    $(this).css("color", "#FFFFFF");
                    $(this).parent('li').parent('ul').parent('li').addClass('active');
                }
            });
        }
    </script>
</body>
</html>
