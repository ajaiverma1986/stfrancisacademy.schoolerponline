<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="Create-Campaing.aspx.cs" Inherits="BranchPanel_Create_Campaing" ValidateRequest="false" %>

<%@ Register Assembly="Moxiecode.TinyMCE" Namespace="Moxiecode.TinyMCE.Web" TagPrefix="tinymce" %>
<%@ Register TagPrefix="cc" Namespace="Winthusiasm.HtmlEditor" Assembly="Winthusiasm.HtmlEditor" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <style>
        .Loader {
            position: absolute;
            top: 180px;
            z-index: 250;
        }

        .student-photo_frame {
            background: none repeat scroll 0 0 #F4F1F1;
            border: 1px solid #CCCCCC;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $('[id*=Button1]').click(function () {
                $('[id*=divcamp]').hide(500);
                $('[id*=divall]').show(500);
                $('[id*=txtSubject]').val('');
                //divcamp.Visible = false;
                //divall.Visible = true;
                //txtSubject.Text = "";
                return false;

            });
            $("#goback").click(function () {
                $('[id*=divcamp]').show(500);
                $('[id*=divall]').hide(500);
                return false;
            })
        });
    </script>
    <%--<div class="content_top">
        <ul>
            <li><a href="enquiry/viewenquiry.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat;
                padding-left: 21px;">Home</a></li>
            <li><a>Enquiry</a></li>
            <li style="background: none;"><a class="active" href="#">Template</a></li>
        </ul>
         <div class="arrowt">
              <a href="enquiry/send-sms.aspx"><img src="../images/back-button.png" src="Create-Campaing.aspx" ></a>
           

        </div>
      
    </div>--%>




    <div class="student-photo_frame content_top1" style="height: 128px; margin-top: 4px;">
        <div class="clear">
        </div>
        <div class="student-photo_frame_img">

            <img id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_imgstu" src="../images/camaing.png" style="border-width: 0px;">
        </div>
        <div style="float: left;">
            <div class="user-deatils">
                <dl>
                    <span id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_lblname">Campaing</span>
                </dl>
            </div>
            <div class="clear">
            </div>
            <div class="user-deatils">
                <dt></dt>
                <span></span>
            </div>
            <div class="clear">
            </div>
            <div class="user-deatils">
                <dt></dt>
                <span></span>
            </div>
        </div>
        <div class="clear">
        </div>
        <div style="margin-bottom: -3px; margin-top: 11px;">
            <a href="enquiry/send-sms.aspx" class="sgpt1">Send Sms </a>
            <a href="Create-Campaing.aspx" class="active3">Create template </a>
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">

        <div class="containerHeadline  cheadline1">
            Template List
             <asp:Button runat="server" ID="Button1" CssClass="button_save btnnew" Text="New Campaing"
                 ToolTip="Click here to add a new mail ." OnClick="Button1_Click" Style="padding: 4px;" />
        </div>
        <div class="divContent" align="center" style="position: relative">
            <%--<asp:UpdateProgress ID="Aupd1" runat="server" AssociatedUpdatePanelID="upd1"  >
        <ProgressTemplate >
               <asp:Image ID="img1" CssClass="Loader" runat="server" ImageUrl="~/images/loading.gif" />
        </ProgressTemplate>
        </asp:UpdateProgress>--%>
            <%-- <asp:UpdatePanel ID="upd1" runat="server">
                <ContentTemplate>--%>
            <table style="width: 100%; margin-left: 80px;" cellpadding="8" cellspacing="8">
                <tr>
                    <td colspan="2" style="text-align: center">

                        <asp:Label ID="lblMsg" runat="server" EnableViewState="false" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                


            </table>
            <div id="divall" runat="server" style="display: none">
                    <table>
                        <tr>
                            <td>
                                <label style="padding-top: 0px; padding-right: 16px; font-family: Arial; font-size: 15px; font-weight: 300">Create Template For</label>
                            </td>
                            <td>
                                <asp:RadioButtonList ID="isusedfor" runat="server" RepeatDirection="Horizontal" CellPadding="10"
                                    CellSpacing="10" CssClass="labelfor_radio" Style="margin-top: 9px;">
                                    <asp:ListItem Text="Mobile " Value="1"></asp:ListItem>
                                    <asp:ListItem Text="E-Mail" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-family: Arial; font-size: 15px; font-weight: 150">Heading
                            </td>
                            <td class="secondTD">
                                <div class="for_sigle_row_form" style="margin-left: 0px;">
                                    <asp:TextBox ID="txtSubject" runat="server" MaxLength="249" CssClass="span8" Width="550px"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <caption>
                            <br />
                            <br />
                            <tr>
                                <td class="firstTD">&nbsp;
                                </td>
                                <td class="secondTD">

                                    <FTB:FreeTextBox ID="ftCreateMail" runat="server" Height="250px" Width="700px">
                                    </FTB:FreeTextBox>

                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <br />
                                    <asp:Button ID="btnSendMail" runat="server" CssClass="button_save"
                                        OnClick="btnSendMail_Click" Text="Save" Style="padding-top: 4px; padding-bottom: 4px; margin-left: -52%;" />
                                    <a id="goback" style="cursor:pointer" class="button_save">Back </a>
                                </td>
                            </tr>
                        </caption>
                    </table>
                </div>
                

                <div align="center" id="divcamp" runat="server" style="display: none">
                    <table width="101%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 8px;">
                        <tr>
                            <td align="center" colspan="4" style="font-size: 15px; width: 100%;" valign="middle">
                                <asp:GridView ID="grdcompaining" AutoGenerateColumns="false" Width="100%" runat="server"
                                    CssClass="stm" GridLines="None" OnRowCommand="grdcompaining_RowCommand" OnRowDataBound="grdcompaining_RowDataBound" Style="font-size: 20px;">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label ID="lblsnox" runat="server">S.NO.</asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label ID="lblnamex" runat="server">Heading</asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" Text='<%# Eval("chead") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label ID="lbldeprt" runat="server">Text</asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbldepartment" Text='<%# Eval("ctext") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label ID="lblmobx" runat="server">companing for</asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblContactno" Text='<%# Eval("isusedfor") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Edit">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="statusEdit" runat="server" CommandName="edit0" CommandArgument='<%# Eval("campid") %>'
                                                    ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            <%--    </ContentTemplate>
            </asp:UpdatePanel>--%>
        </div>
    </div>
</asp:Content>
