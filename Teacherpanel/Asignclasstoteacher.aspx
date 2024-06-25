<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="Asignclasstoteacher.aspx.cs" Inherits="Teacherpanel_Asignclasstoteacher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" media="all" />

    <style type="text/css">
        .leaveactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .Highlighted a {
            background-color: #FFFF00 !important;
            pointer-events: none;
        }

            .Highlighted a:hover {
                color: #ff0000 !important;
                pointer-events: none;
            }

        .active6 {
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

        .important {
            color: white!important;
        }

            .important a {
                color: white!important;
            }

        td {
            border-bottom: 1px black !important;
            border-top: 1px black !important;
        }

        th {
            border-top: 1px black !important;
        }

        .ui-datepicker table {
            border-collapse: collapse;
            font-size: 0.7em;
            margin: 0 0 0.4em;
            width: 100%;
        }

        .ui-datepicker-multi-2 .ui-datepicker-group {
            width: 45%;
        }

        .col-md-9 select {
            border: 1px solid #ccc;
            border-radius: 0 !important;
            color: #676767;
            margin-bottom: 0;
            padding: 4px 5px;
            width: 293px;
        }

        .col-md-9 textarea {
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 64px;
            line-height: 20px;
            margin-bottom: 0;
            margin-top: 0;
            padding: 3px 6px;
            text-align: left;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
            width: 300px;
        }

        .col-md-9 label {
            color: #616161;
            float: left;
            font-size: 13px;
            margin-right: 20px;
            padding-top: 2px;
            text-align: right;
            width: 123px;
        }

        body {
            color: #333333;
            font-family: "Open Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 13px;
            line-height: 1.42857;
        }

        .stm_head th {
            font-size: 13px;
        }

        .texthover {
            border: 1px solid red !important;
        }
    </style>
    <script type="text/javascript">
       
    </script>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                       <a id="lbLogOut" href="../teacher-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Assign Class
                    </h1>
                </div>
                <div class="clearfix">
                </div>

                <div class="main-content">
              
                      <div style="width: 100%; " id="divdatewiseleave">

                                <asp:GridView runat="server" ID="grdteacherclass" AllowPaging="true" EmptyDataText="No Class Details."
                                    PageSize="10" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None" OnRowCommand="grdteacherclass_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="6%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Class">
                                            <ItemTemplate>
                                                <asp:Label ID="class1" runat="server" Text='<%#Eval("classname") %>'> </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Take Attendance">
                                        <ItemTemplate>
                                            <asp:Button ID="btnatten" runat="server" Text="Attendance" CssClass="btn-info btn" CommandName="btnatten" CommandArgument='<%# Eval("tcid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Take Assignment">
                                        <ItemTemplate>
                                            <asp:Button ID="btnassign" runat="server" Text="Assignment" CssClass="btn-info btn" CommandName="btnassign" CommandArgument='<%# Eval("tcid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>

                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hfempcode" />
    <label id="chkapplyedleave" style="display: none"></label>
</asp:Content>

