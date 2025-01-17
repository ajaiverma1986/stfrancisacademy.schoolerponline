﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportCard.aspx.cs" Inherits="BranchPanel_Exams_ReportCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/style.css" rel="stylesheet" />
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        .HiddenCol {
            display: none;
        }
    </style>


</head>
<body>
    <form id="form1" runat="server" style="font-size: 14px;">
        <asp:HiddenField runat="server" ID="ResultType" Value="0" />
        <asp:GridView ID="grdSTDResult" runat="server" EmptyDataText="No data found !" BorderStyle="None" GridLines="None"
            AutoGenerateColumns="false" Width="100%" OnRowDataBound="grdSTDResult_RowDataBound">
            <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-BorderStyle="None">
                    <HeaderStyle CssClass="HiddenCol" />
                    <ItemTemplate>
                        <asp:HiddenField ID="dfrollno" runat="server" Value='<% #Bind("rollno")%>'></asp:HiddenField>
                        <asp:HiddenField ID="dfregno" runat="server" Value='<% #Bind("regno")%>'></asp:HiddenField>
                        <div style="width: 800px; height: 1060px; border: solid 1px black; padding: 10px 10px 10px 10px;">
                            <table style="width: 100%; text-align: center; border: none; margin-top: -10px;">
                                <tr>
                                    <td style="text-align: left; border: none;"><span id="SWebsite" runat="server"></span>
                                    </td>
                                    <td style="text-align: center; border: none;"><span id="SEmailID" runat="server"></span>
                                    </td>
                                    <td style="text-align: right; border: none;">Mob: <span id="SMobile" runat="server"></span>
                                        <br />
                                        <span id="SpFone" runat="server"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; border: none;" colspan="3">
                                        <asp:Image ID="Image1" runat="server" CssClass="schoollogo" Height="100px" Width="100px" ImageUrl="~/images/9update.png" />

                                        <div style="text-align: center; margin: -105px 0 0 0; height: 105px;">
                                            <h1 style="margin: 0"><span id="SpScool" runat="server"></span></h1>
                                            <h3 style="margin: 0; font-size: 14px"><span id="SAddress" runat="server"></span></h3>
                                            <h3 style="margin: 0; font-size: 14px"><span id="SSAddress" runat="server"></span></h3>
                                            <h3 style="margin: 0; font-size: 14px"><span id="affhead" runat="server"></span><span id="SchoolAffia" runat="server"></span></h3>
                                            <div style="border-bottom: solid 2px black; width: 100%; font-size: 14px; height: 23px"></div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="border: none">
                                        <span style="font-size: 25px">Academic Session : 2017-2018</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="border: none">
                                        <div style="height: 5px"></div>
                                        <span style="border: 2px solid; padding: 5px 20px 5px 20px; font-weight: 800; font-size: 20px;">Report Card </span>

                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table style="width: 100%; border: none; margin-top: -6px">
                                <tr>
                                    <td style="border: none; width: 10%; padding: 0 0 8px 0;">Class  </td>
                                    <td style="border: none; width: 12%">: <span id="classID" runat="server">Ist</span></td>
                                    <td style="border: none; width: 10%">Section  </td>
                                    <td style="border: none; width: 12%">: <span id="sectionID" runat="server">A</span></td>
                                    <td style="border: none; width: 9%">Roll No  </td>
                                    <td style="border: none; width: 16%">: <span id="RollNo" runat="server">123456</span></td>
                                    <td style="border: none; width: 12%;">Date of Birth  </td>
                                    <td style="border: none; width: 14%;">: <span id="DOB" runat="server" style="float: right">15/07/2017</span></td>
                                </tr>
                                <tr>
                                    <td colspan="7" style="width: 100%; border: none">
                                        <table style="width: 100%; border: none">
                                            <tr>
                                                <td style="border: none; width: 30%; padding: 0 0 8px 0;">Student's Name </td>
                                                <td style="border: none; font-weight: 800;">: <span id="SpName" runat="server">Ist</span></td>
                                            </tr>
                                            <tr>
                                                <td style="border: none; width: 30%; padding: 0 0 8px 0;">Mother's Name  </td>
                                                <td style="border: none;">: <span id="SpMName" runat="server">A</span></td>
                                            </tr>
                                            <tr>
                                                <td style="border: none; width: 30%; padding: 0 0 8px 0;">Father’s/Guardian’s Name  </td>
                                                <td style="border: none;">: <span id="SpFName" runat="server">123456</span></td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:Image ID="Image2" runat="server" CssClass="schoollogo" Height="100px" Width="100%" ImageUrl="~/images/9update.png" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="8" style="width: 100%; border: none; line-height: 20px;">
                                        <br />
                                        <table style="width: 100%; font-size: 12px">
                                            <tr>
                                                <td style="width: 13.4%" runat="server" id="td1"><b>Scholastic Area</b></td>
                                                <td style="width: 25.4%; text-align: center" runat="server" id="td2"><b>Term - I ( 100 Marks )</b></td>
                                                <td style="width: 28.7%; text-align: center" ><b>Term - II ( 100 Marks )</b></td>
                                                <td style="width: 32%; text-align: center" runat="server" id="td4"><b>Term - III ( 100 Marks )</b></td>
                                                <td style="width: 10%; text-align: center" runat="server" id="td5"><b>Total</b></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="8" style="width: 100%; border: none">
                                        <asp:PlaceHolder ID="placeholder" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="8" style="width: 100%; border: none; line-height: 25px;">
                                        <br />
                                        <table style="width: 100%; font-size: 12px;">
                                            <tr>
                                                <td style="width: 43%; text-align: center; text-align: left; font-size: 11px;"><b>Co - Scholastic Areas : Term - I [ On a 3 - Point ( A - C ) Grading Scale]</b></td>
                                                <td style="text-align: center;"><b>Grade</b></td>
                                                <td style="width: 46%; text-align: center; text-align: left; font-size: 11px"><b>Co - Scholastic Areas : Term - II [ On a 3 - Point ( A - C ) Grading Scale]</b></td>
                                                <td style="text-align: center;"><b>Grade</b></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 43%; text-align: center; text-align: left">Work Education ( or Pre - Vocational Education)</td>
                                                <td style="text-align: center;"><span id="spWorkI" runat="server"></span></td>
                                                <td style="width: 46%; text-align: center; text-align: left">Work Education ( or Pre - Vocational Education)</td>
                                                <td style="text-align: center;"><span id="spWorkII" runat="server"></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 43%; text-align: center; text-align: left">Art Education</td>
                                                <td style="text-align: center;"><span id="SpArtI" runat="server"></span></td>
                                                <td style="width: 46%; text-align: center; text-align: left">Art Education</td>
                                                <td style="text-align: center;"><span id="SpArtII" runat="server"></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 43%; text-align: center; text-align: left">Health & Physical Education</td>
                                                <td style="text-align: center;"><span id="SpPhyI" runat="server"></span></td>
                                                <td style="width: 46%; text-align: center; text-align: left">Health & Physical Education</td>
                                                <td style="text-align: center;"><span id="SpPhyII" runat="server"></span></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="width: 100%; font-size: 12px; line-height: 25px;">
                                            <tr>
                                                <td style="width: 43%; text-align: center; text-align: left"><b>Discipline : Term - I [ On a 3 Point ( A - C ) Grading Scale</b></td>
                                                <td style="text-align: center;"><span id="SpDisI" runat="server"></span></td>
                                                <td style="width: 46%; text-align: center; text-align: left"><b>Discipline : Term - II[ On a 3 Point ( A - C ) Grading Scale</b></td>
                                                <td style="text-align: center;"><span id="SpDisII" runat="server"></span></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="width: 100%; font-size: 16px; border: none">
                                            <tr>
                                                <td style="width: 25%; border: none">Class Teacher’s remarks : 
                                                </td>
                                                <td style="border: none; border-bottom: dotted 1px black; width: 75%"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="border: none;">
                                                    <div style="height: 10px"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 25%; border: none">Promoted to class :
                                                </td>
                                                <td style="border: none; border-bottom: dotted 1px black; width: 75%"></td>
                                            </tr>


                                        </table>
                                        <br />
                                        <br />
                                        <br />
                                        <table style="width: 100%; font-size: 16px; border: none">
                                            <tr>
                                                <td style="width: 25%; border: none" colspan="4">
                                                    <div style="height: 50px"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100%; border: none" colspan="4">Place : 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 6%; border: none">Date :
                                                </td>
                                                <td style="border: none; border-bottom: dotted 1px black; width: 10%"></td>
                                                <td style="border: none; width: 25%; float: right">Signature of Principal</td>
                                                <td style="border: none; width: 45%; float: right">Signature of Class Teacher</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

    </form>
</body>
</html>
