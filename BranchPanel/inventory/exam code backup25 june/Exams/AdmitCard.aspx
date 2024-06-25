<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdmitCard.aspx.cs" Inherits="BranchPanel_Exams_AdmitCard" %>

<!DOCTYPE html>

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
    </style>


</head>
<body>
    <form id="form1" runat="server" style="font-size: 14px;">
        <asp:HiddenField runat="server" ID="ResultType" Value="0" />
        <asp:GridView ID="grdSTDResult" runat="server" EmptyDataText="No data found !" BorderStyle="None" GridLines="None" OnRowCreated="OnRowCreated"
            AutoGenerateColumns="false" Width="100%" OnRowDataBound="grdSTDResult_RowDataBound">
            <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-BorderStyle="None">
                    <HeaderStyle CssClass="HiddenCol" />
                    <ItemTemplate>
                        <asp:HiddenField ID="dfrollno" runat="server" Value='<% #Bind("rollno")%>'></asp:HiddenField>
                        <asp:HiddenField ID="dfregno" runat="server" Value='<% #Bind("regno")%>'></asp:HiddenField>
                        <asp:HiddenField  runat="server" id="hdnClass" Value='<% #Bind("classid")%>'/>
                                         <asp:HiddenField  runat="server" id="hdnSection" Value='<% #Bind("sectionid")%>'/>
                                         <asp:HiddenField  runat="server" id="hdnTerm" Value='<% #Bind("termid")%>'/>
                        <div style="width: 730px; height: 100%; border: solid 1px black; padding: 10px 10px 10px 10px; margin-bottom:2px;">
                            <table style="width: 100%; text-align: center; border: none; margin-top: -10px;">
                                <tr style="display:none;">
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
                                    <td style="text-align: left; border: none;width:86%" colspan="1">
                                         <img id="grdSTDResult_ctl02_Image1" class="schoollogo" src="../images/admitcardheader.jpg" style="height:100px;width:100%;border-width:0px;">
                                    </td>
                                    <td style="text-align: center; border: none;width:1%" colspan="1">                                     

                                        
                                          <!--  <h1 style="margin: 0"><span id="grdSTDResult_ctl02_SpScool">St. Francis Academy </span></h1>
                                            <h3 style="margin: 0; font-size: 14px"><span id="grdSTDResult_ctl02_SAddress">Chota Bariyarpur</span></h3>
                                            <h3 style="margin: 0; font-size: 14px"><span id="grdSTDResult_ctl02_SSAddress">Motihari, Bihar, india, 845401</span></h3>-->
                                            <h3 style="margin: 0; font-size: 14px"><span id="grdSTDResult_ctl02_affhead">.</span><span id="grdSTDResult_ctl02_SchoolAffia"></span><br>
                                                <span id="grdSTDResult_ctl02_SWebsite" style="display:none">http://francisacademy.com</span><br>
                                                
                                                
                                                
                                            </h3>
                                           
                                        
                                    </td>
                                    <td style="text-align: right; border: none;width:14%" colspan="0">
                                        <%--<img id="grdSTDResult_ctl02_Image2" class="schoollogo" src="" style="height:100px;width:120px;border-width:0px;"><br>--%>
										<!--<asp:Image ID="Image2" runat="server" ImageUrl="" Height="80px" Width="100px" />  <br />
                                        
                                        <span style="float:right; width:120px"><b>School Code: BI040</b></span>--!>
			
										
							
                                    </td>
								
                                </tr>
                                <tr style="display:none;">
                                    <td style="text-align: left; border: none;" colspan="3">
                                        <asp:Image ID="Image1" runat="server" CssClass="schoollogo" Height="100px" Width="100px" ImageUrl="~/images/9update.png" />

                                        <div style="text-align: center; margin: -105px 0 0 0; height: 105px;">
                                            <h1 style="margin: 0"><span id="SpScool" runat="server"></span></h1>
                                            <h3 style="margin: 0; font-size: 14px"><span id="SAddress" runat="server"></span></h3>
                                            <h3 style="margin: 0; font-size: 14px"><span id="SSAddress" runat="server"></span></h3>
                                            <h3 style="margin: 0; font-size: 14px"><span id="affhead" runat="server">Affiliation No:</span><span id="SchoolAffia" runat="server"></span></h3>
                                            <div style="border-bottom: solid 2px black; width: 100%; font-size: 14px; height: 25px"></div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                   <td style="text-align: left; border: none;width:100%" colspan="3">
                                         <img id="grdSTDResult_ctl02_Image3" class="schoollogo" src="../images/admitcard.jpg" style="height:35px;width:100%;border-width:0px;">
                                    </td>
                                </tr>
                               
                            </table>
                            <table style="width: 100%; border: none;margin-bottom:8px;font-weight:bold;font-size:14px;">
                                <tbody><tr style="background-color: #3f9306;height: 25px;">
                                    <td style="border: none; width: 5%; text-align:right">Name:</td>
                                    <td style="border: none; font-weight: 770;width: 17%;"><span id="SpName" runat="server">Aanya Kumari </span></td>
                                    <td style="border: none; width: 8%;text-align:right">Roll No:</td>
                                    <td style="border: none; width: 8%"><span id="RollNo" runat="server">123456</span></td>
                                    <td style="border: none; width: 10%;text-align:right ">Class:</td>
                                    <td style="border: none; width: 12%"><span id="classID" runat="server">Nursery</span></td>
                                    <td style="border: none; width: 12%;text-align:left">Section: <span id="sectionID" runat="server">A</span> </td>
                                    <td style="border: none; width: 12%">Session 2021-22</td>
                                     
                                    
                                </tr></tbody></table>

                            <table style="border: none;width:100%;font-weight:bold;font-size:14px;">
                                            <tbody><tr style="background-color: #ff6600;height: 25px;">
                                                <td style="border: none; width:5%;text-align:right">&nbsp;&nbsp;DOB:</td>
                                                <td style="border: none; width:11%;"><span id="DOB" runat="server" ></span></td>
                                     <td style="border: none; width: 22%; text-align:right">Mother's Name:</td>
                                                <td style="border: none;width: 18%; text-align:left"><span id="SpMName" runat="server">Priyanka Kumari </span></td>
                                     <td style="border: none; width: 25%; text-align:right">Father’s Name:  </td>
                                                <td style="border: none;text-align:left"><span id="SpFName" runat="server">123456</span></td>
                                            </tr>
                                        </tbody></table>
                            <br />
                            <table style="width: 100%; border: none">
                                <tr style="display:none;">
                                    <td style="border: none; width: 10%; padding: 0 0 8px 0;">From Date  </td>
                                    <td style="border: none; width: 12%">: <span id="SpanFrom" runat="server"></span></td>
                                    <td style="border: none; width: 10%">  </td>
                                    <td style="border: none; width: 12%"> <span id="Span2" runat="server"></span></td>
                                    <td style="border: none; width: 9%">To Date </td>
                                    <td style="border: none; width: 16%">: <span id="SpanTo" runat="server"></span></td>
                                    <td style="border: none; width: 12%;">  </td>
                                    <td style="border: none; width: 14%;"> <span id="Span4" runat="server" style="float: right"></span></td>
                                </tr>
                                
                                <tr style="display:none">
                                    
                                    <td style="width: 100px">
                                        <%--<asp:Image ID="Image2" runat="server" CssClass="schoollogo" Height="100px" Width="100%" ImageUrl="~/images/9update.png" />--%>
                                    </td>
                                </tr>
                                 <tr>
                                    <td colspan="7" style="width: 100%; border: none;">
                                        <table style="width: 100%; border: none; display:none">
										<center><b>ANNUAL EXAM-2021-22</b3></center>
                                          <tr>
                                                <td style="border: none; width: 30%; padding: 0 0 8px 0;">Address </td>
                                                <td style="border: none; font-weight: 800;">: <span id="SpanAddr" runat="server"></span></td>
                                            </tr>
                                            <tr>
                                                <td style="border: none; width: 30%; padding: 0 0 8px 0;">Mobile  </td>
                                                <td style="border: none;">: <span id="SpanMob" runat="server">A</span></td>
                                            </tr>
                                           
                                        </table>
                                    </td>
                                    <td style="border: none">
                                        
                                    </td>
                                </tr>
                                 <tr>
                                     <td colspan="8" id="tdExams" runat="server"></td>
                                 </tr>
                                <tr >
                                    <td colspan="8" style="width: 100%; border: none; line-height: 25px;">
                                   
                                        
                                        <table style="width: 100%; font-size: 16px; border: none">
                                            <tr>
                                                <td style="width: 25%; border: none" colspan="4">
                                                    <div style="height: 3px"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100%; border: none" colspan="4">Place : 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 5%; border: none;">Date : </td>
                                                <td style="border: none; border-bottom: dotted 1px black; width: 5%"></td>
                                                <td style="border: none; width: 70%; float: right">.</td>
                                                <td style="border: none; width: 10%; float: right">&nbsp;&nbsp</td>
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