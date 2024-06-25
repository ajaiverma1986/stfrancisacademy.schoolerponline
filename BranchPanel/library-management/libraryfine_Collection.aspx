<%@ Page Title="Book Detail" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="libraryfine_Collection.aspx.cs" Inherits="BranchPanel_library_management_libraryfine_Collection"  EnableEventValidation="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
   <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">
   <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Library Fine List</h2>
   </div>
   <div id="finelist" class="for_sigle_row_form">
            <div style="float: left; width: 100%;" id="searchdiv" class="for_sigle_row_form">
           <select id="ddlsession" style="width:100px;height:31px"></select>
            <img src="../../images/clearsearch.png" id="btnclearalld" style="cursor: pointer" width="25" height="25px" title="Clear All Search" alt="No Image" />
          </div>
            <table id="Tablefinelist" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 5px">S.No.</th>
                <th scope="col" style="width: 15px">Student Name</th>
                <th scope="col" style="width: 30px">Admission No</th>
                <th scope="col" style="width: 70px">Library Card No</th>
                <th scope="col" style="width: 50px">Class</th>
                <th scope="col" style="width: 20px">Paid Fine</th>
            </tr>
           </table>
           </div>
           <div id="divProgressBar" class="progress"></div>
        </div>
     <script type="text/javascript">
         //*********************************************************variable***********************************************
         var fyid = 0;
         //********************************************************progressbar*****************************************
         function call_progressbar(progtype) {

             if (progtype == "start") {
                 $("#divProgressBar").find("#loader").remove();
                 $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                 $("#divProgressBar").addClass("progressAdd");
             }
             if (progtype == "end") {
                 $("#divProgressBar").find("#loader").remove();
                 $("#divProgressBar").removeClass("progressAdd");
             }
         }
   </script>
    <script type="text/javascript">
        $(document).ready(function () {
            Bindfinelist();
            Bindsession();
        $('#ddlsession').change(function () {
               fyid = $(this).val();
               Bindfinelist();
            })
               return false;
        });

        //********************************************************************clear all field*************************************************
        $("#btnclearalld").click(function () {
            $('#ddlsession').val('0');
            fyid = 0;
            Bindfinelist();
            return false;
        });
        //**********************************************booklist******************************************************************
        function Bindfinelist() {
            call_progressbar('start')
            $('#Tablefinelist tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "libraryfine_Collection.aspx/fillfinelist",
                data: "{'fyid':'" + fyid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                cssclass = 'stm_light';
                            else
                                cssclass = 'stm_dark';
                            trforappend = '<tr class=' + cssclass + '><td>' + data.d[i].rownumber + '</td>' +
                                       '<td>' + data.d[i].StudentName + '</td>' +
                                       '<td>' + data.d[i].AdmissionNo + '</td>' +
                                       '<td>' + data.d[i].Librarycard + '</td>' +
                                       '<td>' + data.d[i].classname + '</td>' +
                                       '<td>' + data.d[i].paidfine + '</td></tr>'

                            $('#Tablefinelist').append(trforappend);

                        }
                    }
                    else {
                        alertify.error('Record Is Not Exist.')
                    }
                    call_progressbar('end')
                },
                error: function (result) {
                    call_progressbar('end')
                }
            });
        }
 // ***********************************************************bind Fyid*****************************************************
        function Bindsession() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "bookdetail.aspx/bindsession",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlsession").html("");
                    $("#ddlsession").append($("<option></option>").val('0').html('-Session-'));
                    $.each(data.d, function (key, value) {
                        $("#ddlsession").append($("<option></option>").val(value.id).html(value.session));
                    });
                },
                error: function (result) {

                },
            });
        }
    
    </script>
</asp:Content>