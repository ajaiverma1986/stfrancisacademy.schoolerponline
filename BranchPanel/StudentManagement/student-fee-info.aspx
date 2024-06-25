<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-fee-info.aspx.cs" Inherits="BranchPanel_StudentManagement_student_fee_info" %>

<%@ Register Src="~/BranchPanel/StudentManagement/student-admission-list.ascx" TagPrefix="My" TagName="stu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activestudentadmissionlist {
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

        .dashboard-boxes h3 {
            font-size: 13px !important;
        }
    </style>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Students All Details</h2>
                <h2 class="pull-right"><a href="/BranchPanel/StudentManagement/student-list.aspx?Pfor=2" class="pull-right">&lt;&lt; Back</a></h2>
            </div>
            <My:stu runat="server" ID="MyUserInfoBoxControl" />

            <div class="clear"></div>

            <%--<table id="ctl00_ContentPlaceHolder1_tbl1" cellspacing="0" cellpadding="2" border="0" style="width: 98%; margin: 5px 0 0 11px; position: relative;">
                <tbody>
                    <tr>
                        <td style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                            <b>PAID FEE</b>
                        </td>
                        <td style="width: 15px; border-right: 1px solid #D8D8D8;"></td>
                        <td style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                            <b>UNPAID FEE (Excluding Tax)</b>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="width: 49%;">
                            <div>
                                <table id="GrdPaidFee" class="stm" cellspacing="0" cellpadding="6" border="0" style="width: 100%; border-collapse: collapse;">
                                    <tbody>
                                        <tr class="stm_head" align="center">
                                            <th align="center" scope="col">S.No</th>
                                            <th align="center" scope="col">Total Amount (₹)</th>
                                            <th align="center" scope="col">Tax (₹)</th>
                                            <th align="center" scope="col">Paid Date</th>
                                            <th align="center" scope="col">Paymode</th>
                                            <th align="center" scope="col">Recipt</th>
                                            <th align="center" scope="col">Remark</th>
                                            <th align="center" scope="col">Rollback</th>
                                        </tr>                                        
                                    </tbody>
                                </table>
                            </div>
                        </td>
                        <td style="width: 15px; border-right: 1px solid #DDDDDD;"></td>
                        <td id="ctl00_ContentPlaceHolder1_tbl4" valign="top" style="width: 49%; border-bottom: 1px solid #DDDDDD; border-right: 1px solid #DDDDDD;">
                            <div>
                                <table id="GrdPayNow" class="stm" cellspacing="0" cellpadding="5" border="0" style="width: 100%; border-collapse: collapse;">
                                    <tbody>
                                        <tr class="stm_head" align="center">
                                            <th align="center" scope="col">S.No</th>
                                            <th align="center" scope="col">Amount (₹)</th>
                                            <th align="center" scope="col">Tax (₹)</th>
                                            <th align="center" scope="col">Due Date</th>
                                            <th align="center" scope="col">Pay</th>
                                            <th align="center" scope="col">Reminder</th>
                                            <th align="center" scope="col">Details</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>--%>

            <table id="ctl00_ContentPlaceHolder1_tbl1" cellspacing="0" cellpadding="2" border="0" style="width: 98%; margin: 5px 0 0 11px; position: relative;">
                <tbody>
                     <tr>
                    <td colspan="3">
                            <div class="for_sigle_row_form">
                                <label>
                                   Financial Year<span style="color: Red">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlFyid">
                                </asp:DropDownList>
                            </div>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                            <b>Payment Details</b>
                        </td>
                        <td style="width: 15px; border-right: 1px solid #D8D8D8;"></td>
                        <td style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                            <b>UNPAID FEE (Excluding Tax)</b>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="width: 49%;">
                            <table id="GridPaymentDetails" class="stm" cellspacing="0" cellpadding="6" border="0" style="width: 100%; border-collapse: collapse;">
                                <tbody>
                                    <tr class="stm_head" align="center">
                                        <th align="center" scope="col">INSTALLMENT NAME </th>
                                        <th align="center" scope="col">TUITION FEE</th>
                                        <th align="center" scope="col">DISCOUNT DETAILS</th>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="clear">
                                <div id="divPayment" class="new-registration" style="margin-top: 10px; display: none">
                                    <%--<div class="tbl-top-heading" style="border-top: 1px solid #CCCCCC !important; border-bottom: 1px solid #CCCCCC !important">
                        <h2>Payment Details</h2>
                    </div>--%>
                                    <div class="clear"></div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Reciept No.</label>
                                        <asp:TextBox Style="width: 40%;" runat="server" ID="txtfeerecipt" onkeypress="return noAlphabets(event)" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="for_sigle_row_form" id="div1">
                                        <label>
                                            Payable Amount(Excluding Tax)</label>
                                        <input style="width: 40%;" id="txtPayableamountexcludingtax" readonly="readonly" type="text" value="0.00" />
                                    </div>
                                    <div class="for_sigle_row_form" id="div2">
                                        <label>
                                            Taxable Amount</label>
                                        <input style="width: 40%;" id="txttableamount" readonly="readonly" type="text" value="0.00" />
                                    </div>
                                    <div class="for_sigle_row_form" id="div3">
                                        <label>
                                            Non Taxable Amount</label>
                                        <input style="width: 40%;" id="txtnontaxableamount" readonly="readonly" type="text" value="0.00" />
                                    </div>
                                    <div class="for_sigle_row_form" id="div4">
                                        <label>
                                            Service Tax(In%)</label>

                                        <input style="width: 40%;" id="txtsevicetax" readonly="readonly" type="text" value="0.00" />
                                    </div>
                                    <div class="for_sigle_row_form" id="div5">
                                        <label>
                                            Tax Amount</label>
                                        <input style="width: 40%;" id="txttaxamount" readonly="readonly" type="text" value="0.00" />
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Fine Amount</label>
                                        <input style="width: 40%;" id="txtFine" type="text" value="0.00" />
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Payable Amount(Including Tax)</label>
                                        <input style="width: 40%;" id="txtPayable" readonly="readonly" type="text" value="0.00" />
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Enter Amount To Be Paid<span style="color: Red">*</span></label>
                                        <input style="width: 40%;" id="txtAmount" onkeypress="return noAlphabets(event)" type="text" value="0.00" readonly="readonly"/>&nbsp;
                      <div style="float: right; width: 466px;">
                          <label id="lblremainningamount" style="color: green; width: 190px"></label>
                      </div>
                                    </div>
                                    <div id="Partialpayment" style="display: none">
                                        <div class="for_sigle_row_form">
                                            <label style="width: 221px">
                                                Due Date For Remaining Amount<span style="color: Red">*</span></label>
                                            <input style="width: 40%;" id="txtDate" type="text" readonly="readonly" placeholder="Select Due Date For Remaing Amount" />
                                        </div>
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label style="width: 221px">
                                            Payment Date<span style="color: Red">*</span></label>
                                        <input style="width: 40%;" id="txtpaydate" type="text" onkeypress="return false" />
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Payment Mode<span style="color: Red">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlkPayment" Style="width: 43%;">
                                            <asp:ListItem Value="1">Cash</asp:ListItem>
                                         
											<asp:ListItem Value="6">Online</asp:ListItem>
											<asp:ListItem Value="7">QR Code </asp:ListItem>
                                        </asp:DropDownList>
                                    </div>

                                   <%-- <div class="for_sigle_row_form" id="ChequeDetail" style="display: none">
                                        <label>
                                            Cash Mode<span style="color: Red">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlChequeMode" Style="width: 43%;">
                                            <asp:ListItem Value="1">Non Cheque</asp:ListItem>
                                            <asp:ListItem Value="2">Micar Cheque</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>--%>

                                   <%-- <div id="BankDetail" style="display: none">
                                        <div class="for_sigle_row_form" id="divforbankname1">
                                            <label>
                                                Bank Name<span style="color: Red">*</span></label>
                                            <asp:DropDownList runat="server" ID="ddltxtBank" Style="width: 43%;">
                                                <asp:ListItem Value="ALLAHABAD BANK">ALLAHABAD BANK</asp:ListItem>
                                                <asp:ListItem Value="ANDHRA BANK">ANDHRA BANK</asp:ListItem>
                                                <asp:ListItem Value="BANK OF BARODA">BANK OF BARODA</asp:ListItem>
                                                <asp:ListItem Value="BANK OF INDIA">BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="BANK OF MAHARASHTRA">BANK OF MAHARASHTRA</asp:ListItem>
                                                <asp:ListItem Value="CANARA BANK">CANARA BANK</asp:ListItem>
                                                <asp:ListItem Value="CENTRAL BANK OF INDIA">CENTRAL BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="CORPORATION BANK">CORPORATION BANK</asp:ListItem>
                                                <asp:ListItem Value="IDBI BANK LTD.">IDBI BANK LTD.</asp:ListItem>
                                                <asp:ListItem Value="IND BANK HOUSING LTD.">IND BANK HOUSING LTD.</asp:ListItem>
                                                <asp:ListItem Value="INDBANK MERCHANT BANKING SERVICES LTD.">INDBANK MERCHANT BANKING SERVICES LTD.</asp:ListItem>
                                                <asp:ListItem Value="INDIAN BANK">INDIAN BANK</asp:ListItem>
                                                <asp:ListItem Value="INDIAN OVERSEAS BANK">INDIAN OVERSEAS BANK</asp:ListItem>
                                                <asp:ListItem Value="JAMMU & KASHMIR BANK LTD.">JAMMU & KASHMIR BANK LTD.</asp:ListItem>
                                                <asp:ListItem Value="ORIENTAL BANK OF COMMERCE">ORIENTAL BANK OF COMMERCE</asp:ListItem>
                                                <asp:ListItem Value="PNB GILTS LTD">PNB GILTS LTD</asp:ListItem>
                                                <asp:ListItem Value="PUNJAB & SIND BANK">PUNJAB & SIND BANK</asp:ListItem>
                                                <asp:ListItem Value="PUNJAB NATIONAL BANK">PUNJAB NATIONAL BANK</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF INDIA">STATE BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="SYNDICATE BANK">SYNDICATE BANK</asp:ListItem>
                                                <asp:ListItem Value="UCO BANK">UCO BANK</asp:ListItem>
                                                <asp:ListItem Value="UNION BANK OF INDIA">UNION BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="UNITED BANK OF INDIA">UNITED BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="OTHER">OTHER</asp:ListItem>                                                
                                            </asp:DropDownList>
                                        </div>--%>

                                        <%--<div class="for_sigle_row_form" id="divforbankname">
                                            <label>
                                                Other Bank Name<span style="color: Red">*</span></label>
                                            <input style="width: 40%;" type="text" id="txtBank" placeholder="Enter Bank Name PLease" />
                                        </div>

                                        <div class="for_sigle_row_form" id="divforANo">
                                            <label>
                                                Account Number<span style="color: Red">*</span></label>
                                            <input style="width: 40%;" type="text" id="txtANo" placeholder="Enter Account No PLease" />
                                        </div>



                                        <div class="for_sigle_row_form" id="divforbranchname">
                                            <label>
                                                Branch Name<span style="color: Red">*</span></label>
                                            <input style="width: 40%;" type="text" id="txtbranchbank" placeholder="Enter Branch Name PLease" />
                                        </div>

                                        <div class="for_sigle_row_form" id="divforchkrefno">
                                            <label runat="server" id="lblchkrefno">
                                                Cheque Number<span style="color: Red">*</span></label>
                                            <input style="width: 40%;" type="text" id="txtChequeDD" placeholder="Enter Refrence Number PLease" />
                                        </div>

                                        <div class="for_sigle_row_form" id="divmicraname">
                                            <label>
                                                Micre Code<span style="color: Red">*</span></label>
                                            <input style="width: 40%;" type="text" id="txtmicre" placeholder="Enter Bank Name PLease" />
                                        </div>

                                        <div class="for_sigle_row_form" id="divforchkrefdate">
                                            <label id="lblchkrefdate">
                                                Cheque Date<span style="color: Red">*</span></label>
                                            <input style="width: 40%;" type="text" id="txtToDate" onkeypress="return false" placeholder="Select Date PLease" />
                                        </div>
                                    </div>--%>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Received By<span style="color: Red">*</span></label>
                                        <input style="width: 40%;" type="text" readonly="readonly" id="txtReceiver" />
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Comment/Remark</label>
                                        <textarea style="width: 40%;" cols="2" rows="3" id="txtareacomment" placeholder="Enter The Remark Please."></textarea>
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label></label>
                                        <label style="width: auto;">
                                            <input type="checkbox" checked="checked" id="chkprint" />
                                            Print Now</label>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="for_sigle_row_form" style="margin-bottom: 10px !important;">
                                        <label></label>
                                        <a id="BtnPayNow" class="button_save">Pay Now</a>
                                        <a id="BtnBackNow" class="button2">BACK</a>
                                    </div>
                                    <asp:HiddenField ID="hfforasaid" runat="server" />
                                </div>
                            </div>
                        </td>
                        <td style="width: 15px; border-right: 1px solid #DDDDDD;"></td>
                        <td id="ctl00_ContentPlaceHolder1_tbl4" valign="top" style="width: 49%; border-bottom: 1px solid #DDDDDD; border-right: 1px solid #DDDDDD;">
                            <div>
                                <table id="GrdPayNow" class="stm" cellspacing="0" cellpadding="5" border="0" style="width: 100%; border-collapse: collapse;">
                                    <tbody>
                                        <tr class="stm_head" align="center">
                                            <th align="center" scope="col">S.No</th>
                                            <th align="center" scope="col">Amount (₹)</th>
                                            <th align="center" scope="col" style="display: none;">Tax (₹)</th>
                                            <th align="center" scope="col">Due Date</th>
                                            <th align="center" scope="col">Pay</th>
                                            <th align="center" scope="col">Reminder</th>
                                            <th align="center" scope="col">Details</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div>
                                <table id="GrdPaidFee" class="stm" cellspacing="0" cellpadding="6" border="0" style="width: 100%; border-collapse: collapse;">
                                    <tbody>
                                        <tr>
                                            <td colspan="8" style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px; text-align: unset !important;">
                                                <b>PAID FEE</b>
                                            </td>
                                        </tr>
                                        <tr class="stm_head" align="center">
                                            <th align="center" scope="col">S.No</th>
                                            <th align="center" scope="col">Total Amount (₹)</th>
                                            <th align="center" scope="col">Tax (₹)</th>
                                            <th align="center" scope="col">Paid Date</th>
                                            <th align="center" scope="col">Paymode</th>
                                            <th align="center" scope="col">Recipt</th>
                                            <th align="center" scope="col">Remark</th>
                                            <th align="center" scope="col">Rollback</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>


            <%--<div class="clear">
                <div id="divPayment" class="new-registration" style="margin-top: 10px; display: none">
                    <div class="tbl-top-heading" style="border-top: 1px solid #CCCCCC !important; border-bottom: 1px solid #CCCCCC !important">
                        <h2>Payment Details</h2>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <label>
                            Reciept No.</label>
                        <asp:TextBox runat="server" ID="txtfeerecipt" onkeypress="return noAlphabets(event)" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Payable Amount(Excluding Tax)</label>
                        <input id="txtPayableamountexcludingtax" readonly="readonly" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Taxable Amount</label>
                        <input id="txttableamount" readonly="readonly" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Non Taxable Amount</label>
                        <input id="txtnontaxableamount" readonly="readonly" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Service Tax(In%)</label>

                        <input id="txtsevicetax" readonly="readonly" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Tax Amount</label>
                        <input id="txttaxamount" readonly="readonly" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Fine Amount</label>
                        <input id="txtFine" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Payable Amount(Including Tax)</label>
                        <input id="txtPayable" readonly="readonly" type="text" value="0.00" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Enter Amount To Be Paid<span style="color: Red">*</span></label>
                        <input id="txtAmount" onkeypress="return noAlphabets(event)" type="text" value="0.00" />&nbsp;
                      <div style="float: right; width: 466px;">
                          <label id="lblremainningamount" style="color: green; width: 190px"></label>
                      </div>
                    </div>
                    <div id="Partialpayment" style="display: none">
                        <div class="for_sigle_row_form">
                            <label style="width: 221px">
                                Due Date For Remaining Amount<span style="color: Red">*</span></label>
                            <input id="txtDate" type="text" readonly="readonly" placeholder="Select Due Date For Remaing Amount" />
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label style="width: 221px">
                            Payment Date<span style="color: Red">*</span></label>
                        <input id="txtpaydate" type="text" onkeypress="return false" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Payment Mode<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlkPayment">                           
                            <asp:ListItem Value="1">Cash</asp:ListItem>
                            <asp:ListItem Value="2">Cheque</asp:ListItem>
                            <asp:ListItem Value="3">DD</asp:ListItem>
                            <asp:ListItem Value="4">Card</asp:ListItem>
                            <asp:ListItem Value="5">NEFT</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form" id="ChequeDetail" style="display: none">
                        <label>
                            Cash Mode<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlChequeMode">
                            <asp:ListItem Value="1">Non Cheque</asp:ListItem>
                            <asp:ListItem Value="2">Micar Cheque</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div id="BankDetail" style="display: none">
                        <div class="for_sigle_row_form" id="divforbankname">
                            <label>
                                Bank Name<span style="color: Red">*</span></label>
                            <input type="text" id="txtBank" placeholder="Enter Bank Name PLease" />
                        </div>



                        <div class="for_sigle_row_form" id="divforbranchname">
                            <label>
                                Branch Name<span style="color: Red">*</span></label>
                            <input type="text" id="txtbranchbank" placeholder="Enter Branch Name PLease" />
                        </div>

                        <div class="for_sigle_row_form" id="divforchkrefno">
                            <label runat="server" id="lblchkrefno">
                                Cheque Number<span style="color: Red">*</span></label>
                            <input type="text" id="txtChequeDD" placeholder="Enter Refrence Number PLease" />
                        </div>

                        <div class="for_sigle_row_form" id="divmicraname">
                            <label>
                                Micre Code<span style="color: Red">*</span></label>
                            <input type="text" id="txtmicre" placeholder="Enter Bank Name PLease" />
                        </div>

                        <div class="for_sigle_row_form" id="divforchkrefdate">
                            <label id="lblchkrefdate">
                                Cheque Date<span style="color: Red">*</span></label>
                            <input type="text" id="txtToDate" onkeypress="return false" placeholder="Select Date PLease" />
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Received By<span style="color: Red">*</span></label>
                        <input type="text" readonly="readonly" id="txtReceiver" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Comment/Remark</label>
                        <textarea cols="2" rows="3" id="txtareacomment" placeholder="Enter The Remark Please."></textarea>
                    </div>
                    <div class="for_sigle_row_form">
                        <label></label>
                        <label style="width: auto;">
                            <input type="checkbox" checked="checked" id="chkprint" />
                            Print Now</label>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form" style="margin-bottom: 10px !important;">
                        <label></label>
                        <a id="BtnPayNow" class="button_save">Pay Now</a>
                        <a id="BtnBackNow" class="button2">BACK</a>
                    </div>
                    <asp:HiddenField ID="hfforasaid" runat="server" />
                </div>
            </div>--%>
        </div>
    </div>
    <script type="text/javascript">  
        var myData = {}, asaid = 0, trindexforpay = 0, money = 0, _asaid = 0, _firstCheck = 0, payableAmt = 0;
        var tblPaymentDetails = '';
        $(document).ready(function () {
            CallMethod("doc");

            $('#div1').hide(500);
            $('#div2').hide(500);
            $('#div3').hide(500);
            $('#div4').hide(500);
            $('#div5').hide(500);



            $("#txtpaydate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy'
            }).datepicker("setDate", new Date());

            $("#txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            }).datepicker("setDate", new Date());

            $("#txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                minDate: new Date()
            }).datepicker("setDate", new Date());


            $('#ctl00_ContentPlaceHolder1_ddlFyid').live('change', function () {
                //debugger;
                Fyid = $('#ctl00_ContentPlaceHolder1_ddlFyid').val();

                $('#ctl00_ContentPlaceHolder1_txtfeerecipt').val(0);
                // $('#txtPayableamountexcludingtax').val((parseFloat(CurrentDeailsRow.find("InstallmentAmount").text()) + parseFloat($('#txtPayableamountexcludingtax').val())).toFixed(2));
                $('#txttableamount').val(0.00);
                $('#txtnontaxableamount').val(0.00);
                $('#txttaxamount').val(0.00);
                $('#txtPayable').val(0.00);
                $('#txtAmount').val(0.00);
                $('#txtFine').val(0.00);

                CallMethod("doc");
                return false;
            });
            
            $('.ImgBtnForInstallmentDetails').live('click', function () {
                alert('INSTALLMENT NAME:' + $(this).parent('td').find('.SpanInstallmentName').text() + '\nINSTALLMENT DETAILS/BREAKUP:' + $(this).parent('td').find('.SpanInstallmentDetails').text() + '\nDISCOUNT DETAILS:' + $(this).parent('td').find('.SpanDiscountDetails').text() + '');
                return false;
            });
            $('#txtpaydate').live('change', function () {
                $('#txtFine').val(0);
                $('#txtPayable').val(0);
                $('#txtAmount').val(0);
                var TtlFine = 0;
                var TotalPayble = 0;
                debugger
                $('#GrdPayNow').find('tr:gt(0)').each(function () {
                    if ($(this).find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                        debugger
                        var asaid = $(this).find('td:eq(0)').find('input[type="hidden"]').val();
                        TotalPayble = (parseFloat(TotalPayble) + parseFloat($(this).find('td:eq(1)').text())).toFixed(2);
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "student-fee-info.aspx/GetFine",
                            data: "{'ASAID':'" + asaid + "','TodayDate':'" + $('#txtpaydate').val() + "'}",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                debugger
                                var fineAmt = 0;
                                if (data.d > 0) {
                                    fineAmt = parseFloat(data.d);
                                }
                                TtlFine = (parseFloat(TtlFine) + parseFloat(fineAmt)).toFixed(2);
                                TotalPayble = (parseFloat(TotalPayble) + parseFloat(fineAmt)).toFixed(2);

                                $('#txtFine').val(TtlFine);
                                $('#txtPayable').val(TotalPayble);
                                $('#txtAmount').val(TotalPayble);
                            },
                            error: function (response) {
                                alertify.error('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                            }
                        });
                    }
                });
                
                return false;
            });
            $('#txtFine').live('change', function () {
                $('#txtAmount').val(parseFloat($('#txtPayableamountexcludingtax').val()) + parseFloat($('#txtFine').val()) + parseFloat($('#txttaxamount').val()));
                $('#txtPayable').val($('#txtAmount').val());
            });
            $('.ImgBtnForPayNow').live('change', function () {
                var isSelected = false;

                trindexforpay = $(this).parent('td').parent('tr').index();
                asaid = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                $('#ctl00_ContentPlaceHolder1_hfforasaid').val(asaid);

                if ($(this).parent('td').parent('tr').find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true)
                    isSelected = true;
                else
                    isSelected = false;

                BindPayNow(asaid, 2, isSelected);
                $('#divPayment').show(500);
                $('html, body').animate({
                    // scrollTop: $("#divPayment").offset().top
                }, 500);
                var allid="";

                //tblPaymentDetails = '';
                //$('#GridPaymentDetails tbody').find('tr:gt(0)').remove();
                //$('#GrdPayNow').find('tr:gt(0)').each(function () {
                //    if ($(this).find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                //        tblPaymentDetails = tblPaymentDetails + '<tr><td>' + $(this).find('td:eq(4)').find('input[type="hidden"]').val() + '</td><td>' + $(this).find('td:eq(6)').find('.TotalInstallmentAmount').text() + '</td><td>' + $(this).find('td:eq(6)').find('.SpanDiscountDetails').text() + '</td></tr>'
                //    }
                //});
                //$('#GridPaymentDetails tbody').append(tblPaymentDetails);
                $('#GrdPayNow').find('tr:gt(0)').each(function () {
                    if ($(this).find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                        allid = allid  + $(this).find('td:eq(0)').find('input[type="hidden"]').val() +",";
                    }
                });
                if ($(this).parent('td').parent('tr').find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                    GetPaymentDetails(allid, 1, asaid);
                }
                else {
                    GetPaymentDetails(allid, 0, asaid);
                }
                return false;
            });
            $('#BtnBackNow').click(function () {
                $('#divPayment').hide(500);
                $('#txtareacomment').val('');
                return false;
            });
            $('.ImgBtnRollBackFee').live('click', function () {
                var ConfirmRollBack = confirm('Are You Sure You Want To Rollback The Fee.?');
                if (ConfirmRollBack == true) {
                    var ASAID = 0;
                    ASAID = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "student-fee-info.aspx/RoolBackFee",
                        data: "{'ASAID':'" + ASAID + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == '1') {
                                alertify.success('Rollback Done Sucessfully');
                                CallMethod();
                            }
                            else if (data.d == '0') {
                                alertify.error('Some Error Occur.');
                            }
                        }
                    });
                }
                return false;
            });
            $('.ImgGenerateRecipt').live('click', function () {                
                asaid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                var win = window.open("../Fee Management/DoublePay.aspx?sid=" + asaid, '_blank');
                win.focus();
                return false;
            });
            // comment by MKG
            /*  $('#ctl00_ContentPlaceHolder1_ddlkPayment').change(function () {
                  paymentMode = $('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val();
                  if (paymentMode > 1 && paymentMode != 4) {
                      $('#BankDetail').show(500);
                      if (paymentMode == 2) {
                          $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('Cheque Number<span style="color: Red">*</span>');
                          $('#lblchkrefdate').html('Cheque Date<span style="color: Red">*</span>');
                      }
                      else if (paymentMode == 3) {
                          $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('DD Number<span style="color: Red">*</span>');
                          $('#lblchkrefdate').html('DD Date<span style="color: Red">*</span>');
                      }
                      else if (paymentMode == 5) {
                          $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('Transaction Number<span style="color: Red">*</span>');
                          $('#lblchkrefdate').html('Transaction Date<span style="color: Red">*</span>');
                      }
                  }
                  else {
                      $('#BankDetail').hide(500);
                  }
              });*/
            $('#txtBank').val($('#ctl00_ContentPlaceHolder1_ddltxtBank option:selected').val());
            $('#divforbankname').hide();
            $('#ctl00_ContentPlaceHolder1_ddltxtBank').change(function () {
                bn = $('#ctl00_ContentPlaceHolder1_ddltxtBank option:selected').val();
                if (bn == 'OTHER') {
                    $('#txtBank').val('');
                    $('#divforbankname').show();
                }
                else {
                    $('#txtBank').val(bn);
                    $('#divforbankname').hide();
                }
                //alert(bn);
            });

            $('#ctl00_ContentPlaceHolder1_ddlkPayment').change(function () {
                paymentMode = $('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val();
                if (paymentMode > 1 && paymentMode != 4) {
                    $('#BankDetail').show(500);
                    if (paymentMode == 2) {
                        $('#divmicraname').hide(500);
                        $('#ChequeDetail').show(500);
                    }
                    //else if (paymentMode == 2) {
                    //    $('#BankDetail').show(500);
                    //    $('#CaseDetail').hide(500);
                    //    $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('Cheque Number<span style="color: Red">*</span>');
                    //    $('#lblchkrefdate').html('Cheque Date<span style="color: Red">*</span>');
                    //}
                    else if (paymentMode == 3) {
                        $('#ChequeDetail').hide(500);
                        $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('DD Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('DD Date<span style="color: Red">*</span>');
                    }
                    else if (paymentMode == 5) {
                        $('#ChequeDetail').hide(500);
                        $('#ctl00_ContentPlaceHolder1_lblchkrefno').html('Transaction Number<span style="color: Red">*</span>');
                        $('#lblchkrefdate').html('Transaction Date<span style="color: Red">*</span>');
                    }
                }
                else {
                    $('#ChequeDetail').hide(500);
                    $('#BankDetail').hide(500);
                }
            });
            $('#ctl00_ContentPlaceHolder1_ddlChequeMode').change(function () {
                chequeMode = $('#ctl00_ContentPlaceHolder1_ddlChequeMode option:selected').val();
                $('#BankDetail').show(500);
                if (chequeMode > 1) {
                    $('#divmicraname').show(500);
                }
                else {
                    $('#divmicraname').hide(500);
                }
            });
            $('#BtnPayNow').click(function () {
                var err = 0, ermsg = '';
                if ($('#txtAmount').val() == '') {
                    ermsg = "Please Enter The Amount To Be Paid. \n";
                    err = 1;
                }
                if ($('#txtpaydate').val() == '') {
                    ermsg = "Please Select Payment Date. \n";
                    err = 1;
                }
                if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 0) {
                    ermsg = ermsg + "please Select Payment Mode \n";
                    err = 1;
                }
                //if ($('#ctl00_ContentPlaceHolder1_ddlCaseMode option:selected').val() == 0) {
                //    ermsg = ermsg + "please Select Cash Mode \n";
                //    err = 1;
                //}

                /* if ($('#ctl00_ContentPlaceHolder1_ddlChequeMode option:selected').val() == 1) {
                     if ($('#txtBank').val() == '') {
                         ermsg = ermsg + "Please Enter Bank Name. \n";
                         err = 1;
                     }
                     if ($('#txtANo').val() == '') {
                         ermsg = ermsg + "Please Enter Account Number. \n";
                         err = 1;
                     }
                     if ($('#txtbranchbank').val() == '') {
                         ermsg = ermsg + "Please Enter The Branch Name. \n";
                         err = 1;
                     }
                     if ($('#txtChequeDD').val() == '') {
                         ermsg = ermsg + "Please Enter Cheque Number. \n";
                         err = 1;
                     }
                     if ($('#txtToDate').val() == '') {
                         ermsg = ermsg + "Please Enter Cheque Date. \n";
                         err = 1;
                     }
                 } */

                if ($('#ctl00_ContentPlaceHolder1_ddlChequeMode option:selected').val() == 2) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtANo').val() == '') {
                        ermsg = ermsg + "Please Enter Account Number. \n";
                        err = 1;
                    }
                    if ($('#txtbranchbank').val() == '') {
                        ermsg = ermsg + "Please Enter The Branch Name. \n";
                        err = 1;
                    }
                    if ($('#txtChequeDD').val() == '') {
                        ermsg = ermsg + "Please Enter Cheque Number. \n";
                        err = 1;
                    }
                    if ($('#txtToDate').val() == '') {
                        ermsg = ermsg + "Please Enter Cheque Date. \n";
                        err = 1;
                    }
                }

                if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 2) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtANo').val() == '') {
                        ermsg = ermsg + "Please Enter Account Number. \n";
                        err = 1;
                    }
                    if ($('#txtbranchbank').val() == '') {
                        ermsg = ermsg + "Please Enter The Branch Name. \n";
                        err = 1;
                    }
                    if ($('#txtChequeDD').val() == '') {
                        ermsg = ermsg + "Please Enter Cheque Number. \n";
                        err = 1;
                    }
                    if ($('#txtToDate').val() == '') {
                        ermsg = ermsg + "Please Enter Cheque Date. \n";
                        err = 1;
                    }
                }

                else if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 3) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtANo').val() == '') {
                        ermsg = ermsg + "Please Enter Account Number. \n";
                        err = 1;
                    }
                    if ($('#txtbranchbank').val() == '') {
                        ermsg = ermsg + "Please Enter The Branch Name. \n";
                        err = 1;
                    }
                    if ($('#txtChequeDD').val() == '') {
                        ermsg = ermsg + "Please Enter DD Number. \n";
                        err = 1;
                    }
                    if ($('#txtToDate').val() == '') {
                        ermsg = ermsg + "Please Enter DD Date. \n";
                        err = 1;
                    }
                }

                else if ($('#ctl00_ContentPlaceHolder1_ddlkPayment option:selected').val() == 5) {
                    if ($('#txtBank').val() == '') {
                        ermsg = ermsg + "Please Enter Bank Name. \n";
                        err = 1;
                    }
                    if ($('#txtANo').val() == '') {
                        ermsg = ermsg + "Please Enter Account Number. \n";
                        err = 1;
                    }
                    if ($('#txtbranchbank').val() == '') {
                        ermsg = ermsg + "Please Enter The Branch Name. \n";
                        err = 1;
                    }
                    if ($('#txtChequeDD').val() == '') {
                        ermsg = ermsg + "Enter Transaction Number Please. \n";
                        err = 1;
                    }
                    if ($('#txtToDate').val() == '') {
                        ermsg = ermsg + "Select Transaction Date Please. \n";
                        err = 1;
                    }
                }
                if (err > 0) {
                    alertify.error(ermsg);
                    return;
                }
                else {
                    if($('#txtDate:visible').length > 0 && $('#txtDate').val()=='')
                    {
                        alert("Enter due date");
                        return;
                    }
                    FillFieldForPay();
                    var DTO = { 'theData': myData };
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "student-fee-info.aspx/DepositFee",
                        data: JSON.stringify(DTO),
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != '0') {
                                alertify.success('Fee Deposited Successfully and Sent Msg to Registered Mobile No.');
                                if ($('#chkprint').attr('checked') == 'checked') {
                                    window.open("../Fee Management/DoublePay.aspx?sid=" + data.d, '_blank');
                                }
                                else
                                {
                                    alertify.success('Fee Deposited Successfully.');
                                }

                                //            setTimeout(() => {                       
                                //   window.location.href = "student-list.aspx?Pfor=2";
                                //}, 50);


                            }
                            else
                            {
                                alertify.error('Some Error Occur.');
                            }
                            //if (data.d == '2') {
                            //    alertify.error('Duplicate Recipt No.');
                            //}
                            //if (data.d == '0') {
                            //    alertify.error('Some Error Occur.');
                            //}
                            //if (data.d == '5') {
                            //    alertify.success('Fee Deposited Successfully.');
                            //}
                            $('#divPayment').hide(500);
                            $('#txtareacomment').val('');
                            CallMethod();
                            return false;
                        }
                    });
                    location.reload(true);
                }
            });
            $('.ImgBtnForSendFeeRemnainder').live('click', function () {
                trindexforpay = $(this).parent('td').parent('tr').index();
                asaid = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                $('#ctl00_ContentPlaceHolder1_hfforasaid').val(asaid);
                SendFeeMsg(asaid);
            });
            $('#txtAmount').change(function () {
                $('#lblremainningamount').html('');
                $('#Partialpayment').css('display', 'none');
                $('#txtDate').val('');
                if (parseInt($(this).val()) < parseInt($('#txtPayable').val())) {
                    $('#lblremainningamount').html('Remaining Amount:' + (parseInt($('#txtPayable').val()) - $(this).val()) + '.00')
                    $('#Partialpayment').css('display', 'block');
                }
                else if (parseInt($(this).val()) > parseInt($('#txtPayable').val())) {
                    alertify.error('Amount To Be Paid Can Not Greater Than Payable Amount.');
                }
            });




        });

        function GetPaymentDetails(ASAID, CHK, ID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-fee-info.aspx/PaymentDetails",
                data: "{'ids':'" + ASAID + "','chk':'" + CHK + "','id':'" + ID + "'}",
                dataType: "json",
                success: function (data) {
                    $('#GridPaymentDetails tbody').find('tr:gt(0)').remove();
                    trforappend = ''
                    var xmlDocGeneralDetailsPaid = $.parseXML(data.d);
                    var xmlGeneralDetailsPaid = $(xmlDocGeneralDetailsPaid);
                    var TableGeneralDetailsPaid = xmlGeneralDetailsPaid.find("Table1");
                    var iPaid = 0, ClassPaid = "";
                    TableGeneralDetailsPaid.each(function (index ) {
                        var CurrentDeailsRowPaid = $(this);
                        if (iPaid % 2 == 0)
                            ClassPaid = "stm_dark";
                        else
                            ClassPaid = "stm_light";
                        trforappend = trforappend + '<tr class=' + ClassPaid + '>'
                            + '<td>' + CurrentDeailsRowPaid.find("FeeHead").text() + '</td>'
                            + '<td class="fee"><input type="hidden"  id="hdnpay' + index + '" value="' + CurrentDeailsRowPaid.find("ASAID").text() + '" /><input type="text" id="txtpay' + index + '" onkeypress="return isNumberKey(event)" onchange="setTotalFee(this,' + CurrentDeailsRowPaid.find("FeeHeadAmt").text() + ')" value="' + CurrentDeailsRowPaid.find("FeeHeadAmt").text() + '" disabled/></td>'
                            + '<td><input type="hidden"  value="'+ CurrentDeailsRowPaid.find("FeeHeadAmt").text() + '"/>N/A</td>'
                            + '</tr>'
                        iPaid = iPaid + 1;
                    });
                    $('#GridPaymentDetails tbody').append(trforappend);

                },
                error: function (response) {
                    alertify.error('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }

        function SendFeeMsg(ASAID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-fee-info.aspx/sendFeeRemainder",
                data: "{'ASAID':'" + ASAID + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == '5') {
                        alertify.success('Fee Remainder Msg Send to Registered Mobile No.');
                        return false;
                    }
                    else {
                        alertify.error('Msg not Send');
                    } return false;
                }
            });
        }
        function setTotalFee(txt,amt)
        {
            if($(txt).val()=='')
            {
                $(txt).val(0);
                alert("enter Amount");
                return;
            }
            if(parseFloat(amt)<parseFloat($(txt).val()))
            {
                $(txt).val(amt);
                alert("Entered amount can not be greater than original fee amount");
                return;
            }
            var tempamt=0;
            $('#GridPaymentDetails').find('tr:gt(0)').each(function () {
                tempamt=tempamt+parseFloat($(this).find('td:eq(1)').find('input[type="text"]').val());
            });            
               
           
            $('#txtAmount').val(tempamt);

            $('#lblremainningamount').html('');
            $('#Partialpayment').css('display', 'none');
            $('#txtDate').val('');
            if (parseInt($('#txtAmount').val()) < parseInt($('#txtPayable').val())) {
                $('#lblremainningamount').html('Remaining Amount:' + (parseInt($('#txtPayable').val()) - $('#txtAmount').val()) + '.00')
                $('#Partialpayment').css('display', 'block');
            }
            else if (parseInt($('#txtAmount').val()) > parseInt($('#txtPayable').val())) {
                alertify.error('Amount To Be Paid Can Not Greater Than Payable Amount.');
            }
        }
        function FillFieldForPay() {
            myData.ASAID = $('#ctl00_ContentPlaceHolder1_hfforasaid').val();
            myData.PAYMENTMODE = $('#ctl00_ContentPlaceHolder1_ddlkPayment').val();
            myData.CHEQUEMODE = $('#ctl00_ContentPlaceHolder1_ddlChequeMode').val();
            myData.BANKNAME = $('#txtBank').val();
            myData.ACCOUNTNO = $('#txtANo').val();
            myData.BRANCHNAME = $('#txtbranchbank').val();
            myData.CHKREFDDNEFTREFRENCENO = $('#txtChequeDD').val();
            myData.CHKREFDDNEFTDATE = $('#txtToDate').val();
            myData.RECIPTNO = $('#ctl00_ContentPlaceHolder1_txtfeerecipt').val();
            myData.PAYMENTDATE = $('#txtpaydate').val();
            myData.RemarkOrComment = $('#txtareacomment').val();
            myData.FineAmount = $('#txtFine').val();
            myData.PaidAmount = $('#txtAmount').val();
            myData.DateOfDueAmount = $('#txtDate').val();
            myData.SelectedASID = '';
            myData.SelectedASIDFee = '';
            $('#GrdPayNow').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                    myData.SelectedASID = myData.SelectedASID + ',' + $(this).find('td:eq(0)').find('input[type="hidden"]').val();
                }
            });
            $('#GridPaymentDetails').find('tr:gt(0)').each(function () {
                
                myData.SelectedASIDFee=myData.SelectedASIDFee+","+$.trim($(this).find('td:eq(0)').html())+"|"+$(this).find('td:eq(1)').find('input[type="hidden"]').val()+"|"+$(this).find('td:eq(1)').find('input[type="text"]').val()+"|"+$(this).find('td:eq(2)').find('input[type="hidden"]').val();
                
            });
            if(myData.SelectedASIDFee!='')
            {
                myData.SelectedASIDFee=myData.SelectedASIDFee.slice(1, myData.SelectedASIDFee.length);
            }
            
            myData.SelectedASID = myData.SelectedASID.slice(1, myData.SelectedASID.length);
        }

        function isNumberKey(evt) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;            
            return true;
        }

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65) && (charCode <= 90)) {
                return false;
            }
            return true;
        };
        function getFine(ASAID, Amount, isSelected) {
            var TodayDate = $('#txtpaydate').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-fee-info.aspx/GetFine",
                data: "{'ASAID':'" + ASAID + "','TodayDate':'" + $('#txtpaydate').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d > 0) {
                        var TtlFine = 0;
                        var TotalPayble = 0;
                        debugger
                        if (isSelected != undefined) {
                            if (isSelected) {
                                TtlFine = parseFloat($('#txtFine').val()) + parseFloat(data.d);
                                TotalPayble = (parseFloat(data.d) + parseFloat(Amount)).toFixed(2);
                            } else {
                                TtlFine = parseFloat($('#txtFine').val()) - parseFloat(data.d);
                                TotalPayble = (parseFloat(Amount) - parseFloat(data.d)).toFixed(2);
                            }
                        }

                        $('#txtFine').val(TtlFine);
                        $('#txtPayable').val(TotalPayble);
                        $('#txtAmount').val(TotalPayble);
                    }
                    else if (data.d == 5) {
                        if (confirm('Sorry, You have not Set Fine Fee. Do you want take transport ?')) {
                            window.location.replace('../Fee%20Management/mst_FeeFine.aspx');
                            return false;
                        }
                    }
                },
                error: function (response) {
                    alertify.error('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
        var j = 0
        function BindPayNow(ASAID, ch, isSelected) {
            //if (j > 0)
            //{
            //    alertify.error('You can pay only one Month Fee Only !');
            //}
            //else
            //{
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-fee-info.aspx/BindPayNow",
                data: "{'ASAID':'" + ASAID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    var i = 0, Class = "";
                    TableGeneralDetails.each(function () {
                        var CurrentDeailsRow = $(this);

                        if (ch == 0) {
                            $('#ctl00_ContentPlaceHolder1_txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                            // $('#txtPayableamountexcludingtax').val((parseFloat(CurrentDeailsRow.find("InstallmentAmount").text()) + parseFloat($('#txtPayableamountexcludingtax').val())).toFixed(2));
                            $('#txttableamount').val((parseFloat(CurrentDeailsRow.find("TaxableAmount").text()) + parseFloat($('#txttableamount').val())).toFixed(2));
                            $('#txtnontaxableamount').val((parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text()) + parseFloat($('#txtnontaxableamount').val())).toFixed(2));
                            $('#txttaxamount').val((parseFloat(CurrentDeailsRow.find("Tax").text()) + parseFloat($('#txttaxamount').val())).toFixed(2));
                            $('#txtPayable').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtPayable').val())).toFixed(2));
                            $('#txtAmount').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtAmount').val())).toFixed(2));
                            asaid = ASAID, money = $('#txtAmount').val();
                            //debugger
                            getFine(ASAID, $('#txtAmount').val(), isSelected);
                            //tblPaymentDetails = '<tr><td>' + CurrentDeailsRow.find("InstallmentName").text() + '</td><td>' + CurrentDeailsRow.find("InstallmentAmount").text() + '</td><td>' + CurrentDeailsRow.find("DiscountDescription").text() + '</td></tr>'
                            //$('#GridPaymentDetails tbody').append(tblPaymentDetails);


                        }
                        else {
                            if ($('#GrdPayNow').find('tr:eq(' + trindexforpay + ')').find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {

                                $('#ctl00_ContentPlaceHolder1_txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                                $('#txtPayableamountexcludingtax').val((parseFloat(CurrentDeailsRow.find("InstallmentAmount").text()) + parseFloat($('#txtPayableamountexcludingtax').val())).toFixed(2));
                                $('#txttableamount').val((parseFloat(CurrentDeailsRow.find("TaxableAmount").text()) + parseFloat($('#txttableamount').val())).toFixed(2));
                                $('#txtnontaxableamount').val((parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text()) + parseFloat($('#txtnontaxableamount').val())).toFixed(2));
                                $('#txttaxamount').val((parseFloat(CurrentDeailsRow.find("Tax").text()) + parseFloat($('#txttaxamount').val())).toFixed(2));
                                $('#txtPayable').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtPayable').val())).toFixed(2));
                                $('#txtAmount').val((parseFloat(CurrentDeailsRow.find("PayableAmount").text()) + parseFloat($('#txtAmount').val())).toFixed(2));
                                asaid = ASAID, money = $('#txtAmount').val();
                                //debugger
                                getFine(ASAID, $('#txtAmount').val(), isSelected);
                                j++;
                            }
                            else {

                                $('#ctl00_ContentPlaceHolder1_txtfeerecipt').val(CurrentDeailsRow.find("Recipt_No").text());
                                $('#txtPayableamountexcludingtax').val((parseFloat($('#txtPayableamountexcludingtax').val()) - parseFloat(CurrentDeailsRow.find("InstallmentAmount").text())).toFixed(2));
                                $('#txttableamount').val((parseFloat($('#txttableamount').val()) - parseFloat(CurrentDeailsRow.find("TaxableAmount").text())).toFixed(2));
                                $('#txtnontaxableamount').val((parseFloat($('#txtnontaxableamount').val()) - parseFloat(CurrentDeailsRow.find("NonTaxableAmount").text())).toFixed(2));
                                $('#txtPayable').val((parseFloat($('#txtPayable').val()) - parseFloat(CurrentDeailsRow.find("PayableAmount").text())).toFixed(2));
                                $('#txtAmount').val((parseFloat($('#txtAmount').val()) - parseFloat(CurrentDeailsRow.find("PayableAmount").text())).toFixed(2));
                                asaid = ASAID, money = $('#txtAmount').val();
                               // debugger
                                getFine(ASAID, $('#txtAmount').val(), isSelected);
                                j--;
                            }
                        }

                        $('#txtReceiver').val($('#ctl00_lblAdmin').text());
                    });
                },
                error: function (response) {
                    alertify.error('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
            //}
        }
        function UncheckParent(obj) {
            var isUnchecked = obj.checked;
            if (isUnchecked == false) {
                //alert("it is unchecked"); here i have to un check chkSelectAllCheckboxes check box
            }
        }
        function GetStatus(str) {
            if (str == "0.00") {
                return "disabled";
            }
        }
        function BindAdmissionList(SAMID, evtfrom) {
            var trforappend = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-fee-info.aspx/BindFeeDetails",
                data: "{'SAMID':'" + SAMID + "','Fyid':'" + $("#ctl00_ContentPlaceHolder1_ddlFyid").val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#GrdPayNow tbody').find('tr:gt(0)').remove();
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    var i = 0, Class = "";
                    TableGeneralDetails.each(function () {
                        var CurrentDeailsRow = $(this);
                        if (i % 2 == 0)
                            Class = "stm_dark";
                        else
                            Class = "stm_light";
                        if (i == 0) {
                            _asaid = parseInt(CurrentDeailsRow.find("ASAID").text());
                            trforappend = trforappend + '<tr class=' + Class + '>'
                                + '<td><input type="hidden" value=' + CurrentDeailsRow.find("ASAID").text() + ' />' + CurrentDeailsRow.find("Number").text() + '</td>'
                                + '<td>' + CurrentDeailsRow.find("InstallmentAmount").text() + '</td>'
                                + '<td style="display:none;">' + CurrentDeailsRow.find("Tax").text() + '</td>'
                                + '<td>' + CurrentDeailsRow.find("InstallmentDate").text() + '</td>'
                                + '<td><input type="hidden" value="' + CurrentDeailsRow.find("InstallmentName").text() + '" /><input class="ImgBtnForPayNow" checked type="checkbox" ' + GetStatus(CurrentDeailsRow.find("InstallmentAmount").text()) + ' title="Check Here For Pay Fee Now." /></td>'
                                + '<td><input class="ImgBtnForSendFeeRemnainder" type="image" style="width:20px;border-width:0px;" src="../../images/message.png" title="Click Here For Send Fee Remiander." /></td>'
                                + '<td>' +
                                '<span class="SpanInstallmentName" style="display:none">' + CurrentDeailsRow.find("InstallmentName").text() + '</span>' +
                                '<span class="SpanInstallmentDetails" style="display:none">' + CurrentDeailsRow.find("FeeDescription").text() + '</span>' +
                                '<span class="SpanDiscountDetails" style="display:none">' + CurrentDeailsRow.find("DiscountDescription").text() + '</span>' +
                                '<span class="TotalInstallmentAmount" style="display:none">' + CurrentDeailsRow.find("InstallmentAmount").text() + '</span>' +
                                '<input class="ImgBtnForInstallmentDetails" type="image" style="width:18px;border-width:0px;" src="../../images/viewquestion.png" title="Click Here For Send Fee Remiander." /></td>'
                            '</tr>'


                            i = i + 1;
                            trindexforpay = 1;
                            asaid = _asaid;
                            $('#ctl00_ContentPlaceHolder1_hfforasaid').val(asaid);
                            //                                                                
                            $('#txtPayableamountexcludingtax').val((parseFloat(CurrentDeailsRow.find("InstallmentAmount").text()) + parseFloat($('#txtPayableamountexcludingtax').val())).toFixed(2));

                            //
                            BindPayNow(asaid, 0, true);
                            $('#divPayment').show(500);
                            $('html, body').animate({
                                //scrollTop: $("#divPayment").offset().top
                            }, 500);
                            //alert(asaid);
                        }
                        else {
                            trforappend = trforappend + '<tr class=' + Class + '>'
                                + '<td><input type="hidden" value=' + CurrentDeailsRow.find("ASAID").text() + ' />' + CurrentDeailsRow.find("Number").text() + '</td>'
                                + '<td>' + CurrentDeailsRow.find("InstallmentAmount").text() + '</td>'
                                + '<td style="display:none;">' + CurrentDeailsRow.find("Tax").text() + '</td>'
                                + '<td>' + CurrentDeailsRow.find("InstallmentDate").text() + '</td>'
                                + '<td><input type="hidden" value="' + CurrentDeailsRow.find("InstallmentName").text() + '" /><input class="ImgBtnForPayNow" type="checkbox" ' + GetStatus(CurrentDeailsRow.find("InstallmentAmount").text()) + ' title="Check Here For Pay Fee Now." /></td>'
                                + '<td><input class="ImgBtnForSendFeeRemnainder" type="image" style="width:20px;border-width:0px;" src="../../images/message.png" title="Click Here For Send Fee Remiander." /></td>'
                                + '<td>' +
                                '<span class="SpanInstallmentName" style="display:none">' + CurrentDeailsRow.find("InstallmentName").text() + '</span>' +
                                '<span class="SpanInstallmentDetails" style="display:none">' + CurrentDeailsRow.find("FeeDescription").text() + '</span>' +
                                '<span class="SpanDiscountDetails" style="display:none">' + CurrentDeailsRow.find("DiscountDescription").text() + '</span>' +
                                '<span class="TotalInstallmentAmount" style="display:none">' + CurrentDeailsRow.find("InstallmentAmount").text() + '</span>' +
                                '<input class="ImgBtnForInstallmentDetails" type="image" style="width:18px;border-width:0px;" src="../../images/viewquestion.png" title="Click Here For Send Fee Remiander." /></td>'
                            '</tr>'
                            i = i + 1;
                        }
                    });
                    $('#GrdPayNow tbody').append(trforappend);

                    var _asaids = '', _id = 0;
                    setTimeout(() => {

                        $('#GrdPayNow').find('tr:gt(0)').each(function () {
                            if ($(this).find('td:eq(4)').find('input[type="checkbox"]').prop('checked') == true) {
                                _asaids = _asaids + $(this).find('td:eq(0)').find('input[type="hidden"]').val() + ',';
                            }
                            else {
                                if (evtfrom != "doc") {
                                    _id = $(this).find('td:eq(0)').find('input[type="hidden"]').val();
                                }
                                else {
                                    _id = $('#GrdPayNow').find('tr:eq(1)').find('td:eq(0)').find('input[type="hidden"]').val();
                                }
                            }
                        });


                    }, 50);

                    //Paid Fee Calculating Start Here
                    $('#GrdPaidFee tbody').find('tr:gt(0)').remove();
                    trforappend = ''
                    var xmlDocGeneralDetailsPaid = $.parseXML(data.d);
                    var xmlGeneralDetailsPaid = $(xmlDocGeneralDetailsPaid);
                    var TableGeneralDetailsPaid = xmlGeneralDetailsPaid.find("Table1");
                    var iPaid = 0, ClassPaid = "";
                    TableGeneralDetailsPaid.each(function () {
                        var CurrentDeailsRowPaid = $(this);
                        var paymode="";
                        if(CurrentDeailsRowPaid.find("PaymentModeName").text()=='case')
                        {
                            paymode='Cash';
                        }
                        else
                        {
                            paymode=CurrentDeailsRowPaid.find("PaymentModeName").text();
                        }
                        if (iPaid % 2 == 0)
                            ClassPaid = "stm_dark";
                        else
                            ClassPaid = "stm_light";
                        trforappend = trforappend + '<tr class=' + ClassPaid + '>'
                            + '<td><input type="hidden" value=' + CurrentDeailsRowPaid.find("ASAID").text() + ' />' + CurrentDeailsRowPaid.find("Number").text() + '</td>'
                            + '<td>' + CurrentDeailsRowPaid.find("PaidAmount").text() + '</td>'
                            + '<td>' + CurrentDeailsRowPaid.find("PaidTaxAmount").text() + '</td>'
                            + '<td>' + CurrentDeailsRowPaid.find("PaidDate").text() + '</td>'
                            + '<td>' + paymode + '</td>'
                            + '<td><input class="ImgGenerateRecipt" type="image" style="width:20px;border-width:0px;" src="../../images/recipt.png" title="Click Here For Pay Fee Now." /></td>'
                            + '<td>' + CurrentDeailsRowPaid.find("CommentOrRemark").text() + '</td>'
                            + '<td><input class="ImgBtnRollBackFee" type="image" style="width:20px;border-width:0px;" src="../../images/no.png" title="Click Here For Send Fee Remiander." /></td>'
                            + '</tr>'
                        iPaid = iPaid + 1;
                    });
                    $('#GrdPaidFee tbody').append(trforappend);
                    //Paid Fee Calculating Start Here

                    setTimeout(() => {
                        GetPaymentDetails(_asaids, 3, _id);
                    }, 50);
                },
                error: function (response) {
                    alertify.error('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
        function CallMethod(evtfrom) {
            //For Finding That Coming For Edit Start Here
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (parseInt(urlparam.length) > 1) {
                    BindAdmissionList(urlparam[1], evtfrom);
                }
            }
            //For Finding That Coming For Edit End Here
        }
    </script>
</asp:Content>
