<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="downloadassignment.aspx.cs" Inherits="StudentPanel_downloadassignment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../js/jquery-1.8.2.min.js"></script>
    <style type="text/css">
        .assignmentactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }

        .side-bar-wrapper .side-menu > li .assignmentactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }
    </style>
    <%-- <link href="css/exam.css" rel="stylesheet" />--%>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">

                    <h1>
                        <i class="fa fa-folder-open" style="color: white"></i>
                        Assignment
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">

                    <div class="student-panel-tbl">
                        <asp:GridView ID="gridforimagename" AutoGenerateColumns="false" Width="100%" runat="server" CssClass="stm"
                            HeaderStyle-Height="30px" GridLines="None">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSNo" Text='<%#Eval("assignid") %>' runat="server" CssClass="rownumber"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Batch/Lecture" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsubject" Text='<%#Eval("SubjectName") %>' Style="color: black" runat="server" ForeColor="Chocolate" CssClass="documenttype"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Topic" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltopic" Text='<%#Eval("topicname") %>' Style="color: black;" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUploadDate" Text='<%# Convert.ToDateTime(Eval("uploadon")).ToString("dd MMM yyyy") %>' Style="color: black;" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="File Name" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfilename" Text='<%#Eval("FileName") %>' Style="color: black;" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Download Assignment" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtndownloaddocument" ToolTip="Click Here To Download" Style="color: black" Text="Download" Width="25px" Height="25px" OnClick="lbtndownloaddocument_Click" runat="server" CssClass="downloaddocument"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                         <asp:TemplateField HeaderText="View Assignment" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldownlaodurl" runat="server" Text="" Style="display: none;"></asp:Label>
                                                <asp:LinkButton ID="lbtnviewdocument" ToolTip="Click Here To View" Style="color: black" Text="View" Width="25px" Height="25px" runat="server" CssClass="viewdocument"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_dark" />
                            <HeaderStyle CssClass="stm_head" />
                        </asp:GridView>
                    </div>

                    <asp:HiddenField ID="forurl" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        $(document).ready(function () {
            $('.viewdocument').click(function () {
                var file = $(this).parent('td').parent('tr').find('td:eq(4)').find('span').text();
                var url = $('#ctl00_head_forurl').val() + '/BranchPanel/Assignment/';
                window.open(url + file);

                return false;
            });
        });
    </script>
</asp:Content>
