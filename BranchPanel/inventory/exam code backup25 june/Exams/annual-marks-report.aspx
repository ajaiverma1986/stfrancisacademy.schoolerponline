<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="annual-marks-report.aspx.cs" Inherits="BranchPanel_Exams_annual_marks_report" %>

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
                <li style="background: none;"><a class="active" href="#">Annual Report</a></li>
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
                            <asp:Label ID="lblsessional" runat="server" Text="Annual"></asp:Label></th>
                        <th style="width: 110px;"></th>
                        <th>Academy Year : </th>
                        <th>
                            <asp:Label ID="lblacedemicyear" runat="server"></asp:Label></th>
                    </tr>
                </table>

                <table width="100%" style="padding: 10px; margin-top: 20px;">
                    <tr style="font-weight: bold;">
                        <td rowspan="2" style="text-align: center;">Subjects </td>
                        <td colspan="3">Annual </td>
                        <td colspan="1" style="width: 100px">Sessional 1 </td>
                        <td colspan="1" style="width: 100px">Sessional 2 </td>
                        <td colspan="1" style="width: 100px">Sessional 3 </td>
                        <td colspan="1" style="width: 150px">Half Yearly </td>
                        <td colspan="1" style="width: 100px">Sessional 4 </td>
                        <td colspan="1" style="width: 100px">Sessional 5 </td>
                        <td colspan="1" style="width: 100px">Sessional 6 </td>
                        <td colspan="3" style="width: 300px">Total </td>
                        <td colspan="2" style="width: 100px">Grand Total </td>
                    </tr>
                    <tr>
                        <td style="text-align: center;">M.M </td>
                        <td>P.M </td>
                        <td>S.M </td>
                        <td>S.M </td>
                        <td>S.M </td>
                        <td>S.M </td>
                        <td>S.M </td>
                        <td>S.M </td>
                        <td>S.M </td>
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
                            <asp:Label ID="lblhindi_a_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_a_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_s1_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_s2_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_s3_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_h_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_s4_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_s5_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_s6_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhindi_total_s_marks" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trenglish" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblenglish" runat="server" Text="English"></asp:Label></td>
                        <td>
                            <asp:Label ID="lbl_a_m_marks_english" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_a_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_s1_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_s2_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_s3_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_h_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_s4_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_s5_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_s6_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblenglish_total_s_marks" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trmaths" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblmaths" runat="server" Text="Maths"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_a_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_a_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_s1_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_s2_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_s3_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_h_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_s4_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_s5_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_s6_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblmath_total_s_marks" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trscience" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblscience" runat="server" Text="Science"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_a_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_a_s_marks_science" runat="server"></asp:Label></td>

                        <td>
                            <asp:Label ID="lblscience_s1_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_s2_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_s3_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_h_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_s4_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_s5_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_s6_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblscience_total_s_marks" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trsocialscience" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblsocialscience" runat="server" Text="Social Science"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_a_m_marks_" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_a_s_marks" runat="server"></asp:Label></td>

                        <td>
                            <asp:Label ID="lblsscience_s1_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_s2_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_s3_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_h_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_s4_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_s5_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_s6_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblsscience_total_s_marks" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trdrawing" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lbldrawing" runat="server" Text="History"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_a_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_a_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_s1_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_s2_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_s3_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_h_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_s4_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_s5_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_s6_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblhistory_total_s_marks" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trgk" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblgk" runat="server" Text="G.K"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_a_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_a_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_s1_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_s2_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_s3_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_h_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_s4_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_s5_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_s6_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblgk_total_s_marks" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trchemistry" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblchemistry" runat="server" Text="Chemistry"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_a_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_a_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_s1_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_s2_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_s3_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_h_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_s4_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_s5_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_s6_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblchemistry_total_s_marks" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trphysics" runat="server" visible="false">
                        <td>
                            <asp:Label ID="lblphysics" runat="server" Text="Physics"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_a_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_a_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_a_s_marks" runat="server"></asp:Label></td>

                        <td>
                            <asp:Label ID="lblphysics_s1_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_s2_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_s3_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_h_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_s4_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_s5_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_s6_s_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_total_m_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_total_p_marks" runat="server"></asp:Label></td>
                        <td>
                            <asp:Label ID="lblphysics_total_s_marks" runat="server"></asp:Label></td>
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