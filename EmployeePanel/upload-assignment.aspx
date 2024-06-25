<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="upload-assignment.aspx.cs" Inherits="TeacherPanel_upload_assignment" %>

<%--<%@ Register Src="~/EmployeePanel/teacher.ascx" TagName="stu" TagPrefix="My" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .active8 {
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

        .stm_head th {
            padding-left: 10px;
            color: #000000 !important;
            font-family: Arial !important;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="upload-assignment.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li style="background: none;"><a class="active">Upload Assignment </a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="clear">
    </div>
   
    <div class="content_pane_cont input_content" id="contentPane">
       <%-- <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 0px; padding-top: 0px; position: relative;" class="containerHeadline">
            <label id="lbl" runat="server">
                Assignment Report
            </label>
            <asp:Button runat="server" ID="Button1" CssClass="button_save" Text="Upload Assignment "
                ToolTip="Click Here to Upload Assignment." OnClick="Button1_Click" Style="background-color: #2CA8C2; border: 1px solid #0A748A; color: #FFFFFF; float: right; margin-right: 10px; margin-top: -8px;" />
        </div>
        <div id="dd2" runat="server" visible="false">
            <div class="for_sigle_row_form">
                <label>
                    Batch<span style="color: Red">*</span>
                </label>
                <asp:DropDownList ID="ddlbatch" runat="server" Width="130px" OnSelectedIndexChanged="ddlbatch_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Value="0">Select Batch</asp:ListItem>
                </asp:DropDownList>
            </div>
              <div class="for_sigle_row_form">
                <label>
                    Subject<span style="color: Red">*</span>
                </label>
                <asp:DropDownList ID="ddlsubject" runat="server" Width="130px">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" id="DivForStudent" runat="server" visible="false">
                <label>
                Select Student<span style="color: Red">*</span></label>
                <div class="ad-batch-tbl" style="float:left;">
                      <asp:GridView ID="grdForStudent" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                        runat="server" CssClass="stm" ShowHeader="false" GridLines="None">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkclass" runat="server" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblsubject" runat="server" Text='<%# Bind("StudentName") %>'></asp:Label>
                                    <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("StuRegNo") %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                            </asp:TemplateField>
                             <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblrollno" runat="server" Text='<%# Bind("Roll_No") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <AlternatingRowStyle CssClass="stm_light" />
                    </asp:GridView>
                    </div>
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>
                    Assignment Topic<span style="color: Red">*</span>
                </label>
                <asp:TextBox ID="txttopic" runat="server" Width="200px" AutoPostBack="true" OnTextChanged="txttopic_TextChanged"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" style="position: relative;">
                <label>
                    Upload Result<span style="color: Red">*</span></label>
                <asp:FileUpload runat="server" ID="fu1" />&nbsp;
                <div class="df0" style="left: 480px;">
                </div>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="btnSend" runat="server" Text="Upload " CssClass="button_save" OnClientClick="return validate();"
                ToolTip="Click here to upload the assignment." OnClick="btnSend_Click" />
        </div>
        <asp:HiddenField ID="forurl" runat="server" />
        <div id="grdshw" runat="server" style="padding-right: 200px;">
          
            <asp:GridView ID="GridView1" AutoGenerateColumns="false" BorderWidth="0" Width="100%"
                RowStyle-BackColor="#E2E2E2" AlternatingRowStyle-BackColor="White" GridLines="None" runat="server" CssClass="stm" EmptyDataText="No record found!!!!!!!!!" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="S No.">
                        <ItemTemplate>
                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Topic Name">
                        <ItemTemplate>
                            <asp:Label ID="lblpname" Text='<%# Eval("topicname") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="12%" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="uploaded date">
                        <ItemTemplate>
                            <asp:Label ID="lblcname1" Text='<%# Eval("uploadon") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="12%" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Assignment File">
                        <ItemTemplate>
                            <asp:Label ID="lblfilename" Text='<%# Eval("document") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="12%" HorizontalAlign="Center" />
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
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:linkbutton runat="server" id="btnDelete" text="Delete" commandname="dele1" commandargument='<%#Eval("assignid") %>'
                                tooltip="Click here to delete this assignment" onclientclick="return confirm('Do you want to delete this assignment?');"
                                xmlns:asp="#unknown" />
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="20%" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
            </asp:GridView>
           
        </div>
    </div>
   
    <script type="text/javascript">
        $(document).ready(function () {
            $('.viewdocument').click(function () {
                var file = $(this).parent('td').parent('tr').find('td:eq(3)').find('span').text();
                var url = $('#ctl00_ContentPlaceHolder1_forurl').val() + '/BranchPanel/examresult/';
                window.open(url + file);
                return false;
            });
        });
    </script>
</asp:Content>