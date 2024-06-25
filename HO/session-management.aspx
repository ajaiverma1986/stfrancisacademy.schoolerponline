<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="session-management.aspx.cs" Inherits="HO_session_management" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Session Management</h2>
            <asp:Button runat="server" ID="Button1" CssClass="button_save" Text="Add Session"
                ToolTip="Click here to add more session." Style="float: right; margin-top: 5px; margin-right: 3px" />
        </div>
        <div style="width: 100%; display: none" class="divsession">
            <div class="for_sigle_row_form">
                <label>Start Year</label>
                <asp:TextBox ID="txtstartyear" runat="server" placeholder="Enter Session Start Year"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>End Year</label>
                <asp:TextBox ID="txtendyear" runat="server" placeholder="End Year" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>Session Name</label>
                <asp:TextBox ID="txtsessionname" runat="server" placeholder="Session Name" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>Start Month</label>
                <asp:TextBox ID="txtstartmonth" runat="server" placeholder="Start Month" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>End Month</label>
                <asp:TextBox ID="txtendmonth" runat="server" placeholder="End Month" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>Start Date</label>
                <asp:TextBox ID="txtstartdate" runat="server" placeholder="Start Date" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>End Date</label>
                <asp:TextBox ID="txtenddate" runat="server" placeholder="End Date" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>Submit/Back</label>
                <asp:Button ID="btnforsubmit" runat="server" Text="Submit" CssClass="button_save" />
                <asp:Button ID="btnforback" runat="server" Text="Back" CssClass="button_cancel" />
            </div>
        </div>
        <div style="width: 100%" class="divlist">
            <table class="stm" style="width: 100%">
                <tr class="stm_head">
                    <td>S.NO.</td>
                    <td>Session</td>
                    <td>Start Year</td>
                    <td>End Year</td>
                    <td>Start Month</td>
                    <td>End Month</td>
                    <td>Start Date</td>
                    <td>End Date</td>
                    <td>Status</td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            BindGrid();
            $('input[type="text"][id*="txtstartyear"]').on('change', function () {
                if (parseInt($(this).val()) >= 1990 && parseInt($(this).val()) <= 9998) {
                    var StartingYear = $.trim($('#ctl00_ContentPlaceHolder1_txtstartyear').val());
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "session-management.aspx/BindData",
                        data: "{'StartYear':'" + StartingYear + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d.length > 14) {
                                var xmlDocGeneralDetails = $.parseXML(data.d);
                                var xmlGeneralDetails = $(xmlDocGeneralDetails);
                                var TableGeneralDetails = xmlGeneralDetails.find("Table");
                                TableGeneralDetails.each(function () {
                                    var CurrentDeailsRow = $(this);
                                    $('#ctl00_ContentPlaceHolder1_txtendyear').val(CurrentDeailsRow.find("EndYear").text());
                                    $('#ctl00_ContentPlaceHolder1_txtsessionname').val(CurrentDeailsRow.find("FyName").text());
                                    $('#ctl00_ContentPlaceHolder1_txtstartmonth').val(CurrentDeailsRow.find("StartMonth").text());
                                    $('#ctl00_ContentPlaceHolder1_txtendmonth').val(CurrentDeailsRow.find("EndMonth").text());
                                    $('#ctl00_ContentPlaceHolder1_txtstartdate').val(CurrentDeailsRow.find("StartDate").text());
                                    $('#ctl00_ContentPlaceHolder1_txtenddate').val(CurrentDeailsRow.find("EndDate").text());
                                });
                            }
                            else {
                                alertify.error('Already Exists The Entered Year.');
                                $('#ctl00_ContentPlaceHolder1_txtstartyear').val('');
                                $('#ctl00_ContentPlaceHolder1_txtendyear').val('');
                                $('#ctl00_ContentPlaceHolder1_txtsessionname').val('');
                                $('#ctl00_ContentPlaceHolder1_txtstartmonth').val('');
                                $('#ctl00_ContentPlaceHolder1_txtendmonth').val('');
                                $('#ctl00_ContentPlaceHolder1_txtstartdate').val('');
                                $('#ctl00_ContentPlaceHolder1_txtenddate').val('');
                                $('#ctl00_ContentPlaceHolder1_txtstartyear').focus();
                            }
                        }
                    });
                }
                else {
                    alertify.error('Enter Valid Year Please.(i.e Year Must Be Between 1990 To 9998)');
                    $('#ctl00_ContentPlaceHolder1_txtstartyear').val('');
                    $('#ctl00_ContentPlaceHolder1_txtendyear').val('');
                    $('#ctl00_ContentPlaceHolder1_txtsessionname').val('');
                    $('#ctl00_ContentPlaceHolder1_txtstartmonth').val('');
                    $('#ctl00_ContentPlaceHolder1_txtendmonth').val('');
                    $('#ctl00_ContentPlaceHolder1_txtstartdate').val('');
                    $('#ctl00_ContentPlaceHolder1_txtenddate').val('');
                    $('#ctl00_ContentPlaceHolder1_txtstartyear').focus();
                }
            });
            $('#ctl00_ContentPlaceHolder1_btnforback').click(function () {
                $('.divsession').css("display", "none");
                $('.divlist').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_txtstartyear').val('');
                $('#ctl00_ContentPlaceHolder1_txtendyear').val('');
                $('#ctl00_ContentPlaceHolder1_txtsessionname').val('');
                $('#ctl00_ContentPlaceHolder1_txtstartmonth').val('');
                $('#ctl00_ContentPlaceHolder1_txtendmonth').val('');
                $('#ctl00_ContentPlaceHolder1_txtstartdate').val('');
                $('#ctl00_ContentPlaceHolder1_txtenddate').val('');
                $('#ctl00_ContentPlaceHolder1_txtstartyear').focus();
                $('.tbl-top-heading').find('h2').html('Session List');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_Button1').click(function () {
                $('.divsession').css("display", "block");
                $('.divlist').css("display", "none");
                $('.tbl-top-heading').find('h2').html('Add Session');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnforsubmit').click(function () {
                var ConfirmSubmit = confirm('Are you sure you want to submit.?');
                if (ConfirmSubmit == true) {
                    if ($('#ctl00_ContentPlaceHolder1_txtstartyear').val() != '') {
                        var StartingYear = $.trim($('#ctl00_ContentPlaceHolder1_txtstartyear').val());
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "session-management.aspx/SaveData",
                            data: "{'StartYear':'" + StartingYear + "'}",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                alertify.success(data.d);
                                BindGrid();
                            }
                        });
                    }
                    else {
                        alertify.error('Enter Start Year Please.');
                    }
                }
                $('#ctl00_ContentPlaceHolder1_txtstartyear').val('');
                $('#ctl00_ContentPlaceHolder1_txtendyear').val('');
                $('#ctl00_ContentPlaceHolder1_txtsessionname').val('');
                $('#ctl00_ContentPlaceHolder1_txtstartmonth').val('');
                $('#ctl00_ContentPlaceHolder1_txtendmonth').val('');
                $('#ctl00_ContentPlaceHolder1_txtstartdate').val('');
                $('#ctl00_ContentPlaceHolder1_txtenddate').val('');
                $('#ctl00_ContentPlaceHolder1_txtstartyear').focus();
                $('.tbl-top-heading').find('h2').html('Session List');
                return false;
            });
        });
        function BindGrid() {
            var trforappend = '';
            $('.stm').find('tr:gt(0)').remove();
            $('.divsession').css("display", "none");
            $('.divlist').css("display", "block");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "session-management.aspx/BindGrid",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        var trforappend = '';
                        var xmlDocGeneralDetails = $.parseXML(data.d);
                        var xmlGeneralDetails = $(xmlDocGeneralDetails);
                        var TableGeneralDetails = xmlGeneralDetails.find("Table");
                        TableGeneralDetails.each(function () {
                            var CurrentDeailsRow = $(this);
                            trforappend = trforappend + '<tr>' +
                                '<td>' + CurrentDeailsRow.find("RowNumber").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("FyName").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("StartingYear").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("EndYear").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("StartingMonth").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("EndMonth").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("StartDate").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("EndDate").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("Status").text() + '</td>' +
                                '</tr>';
                        });
                        $('.stm').append(trforappend);
                    }
                }
            });
        }
    </script>
</asp:Content>