<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="feeinfo.aspx.cs" Inherits="BranchPanel_feeinfo" %>
<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <style>
        .active7 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
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

     <script type="text/javascript">

         function alertTest() {
             var admno = "";
             var monid = "";
             var ftype = "";
             var monthid = "";
             var allmonthid = "";
             $(document).ready(function () {

                 var balanc1 = 0;
                 var sum5 = 0;
                 var sum8 = 0;
                 var disamt5 = 0;

                 //rizwan
                 $("#<%=GridView1.ClientID %> input:checkbox[id*=chks1]").live('click', function () {
                     var cal1 = 0;
                     var monthid = "";
                     var payabamt = $(this).closest('tr').find('td:eq(1) span:last-child').text();
                     var paidamt = $(this).closest('tr').find('td:eq(4) span:last-child').text();
                     allmonthid = "";
                     $(this).closest('tr').css("background-color", "Green");

                     if ($(this).is(':checked')) {
                         monthid = "";
                         allmonthid = "";
                         $('#<%=GridView1.ClientID%>').find("input:checkbox").each(function () {

                             if ($(this).is(':checked')) {
                                 var amt1 = $(this).closest('tr').find('td:eq(1)').text();
                                 var paidamt = $(this).closest('tr').find('td:eq(4)').text();

                                 monthid = monthid + "," + $(this).closest('tr').find('td:eq(2) span:last-child').text();
                                 sum5 += parseFloat(paidamt);
                                 cal1 += parseFloat(amt1);
                             }

                         });
                         balanc1 = parseFloat(cal1);
                         $('#ctl00_ContentPlaceHolder1_lblMonthName').val(cal1);

                         var rad = $('[id*=rfineadjust]').find('input:checked').val();
                         if (rad == 1) {

                             var novalue = 0;
                             novalue = cal1;
                             var ch1 = $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val();
                             novalue = parseFloat(ch1) + parseFloat(novalue)
                             $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(novalue);
                             $("#ctl00_ContentPlaceHolder1_hd1").val(novalue);

                         }

                         //asif   monthid = monthid.substring(1, monthid.length);

                         $("#ctl00_ContentPlaceHolder1_lblremainbal").text(0);
                         $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");

                         $('#ctl00_ContentPlaceHolder1_Label3').val(monthid);

                     }

                     else {

                         $('#<%=GridView1.ClientID%>').find("input:checkbox").each(function () {

                             if ($(this).is(':checked')) {
                                 var amt1 = $(this).closest('tr').find('td:eq(1)').text();
                                 var paidamt = $(this).closest('tr').find('td:eq(4)').text();

                                 monthid = monthid + "," + $(this).closest('tr').find('td:eq(2) span:last-child').text();
                                 sum5 += parseFloat(paidamt);
                                 cal1 += parseFloat(amt1);
                             }

                         });
                         //   monthid = monthid.substring(1, monthid.length);
                         $('#ctl00_ContentPlaceHolder1_Label3').val(monthid);
                         sum = 0;
                         amt = 0;
                         var amt = $(this).closest('tr').find('td:eq(1)').text();
                         balanc1 = parseFloat(balanc1) - parseFloat($(this).closest('tr').find('td:eq(1) span:last-child').text());
                         // $('#ctl00_ContentPlaceHolder1_Label3').val(monthid) - ($(this).closest('tr').find('td:eq(2) span:last-child').html());;
                         //alert(amt);
                         $('#ctl00_ContentPlaceHolder1_lblMonthName').val(balanc1);
                         var rad = $('[id*=rfineadjust]').find('input:checked').val();
                         if (rad == 1) {
                             if ((parseFloat($("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val()) - parseFloat(amt)) >= 0) {

                                 $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat($("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val()) - parseFloat(amt));
                                 $("#ctl00_ContentPlaceHolder1_hd1").val(parseFloat($("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val()) - parseFloat(amt));

                             }
                             else {
                                 $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat(amt) - parseFloat($("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val()));
                                 $("#ctl00_ContentPlaceHolder1_hd1").val(parseFloat(amt) - parseFloat($("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val()));
                             }
                         }

                         else {
                             $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(0);
                             $("#ctl00_ContentPlaceHolder1_hd1").val(0);

                             $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val(0);

                         }
                         $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00");
                         $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                         $(this).closest('tr').css("background-color", "White");

                     }

                 });

                 $('#ctl00_ContentPlaceHolder1_btnconfig').click(function () {

                     $("#ctl00_ContentPlaceHolder1_gridenquiry").css("display", "none");
                     $("#ctl00_ContentPlaceHolder1_divpay").css("display", "block");
                     $("#ctl00_ContentPlaceHolder1_btnconfig").css("display", "none");

                     return false;

                 });

                 $('#ctl00_ContentPlaceHolder1_btnCancel').click(function () {
                     $("#ctl00_ContentPlaceHolder1_gridenquiry").css("display", "block");
                     $("#ctl00_ContentPlaceHolder1_divpay").css("display", "none");
                     $("#ctl00_ContentPlaceHolder1_btnconfig").css("display", "block");

                     //  $("#ctl00_ContentPlaceHolder1_btnback").css("display", "none");
                     return false;

                 });

                 $("#ctl00_ContentPlaceHolder1_ddlPayMode").change(function () {
                     var mode = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;
                     if (mode == 1) {
                         $("#ctl00_ContentPlaceHolder1_divbank").css("display", "none");

                     }

                     else {

                         $("#ctl00_ContentPlaceHolder1_divbank").css("display", "block");

                     }

                 });

                 $("#ctl00_ContentPlaceHolder1_txtAmount").on('change', function () {

                     var txtvalue = $("#ctl00_ContentPlaceHolder1_txtAmount").val();
                     var payamt = $("#ctl00_ContentPlaceHolder1_lblMonthName").val();
                     var amtwitfine = $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val();
                     $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");

                     var rad = $('[id*=rfineadjust]').find('input:checked').val();

                     if (rad == 2) {
                         if (txtvalue != "") {

                             if (parseFloat(payamt) < parseFloat(txtvalue)) {

                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").text("Amount to be paid is greater than balance amount!");
                                 $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00")
                                 $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                                 return;
                             }
                             else if (parseFloat(payamt) == parseFloat(txtvalue)) {
                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(payamt) - parseFloat(txtvalue));
                                 $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                                 return;
                             }
                             else if (parseFloat(payamt) > parseFloat(txtvalue)) {
                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(payamt) - parseFloat(txtvalue));
                                 $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                                 return;
                             }

                         }
                     }
                     if (rad == 1) {

                         if (txtvalue != "") {

                             if (parseFloat(amtwitfine) < parseFloat(txtvalue)) {

                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").text("Amount to be paid is greater than balance amount!");
                                 $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00")
                                 $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                                 return;

                             }

                             else if (parseFloat(amtwitfine) == parseFloat(txtvalue)) {
                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(amtwitfine) - parseFloat(txtvalue));
                                 $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                             }
                             else if (parseFloat(amtwitfine) > parseFloat(txtvalue)) {
                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(amtwitfine) - parseFloat(txtvalue));
                                 $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                                 $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");

                             }

                         }

                     }

                     else {
                         $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");

                     }

                 });

                 $('[id*=rfineadjust] input').unbind().click(function (e) {
                     var rad = $('[id*=rfineadjust]').find('input:checked').val();

                     if (rad == 1) {
                         $("#ctl00_ContentPlaceHolder1_adjustfine").css("display", "block");
                         $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00");
                         $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_divfee").css("display", "block");
                         $("#ctl00_ContentPlaceHolder1_divfes").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
                         $("#ctl00_ContentPlaceHolder1_hd1").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));

                     }
                     else if (rad == "2") {
                         $("#ctl00_ContentPlaceHolder1_txtAmount").val("0.00");
                         $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_divfee").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_adjustfine").css("display", "none");
                         $("#ctl00_ContentPlaceHolder1_divfes").css("display", "block");
                         $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val($("#ctl00_ContentPlaceHolder1_txtfine").val());
                     }

                 });

                 $("#ctl00_ContentPlaceHolder1_txtpayfinehere").on('change', function () {

                     var totalfine = parseFloat($("#ctl00_ContentPlaceHolder1_txtfine").val()).toFixed(0.00);
                     var fine = parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()).toFixed(0.00);
                     if (parseFloat(fine) <= parseFloat(totalfine)) {
                         $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));
                         $("#ctl00_ContentPlaceHolder1_hd1").val(parseFloat($("#ctl00_ContentPlaceHolder1_txtpayfinehere").val()) + parseFloat($("#ctl00_ContentPlaceHolder1_lblMonthName").val()));

                     }
                     else {
                         $("#ctl00_ContentPlaceHolder1_txttotalpaywithfine").val($("#ctl00_ContentPlaceHolder1_lblMonthName").val());
                         $("#ctl00_ContentPlaceHolder1_hd1").val(0);
                         $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val(0);
                         alert("adjust fine amount can not be greater than actual fine amount.");
                         return;
                     }

                 });

             });
         }
         </script>

     <script type="text/javascript">
         $(document).ready(function () {

             $('.stuname').click(function () {
                 var mid, rno, sid;
                 sid = $(this).closest("td").find("[id*=lblbt2]").text();
                 mid = $(this).closest('tr').find('td:eq(2)').find("input[type='hidden']").val();
                 rno = $(this).closest("td").find("[id*=lnkView]").text();
                 $.ajax(
                   {
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "feeinfo.aspx/getregno",
                       data: "{'mid':'" + mid + "','rno':'" + rno + "'}",
                       dataType: "json",
                       success: function (data) {
                           if (data.d == "0") {
                               alert("Error");
                               return false;

                           }
                           else {
                               window.open("receipt.aspx?sid=" + sid, '_blank');
                               return false;
                           }
                       }
                   });
                 return false;

             });

         });
    </script>

    <script type="text/javascript">

        function check() {

            if (document.getElementById('<%=lblMonthName.ClientID %>').value.trim() == 0) {
                alert("Please select month.");
                document.getElementById('<%=lblMonthName.ClientID %>').focus();
                return false;
            }

            var rad = $('[id*=rfineadjust]').find('input:checked').val();
            var tamount = $("#ctl00_ContentPlaceHolder1_txtAmount").val();
            var payfine = $("#ctl00_ContentPlaceHolder1_txtpayfinehere").val();
            if (rad == 1) {
                if (parseFloat(tamount) > parseFloat(payfine)) {

                }
                else {

                    alert("Please pay amount is greater than fine adjust amount");
                    $("#ctl00_ContentPlaceHolder1_txtAmount").focus();
                    return false;
                }
            }

            if (document.getElementById('<%=ddlPayMode.ClientID %>').value == 0) {
                alert("Please Select Payment Mode.");
                document.getElementById('<%=ddlPayMode.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtAmount.ClientID %>').value.trim() == 0) {
                alert("Please enter amount.");
                document.getElementById('<%=txtAmount.ClientID %>').focus();
                return false;
            }

            if ($('#ctl00_ContentPlaceHolder1_divbank').css('display') == 'block') {

                if (document.getElementById('<%=txtBankName.ClientID %>').value.trim() == 0) {
                    alert("Please enter Bank Name.");
                    document.getElementById('<%=txtBankName.ClientID %>').focus();
                    return false;

                }

                if (document.getElementById('<%=txtCheque.ClientID %>').value.trim() == 0) {
                    alert("Please enter Cheque number.");
                    document.getElementById('<%=txtCheque.ClientID %>').focus();
                    return false;
                }
            }

        }
    </script>

    <script type="text/javascript" lang="javascript">
        Sys.Application.add_load(alertTest);
    </script>

<%--     $('#ctl00_ContentPlaceHolder1_btnback').click(function () {--%>
    <%--<script type="text/javascript">
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_btnback').click(function () {
                alert("ww");
                function backtopage() {

                    window.history.back();
                }

            });

        });
    </script>--%>

   <%-- <asp:UpdatePanel ID="updnewadmission" runat="server">
        <ContentTemplate>--%>
            <div class="content_pane_cont input_content" id="contentPane" style="border-bottom: medium none;">
               <My:stu runat="server" ID="Stu1" />
                &nbsp;&nbsp;

                <asp:Button runat="server" ID="btnback" CssClass="button_save" Visible="false" Text="back" />
              <%--  <asp:Button runat="server" ID="btnAdd" Text="New Admission" CssClass="button_save"
                    OnClick="btnAdd_Click" ToolTip="Click here to add this student to selected courses." />--%>

        <br />

                <div id="paydiv" runat="server">

                     <table cellpadding="0" cellspacing="0" border="0" style="margin-left: 0px;">
            <tr>
                <td>
                </td>
                <td align="left">
                    <div class="conductedlecture234" style="background: none repeat scroll 0 0 #FFECFD;
    border: 1px solid #DEB1D9;; margin-left: 10px;">
                        <asp:Label runat="server" ID="Label7" Text="Total" Font-Bold="true" ForeColor="#B136A4"></asp:Label><br />
                        <asp:Label ID="Label11" runat="server" Text="₹" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lbltot" runat="server" Font-Bold="true" ForeColor="#B136A4"></asp:Label>
                    </div>
                </td>
                <td align="left">
                    <div class="conductedlecture234" style="margin-left: 20px; background: none repeat scroll 0 0 #EEEFFF;
    border: 1px solid #B4B8FF;">
                        <asp:Label runat="server" ID="lb1" Text="Paid" Font-Bold="true" ForeColor="#444A9E"></asp:Label><br />
                        <asp:Label ID="Label10" runat="server" Text="₹" Font-Bold="true" ForeColor="#444A9E"></asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblpaid" runat="server" Font-Bold="true" ForeColor="#444A9E"></asp:Label>
                    </div>
                </td>
                <td align="left">
                    <div class="conductedlecture234" style="background: #D4FEFF; margin-left: 22px;
border: 1px solid #41E1E6;">
                        <asp:Label runat="server" ID="Label8" Text="Balance" Font-Bold="true" ForeColor="#14878A"></asp:Label><br />
                        <asp:Label ID="Label9" runat="server" Text="₹" Font-Bold="true" ForeColor="#14878A"></asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblbal" runat="server" Font-Bold="true" ForeColor="#14878A"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>
        <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; margin-top: 30px; position: relative;"
            id="tbl1" runat="server">
            <tr>
                <td style="background: #D8D8D8; padding-left: 30px; height: 10px; border-top: #ccc solid 1px; border-right: #ccc solid 1px;">
                    <b>Paid</b>
                </td>
                <td style="width: 15px; border-right: 1px solid #D8D8D8;"></td>
                <td style="background: #D8D8D8; padding-left: 30px; border-top: #ccc solid 1px; height: 30px;">
                    <div id="tbl2" runat="server" style="position: absolute; right: 7px; top: -35px;">
                        <asp:Button ID="btnconfig" runat="server" Width="150px" Text="Pay Fee"
                            CssClass="button_save"  CausesValidation="false" />
                    </div>
                    <b>Unpaid </b>
                </td>
            </tr>
            <tr>
                <td style="width: 49%; border-bottom: 1px solid #DDDDDD;" valign="top">
                    <asp:GridView ID="gridenquiry" AutoGenerateColumns="false" EmptyDataText="No data found !"
                        CellPadding="6" runat="server" Width="100%" CssClass="stm" GridLines="None">
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lblsno" runat="server"> S.No</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="3%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lbldateofenquiry" runat="server">Amount (₹)</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbpaydate" Text='<% #Bind("payfee", "{0:0.00}")%>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Month">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldateyy" runat="server" Text='<%# Bind("MonthName") %>'> </asp:Label>
                                                <asp:HiddenField ID="hdfid" runat="server" Value='<%# Eval("paymonths") %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblname" runat="server">Paymode</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblname1" Text='<% #Bind("paymentype")%>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fee Recipt" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkView" runat="server"  Text='<% #Bind("receiptno")%>'
                                        Font-Underline="true" ToolTip="click here to download fee receipt" CssClass="stuname"
                                        Font-Bold="true" ForeColor="#5793B9"></asp:LinkButton>
                                    <asp:Label ID="lblbt2" runat="server" Text='<%# Bind("studentid") %>' CssClass="admo" Style="display: none;"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete Recipt">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkView2" runat="server" CommandName="del12" Text="Delete" Font-Underline="true"
                                         ToolTip="click here to delete fee receipt"
                                        Font-Bold="true" ForeColor="#5793B9"></asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>

                    <table class="file_border bkrt" runat="server" id="divpay" cellpadding="2" cellspacing="0" border="0" style="width:88.6%; margin-left: 29px; display: none; height: auto; float: left; background: #F7F7F7; border-radius: 0px; border: 1px solid #249cdd; padding-top: 30px; position: relative; margin-top: 25px;">
            <tr>
                <td>

                    <div class="form-box-heading" style="width: 430px; top: 1px; left: 1px; height: 28px;"><span>Pay Amount</span></div>

                    <div style="border: 1px solid red; margin-left: 13px; width: 424px; margin-top: 10px; background-color: #FFF8DC;padding: 5px;">
                        <asp:HiddenField ID="hd1" runat="server" />
                        <label class="cssnew">Applicable Fine</label>
                        <div class="for_sigle_row_form1" style="margin-left: 14%;">
                            <label>
                                Payable Fine<span style="color: Red;">*</span></label>
                            <asp:TextBox runat="server" ID="txtfine" DataFormatString="{0:C}" Enabled="false" ForeColor="Black" Font-Size="17px" Width="213px" Style="padding: 2px; margin-left: 20px;">0.00</asp:TextBox><span id="errmsg"></span>
                        </div>
                        <div class="for_sigle_row_form1" style="margin-left: 15.2%; display: block">
                            <label>
                                Fine adjust:</label>
                            <asp:RadioButtonList runat="server" ID="rfineadjust" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Wave off</asp:ListItem>
                                <asp:ListItem Value="2" Selected="True">Pay Later</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div id="adjustfine" class="for_sigle_row_form1" runat="server" style="display: none;    margin-left: 8%;">
                            <label>
                                Fine adjust here:</label>
                            <asp:TextBox runat="server" ID="txtpayfinehere" Style="margin-left: 24px; padding: 2px;" Height="26px" Width="213px"></asp:TextBox>
                        </div>
                    </div>

                    <div class="for_sigle_row_form1" style="margin-left: 10%;" id="divfes" runat="server">
                        <label>
                            Payable Fee(Months)<span style="color: Red;">*</span></label>
                        <asp:TextBox runat="server" ID="lblMonthName" ForeColor="Black" Font-Size="17px" Enabled="false" Style="margin-left: 19px; padding: 2px;" Height="26px" Width="213px">0.00</asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form1" id="divfee" runat="server" style="margin-left: 2%; display: none">
                        <label>
                            Total Payable Fee(With Fine)<span style="color: Red;">*</span></label>
                        <asp:TextBox runat="server" ID="txttotalpaywithfine" Enabled="false" Style="margin-left: 19px; padding: 2px;" Height="26px" Width="213px">0.00</asp:TextBox>
                    </div>

                    <div class="for_sigle_row_form1" style="margin-left: 5.2%;">
                        <label runat="server" id="ll4">
                            Enter amount to be paid<span style="color: Red;">*</span></label>
                        <asp:TextBox runat="server" ID="txtAmount" Style="margin-left: 19px; padding: 2px;" Height="26px" Width="213px"></asp:TextBox>&nbsp;<br />
                        <span id="Span1"></span>
                        <asp:Label runat="server" ID="Label2" ForeColor="Red"></asp:Label>
                        <asp:Label runat="server" ID="lblremain" Style="display: none; margin-left: 165px;" ForeColor="Red">Remaining Blanace:</asp:Label>
                        <asp:Label runat="server" ID="lblremainbal" ForeColor="Red" Style="display: none; margin-left: 295px; margin-top: -10px;"></asp:Label>
                    </div>
                    <div class="clear"></div>

                    <div class="for_sigle_row_form1" style="margin-left: 18%;">
                        <label>
                            Payment Mode<span style="color: Red;">*</span></label>
                        <asp:DropDownList ID="ddlPayMode" runat="server" Height="28px" Width="222px" Style="margin-left: 22px; padding: 2px;">
                            <asp:ListItem Value="0">--Select Payment Mode--</asp:ListItem>
                            <asp:ListItem Value="1">Cash</asp:ListItem>
                            <asp:ListItem Value="2">Bank Draft</asp:ListItem>
                            <asp:ListItem Value="3">Cheque</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;
                    </div>

                    <div class="clear"></div>
                    <div class="for_sigle_row_form1" visible="false" runat="server" id="ddlmonth" style="margin-left: 8%;">
                        <label>
                            select month for remaining amount</label>
                        <asp:DropDownList ID="ddlmonth1" runat="server" Height="28px" Width="213px" Style="padding: 2px;">
                            <asp:ListItem Value="0">--Select month--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label runat="server" ID="Label1" ForeColor="Red"></asp:Label>
                    </div>

                    <div class="clear"></div>
                    <div id="divbank" runat="server" style="display:none;">
                        <div class="for_sigle_row_form1" style="margin-left:22%;">
                            <label runat="server" id="ll1">
                                Bank Name<span style="color: Red;">*</span></label>
                            <asp:TextBox runat="server" ID="txtBankName" onkeypress="ValidateAlpha()" Height="28px" Width="213px" Style="margin-left: 27px; padding: 2px;"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form1" style="margin-left: 15%;">
                            <label runat="server" id="ll2">
                                Cheque Number<asp:Label runat="server" ID="lblCDd"></asp:Label><span style="color: Red;">*</span></label>
                            <asp:TextBox runat="server" ID="txtCheque" Height="28px" Width="213px" Style="margin-left: 27px; padding: 2px;"></asp:TextBox>
                        </div>
                    </div>

                    <div class="clear"></div>

                    <div class="for_sigle_row_form1" style="margin-left: 207px;">
                        <label></label>
                        <asp:Button runat="server" ID="Button3" Text="Submit" CssClass="button_save"  OnClientClick="return check();" OnClick="Button3_Click" />&nbsp;&nbsp;
            <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="view-enquiry1" Style="margin-left: -7px; height: 33px;" />
                    </div>
                </td>
            </tr>
        </table>
                </td>
                <td style="width: 15px; border-right: 1px solid #DDDDDD;"></td>
                <td style="width: 49%; border-bottom: 1px solid #DDDDDD;" id="tbl4" runat="server" valign="top">
                    <asp:GridView ID="GridView1" AutoGenerateColumns="false" EmptyDataText="No data found !"
                        CellPadding="5" runat="server" Width="100%" GridLines="None" CssClass="stm">
                        <Columns>
                             <asp:TemplateField HeaderText="">

                                    <ItemTemplate>
                                        <%-- <asp:Label ID="lbl" runat="server" Text=""  CssClass="lblItem" ></asp:Label>--%>
                                        <asp:CheckBox ID="chks1" runat="server" CssClass="chkItem2" />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="8%" />
                                </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lbldateofenquiry" runat="server">Amount (₹)</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblenqdate1" Text='<%#Eval("payableamount","{0:0.00}") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="14.5%" />
                            </asp:TemplateField>

                             <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lbldateofenquiry" runat="server">Month</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbmonth" Text='<%#Eval("MonthName") %>' runat="server"></asp:Label>
                                    <asp:Label ID="HD134" runat="server" Text='<%# Bind("monthid") %>' CssClass="montid121" Style="display: none;" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="14.5%" />
                            </asp:TemplateField>

                               <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lbldateofenquiry" runat="server">Status</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbstatus" Text='<%#Eval("status") %>' ForeColor="Red" runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="14.5%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lbldateofenquiry" runat="server">Due Date</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblenqdate" Text='<%#Eval("paydate") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20.5%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Reminder" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkView" runat="server" CommandName="ed" CommandArgument='<%#Eval("adid") %>'
                                        Text="Send SMS" Font-Underline="true" ToolTip="click here to Send Sms" Font-Bold="true"
                                        ForeColor="#5793B9"></asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20.5%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                </td>
            </tr>
        </table>

  <asp:TextBox ID="Label3" runat="server" Text="" Style="display: none" ForeColor="Red"></asp:TextBox>
<asp:HiddenField ID="label44" runat="server" />
                     <asp:HiddenField ID="hd2" runat="server" />
                </div>
            </div>
      <%--  </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>