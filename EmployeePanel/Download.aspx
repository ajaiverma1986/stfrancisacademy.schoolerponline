@@@@@<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="Download.aspx.cs" Inherits="EmployeePanel_Download" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .downloadactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        #ctl00_head_PnlCust::-webkit-scrollbar-thumb {
            background-color: #B03C3F;
            border-radius: 10px;
        }

            #ctl00_head_PnlCust::-webkit-scrollbar-thumb:hover {
                background-color: #BF4649;
                border: 1px solid #333333;
            }

            #ctl00_head_PnlCust::-webkit-scrollbar-thumb:active {
                background-color: #A6393D;
                border: 1px solid #333333;
            }

        #chklistboxID {
            overflow: scroll;
        }

        .PnlDesign {
            width: 154px;
            height: auto;
            min-height: 200px;
            overflow: scroll;
            z-index: 1;
            overflow-x: hidden;
            border-radius: 10px;
            border: 3px solid #82403B;
        }

        #chklistboxID tr {
            border-top: 1px solid #82403B !important;
            border-bottom: 1px solid #82403B !important;
        }

        .drop-down {
            background: none repeat scroll 0 0 #e1f8f8;
            border: 1px solid #ddd;
            max-height: 400px;
            overflow-x: hidden;
            overflow-y: scroll;
            position: absolute;
            width: 247px;
            z-index: 2147483647;
        }

        .lblforclass {
            padding-left: 40px !important;
        }

        #ctl00_head_txtboxID {
            color: #000 !important;
            Width: 100px !important;
            margin-left: 25px !important;
            margin-bottom: 5px !important;
            border: 1px solid #D0D1D7 !important;
            text-align: center;
        }
    </style>


    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <asp:Label ID="lbluser" runat="server"></asp:Label>
                        <a id="lbLogOut" href="../emp-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Download
                    </h1>
                </div>

                <div class="main-content">

                   <div class="row">
                        <div class="col-md-12">
                            <div class="widget">
                                <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                    <i class="icon-reorder"></i>
                                    <asp:Button runat="server" ID="btnAdmitCard" OnClick="btnAdmitCard_Click" Text="Admit Card" BorderStyle="None" />

                                    <asp:DropDownList ID="ddlResultType" runat="server">
                                        <asp:ListItem Value="2" Text="Term II" Selected></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Term I"></asp:ListItem>
                                    </asp:DropDownList>
                                </h3>
                            </div>
                        </div>
                    </div>

                    <div class="row" id="divResult" runat="server">
                        <div class="col-md-12">
                            <div class="widget">
                                <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                    <i class="icon-reorder"></i>
                                    <asp:Button runat="server" ID="btnResult" OnClick="btnResult_Click" Text="Download Report Card" BorderStyle="None" />
                                    <asp:DropDownList ID="ddlTerm" runat="server">
                                        <asp:ListItem Value="2" Text="Report Card"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=""></asp:ListItem>
                                    </asp:DropDownList>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>

