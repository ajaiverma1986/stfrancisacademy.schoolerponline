<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="AssignmentMaster.aspx.cs" Inherits="BranchPanel_AttendanceManagement_AssignmentMaster" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Take/Update Assignment</h2>
                <div style="float: right; padding: 5px 15px 0 0;">
                    <asp:Button ID="Button1" runat="server" Text="Add New " CssClass="button_save"
                        ToolTip="Click here to upload the assignment." OnClick="Button1_Click" />
                </div>

            </div>
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        Assignment Information
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Class For Assignment<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlapplyingforclass" runat="server" OnSelectedIndexChanged="ddlapplyingforclass_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Section  For Assignment<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlsection" runat="server">
                            <asp:ListItem Value="0">--Select  Section--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Date<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtdateforattendance" runat="server" placeholder="Select Date Please"></asp:TextBox>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <label>
                            Assignment Topic<span style="color: Red">*</span>
                        </label>
                        <asp:TextBox ID="txttopic" runat="server" Width="200px"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Assign By<span style="color: Red">*</span>
                        </label>
                        <asp:TextBox ID="txtassign" runat="server" Width="200px"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form" style="position: relative;">
                        <label>
                              <asp:HiddenField ID="hdfFIle" runat="server" Value='<%# Bind("assignid") %>' />
                            Upload Result<span style="color: Red">*</span></label>
                        <asp:FileUpload runat="server" ID="fu1" />&nbsp;
                <div class="df0" style="left: 480px;">
                </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                        </label>
                        <asp:Button ID="btnSend" runat="server" Text="Upload " CssClass="button_save"
                            ToolTip="Click here to upload the assignment." OnClick="btnSend_Click" />
                    </div>
                    <div class="sub-heading">
                        Assignment List
                    </div>
                    <div class="ClassForAttendance">
                        <asp:GridView ID="GrdAttendence" AutoGenerateColumns="false" Width="98%" BorderWidth="0" OnRowCommand="GrdAttendence_RowCommand"
                            OnRowDeleting="GrdAttendence_RowDeleting" runat="server" CssClass="stm0" GridLines="None">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="8%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Class Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblrollno" runat="server" Text='<%# Bind("branchName") %>'></asp:Label>
                                        <%-- <asp:HiddenField ID="HD2" runat="server" Value='<%# Bind("admiid") %>' />--%>
                                    </ItemTemplate>
                                    <ItemStyle Width="8%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Section Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%# Bind("sectionName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="8%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Assign Topic" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltopic" runat="server" Text='<%# Bind("topicname") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Assign By" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltopic11" runat="server" Text='<%# Bind("assignby") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Assign Date" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltopic111" runat="server" Text='<%# Bind("uploadon","{0:MMM dd yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="12%" />
                                </asp:TemplateField>
                               <asp:TemplateField HeaderText="Edit" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("assignid") %>' />
                                        <%-- <asp:Label ID="lbltopic"  runat="server" Text='<%# Bind("document") %>' Style="display:none"></asp:Label>--%>
                                        <asp:ImageButton ID="ImageButton4" runat="Server" CommandArgument='<%# Bind("assignid") %>' Width="20px" CommandName="Edit" ImageUrl="~/images/edit.png"></asp:ImageButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="12%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Upload File" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("assignid") %>' />
                                        <%-- <asp:Label ID="lbltopic"  runat="server" Text='<%# Bind("document") %>' Style="display:none"></asp:Label>--%>
                                        <asp:ImageButton ID="ImageButton3" runat="Server" CommandArgument='<%# Bind("assignid") %>' Width="20px" CommandName="Delete" ImageUrl="~/images/delete.png"></asp:ImageButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="12%" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="left" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                        </asp:GridView>
                    </div>
                    <div class="for_sigle_row_form" style="margin-bottom: 10px; display: none" id="divforsubmit">
                        <label>
                        </label>
                        <asp:Button ID="btnforsubmit" runat="server" Text="SUBMIT" CssClass="button_save" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var year = 2020;
        var AdmissionNo = '', AttendanceStatus = '', SturegNo = '';
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_txtdateforattendance").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            }).datepicker("setDate", new Date());

            //$('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').change(function () {
            //    $('#ctl00_ContentPlaceHolder1_ddlsection').html('');
            //    $.ajax({
            //        type: 'POST',
            //        contentType: "application/json; charset=utf-8",
            //        url: "AssignmentMaster.aspx/BindSectionDDL",
            //        data: "{'Classid':'" + $(this).val() + "'}",
            //        dataType: "json",
            //        success: function (data) {
            //            $('#ctl00_ContentPlaceHolder1_ddlsection').html('<option value="0">--Select Section--</option>');
            //            if (data.d.length > 0) {
            //                for (var i = 0; i < data.d.length; i++) {
            //                    $('#ctl00_ContentPlaceHolder1_ddlsection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
            //                }
            //            }
            //        }
            //    });
            //});
            //$('#ctl00_ContentPlaceHolder1_btnforsubmit').click(function () {
            //    $('.tblforattendance').find('tbody').find('tr:gt(0)').each(function () {
            //        AdmissionNo = AdmissionNo + ',' + $(this).find('td:eq(1)').html();
            //        SturegNo = SturegNo + ',' + $(this).find('td:eq(2)').find('input[type="checkbox"]').val();
            //        if ($(this).find('td:eq(2)').find('input[type="checkbox"]').prop('checked') == true) {
            //            AttendanceStatus = AttendanceStatus + ',' + '0';
            //        }
            //        else {
            //            AttendanceStatus = AttendanceStatus + ',' + '1';
            //        } 
            //    });
            //    AdmissionNo = AdmissionNo.slice(1, AdmissionNo.length);
            //    SturegNo = SturegNo.slice(1, SturegNo.length);
            //    AttendanceStatus = AttendanceStatus.slice(1, AttendanceStatus.length);
            //    $.ajax({
            //        type: 'POST',
            //        contentType: "application/json; charset=utf-8",
            //        url: "take-student-assign.aspx/TakeAttendance",
            //        data: "{'AdmissionNo':'" + AdmissionNo + "','SturegNo':'" + SturegNo + "','AttendanceStatus':'" + AttendanceStatus + "','Date':'" + $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() + "'}",
            //        dataType: "json",
            //        success: function (data) {
            //            if (data.d == '1') {
            //                alertify.success('Attendance Taken Successfully.');
            //            }
            //            if (data.d == '0') {
            //                alertify.success('Some Error While Taking Attendance.');
            //            }
            //            AdmissionNo = '', SturegNo = '', AttendanceStatus = '';
            //            return false;
            //        }
            //    });
            //    return false;
            //});
            //$('#ctl00_ContentPlaceHolder1_ddlsection,#ctl00_ContentPlaceHolder1_txtdateforattendance').change(function () {
            //    TakeAttendanceDefault();
            //});

            //$('.chkforabsent').live('change', function () {
            //    if ($(this).prop('checked') == true) {
            //        $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'red');
            //        $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', 'cursive');
            //    }
            //    else {
            //        $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'black');
            //        $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', '"Helvetica Neue",Helvetica,Arial,sans-serif');
            //    }
            //});

        });
        $('.detailimage').click(function () {
            file = $(this).parent('td').parent('tr').find('td:eq(6)').find('input[type=hidden]').val();

            if (file != "") {
                var url = 'http://schoolerponline.in/Branchpanel/';
                //var url = 'http://localhost:17673/currentcode/Branchpanel/';
                window.open(url + file);
            }
            else {
                alert("There is no file to view.");
            }
            return false;
        });

        //function TakeAttendanceDefault() {
        //    if ($('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() == '0') {
        //        alertify.error('Select Class Please.');
        //    }
        //    else if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() == '0') {
        //        alertify.error('Select Section Please.');
        //    }
        //    else if ($('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() == '') {
        //        alertify.error('Select Date Please.');
        //    }
        //    else {
        //        BindAttendanceGrid();
        //    }
        //    return false;
        //}
        //function BindAttendanceGrid() {
        //    $('#divforsubmit').css("display", "none");
        //    var trforappend = '', trclass = '', tdclass = '';
        //    $.ajax({
        //        type: 'POST',
        //        contentType: "application/json; charset=utf-8",
        //        url: "take-student-assign.aspx/BindAttendanceGrid",
        //        data: "{'Classid':'" + $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() + "','SectionId':'" + $('#ctl00_ContentPlaceHolder1_ddlsection').val() + "','Date':'" + $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() + "'}",
        //        dataType: "json",
        //        success: function (data) {
        //            $('.tblforattendance').find('tbody').find('tr:gt(0)').remove();
        //            if (data.d.length > 0) {
        //                $('#divforsubmit').css("display", "block");
        //                for (var i = 0; i < data.d.length; i++) {
        //                    if (i % 2 == 0) {
        //                        trclass = 'stm_dark'
        //                    }
        //                    else {
        //                        trclass = 'stm_light'
        //                    }
        //                    if (data.d[i].CHECKBOXSTATUS != '') {
        //                        tdclass = 'style="color:red;font-family:cursive"'
        //                    }
        //                    else {
        //                        tdclass = '';
        //                    }
        //                    trforappend = trforappend + '<tr class="' + trclass + '">' +
        //                        '<td>' + data.d[i].ROWNUMBER + '</td>' +
        //                        '<td>' + data.d[i].ADMISSIONNO + '</td>' +
        //                        '<td><input type="checkbox" value="' + data.d[i].STUREGNO + '" ' + data.d[i].CHECKBOXSTATUS + ' class="chkforabsent" /></td>' +
        //                        '<td ' + tdclass + '>' + data.d[i].NAME + '</td>' +
        //                        '<td>' + data.d[i].ATTENDANCESTATUS + '</td>' +
        //                        '</tr>'
        //                }
        //            }
        //            else {
        //                trforappend = '<tr>' +
        //                        '<td></td>' +
        //                        '<td></td>' +
        //                        '<td>No Student List Found.</td>' +
        //                        '<td</td>' +
        //                        '<td></td>' +
        //                        '</tr>'
        //            }
        //            $('.tblforattendance').append(trforappend);
        //            trforappend = '', trclass = '';
        //        }
        //    });
        //}
    </script>
</asp:Content>

