<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="load-attendance-excel-sheet.aspx.cs" Inherits="BranchPanel_load_attendance_excel_sheet" %>

<%@ Register Src="~/BranchPanel/employee/attendance-management.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />

    <script type="text/javascript">

        $(document).ready(function () {
            document.title = 'Upload Attendance Excel sheet';

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
            $("#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy/mm/dd',
                maxDate: new Date()
            });
            $("#ctl00_ContentPlaceHolder1_txtdateofexcelsheet").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy/mm/dd',
                maxDate: new Date()
            });

            $('#ctl00_ContentPlaceHolder1_btnpayamount').click(function () {
                //if ($('#ctl00_ContentPlaceHolder1_txtdateofexcelsheet').val() == "") {
                //    alert('Please Select The Date First');
                //    $('#ctl00_ContentPlaceHolder1_txtdateofexcelsheet').focus();
                //    return false;
                //}
                //if ($('#ctl00_ContentPlaceHolder1_txttodate').val() == "") {
                //    alert('Please Select The Date First');
                //    $('#ctl00_ContentPlaceHolder1_txtdateofexcelsheet').focus();
                //    return false;
                //}
            });
            $('#ctl00_ContentPlaceHolder1_imgtooltip').click(function () {
                alert('You Can Upload Only Excel File.')
            });

        });
    </script>

    <style type="text/css">
        #ctl00_ContentPlaceHolder1_fileuploadExcel {
            border: 1px dotted green;
            width: 312px !important;
            Height: 30px;
        }

        #ui-datepicker-div {
            width: 307px !important;
        }

        .activeuploadexcelsheet {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
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

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li style="background: none;"><a>Attendance Management</a></li>
            <li style="background: none;"><a class="active" href="#">Upload Attendance Excel sheet</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">

        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div id="divgrid" runat="server" style="display: block;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Select From Date</label>
                            <asp:TextBox ID="txtdateofexcelsheet" runat="server" placeholder="Select Date For Upload"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Select To Date</label>
                            <asp:TextBox ID="txttodate" runat="server" placeholder="Select Date For Upload"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Attach Excel File<span style="color: Red">*</span></label>
                            <asp:FileUpload ID="fileuploadExcel" runat="server" />&nbsp;&nbsp;
                            <img src="../../images/questionmark.png" alt="alternative text" title="You Can Upload Only Excel File." id="imgtooltip" runat="server" style="cursor: pointer" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <asp:Button ID="btnuploadorsubmit" runat="server" Text="Upload" OnClick="btnuploadorsubmit_Click" CssClass="button_save" Style="cursor: pointer" />
                        </div>
                    </td>
                </tr>
                <tr id="trmessage" style="display: none">
                    <td>
                        <asp:Label ID="lblmessage" runat="server" Text="There Is No Data In Your Excel Sheet." Style="color: red; font-size: 15px; margin-left: 150px; margin-bottom: 100px !important"></asp:Label>
                    </td>
                </tr>
                <tr id="trgrid" runat="server" style="display: block">
                    <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                        <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                            GridLines="None" Width="1065" CssClass="stm">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center" HeaderText="Card No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblbiometriccardno" runat="server" Text='<%# Eval("EMP_CODE") %>' CssClass="lbltotalworkingdays"></asp:Label>
                                        <asp:Label ID="lblEID" Visible="false" runat="server" Text='<%# Eval("EID") %>' CssClass="lbltotalworkingdays"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center" HeaderText="Employee Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblemployeename" runat="server" Text='<%# Eval("EMP_NAME") %>' CssClass="lbltotalunpaidleave"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="165px" ItemStyle-HorizontalAlign="Center" HeaderText="Attendance Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lbattendancedate" runat="server" Text='<%# Convert.ToDateTime(Eval("ATTANDANCE_DATE")).ToString("dd MMM yyyy") %>' CssClass="lblemployeeworkingdays"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="165px" ItemStyle-HorizontalAlign="Center" HeaderText="Attendance Day">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldayname" runat="server" Text='<%# Eval("ATTANDANCE_DAY") %>' CssClass="lblemployeeworkingdays"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="165px" ItemStyle-HorizontalAlign="Center" HeaderText="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldepartment" runat="server" Text='<%# Eval("DEPART") %>' CssClass="lblemployeeworkingdays"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="165px" ItemStyle-HorizontalAlign="Center" HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblstatus" runat="server" Text='<%# Eval("STATUS") %>' CssClass="lblemployeeworkingdays"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="110px" ItemStyle-HorizontalAlign="Center" HeaderText="In Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblintime" runat="server" Text='<%# Convert.ToDateTime(Eval("IN_TIME")).ToString("hh:mm tt") %>' CssClass="lbltotalpaidleave"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="110px" ItemStyle-HorizontalAlign="Center" HeaderText="Out Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblouttime" runat="server" Text='<%# Convert.ToDateTime(Eval("OUT_TIME")).ToString("hh:mmtt") %>' CssClass="lbltotalpaidleave"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <div class="for_sigle_row_form" style="margin-left: -68px">
                <label>
                    <span style="color: Red"></span>
                </label>
                <asp:Button ID="btnpayamount" Visible="false" runat="server" Text="Submit Attendance" CssClass="button_save" Style="cursor: pointer" OnClick="btnpayamount_Click" />
            </div>
        </div>
    </div>
</asp:Content>