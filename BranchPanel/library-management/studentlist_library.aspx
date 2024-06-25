<%@ Page Language="C#" AutoEventWireup="true" CodeFile="studentlist_library.aspx.cs" Inherits="BranchPanel_library_management_studentlist_library" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false"%>

 <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
     <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">
   <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Member list</h2>
   </div>
   <div id="studentdata" class="for_sigle_row_form">
           <div style="float: left; width: 100%;" id="searchdiv" class="for_sigle_row_form">
              <asp:TextBox ID="TxtName" runat="server" style="height:23px;width:150px;" placeholder="Enter Student Name"></asp:TextBox>
                 <asp:TextBox ID="TextAdmission" runat="server" style="height:23px;width:150px;" placeholder=" Enter Admission No."></asp:TextBox>
                 <asp:TextBox ID="Textlibrary" runat="server" style="height:23px;width:150px;" placeholder="Enter Library Card No."></asp:TextBox>
                <select id="ddlclass" style="width:160px;height:31px"></select>
               <select id="ddlstatus" style="width:160px;height:31px">
                   <option value="1">Active Member</option>
                   <option value="0">Deactive Member</option>
            </select>
            <img src="../../images/clearsearch.png" id="btnclearalld" style="cursor: pointer" width="25" height="25px" title="Clear All Search" alt="No Image" />
            </div>
            <table id="studentdetaillist" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 5px">S.No.</th>
                <th scope="col" style="width: 15px">Name</th>
                <th scope="col" style="width: 30px">Class</th>
                <th scope="col" style="width: 70px">Admission No.</th>
                <th scope="col" style="width: 50px">Library Card No.</th>
                <th scope="col" style="width: 50px">Deactivate</th>
            </tr>
           </table>
           </div>
           <div id="divProgressBar" class="progress"></div>
        </div>
     <script type="text/javascript">
         //*******************************************************variable***************************************************
         var classid = 0, studentname = "", Admissionno = "", librarycard = "", memberstatus = 1;
         //******************************************************************************************************************
         $(document).ready(function () {
             Bindclassddl();
             Bindstudentlist();
             $('#ddlclass').change(function () {
                 classid = $(this).val();
                 Bindstudentlist();
             })
             $('#ddlstatus').change(function () {
                 memberstatus = $(this).val();
                 Bindstudentlist();
             })
             $('#ctl00_ContentPlaceHolder1_TxtName').keyup(function () {
                 studentname = $(this).val();
                 Bindstudentlist();
             })
             $('#ctl00_ContentPlaceHolder1_TextAdmission').keyup(function () {

                 Admissionno = $(this).val();
                 Bindstudentlist();
             })
             $('#ctl00_ContentPlaceHolder1_Textlibrary').keyup(function () {

                 librarycard = $(this).val();
                 Bindstudentlist();
             })
             return false;
         })
         //********************************************************************clear all field*************************************************
         $("#btnclearalld").click(function () {
             $('#ctl00_ContentPlaceHolder1_TxtName').val('');
             $('#ctl00_ContentPlaceHolder1_TextAdmission').val('');
             $('#ctl00_ContentPlaceHolder1_Textlibrary').val('');
             $('#ddlclass').val('0');
             $('#ddlstatus').val('1');
             classid = 0, studentname = "", Admissionno = "", librarycard = "", memberstatus = 1
             ;
             Bindstudentlist();
             return false;
         });
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
         //********************************************************bindclass***************************************************
        
         function Bindclassddl() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "studentlist_library.aspx/Bindclass",
                 data: "{}",
                 dataType: "json",
                 async: false,
                 success: function (data) {
                     $("#ddlclass").html("");
                     $("#ddlclass").append($("<option></option>").val('0').html('-Select Class-'));
                     $.each(data.d, function (key, value) {
                         $("#ddlclass").append($("<option></option>").val(value.id).html(value.classname));
                     });
                 },
                 error: function (result) {
                 },
             });
         }
         //**********************************************booklist******************************************************************
         function Bindstudentlist() {
             call_progressbar('start')
             $('#studentdetaillist tr:gt(0)').remove();
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "studentlist_library.aspx/fillstudentlist",
                 data: "{'classid':'" + classid + "','studentname':'" + studentname.split("'").join("~") + "','Admissionno':'" + Admissionno.split("'").join("~") + "','librarycard':'" + librarycard.split("'").join("~") + "','memberstatus':'" + memberstatus + "'}",
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
                                        '<td>' + data.d[i].name + '</td>' +
                                        '<td>' + data.d[i].classname + '</td>' +
                                        '<td>' + data.d[i].Admissionno + '</td>' +
                                        '<td>' + data.d[i].librarycardno + '</td>'+
                                       '<td><input id="hfsturegno" type="hidden" value="' + data.d[i].sturegno + '">' + data.d[i].ismember + '</td></tr>'

                             $('#studentdetaillist').append(trforappend);

                         }
                     }
                     call_progressbar('end')
                 },
                 error: function (result) {
                     call_progressbar('end')
                 }
             });
         }
         //**************************************************************deactivate studeny from library here*****************************************]

         $('.deactivateimage').live("click", function () {
             if (confirm("Are you sure you want to Deactivate this from Library?")) {
                 var sturegnofordeactivate = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "studentlist_library.aspx/deactivatestudent",
                     data: "{'sturegnofordeactivate':'" + sturegnofordeactivate + "'}",
                     dataType: "json",
                     success: function (data) {
                         alertify.success("Student Deactivated Successfully.");
                         $('#ddlstatus').val('1');
                         memberstatus = 1
                         Bindstudentlist()
                      
                     },

                     error: function (result) {
                     }
                 });

             }
             return false;
         });
         //***********************************************************Activate the membership of library*****************************************************

         $('.editimage').live("click", function () {
             if (confirm("Are you sure you want to Activate this from Library?")) {
                 var sturegnofordeactivate = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "studentlist_library.aspx/Activatestudent",
                     data: "{'sturegnofordeactivate':'" + sturegnofordeactivate + "'}",
                     dataType: "json",
                     success: function (data) {
                     alertify.success("Student Activated Successfully.");
                     $('#ddlstatus').val('1');
                         memberstatus = 1
                         Bindstudentlist();
                     },

                     error: function (result) {
                   
                     }
                 });

             }
             return false;
         });
     </script>
     </asp:Content>