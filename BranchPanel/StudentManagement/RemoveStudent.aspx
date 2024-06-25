<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"  EnableEventValidation="false" AutoEventWireup="true" CodeFile="RemoveStudent.aspx.cs" Inherits="BranchPanel_StudentManagement_RemoveStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            BindClass();
            $("#ctl00_ContentPlaceHolder1_ddlSection").on('change keyup paste', function () {
                $("#ctl00_ContentPlaceHolder1_hdfSectionID").val($("#ctl00_ContentPlaceHolder1_ddlSection").val());
            });
            $("#ctl00_ContentPlaceHolder1_ddlclass").on('change keyup paste', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../Fee Management/overdue-fee.aspx/BindSectionMethod",
                    data: "{'ClassID':'" + $("#ctl00_ContentPlaceHolder1_ddlclass").val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#ctl00_ContentPlaceHolder1_hdfClassID").val($("#ctl00_ContentPlaceHolder1_ddlclass").val());
                        $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                        $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val('0').html('Select Section'));
                        $.each(data.d, function (key, value) {
                            $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.courseID).html(value.courseName));

                        });
                        call_progressbar("end");
                    }
                });
                return false;
            });
        });
        function BindClass() {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "RemoveStudent.aspx/BindClassDDL",
                data: "{}",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
                    $('#ctl00_ContentPlaceHolder1_ddlclass').html('<option value="0">--Select Class--</option>');
                    $.each(data.d, function (key, value1) {
                        $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val(value1.ID).html(value1.ClassName));
                    });
                }
            });
        }
    </script>
    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
        <asp:HiddenField ID="hdfClassID" runat="server" Value="0" />
        <asp:HiddenField ID="hdfSectionID" runat="server" Value="0" />
         <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Delete Student</h2>            
        </div>
        <br />
        <div id="divall" runat="server">
            <div class="for_sigle_row_form">
                <label>
                    Branch Name : <span style="color: Red;">* </span>
                </label>
                
                <asp:RadioButtonList ID="rdbOption" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                    <asp:ListItem Value="1" Selected="True">Registration No Wise</asp:ListItem>
                    <asp:ListItem Value="2" >Branc Wise</asp:ListItem>
                     <asp:ListItem Value="3" >Class Wise</asp:ListItem>
                </asp:RadioButtonList>
            </div>     
            <div class="for_sigle_row_form" runat="server" id="tr">
                <label>
                    Student Reg No : <span style="color: Red;">*</span>
                </label>
                <asp:TextBox ID="txtFeeName" Text="" runat="server" placeholder="Enter Student Registration No Please."></asp:TextBox>
            </div>  
            <div class="for_sigle_row_form" runat="server" id="trClass">
                <label>
                    Class : <span style="color: Red;">*</span>
                </label>
                <asp:DropDownList ID="ddlclass" runat="server" Width="300px" Height="31px">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" runat="server" id="trSection">
                <label>
                    Section : <span style="color: Red;">*</span>
                </label>
                <asp:DropDownList ID="ddlSection" runat="server" Width="300px" Height="31px">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save" OnClick="btSave_Click"
                    ValidationGroup="g1" />
            </div>
        </div>        
    </div>
</asp:Content>

