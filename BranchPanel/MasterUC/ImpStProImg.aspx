<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="ImpStProImg.aspx.cs" Inherits="BranchPanel_MasterUC_ImpStProImg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <div>
            <h1 style="font-size: 28px">Import Student Profile Pictures</h1>
            <table style="border: 0px; height: 280px;" align="center">
                <tr>
                    <td>
                        <table style="height: 140px;" align="center">
                            <tr>
                                <td align="center" style="border: 0px; width: 400px;" colspan="2">
                                    <div style="border: 0px; margin-top: 30px; margin-left: 10px;">                                    
                                       <asp:FileUpload AllowMultiple="true" ID="fileuploadimages" runat="server" /><br />    
                                        <b>Select Your Profile Pictures : </b>&nbsp;
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="border: 0px;">
                                    <asp:Button ID="btnUploadPP" runat="server" CssClass="button_save" Text="Upload" ToolTip="Upload Profile Pictures" OnClick="btnUploadPP_Click" />
                                </td>

                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div>
        <div>
            <h1 style="font-size: 28px">Upload Result </h1>
            <table style="border: 0px; height: 280px;" align="center">
                <tr>
                    <td>
                        <table style="height: 140px;" align="center">
                            <tr>
                                <td align="center" style="border: 0px; width: 400px;" colspan="2">
                                    <div style="border: 0px; margin-top: 30px; margin-left: 10px;">                                    
                                     <b>Select Pdf : </b>&nbsp;  <asp:FileUpload AllowMultiple="true" ID="fileupload1" runat="server" /><br />    
                                        
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="border: 0px;">
                                    <asp:Button ID="Button1" runat="server" CssClass="button_save" Text="Upload" ToolTip="Upload Profile Pictures" OnClick="btnUploadResult_Click" />
                                </td>

                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div>
        <div>
            <h1 style="font-size: 28px">Upload Admit card  </h1>
            <table style="border: 0px; height: 280px;" align="center">
                <tr>
                    <td>
                        <table style="height: 140px;" align="center">
                            <tr>
                                <td align="center" style="border: 0px; width: 400px;" colspan="2">
                                    <div style="border: 0px; margin-top: 30px; margin-left: 10px;">                                    
                                     <b>Select Pdf : </b>&nbsp;  <asp:FileUpload AllowMultiple="true" ID="fileupload2" runat="server" /><br />    
                                        
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="border: 0px;">
                                    <asp:Button ID="Button2" runat="server" CssClass="button_save" Text="Upload" ToolTip="Upload Profile Pictures" OnClick="BtnUploadResult_Clickadmit" />
                                </td>

                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>

