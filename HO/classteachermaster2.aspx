<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="classteachermaster2.aspx.cs" 
    Inherits="HO_classteachermaster2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Teacher in Class and Section</h2>
        </div>
        <br />
         <div class="for_sigle_row_form">
                <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlfinancialyear" runat="server" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </div>
       <%-- <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Applying For Class<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:DropDownList ID="ddlclass" runat="server">
                        <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                </div>--%>
       
        <br />
        <br />
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
                                            <asp:LinkButton ID="lblsubject" runat="server" Text='<%# Bind("Classname") %>' CommandName="c1"
                                                CommandArgument='<%# Bind("id") %>' ForeColor="black" Font-Underline="true"
                                                 ToolTip="Click here to update Course for this Branch."></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" ForeColor="Blue" />
                                    </asp:TemplateField>
                                    <%--add by swati--%>
                                     <asp:TemplateField HeaderText="Section">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblsection" runat="server" Text='<%# Bind("Sectionname") %>' CommandName="s1"
                                                CommandArgument='<%# Bind("id") %>' ForeColor="black" Font-Underline="true"
                                                 ToolTip="Click here to update Course for this Branch."></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" ForeColor="Blue" />
                                    </asp:TemplateField>
                                   <%-- add by swati finished--%>
                                    <asp:TemplateField HeaderText="Edit" Visible="false">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblsubject22" Font-Underline="true" ToolTip="Click here to update subject for this Class."
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
                        <div id="divTitle" runat="server" style="color:blue;font-weight:bold;margin-bottom:20px;text-align:center"></div>
                        <div style="width: 95%; float: left; margin-left: 10px; position: relative;margin-top:-14px">
                            <asp:LinkButton ID="lnk" runat="server" Text="EDIT" Visible="false" CssClass="gft"
                                OnClick="lnk_Click" ToolTip="Click here to add subject with Class"
                                 Font-Bold="true" Font-Size="Medium"></asp:LinkButton>
                            
                            <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="button_save sdr"
                                OnClick="btnSubmit_Click" />
                        </div>
                              <asp:GridView ID="GrdTeacher" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm" GridLines="None" 
                               EmptyDataText="Click on Edit Button to add Teacher with Class">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo1" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Select">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkTeacher" runat="server"  Checked='<%# Convert.ToBoolean(Eval("status"))%>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Teacher Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTachername" runat="server" Text='<%# Bind("EmpName") %>'></asp:Label>
                                            <asp:HiddenField ID="HDTea" runat="server" Value='<%# Bind("eid") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="60%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                        </div>
                    </td>
                    <td>
                         
                    </td>
                </tr>
            </table>          

        </div>
        <div style="margin-top: 15px;">
        </div>
    </div>
</asp:Content>