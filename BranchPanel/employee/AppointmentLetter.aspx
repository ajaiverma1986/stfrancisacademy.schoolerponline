<%@ Page Title="Appointment Letter" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="AppointmentLetter.aspx.cs" Inherits="Letters_AppointmentLetter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function callPrint() {
            document.getElementById('<%=btn_print.ClientID%>').style.display = 'none';
            var printContent = document.getElementById('<%=divforprintappointedletter.ClientID%>');
            var printWindow = window.open('left=500,top=500,width=500,height=500');
            printWindow.document.write(printContent.innerHTML);
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }
    </script>
    <style type="text/css">
        .Divformessage span {
            margin: 30px 0px 30px 70px !important;
            font-weight: bold !important;
            color: green !important;
            font-style: oblique !important;
            font-size: 20px !important;
        }

        .print {
            width: 700px !important;
            height: auto !important;
            position: relative !important;
            margin: 0px auto !important;
            background: white;
        }

        .p {
            margin: 0px !important;
            padding: 0px !important;
            font-size: 12px !important;
            color: #999999 !important;
            float: left;
        }

        .str {
            width: 308px !important;
            height: 30px !important;
            float: left !important;
            display: block;
        }

        .offerletter td {
            padding: 5px 40px 0px 40px !important;
        }

        .offerletter {
            padding-bottom: 100px !important;
            padding-top: 100px !important;
            text-align: justify !important;
        }

            .offerletter cite {
                width: auto !important;
                height: 30px !important;
                float: left !important;
                line-height: 30px !important;
                font-style: normal !important;
                padding-right: 10px;
            }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">HR Managment</a></li>
            <li style="background: none;"><a class="active" href="#">Appointment Letter</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Appointment Letter
        </div>
        <br />
        <div id="divforprintappointedletter" runat="server" style="padding-bottom: 100px; padding-top: 10px; text-align: justify; font-family: Arial; font-size: 12px;" visible="false">
            <table style="width: 770px; border: 1px solid #CCCCCC; height: auto; position: relative; padding-left: 30px; padding-right: 30px; padding-bottom: 80px; margin: 0px auto; background: white; text-align: justify; font-family: Arial; font-size: 14px;">
                <tr>
                    <td>
                        <div style="width: 308px; height: 30px; float: left; display: block; padding-top: 100px;">
                            Employee ID:&nbsp;<b>
                                <asp:Label ID="lbl_refno1" runat="server" Text="RefNo"></asp:Label></b>
                        </div>
                        <div style="width: 393px; height: 30px; float: left; text-align: right; display: block; padding-top: 100px;">
                            Date:&nbsp;<b>
                                <asp:Label ID="lbl_Date1" runat="server" Text="Date"></asp:Label></b>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_title" runat="server" Text="Title"></asp:Label>&nbsp;
                        <asp:Label ID="lbl_firstname1" runat="server" Text="First Name"></asp:Label>
                        <asp:Label ID="lbl_middlename1" runat="server" Text="Middle Name"></asp:Label>
                        <asp:Label ID="lbl_lastname1" runat="server" Text="Last Name"></asp:Label>
                        <asp:HiddenField ID="hdvforid" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_address1" runat="server" Text="Address"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_city1" runat="server" Text="City"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_State1" runat="server" Text="State"></asp:Label>-
                        <asp:Label ID="lbl_pincode" runat="server" Text="Picode"></asp:Label>,
                        <asp:Label ID="lbl_country1" runat="server" Text="Country"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 30px; line-height: 30px;">Subject: Appointment Letter
                    </td>
                </tr>
                <tr>
                    <td style="height: 30px; line-height: 30px;">Dear
                       <b>
                           <asp:Label ID="Label11" runat="server" Text="Candidate Name"></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>
                            With reference to the discussion we had with you, we are pleased to offer you the
                            position of “<b><asp:Label ID="lbl_position1" runat="server" Text="Position"></asp:Label></b>”
                            and invite you to join us.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>
                            Your Cost To Company (CTC) would be Rs. <b>
                                <asp:Label ID="lbl_salary1" runat="server" Text="Salary"></asp:Label></b> ,
                                ("<b><asp:Label
                                    ID="lbl_saleryinwords1" runat="server" Text="Salary In Words"></asp:Label>)</b>")
                            per annum.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>
                            The allowances, benefits and other terms and conditions of your employment will
                            be as per Company policies as applicable from time to time. Your compensation will
                            be reviewed in future as per Company policy.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>
                            On joining the company you shall be on probation period for <b>
                                <asp:Label ID="lbl_months1" runat="server" Text=""></asp:Label>&nbsp;months</b>. You
                            will abide by the rules and regulations of the company as may be in force from time
                            to time.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>
                            You are required to maintain the highest order of discipline and secrecy as regards
                            the work of the company and/or its subsidiaries or associate companies and in case
                            of any breach of discipline/trust, your services may be terminated by the company
                            with immediate effect.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>The company looks for a long term association with all its employees and expects
                        the same from you.
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        Your appointment is with effect from <b>
                            <asp:Label ID="Lbl_Date" runat="server" Text="Date"></asp:Label></b>.
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <p>
                            Kindly sign the copy of this letter indicating your acceptance of the above terms
                            and conditions of this appointment and return the same to us.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>
                            We welcome to you in our company and we wish you good luck and a very bright career
                            with us.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <div style="width: 308px; height: 30px; float: left; display: block;">
                            For <b>
                                <asp:Label ID="Lbl_CompanyName2" runat="server" Text="Company Name"></asp:Label></b>
                        </div>
                        <div style="width: 393px; height: 30px; float: left; display: block; text-align: right;">
                            Employment offer Accepted
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <div style="width: 308px; height: 30px; float: left; display: block;">
                            <b>
                                <asp:Label ID="lbl_hrname1" runat="server" Text="HR Manager Name"></asp:Label></b><br />
                            Managing Director
                        </div>
                        <div style="width: 393px; height: 30px; float: left; display: block; text-align: right;">
                            <b>
                                <asp:Label ID="lbl_candidatename1" runat="server" Text="Candidate Name"></asp:Label></b>
                        </div>
                    </td>
                </tr>
            </table>
            <center>
                <div class="button_style" align="center">
                    <br />
                    <asp:HiddenField ID="hfforname" runat="server" />
                    <asp:HiddenField ID="hfforemail" runat="server" />
                    <asp:Button ID="btn_print" CssClass="button_save" runat="server" Text="Print" OnClientClick="return callPrint();" ToolTip="Click here to print this appointment letter." />
                    <asp:Button runat="server" ID="btnBack" CssClass="button_save" Text="Back"
                        ToolTip="Click here to go back to the list" OnClick="btnBack_Click" Style="margin-left: 10px !important;" />
                    <asp:Button runat="server" ID="btnforsendmail" CssClass="button_save" Text="Send Mail"
                        ToolTip="Click here to send e-mail" OnClientClick="return confirm('Are you sure you want to E-mail the appointment letter?')" OnClick="btnforsendmail_Click" Style="margin-left: 10px !important;" />
                </div>
            </center>
        </div>
        <div class="clear">
        </div>
        <div class="Divformessage" runat="server" id="DivForMessage">
            <asp:Label ID="labelforofferletter" runat="server" Style="margin-left: 350px !important;"></asp:Label>
            <div class="clear"></div>
            <asp:Label ID="lblmessageaccordingtostatus" runat="server"></asp:Label>
            <br />
            <br />
            <br />
            <asp:Button ID="btnbackwhennoofofferletter" runat="server" Text="GO TO EMPLOYEE LIST" CssClass="button_save" Style="margin-left: 300px !important;" OnClick="btnbackwhennoofofferletter_Click" />
        </div>
    </div>
</asp:Content>