<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="studentperformance.aspx.cs" Inherits="BranchPanel_studentperformance" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .active3 {
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

        td:nth-child(3) {
            width: 135px;
        }

        td:First-child {
            width: 145px;
            text-align: left;
            padding: 3px;
        }

        .abcode {
            width: 21%;
            float: left;
            margin-top: 12px;
        }

        .pre {
            width: 26%;
            float: right;
            margin-top: 5%;
        }
    </style>

    <div class="content_top">

        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active">View Admission Fee</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div class="clear">
    </div>

    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <div class="content_pane_cont input_content" id="contentPane">
                <My:stu runat="server" ID="Stu1" />

                <asp:GridView ID="GridView1" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                    runat="server" CssClass="stm0" GridLines="None" OnRowDataBound="GridView1_RowDataBound" EmptyDataText="No exam given by this student." OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Exam Date">
                            <ItemTemplate>
                                <asp:Label ID="lbldate" runat="server"></asp:Label>
                                <asp:HiddenField ID="lbexamid" runat="server" Value='<%#Eval("examid") %>'></asp:HiddenField>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Marks">
                            <ItemTemplate>
                                <asp:Label ID="lblrank" runat="server" Text='<%# Bind("marks") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Exam Name">
                            <ItemTemplate>
                                <asp:Label ID="lblsub" runat="server" Text='<%# Bind("examname") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Show Report" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnshow" runat="server" ToolTip="Click here to see exam report" Text="Show" CommandArgument='<%#Eval("examid") %>' CommandName="Show"></asp:LinkButton>
                                <%--<asp:Label ID="lbleid" runat="server" Style="display: none" Text='<%#Eval("examid") %>'></asp:Label>--%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>

                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light" />
                    <AlternatingRowStyle CssClass="stm_dark" />
                </asp:GridView>

                <div class="clear"></div>

                <table width="100%" style="padding: 10px; margin-top: 20px;" runat="server" id="tblreport">
                    <tr style="margin-top: 50px; font-weight: bold;">
                        <td rowspan="2" style="text-align: center;">Subjects </td>
                        <td colspan="3">
                            <asp:Label ID="lblsessionalname" runat="server"></asp:Label></td>
                        <td>Grand total </td>
                    </tr>
                    <tr>
                        <td style="text-align: center;">M.M </td>
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
                    </tr>
                </table>

                <div class="abcode" runat="server" id="divsug">
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

                <div class="clear">
                </div>

                <div class="for_sigle_row_form">

                    <asp:Button ID="btnsubmit" Visible="false" runat="server" Text="Cancel" CssClass="button2" Autopostback="true" OnClick="btnsubmit_Click" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>