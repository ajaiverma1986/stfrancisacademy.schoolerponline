<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="FeeHeadWiseCollection.aspx.cs" Inherits="BranchPanel_Fee_Management_Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .loader1 {
            position: fixed;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            z-index: 9999;
            background: url('preloading.gif') 50% 50% no-repeat rgb(249,249,249);
            opacity: .8;
        }
        .colWidth{
            width: 22%;
        }
        .TextBoxStyle {
                /*height: auto;*/
                padding: 0;
        }
        #loading {
            position: fixed;
            width: 75%;
            height: 100vh;
            background: url('../../images/PleaseLoader.gif') no-repeat center center;
            z-index: 11;
        }
    </style>
    <script type="text/javascript">
        var year = 2026;
        $(document).ready(function () {
            $('#loading').hide();
            $("#ctl00_ContentPlaceHolder1_btnSubmit").hide();
            $("#ctl00_ContentPlaceHolder1_btnDownload").hide();
            BindUser();
            BindClass();
            BindFeeHead(true);
            $("#chkAll").live('click', function () {
                if ($("#chkAll").is(':checked')) {
                    BindFeeHead(true);
                }
                else {
                    BindFeeHead(false);
                }
            });

            $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").on('change', function () {
                BindClass();
                gotoHome();
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_txtStartDate,#ctl00_ContentPlaceHolder1_txtEndDate").on('change', function () {
                gotoHome();
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_ddlGroup,#ctl00_ContentPlaceHolder1_ddlUser,#ctl00_ContentPlaceHolder1_ddlClass,#ctl00_ContentPlaceHolder1_ddlPaymentType").on('change', function () {
                gotoHome();
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btnDownload").click(function (e) {
                e.preventDefault();
                alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                    if (e) {
                        var fileName = "CollectionbyFeeHead_" + new Date();
                        var element = document.createElement('a');
                        element.setAttribute('href', 'data:application/vnd.ms-excel,' + encodeURIComponent($('#divUsers').html()));
                        element.setAttribute('download', fileName);
                        element.style.display = 'none';
                        document.body.appendChild(element);
                        element.click();
                        document.body.removeChild(element);
                        e.preventDefault();
                    }
                });
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btnSubmit").click(function (e) {
                e.preventDefault();
                var FeeHeadIDs = getFeeHeadIDs();
                $('#divUsers').html('');
                var trforappend = "";
                call_progressbar("start");              
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "FeeHeadWiseCollection.aspx/getFeeHeadCollection",
                    data: "{'FyID':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "','UserID':'" + $('#ctl00_ContentPlaceHolder1_ddlUser').val() + "','GroupID':'" + $('#ctl00_ContentPlaceHolder1_ddlGroup').val() + "','ClassID':'" + $('#ctl00_ContentPlaceHolder1_ddlClass').val() + "','StartDate':'" + $('#ctl00_ContentPlaceHolder1_txtStartDate').val() + "','EndDate':'" + $('#ctl00_ContentPlaceHolder1_txtEndDate').val() + "','FeeHeadID':'" + FeeHeadIDs + "','PaymentType':'" + $('#ctl00_ContentPlaceHolder1_ddlPaymentType').val() + "'}",
                    dataType: "json",
                  //  async: false,
                    success: function (data) {
                        if (data.d != '') {
                            $('#divUsers').html(data.d);
                            $('#ctl00_ContentPlaceHolder1_Div1').hide();
                            $("#ctl00_ContentPlaceHolder1_btnDownload").show();
                            $("#ctl00_ContentPlaceHolder1_btnSubmit").hide();
                        } else {
                            alertify.error("There is record found!");
                            $('#divUsers').html(data.d);
                            $('#ctl00_ContentPlaceHolder1_Div1').show();
                            $("#ctl00_ContentPlaceHolder1_btnDownload").hide();
                            $("#ctl00_ContentPlaceHolder1_btnSubmit").show();
                        }
                        $(".loader1").hide();
                        call_progressbar("end");
                    },
                    error: function (result) {
                        call_progressbar("end");
                        $(".loader1").hide();
                    }
                });
            });
            $("#ctl00_ContentPlaceHolder1_txtEndDate").val($.datepicker.formatDate("dd MM yy", new Date()));
            $("#ctl00_ContentPlaceHolder1_txtStartDate").val($.datepicker.formatDate("dd MM yy", new Date()));
            $("#ctl00_ContentPlaceHolder1_txtStartDate,#ctl00_ContentPlaceHolder1_txtEndDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2019:' + year,
                dateFormat: 'dd MM yy'
            });
        });
        function gotoHome() {
            $('#divUsers').html('');
            $('#ctl00_ContentPlaceHolder1_Div1').show();
            $("#ctl00_ContentPlaceHolder1_btnDownload").hide();
            $("#ctl00_ContentPlaceHolder1_btnSubmit").show();
            BindFeeHead(true);
        }

        function getFeeHeadIDs() {
            var feeHeadIds = '';
            $('.stm').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(1)').find('input[type="checkbox"]').prop('checked') == true) {
                    var feeId = $(this).find('td:eq(0)').find('input[type="hidden"]').val();
                    if (feeHeadIds == '') {
                        feeHeadIds = feeId;
                    } else {
                        feeHeadIds = feeHeadIds + ',' + feeId;
                    }
                }
            });
            return feeHeadIds;
        }

        function BindUser() {
            var trforappend = "";
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "FeeHeadWiseCollection.aspx/BindUser",
                data: "{'UserID':'0'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlUser').html('<option value="0">-- All User --</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlUser').append('<option value="' + data.d[i].UserID + '">' + data.d[i].UserName + '</option>');
                        }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindClass() {
            var trforappend = "";
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "FeeHeadWiseCollection.aspx/BindClass",
                data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlClass').html('<option value="0">-- All Class --</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlClass').append('<option value="' + data.d[i].ClassID + '">' + data.d[i].ClassName + '</option>');
                        }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindFeeHead(isChecked) {
            $('.stm').find('tr:gt(0)').remove();
            var trforappend = "", ClassPaid = "";
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "FeeHeadWiseCollection.aspx/BindFeeHead",
                data: "{'ClassID':'" + $('#ctl00_ContentPlaceHolder1_ddlClass').val() + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_btnSubmit").show();
                    trforappend = '', Checked = '';
                    for (var i = 0; i < data.d.length; i++) {
                        if (isChecked)
                            Checked = 'checked';

                        if (i % 2 == 0)
                            ClassPaid = "stm_dark";
                        else
                            ClassPaid = "stm_light";
                        trforappend = trforappend + '<tr class=' + ClassPaid + '>'
                            + '<td><input type="hidden" value="' + data.d[i].Feeid + '" />' + data.d[i].Feename + '</td>'
                            + '<td><input type="checkbox" undefined="" title="Check Here For Pay Fee Now." ' + Checked + '/></td>'
                            + '</tr>'
                    }
                    $('.stm').append(trforappend);
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function call_progressbar(progtype) {
            if (progtype == "start") {
                $('#loading').show();
            }
            if (progtype == "end") {
                $('#loading').hide();
            }
        }

    </script>
    <div id="loading"></div>

    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="loader1" style="display: none"></div>
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Fee Head Wise Collection</h2>
        </div>
        <br />

        <div class="form-row">
            <div class="col-md-3 colWidth">
                <div class="position-relative form-group">
                    <label for="exampleEmail" class="">Session</label>
                    <asp:DropDownList ID="ddlfinancialyear" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
            <div class="col-md-3 colWidth">
                <div class="position-relative form-group">
                    <label for="exampleName" class="">Select User</label>
                      <asp:DropDownList ID="ddlUser" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
            <div class="col-md-3 colWidth">
                <div class="position-relative form-group">
                    <label for="examplePassword" class="">Select Group</label>
                    <asp:DropDownList ID="ddlGroup" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">-- ALL Group --</asp:ListItem>
                        <asp:ListItem Value="1">Nur-LKG-UKG</asp:ListItem>
                        <asp:ListItem Value="2">Ist-Xth</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-3 colWidth">
                <div class="position-relative form-group">
                    <label for="examplePasswordRep" class="">Select Class</label>
                   <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>

              <div class="col-md-3 colWidth">
                <div class="position-relative form-group">
                    <label for="examplePasswordRep" class="">Start Date</label>
                    <asp:TextBox ID="txtStartDate" runat="server" placeholder="Enter Start Date" onkeypress="return false" CssClass="form-control TextBoxStyle"></asp:TextBox>
                </div>
            </div>

              <div class="col-md-3 colWidth">
                <div class="position-relative form-group">
                    <label for="examplePasswordRep" class="">End Date</label>
                      <asp:TextBox ID="txtEndDate" runat="server" placeholder="Enter Start Date" onkeypress="return false" CssClass="form-control TextBoxStyle"></asp:TextBox>
                </div>
            </div>

              <div class="col-md-3 colWidth">
                <div class="position-relative form-group">
                    <label for="examplePasswordRep" class="">Payment Type</label>
                   <asp:DropDownList ID="ddlPaymentType" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">-- All Payment Type --</asp:ListItem>
                <asp:ListItem Value="1">Cash</asp:ListItem>
                <asp:ListItem Value="6">Online</asp:ListItem>
				<asp:ListItem Value="7">QR Code</asp:ListItem>
            </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div class="for_sigle_row_form">
            <asp:Button ID="btnSubmit" runat="server" Text="View Report" CssClass="button_save sdr" />
            <asp:Button ID="btnDownload" runat="server" Text="Download Report" CssClass="button_save sdr" />
        </div>
        <br />
        <br />
        <div style="margin-top: 15px;" id="Div1" runat="server">
            <table id="GridPaymentDetails" class="stm" cellspacing="0" cellpadding="6" border="0" style="width: 100%; border-collapse: collapse;">
                <tbody>
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col">FEE HEAD NAME </th>
                        <th align="center" scope="col">Check if, Select All<input id="chkAll" style="float: none; margin-left: 10px" type="checkbox" checked title="Check Here For Pay Fee Now." /></th>
                    </tr>
                </tbody>
            </table>
            <%--  <table style="width: 50%;" class="stm">
                <tr id="tr1" runat="server" class="stm_head">
                    <td style="width: 5%;">
                        <asp:Label ID="Label1" runat="server">S No.</asp:Label>
                    </td>
                    <td style="width: 40%;">
                        <asp:Label ID="Label2" runat="server">Fee Head Name</asp:Label>
                    </td>
                    <td style="width: 5%;">
                        <asp:CheckBox ID="chkall" runat="server" OnCheckedChanged="chkall_CheckedChanged"
                            AutoPostBack="true" />
                    </td>
                </tr>
                <tr id="tr2" runat="server">
                    <td colspan="4" class="stm1" style="border-bottom: 0px;">
                       

                       <%-- <asp:GridView ID="grdFead" AutoGenerateColumns="false" ShowHeader="false" Width="100%" CssClass="stm"
                            BorderWidth="0" runat="server" GridLines="None">
                            <columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                    </asp:TemplateField>                                   
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblsubject" runat="server" Text='<%# Bind("Feename") %>'></asp:Label>
                                            <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("Feeid") %>' />
                                        </ItemTemplate>
                                        <ItemStyle Width="40%" />
                                    </asp:TemplateField>     
                                     <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkclass" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                    </asp:TemplateField>                               
                                </columns>
                            <rowstyle cssclass="stm_dark" />
                            <alternatingrowstyle cssclass="stm_light" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>--%>
            <br />
            <br />
        </div>
        <div class="clear"></div>
        <div style="margin-top: 15px;">
        </div>
    </div>
    <asp:Panel ID="pnlMultipleBeneficiaries" ScrollBars="Horizontal" Style="overflow: scroll" runat="server" Width="1290px">
        <div id="divUsers">
        </div>
    </asp:Panel>
</asp:Content>
