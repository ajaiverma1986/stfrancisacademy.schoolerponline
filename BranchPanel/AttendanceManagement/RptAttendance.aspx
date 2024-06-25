<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="RptAttendance.aspx.cs" Inherits="BranchPanel_AttendanceManagement_RptAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .tr {
            font-size: 16px;
            color: green;
            border-bottom: 1px double;
        }

        .td {
            font-size: 16px;
            height: 40px;
            color: green;
            border-bottom: 1px double;
            text-align: center;
        }
    </style>    

     <script type="text/javascript">
         $(document).ready(function () {
             $("#ctl00_ContentPlaceHolder1_Calendar2").hide();
             $("#ctl00_ContentPlaceHolder1_txtattendancedate").click(function () {
                 $("#ctl00_ContentPlaceHolder1_Calendar2").show();
             });
         });
        </script>
    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Student Date Wise Attendance </h2>            
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="button_save" PostBackUrl="~/BranchPanel/SectionAdd.aspx" Style="float: right; margin-top: 5px; margin-right: 3px">Back</asp:LinkButton>            
        </div>
    </div>
    <div class="for_sigle_row_form">
        <asp:TextBox ID="txtattendancedate" runat="server" Placeholder="From Date" Style="width: 150px !important;"></asp:TextBox>
        <asp:Calendar ID="Calendar2" runat="server" BorderWidth="2px" BackColor="white" Width="200px"
                            ForeColor="Black" Height="180px" Font-Size="8pt" Font-Names="Verdana" BorderColor="#E4DA85"
                            BorderStyle="Outset" DayNameFormat="FirstLetter" CellPadding="4" OnSelectionChanged="Calendar2_SelectionChanged">
                            <TodayDayStyle ForeColor="Black" BackColor="#E9E19A"></TodayDayStyle>
                            <DayHeaderStyle Font-Size="7pt" Font-Bold="True" BackColor="#E9E19A"></DayHeaderStyle>
                            <SelectedDayStyle Font-Bold="True" ForeColor="White" BackColor="#D5D900"></SelectedDayStyle>
                        </asp:Calendar>
    </div>
    <br />
    <div>
        <asp:Panel ID="Panel1" runat="server"></asp:Panel>
    </div>
</asp:Content>

