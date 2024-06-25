<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="OnlineFeeCollection.aspx.cs" Inherits="EmployeePanel_OnlineFeeCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .for_sigle_row_form1 {
            padding: 5px 0 !important;
            width: 100% !important;
            /* border-bottom: 1px solid #F5F5F5; */
            min-height: auto !important;
        }

            .for_sigle_row_form1 input[type="text"], input[type="select"], input[type="Password"] {
                background-color: #fcfcfc !important;
                border: 1px solid #ccc !important;
                box-shadow: none !important;
                color: #676767 !important;
                font-size: 14px !important;
                height: 28px !important;
                line-height: 25px !important;
                padding: 3px 6px !important;
                text-align: left !important;
                transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s !important;
                width: 199px !important;
                border-radius: 4px !important;
            }

        .stm_head th {
            font-size: 13px;
            padding: 0;
            padding: inherit;
        }

        .stm td {
            border-bottom: 1px solid #dddddd;
            line-height: 30px;
            /* padding-left: 20px; */
            /* padding-right: 5px; */
            color: #333;
            text-align: left;
            padding: inherit;
        }

        .even {
            border-bottom: 1px solid #7b7b7b;
            border-top: 1px solid #0D6B7e;
            line-height: 36px;
            padding-left: 10px;
            font-weight: bold;
            background: #fff;
        }

        .odd {
            border-bottom: 1px solid #7b7b7b;
            border-top: 1px solid #0D6B7e;
            line-height: 36px;
            padding-left: 10px;
            font-weight: bold;
            background: #F7F7F7;
        }
    </style>
    <script type="text/javascript">
        var myData = {}, asaid = 0, trindexforpay = 0, money = 0;
        $(document).ready(function () {
            $("#ctl00_head_txtFromDate,#ctl00_head_txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            })
            $("#ctl00_head_txtFromDate,#ctl00_head_txtFromDate").on('change', function () {
                BindFeeCollection();
                return false;
            });
            $("#ctl00_head_txtStdName").on('keyup', function () {
                BindFeeCollection();
                return false;
            });
            $("#ctl00_head_txtReceiptNo").on('keyup', function () {
                BindFeeCollection();
                return false;
            });
            $("#ctl00_head_txtStdMobNo").on('keyup', function () {
                BindFeeCollection();
                return false;
            });
            $("#ctl00_head_txtStdMobNo").on('keyup', function () {
                BindFeeCollection();
                return false;
            });
            $("#ctl00_head_txtTransID").on('keyup', function () {
                BindFeeCollection();
                return false;
            });
            $("#ctl00_head_txtBankName").on('keyup', function () {
                BindFeeCollection();
                return false;
            });
            $("#ctl00_head_txtAccount").on('keyup', function () {
                BindFeeCollection();
                return false;
            });
            BindFeeCollection();
        });

        function BindFeeCollection() {
            $('#GrdPayNow tr:gt(0)').remove();
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../Service.asmx/OnlineTransFeeCol",
                data: "{'Account':'" + $("#ctl00_head_txtAccount").val() + "','BankName':'" + $("#ctl00_head_txtBankName").val() + "','TransID':'" + $("#ctl00_head_txtTransID").val() + "','FromDate':'" + $("#ctl00_head_txtFromDate").val() + "','ToDate':'" + $("#ctl00_head_txtToDate").val() + "','Name':'" + $("#ctl00_head_txtStdName").val() + "','MobNo':'" + $("#ctl00_head_txtStdMobNo").val() +"','ReciptNo':'" + $("#ctl00_head_txtReceiptNo").val() +"'}",
                dataType: "json",
                success: function (data) {
                    $('#GrdPayNow tbody').find('tr:gt(0)').remove();
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    var i = 0, Class = "";
                    TableGeneralDetails.each(function () {
                        var tdStyle = '';
                        var CurrentDeailsRow = $(this);
                        if (i % 2 == 0)
                            Class = "even";
                        else
                            Class = "odd";

                        if (CurrentDeailsRow.find("InstallmentAmount").text() != "0.00") {
                            trforappend = trforappend + '<tr class=' + Class + '>'
                                + '<td ' + tdStyle + '><input type="hidden" value=' + CurrentDeailsRow.find("ASAID").text() + ' />' + (i + 1) + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("AdmissionNo").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("studentname").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("fathername").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("Classname").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("SectionName").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("PrimaryMobileNo").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("MonthName").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("FeeAmount").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("PaidDate").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("ReciptNo").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("PaidStatus").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("bank_txn").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("Prod").text() + '</td>'
                                + '<td ' + tdStyle + '>' + CurrentDeailsRow.find("CardNumber").text() + '</td>'
                            '</tr>'
                            i = i + 1;
                        }
                    });
                    $('#GrdPayNow tbody').append(trforappend);
                    result = 1;
                    return result;
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
    </script>
    <div class="content-wrapper col-md-9">
        <div class="content-inner">
            <div class="page-header">
                <div class="header-links hidden-xs">
                    <a id="lbLogOut" href="../emp-login.aspx"><i class="icon-signout"></i>Logout
                    </a>
                </div>
                <h1>
                    <i class="icon-user"></i>
                    Fee Details
                </h1>
            </div>
            <div class="main-content">
                <div class="for_sigle_row_form1">
                    <asp:TextBox runat="server" ID="txtFromDate" ReadOnly placeholder="From Date"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtToDate" ReadOnly placeholder="To Date"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtStdName" placeholder="Name"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtStdMobNo" placeholder="Mob No"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtReceiptNo" placeholder="Receipt No"></asp:TextBox>
                </div>
                 <div class="for_sigle_row_form1">
                    <asp:TextBox runat="server" ID="txtTransID" placeholder="Bank TransactionID"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtBankName" placeholder="Bank Name"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtAccount" placeholder="Account"></asp:TextBox>
                </div>

                <div style="background-color: #F7F7F7; height: auto !important;" class="overflow">
                    <table id="ctl00_head_tbl1" cellspacing="0" cellpadding="2" border="0" style="width: 100%; margin: 0; position: relative;">
                        <tbody>
                            <tr>
                                <td style="background: #ddd; padding-left: 5px; height: 30px; color: #222; border: #ccc solid 1px;">
                                    <b>UNPAID FEE (Excluding Tax)</b>
                                </td>
                            </tr>
                            <tr>
                                <td id="ctl00_head_tbl4" valign="top" style="width: 49%; border-bottom: 1px solid #DDDDDD; border-right: 1px solid #DDDDDD;">
                                    <asp:Panel ID="pnlMultipleBeneficiaries" ScrollBars="Auto" Style="overflow: scroll" runat="server" Width="1000px">
                                        <div>
                                            <table id="GrdPayNow" class="stm" cellspacing="0" cellpadding="5" border="0" width="1250px" style="border-collapse: collapse;">
                                                <tbody>
                                                    <tr class="stm_head" align="left">
                                                        <th align="left" scope="col">S.No.</th>
                                                        <th align="left" scope="col">Adm No</th>
                                                        <th align="left" scope="col">Name</th>
                                                        <th align="left" scope="col">FName</th>
                                                        <th align="left" scope="col">Class</th>
                                                        <th align="left" scope="col">Sec</th>
                                                        <th align="left" scope="col">Mob.No</th>
                                                        <th align="left" scope="col">Fee Month</th>
                                                        <th align="left" scope="col">Paid Amt ₹</th>
                                                        <th align="left" scope="col">Paid Date</th>
                                                        <th align="left" scope="col">Receipt No.</th>
                                                        <th align="left" scope="col">Payment Status</th>
                                                        <th align="left" scope="col">TransID</th>
                                                        <th align="left" scope="col">Account</th>
                                                        <th align="left" scope="col">Payment Detail</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

