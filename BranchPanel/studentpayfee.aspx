<%@ Page Title="Student Pay Fee" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="studentpayfee.aspx.cs" EnableEventValidation="false" Inherits="BranchPanel_studentpayfee" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <script src="feedefault.js" type="text/javascript"></script>

    <script src="../js/1.8-jquery-ui.min.js" type="text/javascript"></script>

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
     <style>
         th {
             padding: 10px 18px;
             text-align: left;
         }

         td {
             padding: 10px 18px;
         }

         .cscfeepay {
             outline: 0;
             height: 25px;
             width: 275px;
         }
     </style>

     <div class="content_pane_cont input_content" id="contentPane" style="border-bottom: medium none;">
               <My:stu runat="server" ID="Stu1" />
                &nbsp;&nbsp;

              <%--  <asp:Button runat="server" ID="btnAdd" Text="New Admission" CssClass="button_save"
                    OnClick="btnAdd_Click" ToolTip="Click here to add this student to selected courses." />--%>

        <br />

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
         <asp:HiddenField ID="hfclassid" runat="server" />
         <asp:HiddenField ID="hftransid" runat="server" />
          <asp:HiddenField ID="hfadid" runat="server" />
          <div id="divstudentadno1" runat="server">
        </div>
         <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; margin-top: 30px; position: relative;"
            id="tbl1" runat="server">
            <tr>
                <td id="paidtop" runat="server" style="background: #D8D8D8; padding-left: 30px; height: 10px; border-top: #ccc solid 1px; border-right: #ccc solid 1px;">
                    <b><asp:Label ID="lbpainame" runat="server"></asp:Label></b>
                </td>
                <td style="width: 15px; border-right: 1px solid #D8D8D8;"></td>
                <td id="uppaidt" style="background: #D8D8D8; padding-left: 30px; border-top: #ccc solid 1px; height: 30px;">
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
                                                <asp:Label ID="lbldateyy" runat="server" Text='<%# Eval("MonthName") %>'  ToolTip='<%# Eval("MonthName") %>'> </asp:Label>
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
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>

                    <div id="feedetails" style="display:none;" class="stm">
                     <div id="Container1">
        </div>
<%--<div id="payfeebind" class="myclass" style="margin-left:550px;margin-top:-430px;">
        </div>--%>
        <div id="divfeestructure" style="display:none;">
        </div>
</div>
                    <table class="file_border bkrt" runat="server" id="divpay" cellpadding="2" cellspacing="0" border="0" style="width:88.6%; margin-left: 29px; display: none; height: auto; float: left; background: #F7F7F7; border-radius: 0px; border: 1px solid #249cdd; padding-top: 30px; position: relative; margin-top: 30px;">
            <tr>
                <td>

                    <div class="form-box-heading" style="width: 413px; top: 1px; left: 1px; height: 28px;"><span>Pay Amount</span></div>

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
                           <%-- <asp:ListItem Value="3">Cheque</asp:ListItem>--%>
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
                         <div class="for_sigle_row_form1" style="margin-left:19%;">
                            <label runat="server" id="Label4">
                                Bank Branch <span style="color: Red;">*</span></label>
                            <asp:TextBox runat="server" ID="txtbranch"  Height="28px" Width="213px" Style="margin-left: 27px; padding: 2px;"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form1" style="margin-left: 19%;">
                            <label runat="server" id="ll2">
                                Draft Number<asp:Label runat="server" ID="lblCDd"></asp:Label><span style="color: Red;">*</span></label>
                            <asp:TextBox runat="server" ID="txtCheque" Height="28px" Width="213px" Style="margin-left: 27px; padding: 2px;"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form1" style="margin-left: 19%;">
                            <label runat="server" id="Label5">
                                Draft/Check Date:<span style="color: Red;">*</span></label>
                            <asp:TextBox ID="txtDate" runat="server"  Height="30px" Width="213px" ></asp:TextBox>
                        </div>
                    </div>

                    <div class="clear"></div>

                    <div class="for_sigle_row_form1" style="margin-left: 207px;">
                        <label></label>
                        <asp:Button runat="server" ID="Button3" Text="Submit" CssClass="button_save"  OnClick="Button3_Click" />&nbsp;&nbsp;
            <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="view-enquiry1" Style="margin-left: -7px; height: 33px;" />
                    </div>
                </td>
            </tr>
        </table>
                </td>
                <td style="width: 15px; border-right: 1px solid #DDDDDD;"></td>
                <td style="width: 49%; border-bottom: 1px solid #DDDDDD;" id="tbl4" runat="server" valign="top">
                    <asp:GridView ID="GridView1" AutoGenerateColumns="false" EmptyDataText="No data found !"
                        CellPadding="5" runat="server" Width="100%" GridLines="None"  CssClass="stm">
                        <Columns>
                             <asp:TemplateField HeaderText="">

                                    <ItemTemplate>
                                        <%-- <asp:Label ID="lbl" runat="server" Text=""  CssClass="lblItem" ></asp:Label>--%>
                                        <%--<asp:CheckBox ID="chks1" runat="server"  />--%>
                                        <span class="as1">
                                        <input type="checkbox" name="ctl00$ContentPlaceHolder1$GridView1$ctl02$chks1"  class="ops"  id="ctl00_ContentPlaceHolder1_GridView1_ctl02_chks1">
                                            </span>
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
                                    <asp:Label ID="lnkView" runat="server"
                                        Text="Send SMS" Font-Underline="true" ToolTip="click here to Send Sms" Font-Bold="true"
                                        ForeColor="#5793B9"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20.5%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>

                     <asp:TextBox ID="Label3" runat="server" Text="" Style="display: none" ForeColor="Red"></asp:TextBox>
<asp:HiddenField ID="label44" runat="server" />
                     <asp:HiddenField ID="hd2" runat="server" />
                </td>
            </tr>
        </table>
         </div>
</asp:Content>