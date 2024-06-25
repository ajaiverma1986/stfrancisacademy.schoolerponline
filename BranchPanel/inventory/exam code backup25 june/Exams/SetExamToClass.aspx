<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="SetExamToClass.aspx.cs" Inherits="BranchPanel_Exams_SetExamToClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Exams</a></li>
            <li style="background: none;"><a class="active" href="#">Set Exam to Class</a></li>
        </ul>
        <div class="arrowt">
            <a href="exam_settings.aspx">
                <img src="../../images/back-button.png" alt="" /></a>
        </div>
    </div>
     <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Exam Name in Class</h2>
        </div>
        <br />
         <div class="for_sigle_row_form">
                <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlfinancialyear" runat="server" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </div>
        <br />
        <br />
        <div class="clear"></div>
          <div class="for_sigle_row_form">
                            <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="button_save sdr"
                                OnClick="btnSubmit_Click" />
                        </div>
         <div class="clear"></div>
        <div style="margin-top: 0px; position: relative;">
            <table cellpadding="2" cellspacing="0" border="0" style="width: 1000px; border-left: none !important;">
                <tr>
                    <td colspan="4" style="vertical-align: top; width: 500px;">
                        <div style="float: left; width: 500px; margin-left: 10px;">
                            <asp:GridView ID="grdBranch" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm" GridLines="None" OnRowCommand="grdBranch_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Class">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblexam" runat="server" Text='<%# Bind("classname") %>' CommandName="c1"
                                                CommandArgument='<%# Bind("id") %>' ForeColor="black" Font-Underline="true" ToolTip="Click here to update Course for this Branch."></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" ForeColor="Blue" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" Visible="false">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblexam22" Font-Underline="true" ToolTip="Click here to update exam for this Class."
                                                runat="server" Text="Edit" CommandName="c2" CommandArgument='<%# Bind("id") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                        </div>
                        <div class="clear">
                        </div>                       
                    </td>
                    <td valign="top" style="width: 500px;" id="tr2" runat="server">
                        <div style="width: 95%; float: left; margin-left: 10px; position: relative;margin-top:-14px">
                            <asp:LinkButton ID="lnk" runat="server" Text="EDIT" Visible="false" CssClass="gft"
                                OnClick="lnk_Click" ToolTip="Click here to add exam with Class" Font-Bold="true" Font-Size="Medium"></asp:LinkButton>
                            <asp:GridView ID="grdexam" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm" GridLines="None" EmptyDataText="Click on Edit Button to add exam with Class">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo1" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkclass" runat="server" Checked='<%# Convert.ToBoolean(Eval("status")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Exam Name List">
                                        <ItemTemplate>
                                            <asp:Label ID="lblexam123" runat="server" Text='<%# Bind("examname") %>'></asp:Label>
                                            <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("id") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                            <%--<asp:GridView ID="gridoptionalexam" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm1" GridLines="None" EmptyDataText="Click on Edit Button to add exam with Class">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo1" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkclass" Checked='<%#Eval("status") %>' runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Optional exam">
                                        <ItemTemplate>
                                            <asp:Label ID="lblexam123" runat="server" Text='<%# Bind("examname") %>'></asp:Label>
                                            <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("id") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>--%>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div style="margin-top: 15px;">
        </div>
    </div>
</asp:Content>

