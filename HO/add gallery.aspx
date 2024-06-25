<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="add gallery.aspx.cs" Inherits="HO_add_gallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
                  <div class="for_sigle_row_form" style="margin-top: 15px;">
                <label>Upload Picture</label>
                <asp:FileUpload ID="fluploadproduct" runat="server" />
                      <div class="clear"></div>
                <a href="javascript:$('#<%=fluploadproduct.ClientID%>').fileUploadStart()"
                    style="text-decoration: underline !important; margin-left: 170px; margin-top: 15px; color: red; font-weight: bold">Click here for Start Upload</a>
                <div style="padding: 0px;" id="imagediv">
                </div>
            </div>
    <script src="scripts/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="scripts/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="scripts/jquery.uploadify.js"></script>
    <script type="text/javascript">
        $(window).load(
            function () {
                $("#<%=fluploadproduct.ClientID%>").fileUpload({
                    'uploader': 'Scripts/uploader.swf',
                    'cancelImg': '../images/cancel.png',
                    'buttonText': 'Browse Files',
                    'script': 'Scripts/ExamUpload.ashx',
                    'folder': 'school photo',
                    'fileDesc': 'Image Files',
                    'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                    'multi': true,
                    'auto': false,
                });
            }
               );
    </script>
    </asp:Content>
         
    


