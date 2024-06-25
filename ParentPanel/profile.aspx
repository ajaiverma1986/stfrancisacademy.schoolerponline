<%@ Page Title="" Language="C#" MasterPageFile="~/ParentPanel/MasterPage.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="ParentPanel_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .drop-shadow {
            text-align: center;
            position: relative;
            float: left;
            width: 40%;
            padding: 5px;
            margin: 2em 10px 1em;
            background: #F7F7F7;
            -webkit-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
            -moz-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
        }

            .drop-shadow:before,
            .drop-shadow:after {
                content: "";
                position: absolute;
                z-index: -2;
            }

            .drop-shadow p {
                font-size: 16px;
                font-weight: bold;
            }

        .curved:before {
            top: 10px;
            bottom: 10px;
            left: 0;
            right: 50%;
            -webkit-box-shadow: 0 0 15px rgba(0,0,0,0.6);
            -moz-box-shadow: 0 0 15px rgba(0,0,0,0.6);
            box-shadow: 0 0 15px rgba(0,0,0,0.6);
            -moz-border-radius: 10px / 100px;
            border-radius: 10px / 100px;
        }

        .curved-vt-2:before {
            right: 0;
        }

        .auto-style1 {
            width: 26% !important;
            padding: 3px;
            text-align: right;
            border-top-style: none;
            border-top-color: inherit;
            border-top-width: 0px;
        }
    </style>

    <div class="page-content">
        <div class="page-header">
            <h1><a href="studentviewinfo.aspx">Home</a>
                <small>
                    <i class="ace-icon fa fa-angle-double-right"></i>
                    Profile
                </small>
            </h1>
        </div>
        <div class="row">
            <div class="drop-shadow curved curved-vt-2" style="width: 50%; height: auto; float: left">
                <div style="width: 30%; float: right; border: 1px dotted #dddddd; height: 160px">
                    <img id="avatar" style="width: 100%; height: 100%" src="../images/profile-pic.jpg" alt="Alex's Avatar" />
                </div>
                <div class="drop-shadow curved curved-vt-2" style="float: left; margin-top: 0px !important; width: 66%; background: #EFBB05!important">
                    <span style="padding: 5px; color: #fff; font-size: 16px; font-weight: bold; text-shadow: 1px 1px #dddddd;">Basic Details</span>
                </div>

                <div style="float: left; width: 69%">
                    <table class="table" style="border: 1px Solid #dddddd; width: 96%; margin-left: 3%;">
                        <tr style="width: 100%">
                            <td style="border-top: 0px; padding: 3px; width: 50%; text-align: right">
                                <label>Class:</label>
                            </td>
                            <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                                <span>
                                    <asp:Label runat="server" ID="lblclass"></asp:Label></span></td>
                        </tr>
                        <tr style="width: 100%">
                            <td style="border-top: 0px; padding: 3px; width: 50%; text-align: right">
                                <label>Name:</label>
                            </td>
                            <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                                <span>
                                    <asp:Label runat="server" ID="lblname"></asp:Label></span></td>
                        </tr>
                        <tr style="width: 100%">
                            <td style="border-top: 0px; padding: 3px; width: 50%; text-align: right">
                                <label>Sec:</label>
                            </td>
                            <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                                <span>
                                    <asp:Label runat="server" ID="lblsec"></asp:Label></span></td>
                        </tr>
                        <tr style="width: 100%">
                            <td style="border-top: 0px; padding: 3px; width: 50%; text-align: right">
                                <label>House:</label>
                            </td>
                            <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                                <span>N/A</span></td>
                        </tr>
                    </table>
                </div>

                <table class="table" style="border: 1px Solid #dddddd; width: 96%; margin-left: 2%;">
                    <tr>
                        <td class="auto-style1">
                            <label>Gender:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblgender"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Blood Group:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblBloodGroup"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Nationality:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblNationality"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Country:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblcountry"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>State:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblstate"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>City:</label></td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblcity"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Address:</label></td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lbladdress"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Email:</label></td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblemail"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Phone:</label></td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">N/A</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Mobile:</label></td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblmobile"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Transport:</label></td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lbltransport"></asp:Label></span></td>
                    </tr>
                </table>
            </div>
            <div class="drop-shadow curved curved-vt-2" style="width: 46%; height: auto; float: right">
                <div class="drop-shadow curved curved-vt-2" style="float: left; margin-top: 0px !important; width: 96%; background: #EFBB05!important">
                    <span style="padding: 5px; color: #fff; font-size: 16px; font-weight: bold; text-shadow: 1px 1px #dddddd;">Guardian Details</span>
                </div>
                <span style="text-align: left!important; background: #B4DD43; padding: 5px; width: 100%; margin-right: 275px;">Vishnu Prakash Nigam (Father)</span>

                <table class="table" style="border: 1px Solid #dddddd; width: 96%; margin-top: 5px; margin-left: 2%;">
                    <tr>
                        <td class="auto-style1">
                            <label>Profession:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblprofession"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Designation:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lbldesignation"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Nationality:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblfnatinality"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Mobile:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblfmobile"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Mail:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblfemail"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Qualification:</label></td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblfqualification"></asp:Label></span></td>
                    </tr>
                </table>
                <br />
                <span style="text-align: left!important; background: #B4DD43; padding: 5px; width: 100%; margin-right: 326px;">Madhu Nigam (Mother)</span>
                <table class="table" style="border: 1px Solid #dddddd; width: 96%; margin-top: 5px; margin-left: 2%;">
                    <tr>
                        <td class="auto-style1">
                            <label>Profession:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblmprofession"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Designation:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblmdesignation"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Nationality:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblmnationality"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Mobile:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblmmobile"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Mail:</label>
                        </td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblmemail"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <label>Qualification:</label></td>
                        <td style="border-left: 1px solid #dddddd; text-align: left; padding: 3px; width: 50%">
                            <span>
                                <asp:Label runat="server" ID="lblmqualification"></asp:Label></span></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>