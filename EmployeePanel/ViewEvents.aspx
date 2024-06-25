<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="ViewEvents.aspx.cs" Inherits="EmployeePanel_ViewEvents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../js/jquery-1.11.1.min.js"></script>
    <style>
        .profileactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
            font-size: 11px!important;
            font-weight: normal!important;
        }

        .trqualification {
            margin-top: 0px;
            height: 30px;
            border: 1px solid #CCCCCC!important;
            text-align: center;
            padding-left: 5px;
        }

        .tdfortrqualification {
            width: 20%;
            border: 0.50px solid #CCCCCC!important;
        }

        .eductabletxt {
            width: 100%;
            border: none;
            margin-left: 0px;
            text-transform: none!important;
        }

        .content-wrapper .main-content {
            height: 760px !important;
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
                       View Events
                    </h1>
                </div>

                <div class="main-content">
                    
                    <div class="row">
                        <div class="col-md-12">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Events List
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <asp:GridView runat="server" ID="grdEvents" HeaderStyle-BackColor="cornflowerblue" HeaderStyle-ForeColor="Black" AutoGenerateColumns="false" 
                                                CssClass="table table-responsive" AllowPaging="true" PageSize="5" OnPageIndexChanging="grdEvents_PageIndexChanging" >
                                                <Columns>
                                                   
                                                    <asp:TemplateField HeaderText="Date" HeaderStyle-CssClass="thsty" HeaderStyle-Width="200px">
                                                       <ItemTemplate>
                                                           <asp:Label ID="lblgrdDate" runat="server" Text='<%# Convert.ToDateTime(Eval("EventDate")).ToString("dd MMMM yyyy")%>'></asp:Label>
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Event" HeaderStyle-CssClass="thsty">
                                                       <ItemTemplate>
                                                           <asp:Label ID="lblgrdevent" TextMode="MultiLine" Height="50px" Enabled="false" Width="100%"  runat="server" Text='<%#Eval("EventDetails").ToString()%>'></asp:Label>
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>

