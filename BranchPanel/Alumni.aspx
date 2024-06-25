<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="Alumni.aspx.cs" Inherits="BranchPanel_Alumni" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        function SaveDetails()
        {
            debugger;
            var formdata = new FormData();
            if ($('#FileUpload1').val() != "") {
                alert($('#FileUpload1').get(0).files[0].name);
                formdata.append('FileUpload1', $('#FileUpload1').get(0).files[0], $('#FileUpload1').get(0).files[0].name);
                $.ajax({
                    type: "POST",
                    url: "Alumni.aspx/saveDetails",
                    data: JSON.stringify(formdata),
                    contentType: false,
                    processData: false,
                    dataType: "json",
                    success: function (result) {
                        debugger;
                        var D = result;
                        if (result == '0') {                            
                            alert("Not saved, an error occured");                           
                        }                       
                        $('#FileUpload1').val("");
                    },
                    error: function (error) {
                        $('#err').html(JSON.stringify(error));
                    }

                });
            }
            else {
                alert('Please Choose a file');
            }
        }
    </script>
    <style>
        .frmctrl{
            height: 21px;
            border-radius: 3px;
            width:100%;
        }
    </style>
    <div class="row text-center" style="margin-bottom:20px; font-size:14px;font-weight:bold">
        Alumni Details
    </div>
    <div class="row">
        <div class="col-md-2 text-right">
            Name
        </div>
        <div class="col-md-2 text-left">
            <asp:TextBox ID="txtName" class="frmctrl" runat="server"></asp:TextBox>
        </div>
        <div class="col-md-2 text-right">
            Details
        </div>
        <div class="col-md-2 text-left">
            <asp:TextBox ID="TextBox1" class="frmctrl" runat="server"></asp:TextBox>
        </div>
        <div class="clear" style="margin-bottom:5px"></div>
        <div class="col-md-2 text-right">
            Photo
        </div>
        <div class="col-md-3 text-left">
            <asp:FileUpload ID="fileupload" runat="server" />
        </div>
    </div>
    <div class="row" style="text-align:center">
      <asp:Button runat="server" Text="Save" Width="70px" BackColor="LightBlue"  ID="btnSave" OnClick="btnSave_Click" />
    </div>
    <div class="row text-center" id="err" runat="server" style="margin-top:10px;">

    </div>
</asp:Content>

