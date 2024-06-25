<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="halfyearly-report.aspx.cs" Inherits="BranchPanel_Exams_halfyearly_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        #ctl00_ContentPlaceHolder1_CompareValidator1 {
            margin-left: 578px;
            left: 0;
            margin-top: 5px;
            position: absolute;
            width: 184px;
        }

        table {
            padding: 10px;
            border-collapse: collapse;
        }

        tr td {
            border: 1px solid #000;
            text-align: center;
            font-size: 13px;
        }

        th {
            color: #000!important;
            padding: 2px;
            text-align: left;
        }

        td:nth-child(2) {
            width: 75px;
        }

        td:nth-child(3) {
            width: 75px;
        }

        td:nth-child(4) {
            width: 75px;
        }

        td:nth-child(5) {
            width: 75px;
        }

        td:nth-child(6) {
            width: 75px;
        }

        td:nth-child(7) {
            width: 75px;
        }

        td:nth-child(8) {
            width: 75px;
        }

        td:First-child {
            text-align: left;
            padding: 3px;
        }

        .abcode {
            width: 19%;
            float: left;
            margin-top: 12px;
        }

        .pre {
            width: 26%;
            float: right;
            margin-top: 5%;
        }
    </style>

    <div class="content_pane_cont" id="contentPane">
        <div class="content_top">
            <ul>
                <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
                <li><a href="#">Exam List</a></li>
                <li style="background: none;"><a class="active" href="#">Halfyearly Report</a></li>
            </ul>
            <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            </div>
        </div>
        <div class="clear">
        </div>
        <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                class="containerHeadline">
                Select User
            </div>

            <center>
                <table width="90%" style="padding: 10px">
                    <tr>
                        <th colspan="5" style="text-align: center;">
                            <img src="../../images/logo.png" style="width: 300px;" />
                        </th>
                    </tr>
                    <tr>
                        <th colspan="5" style="text-align: center;">Statment Of Marks </th>
                    </tr>
                    <tr>
                        <th>Student Name : </th>
                        <th>
                            <asp:Label ID="lblstudentname" runat="server"></asp:Label></th>
                        <th style="width: 110px;"></th>
                        <th>Admission No. :  </th>
                        <th>
                            <asp:Label ID="lbladmission" runat="server"></asp:Label></th>
                    </tr>
                    <tr>
                        <th>Class : </th>
                        <th>
                            <asp:Label ID="lblclass" runat="server"></asp:Label></th>
                        <th style="width: 110px;"></th>
                        <th>Roll No : </th>
                        <th>
                            <asp:Label ID="lblroll" runat="server"></asp:Label></th>
                    </tr>
                    <tr>
                        <th>Exam : </th>
                        <th>
                            <asp:Label ID="lblsessional" runat="server" Text="Halfyearly"></asp:Label></th>
                        <th style="width: 110px;"></th>
                        <th>Academy Year : </th>
                        <th>
                            <asp:Label ID="lblacedemicyear" runat="server"></asp:Label></th>
                    </tr>
                </table>

                <table width="90%" style="padding: 10px; margin-top: 20px;">
                    <tr style="font-weight: bold;">
                        <td rowspan="2" style="text-align: center;">Subjects </td>
                        <td colspan="3">Halfyearly </td>
                        <td colspan="2">Sessional </td>
                        <td colspan="3">Total </td>
                        <td colspan="2">Grand Total </td>
                    </tr>
                    <tr>
                        <td style="text-align: center;">M.M </td>
                        <td>P.M </td>
                        <td>S.M </td>
                        <td>M.M </td>
                        <td>S.M </td>
                        <td>M.M </td>
                        <td>P.M </td>
                        <td>S.M </td>
                        <td rowspan="6">Total :<asp:Label ID="lblgrandtotal" runat="server"></asp:Label><br />
                            <br />
                            Percentage:<asp:Label ID="lblpercentage" runat="server"></asp:Label><br />
                            <br />
                            Rank:<asp:Label ID="lblrank" runat="server" Text="Not Calculated"></asp:Label>
                            <br />
                            <br />
                            Designation:<asp:Label ID="lbldesignation" runat="server" Text="Not Calculated"></asp:Label></td>
                    </tr>
                    <tr id="trhindi" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblhindi" runat="server" Text="Hindi"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindimaximummarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblpassingmarkshindi" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblstudentmarkshindi" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalmaxmarkshindi" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalstudentmarkshindi" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarkshindi" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarkshindi" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarkshindi" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trenglish" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblenglish" runat="server" Text="English"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglishmaximummarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglishpassingmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglishstudentmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalmaxmarksenglish" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalstudentmarksenglish" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarksenglish" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarksenglish" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarksenglish" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trmaths" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblmaths" runat="server" Text="Maths"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmathsmaximummarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmathpassingmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmathstudentmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalmaxmarksmath" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalpassingmarksmaths" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarksmaths" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarksmaths" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarksmaths" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trscience" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblscience" runat="server" Text="Science"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsciencemaximummarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsciencepassingmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsciencestudentmarks" runat="server"></asp:Label></td>

                        <td>
                            <asp:Label ID="lblsessionalsciencemaxmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessinalstudentmarksscience" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarksscience" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarksscience" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarksscience" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trsocialscience" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblsocialscience" runat="server" Text="Social Science"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsocialsciencemaxmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsocialsciencepassingmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsocialstudentmarks" runat="server"></asp:Label></td>

                        <td>
                            <asp:Label ID="lblsessionalmaxmarkssocialscience" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalstudentmarkssocialscience" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarkssocialscience" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarkssocialscience" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarkssocialscience" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trdrawing" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lbldrawing" runat="server" Text="History"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbldrawingmaximummarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbldrawingpassingmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbldrawingstudentmarks" runat="server"></asp:Label></td>

                        <td>
                            <asp:Label ID="lblsessionalmaxmarksHistory" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalstudentmarksHistory" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarksHistory" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarksHistory" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarksHistory" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trgk" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblgk" runat="server" Text="G.K"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgkmaximummarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgkpassingmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgkstudentmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalmaxmarksGK" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalstudentmarksGK" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarksGK" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarksGK" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarksGK" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trchemistry" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblchemistry" runat="server" Text="Chemistry"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistrymaximummarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistrypassingmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistrystudentmarks" runat="server"></asp:Label></td>

                        <td>
                            <asp:Label ID="lblsessionalmaxmarkschemistry" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalstudentmarkschemistry" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarkschemistry" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarkschemistry" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarkschemistry" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trphysics" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblphysics" runat="server" Text="Physics"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysicsmaximummarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysicspassingmarks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysicsstudentmarks" runat="server"></asp:Label></td>

                        <td>
                            <asp:Label ID="lblsessionalmaxmarksphysics" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsessionalstudentmarksphysics" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalmaxmarksphysics" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalpassingmarksphysics" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbltotalstudentmarksphysics" runat="server"></asp:Label></td>
                    </tr>
                </table>

                <div class="abcode">
                    <p style="font-weight: bold;">
                        Abbrevation Code
                    </p>
                    <ul style="text-align: left; margin-left: 25%; line-height: 17px;">
                        <li>M.M = Maximum Marks </li>
                        <li>P.M = Passing Marks </li>
                        <li>S.M = Student Marks </li>

                        <li>N.A = Not Applicable </li>
                        <li>S.C = Subject Code </li>
                        <li>A.B = Absent </li>
                    </ul>
                </div>

                <div class="pre">
                    <p>Controller of Examination</p>

                    <p>Date :.......................</p>
                </div>
            </center>
        </div>
    </div>
</asp:Content>