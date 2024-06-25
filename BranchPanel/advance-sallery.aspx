<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="advance-sallery.aspx.cs" Inherits="BranchPanel_advance_sallery" %>

<%@ Register Src="~/BranchPanel/employee/employee-panel.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <link href="../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />

    <script type="text/javascript">

        function pageLoad() {
            document.title = "Employee Advanced Salary";

        }

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_txtchequedate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy/mm/dd',
                maxDate: new Date()
            });

            $("#ctl00_ContentPlaceHolder1_txtpaymentdate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy/mm/dd',
                maxDate: new Date()
            });

            $("#ctl00_ContentPlaceHolder1_ddlpaymentmode").change(function () {
                var ddlvalue = $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val();
                if (ddlvalue == "2") {
                    $('#divcheque').css("display", "block");
                }
                else {
                    $('#divcheque').css("display", "none");
                }
            });

            $("#ctl00_ContentPlaceHolder1_btnpay").click(function () {
                validatefield();
                return false;
            });
        });

        function validatefield() {
            if ($('#ctl00_ContentPlaceHolder1_txtamounttobepaid').val() == "") {
                alert('Amount To Be Paid Can Not Blank.');
                $('#ctl00_ContentPlaceHolder1_txtamounttobepaid').focus();
                return false;
            }
            else if ($('#ctl00_ContentPlaceHolder1_txtpaymentdate').val() == "") {
                alert('Payment Date Can Not Blank.');
                $('#ctl00_ContentPlaceHolder1_txtpaymentdate').focus();
                return false;
            }

            else if ($('#ctl00_ContentPlaceHolder1_txtdeccription').val() == "") {
                alert('Enter Description Please.');
                $('#ctl00_ContentPlaceHolder1_txtdeccription').focus();
                return false;
            }

            else if ($('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val() == "0") {
                alert('Select One Of Two Payment Mode Either Cash Or Cheque.');
                $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').focus();
                return false;
            }

            if ($('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val() == "2") {

                if ($('#ctl00_ContentPlaceHolder1_txtbankname').val() == "") {
                    alert('Bank Name Can Not Blank.');
                    $('#ctl00_ContentPlaceHolder1_txtbankname').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtchequenumber').val() == "") {
                    alert('Cheque Number Can Not Blank.');
                    $('#ctl00_ContentPlaceHolder1_txtchequenumber').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtchequedate').val() == "") {
                    alert('Cheque Date Can Not Blank.');
                    $('#ctl00_ContentPlaceHolder1_txtchequedate').focus();
                    return false;
                }
            }

        }
    </script>

    <style type="text/css">
        .for_sigle_row_form label {
            padding-top: 1px !important;
        }

        #divcheque .for_sigle_row_form label {
            margin-top: 9px !important;
        }

        .activeadvancesallery {
            border-color: #ccc!important;
            border-width: medium;
            background: #F7F7F7;
            color: #15A1BF!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px!important;
            margin-top: 3px;
        }

        .txttotaleffectiveday {
            border: dotted 0.05px;
            opacity: 1 !important;
            width: 43px !important;
            text-align: center !important;
        }

        #divcheque .for_sigle_row_form {
            margin-left: -27px !important;
        }

        #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment {
            width: 100%;
        }

            #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment td {
                width: 50%;
            }

            #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment label {
                width: 44px !important;
                float: left !important;
                padding-top: 2px;
            }

        .paytable {
            width: 100%;
        }

            .paytable td {
                padding: 5px;
            }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Hr Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Advance Salary</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
       <%-- <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>

        <div class="for_sigle_row_form" id="divpaynow" style="margin-left: 227px; width: 563px; min-height: 50px; margin-top: 10px !important; display: block">

            <table class="paytable">
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Employee Name<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtempname" runat="server" MaxLength="100"></asp:TextBox></td>
                </tr>

                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Amount To Be Paid<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtamounttobepaid" runat="server" MaxLength="100"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Payment Date<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtpaymentdate" runat="server" MaxLength="100"></asp:TextBox></td>
                </tr>

                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Description<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtdeccription" runat="server" MaxLength="100"></asp:TextBox></td>
                </tr>

                <tr>
                    <td style="text-align: right; width: 30%">
                        <label style="width: 180px;">
                            Payment Mode<span style="color: Red">*</span>
                        </label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlpaymentmode" runat="server">
                            <asp:ListItem Value="0"> Select One </asp:ListItem>
                            <asp:ListItem Value="1"> Cash </asp:ListItem>
                            <asp:ListItem Value="2"> Cheque </asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <div id="divcheque" style="display: none">

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Bank Name<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtbankname" runat="server" MaxLength="100"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Cheque No<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtchequenumber" runat="server" MaxLength="100"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form" style="margin-left: -68px">
                    <label>
                        Cheque Date<span style="color: Red">*</span>
                    </label>
                    <asp:TextBox ID="txtchequedate" runat="server" MaxLength="100"></asp:TextBox>
                </div>
            </div>
            <div class="for_sigle_row_form" style="margin-left: -26px">
                <label>
                    <span style="color: Red"></span>
                </label>
                <asp:Button ID="btnpay" runat="server" Text="Pay" CssClass="button_save" Style="cursor: pointer" OnClick="btnpay_Click" />
            </div>
        </div>
    </div>
</asp:Content>