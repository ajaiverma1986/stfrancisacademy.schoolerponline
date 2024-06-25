<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="studentFeeDeposite.aspx.cs" Inherits="EmployeePanel_studentFeeDeposite" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
    
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
    <script language="javascript" type="text/javascript">
        var myData = {}, asaid = 0, trindexforpay = 0;
        $(document).ready(function () {
            $('#btngetStudent').click(function () {          
                var err = 0, ermsg = '';
                if ($('#ctl00_head_txtStdregis').val() == '') {
                    ermsg = "Please Enter Student Registration No. \n";
                    err = 1;
                }            
                if (err > 0) {
                    alert(ermsg);
                    return;
                }
                else {                   
                    $.ajax({
                        type: "POST",
                        url: "Service.cs/BindFeeDetails",
                        data: '{name: "' + $('#txtStdregis').val() + '" }',       
                        contentType: "application/json; charset=utf-8",                     
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
                                trforappend = trforappend + '<tr class=' + Class + '>'
                                  + '<td><input type="hidden" value=' + CurrentDeailsRow.find("ASAID").text() + ' />' + CurrentDeailsRow.find("Number").text() + '</td>'
                                  + '<td>' + CurrentDeailsRow.find("InstallmentAmount").text() + '</td>'
                                  + '<td>' + CurrentDeailsRow.find("Tax").text() + '</td>'
                                  + '<td>' + CurrentDeailsRow.find("InstallmentDate").text() + '</td>'
                                  + '<td><input class="ImgBtnForPayNow" type="checkbox" title="Check Here For Pay Fee Now." /></td>'
                                  + '<td><input class="ImgBtnForSendFeeRemnainder" type="image" style="width:20px;border-width:0px;" src="../../images/message.png" title="Click Here For Send Fee Remiander." /></td>'
                                  + '<td>' +
                                  '<span class="SpanInstallmentName" style="display:none">' + CurrentDeailsRow.find("InstallmentName").text() + '</span>' +
                                  '<span class="SpanInstallmentDetails" style="display:none">' + CurrentDeailsRow.find("FeeDescription").text() + '</span>' +
                                  '<span class="SpanDiscountDetails" style="display:none">' + CurrentDeailsRow.find("DiscountDescription").text() + '</span>' +
                                  '<input class="ImgBtnForInstallmentDetails" type="image" style="width:18px;border-width:0px;" src="../../images/viewquestion.png" title="Click Here For Send Fee Remiander." /></td>'
                                '</tr>'
                                i = i + 1;
                            });
                            $('#GrdPayNow tbody').append(trforappend);
                            //Paid Fee Calculating Start Here
                            $('#GrdPaidFee tbody').find('tr:gt(0)').remove();
                            trforappend = ''
                            var xmlDocGeneralDetailsPaid = $.parseXML(data.d);
                            var xmlGeneralDetailsPaid = $(xmlDocGeneralDetailsPaid);
                            var TableGeneralDetailsPaid = xmlGeneralDetailsPaid.find("Table1");
                            var iPaid = 0, ClassPaid = "";
                            TableGeneralDetailsPaid.each(function () {
                                var CurrentDeailsRowPaid = $(this);
                                if (iPaid % 2 == 0)
                                    ClassPaid = "stm_dark";
                                else
                                    ClassPaid = "stm_light";
                                trforappend = trforappend + '<tr class=' + ClassPaid + '>'
                                + '<td><input type="hidden" value=' + CurrentDeailsRowPaid.find("ASAID").text() + ' />' + CurrentDeailsRowPaid.find("Number").text() + '</td>'
                                + '<td>' + CurrentDeailsRowPaid.find("PaidAmount").text() + '</td>'
                                + '<td>' + CurrentDeailsRowPaid.find("PaidTaxAmount").text() + '</td>'
                                + '<td>' + CurrentDeailsRowPaid.find("PaidDate").text() + '</td>'
                                + '<td>' + CurrentDeailsRowPaid.find("PaymentModeName").text() + '</td>'
                                + '<td><input class="ImgGenerateRecipt" type="image" style="width:20px;border-width:0px;" src="../../images/recipt.png" title="Click Here For Pay Fee Now." /></td>'
                                + '<td>' + CurrentDeailsRowPaid.find("CommentOrRemark").text() + '</td>'
                                + '<td><input class="ImgBtnRollBackFee" type="image" style="width:20px;border-width:0px;" src="../../images/no.png" title="Click Here For Send Fee Remiander." /></td>'
                                + '</tr>'
                                iPaid = iPaid + 1;
                            });
                            $('#GrdPaidFee tbody').append(trforappend);
                            //Paid Fee Calculating Start Here
                        },
                        error: function (response) {
                            alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                        }
                    });
                    location.reload(true);
                }
            });           
        }
        );
        </script>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane" style="color:white">
            <div class="tbl-top-heading">
                <h2>UNPAID FEE (Excluding Tax)</h2>
            </div>          

            <div class="clear"></div>
            <asp:TextBox ID="txtStdregis" runat="server" placeholder="Enter Reg. No."></asp:TextBox>            
            <asp:Button ID="btnFeeDetails" runat="server" Text="Enter Reg. No." OnClick="btnFeeDetails_Click"></asp:Button>            
            
           <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" >
            <Columns>
                 <asp:TemplateField HeaderText="S.No.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                 <asp:TemplateField HeaderText="Amount(₹)">
                        <ItemTemplate>
                           <asp:Label ID="txtCustomerId1" runat="server" Text='<%# Eval("ASAID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                 <asp:TemplateField HeaderText="Tax(₹)">
                        <ItemTemplate>
                            <asp:Label ID="txtCustomerId2" runat="server" Text='<%# Eval("InstallmentAmount") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                 <asp:TemplateField HeaderText="Due Date">
                        <ItemTemplate>
                            <asp:Label ID="txtCustomerId3" runat="server" Text='<%# Eval("InstallmentDate") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                <asp:TemplateField HeaderText="Pay">
                        <ItemTemplate>
                          <asp:checkbox id="CheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" xmlns:asp="#unknown" />
                        </ItemTemplate>
                    </asp:TemplateField>
                <asp:TemplateField HeaderText="Details">
                        <ItemTemplate>
                            <input class="ImgBtnForInstallmentDetails" type="image" style="width:18px;border-width:0px;" src="../images/viewquestion.png" title="Click Here For Send Fee Remiander." />
                        </ItemTemplate>
                    </asp:TemplateField>              
            </Columns>
        </asp:GridView>




           <%-- <table id="ctl00_ContentPlaceHolder1_tbl1" cellspacing="0" cellpadding="2" border="0" style="width: 75%; margin: 5px 0 0 11px; position: relative;">
                <tbody>                    
                    <tr>                       
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
            </table>           --%>
        </div>
        </div>         
    
</asp:Content>

