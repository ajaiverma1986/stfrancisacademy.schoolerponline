<%@ Page Title="Add Vechicle" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="AddVehicle.aspx.cs" Inherits="Transport_AddVehicle" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%--<%@ Register Src="~/BranchPanel/transport.ascx" TagName="stu" TagPrefix="My" %>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
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
    <style type="text/css">
        .active1 {
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

    <script type="text/javascript">

        function check() {

            $('input[type="text"]').keyup(function (evt) {
                var txt = $(this).val();

                $(this).val(txt.replace(/^(.)|\s(.)/g, function ($1) { return $1.toUpperCase(); }));
            });
            return false;
        }
    </script>

    <script type="text/javascript">

        Sys.Application.add_load(check);
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Master Settings</a></li>
            <li><a>Transport Settings</a></li>
            <li style="background: none;"><a class="active">
                <asp:Label ID="lbladdvehicle" runat="server"></asp:Label>
            </a></li>
        </ul>

        <div class="arrowt">
            <a href="VehicleReport.aspx">
                <img src="../images/back-button.png"></a>
        </div>
    </div>

    <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">
        <%-- <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px; padding-top: 3px;"
            class="containerHeadline stripheading">
            <asp:Label ID="lbl1" runat="server"></asp:Label>
        </div>
        <div class="content_pane_cont" id="contentPane">
            <asp:UpdatePanel runat="server" ID="upd1">
                <ContentTemplate>
                    <table style="width: 100%">
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Vehicle Registration No.<span style="color: Red;">*</span></label>

                                    <asp:TextBox ID="txtRegNo" runat="server" AutoPostBack="true"
                                        OnTextChanged="txtRegNo_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Registration No."
                                        ControlToValidate="txtRegNo" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <label>Number of Seats<span style="color: Red;">* </span></label>
                                    <asp:TextBox ID="txtNumOfSeat" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rqnumberseat" runat="server" ErrorMessage="Please Enter Number of seats"
                                        ControlToValidate="txtNumOfSeat" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <label>Chassis No.<span style="color: Red;">* </span></label>
                                    <asp:TextBox ID="txtChassisNo" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rqchesisno" runat="server" ErrorMessage="Please Enter Chasis No."
                                        ControlToValidate="txtChassisNo" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <label>Model<span style="color: Red;">* </span></label>
                                    <asp:TextBox ID="txtModel" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rqmodel" runat="server" ErrorMessage="Please Enter Model"
                                        ControlToValidate="txtModel" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <label>Make<span style="color: Red;">* </span></label>
                                    <asp:TextBox ID="txtmake" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rqmake" runat="server" ErrorMessage="Please Enter Make"
                                        ControlToValidate="txtmake" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>

                                <div class="for_sigle_row_form">
                                    <label>
                                        Next FC Date<span style="color: Red">*</span></label>
                                    <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <label>
                                        Next Tax Date<span style="color: Red">*</span></label>
                                    <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="margin-left: 20px; font-size: 15px; background: url(../images/active.png) no-repeat; height: 32px; color: #fff; padding-left: 46px;">
                                <label><b>&nbsp;&nbsp; Insurance Co. Details</b></label>
                            </td>
                        </tr>

                        <caption>
                            <br />
                            <tr>
                                <td>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Insurance Company Name<span style="color: Red;">* </span>
                                        </label>
                                        <asp:TextBox ID="txtIncCmpny" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rqcompanyname" runat="server" ControlToValidate="txtIncCmpny" CssClass="rqd" ErrorMessage="Please Enter Comapany " SetFocusOnError="True" ValidationGroup="g1"></asp:RequiredFieldValidator>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Insurance Number<span style="color: Red;">* </span>
                                        </label>
                                        <asp:TextBox ID="txtInsurenceNum" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rqinsuranceno" runat="server" ControlToValidate="txtInsurenceNum" CssClass="rqd" ErrorMessage="Please Enter Insurace No." SetFocusOnError="True" ValidationGroup="g1"></asp:RequiredFieldValidator>
                                    </div>
                                </td>
                            </tr>
                            <%--<tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Contact Person<span style="color: Red;">* </span></label>
                               <asp:TextBox ID="txtCnctPersn" runat="server"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="rqcontactperson" runat="server" ErrorMessage="Please Enter Contact person "
                            ControlToValidate="txtCnctPersn" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                                </div>
                                </td>
                                </tr>--%>
                            <tr>
                                <td>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Contact Number<span style="color: Red;">* </span>
                                        </label>
                                        <asp:TextBox ID="txtCnctNum" runat="server" MaxLength="10" onblur="javascript:return IsNumeric();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rqcntnumber" runat="server" ControlToValidate="txtCnctNum" CssClass="rqd" ErrorMessage="Please Enter Contact Number " SetFocusOnError="True" ValidationGroup="g1"></asp:RequiredFieldValidator>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Next Insurance Date<span style="color: Red">*</span></label>
                                        <asp:TextBox ID="txtMDOB" runat="server"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Insurance Documents</label>
                                        <asp:FileUpload ID="FileUpload1" runat="server" EnableViewState="true" type="file" />
                                        <asp:Label ID="lblfile" runat="server"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="for_sigle_row_form" style="margin-top: -19px;">
                                        <label>
                                        </label>
                                        <asp:Button ID="btnAdd" runat="server" CssClass="button_save" OnClick="btSave_Click" Text="Submit" ValidationGroup="g1" />
                                        <asp:Button ID="Button1" runat="server" CssClass="button_save" OnClick="Button1_Click" Text="Cancel" />
                                        <asp:Button ID="Button2" runat="server" CssClass="button_save" OnClick="Button2_Click" Text="Back" Visible="false" />
                                    </div>
                                </td>
                            </tr>
                        </caption>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>