<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reportcard_term.aspx.cs" Inherits="EmployeePanel_reportcard_term" %>
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
        <asp:GridView ID="grdSTDResult" runat="server" EmptyDataText="No data found !" BorderStyle="None" GridLines="None" style="border:none;" OnRowCreated="OnRowCreated"
            AutoGenerateColumns="false" Width="100%" OnRowDataBound="grdSTDResult_RowDataBound">
            <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle CssClass="HiddenCol" />
                    <ItemTemplate>
                        <asp:HiddenField ID="dfrollno" runat="server" Value='<% #Bind("rollno")%>'></asp:HiddenField>
                        <asp:HiddenField ID="dfregno" runat="server" Value='<% #Bind("regno")%>'></asp:HiddenField>
                        <div style="width: 830px; height: 1080px; border: solid 2px black; padding: 10px 10px 10px 10px;">
                            <table style="width: 100%; text-align: center; border: none; margin-top: 2px;">
                               
                                <tr>
                                    <td style="text-align: left; border: none;width:86%" colspan="1">
                                         <asp:Image ID="Image1" runat="server" CssClass="schoollogo" Height="170px" Width="100%" ImageUrl="~/BranchPanel/images/schImage.jpg" />
                                    </td>
                                    <td style="text-align: center; border: none;width:1%" colspan="1">                                     

                                        
                                          <!--  <h1 style="margin: 0"><span id="SpScool" runat="server"></span></h1>
                                            <h3 style="margin: 0; font-size: 14px"><span id="SAddress" runat="server"></span></h3>
                                            <h3 style="margin: 0; font-size: 14px"><span id="SSAddress" runat="server"></span></h3>--!>
                                            <h3 style="margin: 0; font-size: 14px"><span id="affhead" runat="server">Affiliation No:</span><span id="SchoolAffia" runat="server"></span><br />
                                                <span id="SWebsite" runat="server" style="display:none"></span><br />
                                                
                                                
                                                
                                            </h3>
                                           
                                        
                                    </td>
                                    <td style="text-align: right; border: none;width:14%" colspan="0">
                                        <asp:Image ID="Image2" runat="server" CssClass="schoollogo" Height="130px" Width="120px" ImageUrl="~/images/9update.png" /><br/>
										<span style="float:right"><b>School Code: BI040</b></span>
                                    </td>
								
                                </tr>
								<!--<tr>
								<td colspan="3" style="text-align: left; border: none;font-weight:bold">
								<span id="SMobile" runat="server" style="display:none"></span><span id="SpFone" runat="server" style="display:none"></span>
                                               <span style="float:left"> Email:<span id="SEmailID" runat="server" ></span></span> 
								</td>
								</tr>--!>
                                <tr>
                                   <!-- <td colspan="3" style="border:none!important">
                                         <div style="border-bottom: solid 2px black; width: 100%; font-size: 14px; height: 5px"></div><br/>
                                        <div style="text-align:center;font-size:16px;font-weight:bold">REPORT CARD</div>
										
                                    </td>--!>
									<td style="text-align: left; border: none;width:100%" colspan="3">
                                         <asp:Image ID="Image3" runat="server" CssClass="schoollogo" Height="45px" Width="100%" ImageUrl="~/BranchPanel/images/report.jpg" />
                                    </td>
									
                                </tr>
                                
                                
                            </table>
                            
                            <table style="width: 100%; border: none;margin-bottom:8px;font-weight:bold;font-size:14px;">
                                <tr style="background-color: #3f9306;height: 25px;">
                                    <td style="border: none; width: 5%; text-align:right">Name:</td>
                                    <td style="border: none; font-weight: 770;width: 17%;"><span id="SpName" runat="server">Ist</span></td>
                                    <td style="border: none; width: 8%;text-align:right">Adm ID:</td>
                                    <td style="border: none; width: 8%"><span id="RollNo" runat="server"><asp:Label runat="server" Text='<%#Eval("rollno")%>'></asp:Label></span></td>
                                    <td style="border: none; width: 10%;text-align:right ">Class&nbsp;</td>
                                    <td style="border: none; width: 12%"><span id="classID" runat="server">Ist</span></td>
                                    <td style="border: none; width: 12%;text-align:left">Section&nbsp; <span id="sectionID" runat="server">A</span> </td>
                                    <td style="border: none; width: 11%">Session 2022-23</td>
                                     
                                    
                                </tr></table>
                            <table style="border: none;width:100%;font-weight:bold;font-size:14px;">
                                            <tr style="background-color: #ff6600;height: 25px;">
                                                <td style="border: none; width:5%;text-align:right">&nbsp;&nbsp;DOB:</td>
                                                <td style="border: none; width:11%;"><span id="DOB" runat="server" style="float: right">15/07/2017</span></td>
                                     <td style="border: none; width: 22%; text-align:right">Mother's Name:</td>
                                                <td style="border: none;width: 18%; text-align:left"><span id="SpMName" runat="server">A</span></td>
                                     <td style="border: none; width: 25%; text-align:right">Father’s Name:  </td>
                                                <td style="border: none;text-align:left"><span id="SpFName" runat="server">123456</span></td>
                                            </tr>
                                        </table>
                            <table style="width: 100%; border: none">
                                
                               
                                <tr>
                                    <td colspan="8" style="width: 100%; border: none; line-height: 20px;">
                                        <br />
                                        <table style="width: 100%; font-size: 14px;font-weight:bold;">
                                            <tr>
                                                <td style="width: 23%"><b>Subjects</b></td>
                                                <td style="width: 38.5%; text-align: center"><b><span id="SpTerm" runat="server">First Term </span></b></td>
                                              <!-- <td style="width: 39%; text-align: center"><b>Second Term </b></td>--!>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                   <td colspan="8" style="width: 100%; border: none;font-size:12px;">
                                        <asp:PlaceHolder ID="placeholder" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="8" style="width: 100%; border: none; line-height: 25px;">
                                       
                                       
                                        
                                        
                                        <table style="width: 100%; font-size: 16px; border: none;text-align:left">
                                            <tr>
                                                <td style="width: 100%; border: none; ">
                                                 <h3> <u>  Grades: </u></h3>
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td style="width: 100%; border: none">
                                                 <b> &nbsp; A - Very Good (80 & above) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B - Good (65-79.9)&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C - Satisfactory( 50-64.9)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D  - Fair(40-49.9)</b>
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="border: none;">
                                                    <div style="height: 10px"></div>
                                                </td>
                                            </tr>
                                                                         

                                        </table>
                                        
                                      
                                        <table style="width: 100%; font-size: 16px; border: none">
                                            <tr>
                                                <td style="width: 25%; border: none" colspan="1">
                                                    <asp:TextBox TextMode="MultiLine" Columns="22" style="border-width: 2px;border-color: black;" Height="105px" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="width: 25%; border: none" colspan="1">
                                                    <asp:TextBox TextMode="MultiLine" Columns="22" Height="105px" runat="server" style="border-width: 2px;border-color: black;"></asp:TextBox>
                                                </td>
                                                <td style="width: 25%; border: none" colspan="1">
                                                    <asp:TextBox TextMode="MultiLine" Columns="22" Height="105px" runat="server" style="border-width: 2px;border-color: black;"></asp:TextBox>
                                                </td>
                                                <td style="width: 25%; border: none" colspan="1">
                                                    <asp:TextBox TextMode="MultiLine" Columns="22" Height="105px" runat="server" style="border-width: 2px;border-color: black;"></asp:TextBox>
                                                </td>
                                            </tr>
                                            
                                        </table>
										
                                        <table style="width: 100%; font-size: 16px;border:2px solid">
                                            <tr>
                                                <td style="width: 25%; border: none;text-align:center" colspan="1" >
                                                  <center><b>  Seal</b></center>
                                                </td>
                                                <td style="width: 25%; border: none;text-align:center" colspan="1">
                                                    <b> Class Teacher's Signature <b>
                                                </td>
                                                <td style="width: 25%; border: none;text-align:center" colspan="1">
                                                     <b>Parent's Signature <b>
                                                </td>
                                                <td style="width: 25%; border: none;text-align:center" colspan="1">
                                                   <b>  Principal <b>
                                                </td>
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
