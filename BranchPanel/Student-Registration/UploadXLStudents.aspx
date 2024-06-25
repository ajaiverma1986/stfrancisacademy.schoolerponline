<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="UploadXLStudents.aspx.cs" Inherits="BranchPanel_Student_Registration_UploadXLStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="main-div-tbl">
            <div class="new-registration">
                <div class="sub-heading">
                    Student Information 
                                        <asp:Button ID="btnImportFormat" runat="server" Text="Download Import Format" CssClass="button_save" Style="float: right;" OnClick="btnImportFormat_Click" />
                </div>
                <div class="for_sigle_row_form" id="StudentPhotograph">
                    <label style="padding-top: 4px;">
                        Upload Student Data</label>
                    <asp:FileUpload ID="fileuploaderofstudentexeclData" runat="server" onchange="ShowpImagePreviewstudentphotograph(this)" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Save/Update</label>
                    <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" OnClick="btnforupdateorsave_Click1" CssClass="button_save" />
                    <asp:Button ID="btnforcancel" runat="server" Text="Cancel" OnClick="btnforcancel_Click" CssClass="button_cancel" />
                </div>
                <br />
                <br />
            </div>
        </div>
    </div>
</asp:Content>

