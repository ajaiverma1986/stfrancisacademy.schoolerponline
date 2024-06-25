<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/StudentPanel/student-panel-master.master" EnableEventValidation="false"
    CodeFile="student-performance.aspx.cs" Inherits="BranchPanel_StudentPanel_student_performance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="FusionCharts/FusionCharts.js"></script>
    <link href="../../js/1.8-themes-base-jquery-ui.css" rel="stylesheet" />
    <link href="css/exam.css" rel="stylesheet" />
    <style type="text/css">
       
          
       .performanceactive {
             margin: 0px -3px;
            background-color: #2aa9eb;
           
         
        }


        .side-bar-wrapper .side-menu > li .performanceactive i {
             border-right: 1px solid #2cd7fb;
                -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
                box-shadow: 1px 0px 0px 0px #1d93d0;
        }


        .stm a, .stm2 a, input[type="submit"], img {
            border: medium none;
            cursor: pointer !important;
            background-color: #fff;
        }
    </style>

    <div id="studentperformance" >
        <div class="content-wrapper">
            <div class="content-inner">
               
                 
                    <div class="page-header">
                       
                        <h1>
                            <i class="fa fa-line-chart" style="color: white"></i>
                              Performance 
                        </h1>
                    </div>
                    <div class="clearfix"></div>
                 <div class="main-content" style="width: 100%;">
                    <asp:Label ID="lblmsg" runat="server" ForeColor="red" Font-Size="16px" ></asp:Label>

                    <div id="DivForGrid" runat="server" class="student-panel-tbl">
                    
                        <asp:GridView runat="server" ID="GridView2" OnRowCommand="GridView2_RowCommand"
                            AutoGenerateColumns="false" Width="100%" CssClass="stm">
                            <Columns>
                                <asp:TemplateField HeaderText="Select Test">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chk" runat="server" />
                                        <asp:HiddenField ID="hd1" runat="server" Value='<%# Bind("tid") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="testdate" HeaderText="Test Date" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Test Name" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Button ID="btntestname" runat="server" ToolTip="Click here To See Graph of Student Performance." CommandArgument='<%# Eval("tid") %>' Text='<%# Bind("testname") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="8%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="marks" HeaderText="Marks" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="per" DataFormatString="{0:f}" HeaderText="Percentage" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center" />
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                        </asp:GridView>
                    </div>
                    <div id="DivDownloadpdf" runat="server" visible="false">

                        <asp:GridView runat="server" ID="GridView3"
                            AutoGenerateColumns="false" Width="100%" CssClass="stm">
                            <Columns>
                                <asp:BoundField DataField="testdate" HeaderText="Test Date" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="testname" HeaderText="Test Name" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="marks" HeaderText="Marks" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="per" DataFormatString="{0:f}" HeaderText="Percentage" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center" />
                            </Columns>
                            <HeaderStyle CssClass="grdHeader" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                        </asp:GridView>
                    </div>

                    <div id="Div1" runat="server" style="overflow-y: hidden; width: 1000px; height: 400px; margin-left: 100px;">
                        <asp:Literal ID="FCLiteral1" runat="server"></asp:Literal>
                    </div>
                    <br />
                    <br />
                    <div id="DivMailContnt" class="DivMailContnt" runat="server">
                        <asp:GridView ID="GridView1" AutoGenerateColumns="false" Width="98% " BorderWidth="0"
                            runat="server" CssClass="stm0" GridLines="None" Style="margin-left: 10px; border: 1px solid rgb(204, 204, 204);">
                            <Columns>
                                <asp:TemplateField HeaderText="Select Test">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chktestid" runat="server" />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldate" runat="server" Text='<%# Bind("testdate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                        <asp:HiddenField ID="hd1" runat="server" Value='<%# Bind("tid") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="30%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rank">
                                    <ItemTemplate>
                                        <asp:Label ID="lblrank" runat="server" Text='<%# Bind("sturank") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Exam">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsub" runat="server" Text='<%# Bind("testname") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="30%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Marks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsubject2" runat="server" Text='<%# Bind("marks","{0:f}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Percentage">
                                    <ItemTemplate>
                                        <asp:Label ID="lblper" runat="server" Text='<%# Bind("per","{0:f}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                        </asp:GridView>
                    </div>
                    <div class="for_sigle_row_form">
                        <label></label>
                        <asp:Button ID="btnsendmail" CssClass="button_save" runat="server" Text="Send Mail" OnClick="btnsendmail_Click" />
                        <asp:Button ID="btnsetgraph" CssClass="button_save" runat="server" Text="Show Graph" OnClick="btnsetgraph_Click"
                            ToolTip="CLick Here To Set Graph According To Selected Test." />
                        <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button_save" OnClick="btnback_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>