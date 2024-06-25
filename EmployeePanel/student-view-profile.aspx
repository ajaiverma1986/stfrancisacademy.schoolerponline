<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="student-view-profile.aspx.cs" Inherits="EmployeePanel_employee_view_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../js/jquery-1.11.1.min.js"></script>
    <style>
        .profileactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
            font-size: 11px!important;
            font-weight: normal!important;
        }

        .trqualification {
            margin-top: 0px;
            height: 30px;
            border: 1px solid #CCCCCC!important;
            text-align: center;
            padding-left: 5px;
        }

        .tdfortrqualification {
            width: 20%;
            border: 0.50px solid #CCCCCC!important;
        }

        .eductabletxt {
            width: 100%;
            border: none;
            margin-left: 0px;
            text-transform: none!important;
        }

        .content-wrapper .main-content {
            height: 760px !important;
        }
    </style>
	
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <asp:Label ID="lbluser" runat="server"></asp:Label>
                        <a id="lbLogOut" href="../emp-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Profile
                    </h1>
                </div>

                <div class="main-content">
                    <div class="row">
                        <%--===============Thid div is for Student details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <asp:Image ID="img1" runat="server" Width="100px" Height="100px" />
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Student Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tr  style="display:none">
                                                    <td class="t1"><span>Roll No:</span></td>
                                                    <td class="t2">
                                                        <label id="lblRollno" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Name:</span></td>
                                                    <td class="t2">
                                                        <label id="lblname" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Gender:</span></td>
                                                    <td class="t2">
                                                        <label id="lblGender" runat="server"></label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Date of Birth:</span></td>
                                                    <td class="t2">
                                                        <label id="lblDOB" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Student Address:</span></td>
                                                    <td class="t2">
                                                        <label id="lblAddress" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Board:</span></td>
                                                    <td class="t2">
                                                        <label id="lblBoard" runat="server">--</label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Medium:</span></td>
                                                    <td class="t2">
                                                        <label id="lblMedium" runat="server">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Student Mobile no for SMS:</span></td>
                                                    <td class="t2">
                                                        <label id="lblMobileno" runat="server">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Landline No:</span></td>
                                                    <td class="t2">
                                                        <label id="lblLandlineno" runat="server">--</label>
                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td class="t1"><span>School:</span></td>
                                                    <td class="t2">
                                                        <label id="lblschool" runat="server">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Student Email-Id:</span></td>
                                                    <td class="t2">
                                                        <label id="lblemailid" runat="server">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Source of Student:</span></td>
                                                    <td class="t2">
                                                        <label id="lblstudentsource" runat="server">--</label>
                                                    </td>
                                                </tr>
                                               <!-- <tr>
                                                        <asp:HiddenField runat="server" ID="hdnResult" />
                                                        <td class="t2" colspan="2">
                                                            <asp:LinkButton Font-Size="Large" runat="server" ID="downloadResult" OnClick="downloadResult_Click"> Download Result</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                <tr>
                                                        <asp:HiddenField runat="server" ID="hdnAdmit" />
                                                        <td class="t2" colspan="2">
                                                            <asp:LinkButton Font-Size="Large" runat="server" ID="downloadAdmit" OnClick="downloadAdmit_Click"> Download Admit Card</asp:LinkButton>
                                                        </td>
                                                    </tr>--!>
												<tr>
													
													<td><a href="https://stfrancisacademy.schoolerponline.in/EmployeePanel/download.aspx" target="_blank">Download Result</a>
													</td>
													</tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>
                        <%--===============Thid div is for Guardian details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <asp:Image ID="Img2" runat="server" Width="100px" Height="100px" />
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-group"></i>
                                            Guardian Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>Guardian Name:</span></td>
                                                        <td class="t2">
                                                            <label id="lblGName" runat="server">--</label>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1">
                                                            <span>Relation: </span>
                                                        </td>
                                                        <td class="t2">
                                                            <label id="lblRelation" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Guardian Mobile No. for SMS.:</span></td>
                                                        <td class="t2">
                                                            <label id="lblGMobileno" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Guardian Email-Id:</span></td>
                                                        <td class="t2">
                                                            <label id="lblGemailid" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Guardian Address:</span></td>
                                                        <td class="t2">
                                                            <label id="lblGAddress" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for student login details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Login Detail
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>User Name:</span></td>
                                                        <td class="t2">
                                                            <label id="lblUserName" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Password:</span></td>
                                                        <td class="t2">
                                                            <asp:Label ID="lblpassword" runat="server" Style="cursor: pointer">*****</asp:Label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>