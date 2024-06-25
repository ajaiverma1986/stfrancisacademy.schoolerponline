<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/EmployeePanel/employee-panel-master.master" CodeFile="StudentReview.aspx.cs" Inherits="EmployeePanel_StudentReview" %>

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
                        Review by Teacher
                    </h1>
                </div>

                <div class="main-content">
                    <div class="row">
                        <%--===============Thid div is for Student details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>                                       
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Student Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tr  style="display:none">
                                                    <td class="t1"><span>Roll No:</span></td>
                                                    <td class="t2">
                                                        <label id="lblRollno" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Name:</span></td>
                                                    <td class="t2">
                                                        <label id="lblname" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Gender:</span></td>
                                                    <td class="t2">
                                                        <label id="lblGender" runat="server"></label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Date of Birth:</span></td>
                                                    <td class="t2">
                                                        <label id="lblDOB" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Student Address:</span></td>
                                                    <td class="t2">
                                                        <label id="lblAddress" runat="server"></label>
                                                    </td>
                                                </tr>
                                               
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>
                        <%--===============Thid div is for Guardian details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>                                       
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-group"></i>
                                           Latest Review
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>Date:</span></td>
                                                        <td class="t2">
                                                            <asp:Label id="lblDate" runat="server"></asp:Label>
                                                        </td>
                                                       
                                                    </tr>
                                                    <tr>
                                                        <td class="t1">
                                                            <span>Review: </span>
                                                        </td>
                                                       <td>
                                                           
                                                        </td>
                                                    </tr>
                                                    <tr>                                                        
                                                        <td class="t2" colspan="2">
                                                            <asp:TextBox TextMode="MultiLine" style="height: 77px; width: 100%;" runat="server" ID="txtReview"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for student login details===============--%>
                        
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Review History
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <asp:GridView runat="server" ID="grdReview" HeaderStyle-BackColor="cornflowerblue" AutoGenerateColumns="false" CssClass="table table-responsive" AllowPaging="true" PageSize="5" OnPageIndexChanging="grdReview_PageIndexChanging">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Teacher Name">
                                                       <ItemTemplate>
                                                           <asp:Label ID="lblgrdRevTeacher" runat="server" Text='<%#Convert.ToString(Eval("Teacher"))%>'>></asp:Label>
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Date">
                                                       <ItemTemplate>
                                                           <asp:Label ID="lblgrdRevDate" runat="server" Text='<%# Convert.ToDateTime(Eval("ReviewForDate")).ToString("dd-MM-yyyy")%>'></asp:Label>
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Review">
                                                       <ItemTemplate>
                                                           <asp:TextBox ID="txtgrdRev" TextMode="MultiLine" Height="50px" Width="100%" Enabled="false" runat="server" Text='<%#Eval("Review").ToString()%>'></asp:TextBox>
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%-- <asp:TemplateField HeaderText="Date">
                                                       <ItemTemplate>
                                                           <asp:ImageButton runat="server" ID="btnViewRevi"
                                                       </ItemTemplate>
                                                    </asp:TemplateField>--%>
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