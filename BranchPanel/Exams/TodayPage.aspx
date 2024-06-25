<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TodayPage.aspx.cs" Inherits="Demo.TodayPage" %>

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
    <form id="form1" runat="server">
      <div style="width: 900px">
            <div class="Main">
                <div class="leftSide">
                    <asp:Image ID="logo" runat="server" CssClass="schoollogo" ImageUrl="~/Images/schoollogo.png" />
                </div>
                <div class="rightSide">
                    <h1 style="margin:0">Brilliant Public Campus School</h1>
                    <h3 style="margin:0">Harduaganj Thermal Power Station Kasimpur</h3>
                    <h3 style="margin:0">Phone No:0571-2482316,Pin:202002,Affiliation No:16852/2014-2015</h3>
                   <div style="border-bottom: solid 2px black; width: 87%; margin-left: 55px;"></div>
                    <br/>
                    <h2 style="margin:0">Academic Session:2017-18</h2>
                    <h2 style="margin:0">Report card For VI-VIII</h2>
                </div>
            </div>
          
               <div style="text-align:justify; margin-left:50px">
                <asp:Label ID="lblrollno" runat="server" Text="Roll No:"></asp:Label><br/>
                   <asp:Label ID="Label1" runat="server" Text="Student's Name:"></asp:Label><br/>
                   <asp:Label ID="Label2" runat="server" Text="Mother's/father's/Guardian's Name:"></asp:Label><br/>
                   <asp:Label ID="Label3" runat="server" Text="Date Of Birth:"></asp:Label><br/>
                   <asp:Label ID="Label4" runat="server" Text="Class/Section:"></asp:Label>
                   <asp:GridView ID="GridView1" runat="server">
                       <Columns>
                        <asp:TemplateField HeaderText="Sub Name">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("SubName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                           <%-- <asp:TemplateField HeaderText="Per Test">
                            <ItemTemplate>
                                 <asp:Label ID="lblpertst" runat="server" Text='<%# Eval("PerTest_10") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Note Book">
                            <ItemTemplate>
                                 <asp:Label ID="lblnotebok" runat="server" Text='<%# Eval("NoteBook_5") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sub Enchrichment">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("SubEnrichment_5") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Half Yearly Exam">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("HalfyearlyExam_5") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Marks Obtained">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("MarksObtained_100") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gr">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("Gr") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Per Test">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("PPerTest_10") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Note Book">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("NNoteBook_5") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sub Enrichment">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("SSubEnrichment_5") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Yearly Exam">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("yearlyExam_5") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Marks Obtained">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("MMarksObtained_100") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gr">
                            <ItemTemplate>
                                 <asp:Label ID="lblsubname" runat="server" Text='<%# Eval("GGr") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                       </Columns>
 
                   </asp:GridView>







                    <asp:Label ID="Label5" runat="server" Text="Class Teacher's Remarks................."></asp:Label><br/>
                    <asp:Label ID="Label6" runat="server" Text="Promoted to Class................."></asp:Label><br/>
                   <br/>
                   <br/>
                   <asp:Label ID="Label7" runat="server" Text="Place:"></asp:Label>
                   <asp:Label ID="Label9" runat="server" Text="Signature Of" Style="margin-left:200px;"></asp:Label>
                   <asp:Label ID="Label10" runat="server" Text="Signature Of" Style="margin-left:317px;"></asp:Label><br/>
                   <asp:Label ID="Label8" runat="server" Text="Date........."></asp:Label>
                   <asp:Label ID="Label11" runat="server" Text="Class Teacher" Style="margin-left:171px;"></asp:Label>
                   <asp:Label ID="Label12" runat="server" Text="Principal" Style="margin-left:307px;"></asp:Label>
                   <div style="border-bottom: solid 2px black; width: 90%; margin-left: 0px;"></div>
                    <div class="rightSide">
                   <h3 style="margin:0">Instructions</h3>
                        </div>
                   <br/>
                  <p> <h4 style="margin:0">Grading scale for scholastic areas:</h4>Grades are awarded on a 8-point grading scale as follows-</p>
                    
                 <table style="width:100%">
  <tr>
    <th>MARKS RANGE</th>
    <th>GRADE</th> 
    
  </tr>
  <tr>
    <td>91-100</td>
    <td>A1</td>
    
  </tr>
  <tr>
    <td>81-90</td>
    <td>A2</td>
    
  </tr>
  <tr>
    <td>71-80</td>
    <td>B1</td>
    
  </tr>
   <tr>
    <td>61-70</td>
    <td>B2</td>
    
  </tr>

 <tr>
    <td>51-60</td>
    <td>C1</td>
    
  </tr>

 <tr>
    <td>41-50</td>
    <td>C2</td>
    
  </tr>

 <tr>
    <td>33-40</td>
    <td>D</td>
    
  </tr>
    <tr>
    <td>32 & Below</td>
    <td>E(Needs improvement)</td>
    
  </tr>


</table>

          </div>
        </div> 
    </form>
</body>
</html>
