<%@ Page Title="" Language="C#" MasterPageFile="~/ParentPanel/MasterPage.master" AutoEventWireup="true" CodeFile="studentviewinfo.aspx.cs" Inherits="ParentPanel_studentviewinfo" %>

<%@ Register Src="~/ParentPanel/parentuser.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .active0 {
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

    <div class="for_sigle_row_form" id="dvregno" runat="server" visible="false">
        <label>
            Registration No.(for reference)</label>
        <asp:TextBox ID="txtRegNo" runat="server" Enabled="true"></asp:TextBox>
    </div>

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
            <div class="col-xs-12 widget-box widget-body" style="border-top: 2px solid #2bbce0; border-radius: 3px;">

                <div id="divstudent" runat="server">

                    <h3><i class="fa fa-align-justify"></i>Personal Detail </h3>
                    <table class="table">
                        <tr>
                            <td colspan="2">
                                <label>
                                    Name of Applicant</label></td>

                            <td style="border-right: 1px solid #ddd;">
                                <asp:Label ID="txtName" runat="server"></asp:Label>&nbsp;
             <asp:Label ID="txtmidname" runat="server"></asp:Label>&nbsp
              <asp:Label ID="txtLName" runat="server"></asp:Label>&nbsp </td>

                            <td rowspan="7" style="text-align: center; padding-top: 21px;">
                                <div>
                                    <span class="profile-picture">
                                        <img id="avatar" class="editable img-responsive editable-click editable-empty" alt="Alex's Avatar" src="../images/profile-pic.jpg"></img>
                                    </span>

                                    <div class="space-4"></div>
                                </div>

                                <div class="space-6"></div>
                            </td>
                        </tr>

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <tr>
                                    <td colspan="3">
                                        <label>
                                            Date of Birth<span style="color: Red">*</span></label>
                                    </td>
                                    <td style="border-right: 1px solid #ddd;">
                                        <asp:Label ID="txdate" runat="server">
                                        </asp:Label>
                                    </td>
                                </tr>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <tr>
                            <td colspan="2">
                                <label>
                                    Gender</label>
                            </td>
                            <td style="border-right: 1px solid #ddd;">
                                <asp:Label runat="server" ID="lblgenders" ForeColor="Black" Font-Size="12px" Text=""></asp:Label>
                            </td>
                        </tr>

                        <asp:UpdatePanel runat="server" ID="up12">
                            <ContentTemplate>

                                <tr>
                                    <td colspan="3">
                                        <label>
                                            Applying for Class</label></td>
                                    <td style="border-right: 1px solid #ddd;">
                                        <asp:Label ID="ddlClass" runat="server">
                                        </asp:Label></td>
                                </tr>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <tr>
                            <td colspan="2">
                                <label>
                                    Transportation</label></td>
                            <td style="border-right: 1px solid #ddd;">
                                <asp:Label ID="lbtrans" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label>
                                    Address Line</label></td>
                            <td style="border-right: 1px solid #ddd;">
                                <asp:Label ID="txtPAddress" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    PIN/ZIP code</label></td>
                            <td colspan="2" style="border-right: 1px solid #ddd;">
                                <asp:Label ID="txtPZIP" runat="server" MaxLength="8"></asp:Label>&nbsp; </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label>
                                    Mobile No.</label></td>
                            <td colspan="2">
                                <asp:Label ID="txtmob" runat="server" MaxLength="15"></asp:Label>&nbsp; </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label>
                                    Admission No.</label></td>
                            <td colspan="2">
                                <asp:Label ID="txtadmNo" runat="server" Enabled="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label>
                                    Father's Name</label></td>
                            <td colspan="2">
                                <asp:Label runat="server" ID="txtFname"></asp:Label>&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label>
                                    Mother's Name</label>
                            </td>
                            <td colspan="2">
                                <asp:Label runat="server" ID="txtmother"></asp:Label>&nbsp;</td>
                        </tr>
                        <%--   <tr>
                               <td colspan="3">
                                    <label>
                                        Email ID:</label>
                                </td>
                                <td colspan="6">
                                    <asp:Label ID="lblemailid" runat="server"></asp:Label>
                                </td>
                            </tr>--%>
                    </table>
                </div>
            </div>

            <div class="col-sm-5" style="width: 20.666%; margin-left: 10%;">

                <div class="hr hr12 dotted"></div>
            </div>
        </div>
    </div>
</asp:Content>