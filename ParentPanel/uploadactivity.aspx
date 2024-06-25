<%@ Page Title="" Language="C#" MasterPageFile="~/ParentPanel/MasterPage.master" AutoEventWireup="true" CodeFile="uploadactivity.aspx.cs" Inherits="ParentPanel_uploadactivity" %>

<%--<%@ Register Src="~/ParentPanel/parentuser.ascx" TagName="stu" TagPrefix="My" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .active2 {
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

        th {
            text-align: center;
        }

        .col-xs-12 {
        }
    </style>

    <div class="clear"></div>

    <%-- <asp:UpdatePanel ID="updprofile" runat="server" UpdateMode="Conditional">
        <ContentTemplate>--%>
    <div class="page-content" id="contentPane">

        <%--  <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>

        <div class="page-header">
            <h1>
                <a href="studentviewinfo.aspx">Home</a>
                <small>
                    <i class="ace-icon fa fa-angle-double-right"></i>
                    Upload Activity
                </small>
            </h1>
        </div>

        <div class="row">

            <div class="dropzone dz-clickable" style="border-top: 2px solid #2bbce0; border-radius: 3px; padding: 18px; background: #fff;">

                <div class="dz-default dz-message" id="divtop" runat="server">
                    <span>
                        <span class=" bolder">upload activity</span>
                        <span class="smaller-80 grey"></span>
                        <br>
                        <asp:ImageButton runat="server" ID="Button2" OnClick="Button2_Click" src="../images/upload-icon.png" />
                    </span>
                </div>
            </div>

            <div class="clear"></div>

            <div class="col-xs-12  " id="divtopbtn" runat="server" style="padding-left: 0px; padding-right: 0px;">
                <div class="widget-box">
                    <div class="widget-header">
                        <h4 class="smaller">Upload photo
													<small></small>
                        </h4>
                    </div>
                    <div style="padding: 12px; background: #fff;">

                        <asp:Image runat="server" ID="imgsource1" CssClass="BotonDeImagen1" Visible="false" />

                        <div>
                            <label>
                            </label>
                            <asp:FileUpload runat="server" ID="FileUpload1" />&nbsp;
                    <div class="df0" style="left: 480px;">
                    </div>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <asp:Button runat="server" ID="btnSubmit" Text="Upload" CssClass="btn btn-primary" ToolTip="Click here to submit details." OnClick="btnSubmit_Click" />
                            <asp:Button runat="server" ID="btncancel" Text="Back" CssClass="btn btn-primary" OnClick="btncancel_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12" style="background: #fff; margin-top: 12px; padding-top: 17px; border: 1px solid #ddd; border-radius: 3px; border-top: 2px solid #2bbce0;">

                <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; margin-top: 13px; border-left: none !important; border-bottom: 1px solid #ddd;">
                    <tr>
                        <td>

                            <asp:GridView ID="grdfiles" runat="server" EmptyDataText="No data found !" CssClass="table table-striped table-bordered table-hover" BorderWidth="0" HeaderStyle-Height="30px"
                                AutoGenerateColumns="false" PagerSettings-Position="Bottom" GridLines="None"
                                PagerStyle-Font-Size="15px" PagerStyle-HorizontalAlign="Right"
                                Width="100%" OnRowCommand="grdfiles_RowCommand">

                                <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                                <Columns>
                                    <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Content" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Image runat="server" ID="imgsource" CssClass="BotonDeImagen" ImageUrl='<%# Eval("photo") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkview" runat="server" Text="Edit" CommandName="Edit1" CommandArgument='<%# Bind("fid") %>' CausesValidation="false" ToolTip="update"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_dark" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%-- </ContentTemplate>
        <Triggers>
        <asp:PostBackTrigger ControlID="btnSubmit" />
        </Triggers>
    </asp:UpdatePanel>--%>
    </div>
</asp:Content>