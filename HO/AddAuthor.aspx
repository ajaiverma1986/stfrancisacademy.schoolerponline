<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddAuthor.aspx.cs" Inherits="HO_AddAuthor" EnableEventValidation="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
   <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">
   <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Author list</h2>
   <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="containerHeadlinenew">
   <asp:Button runat="server" ID="ButtonaddAuthor" Text="Add Author" CssClass="button_save" Style="float: right; height: 25px; margin-right: 12px; margin-top: 3px; padding: 0 5px 1px;" ToolTip="Click here to Add Author." />
  </div>
  </div>
  
        <div id="divadd" style="display:none">
             
             <div class="for_sigle_row_form">
                <label> Author Name<span style="color: Red;">* </span></label>
              

                <asp:TextBox ID="txtname" placeholder="Enter the Author Name" onkeypress="return lettersOnly(event)" MaxLength="40"  runat="server"></asp:TextBox>
              </div>
             <%-- <div class="for_sigle_row_form">
                <label>Author ID </label>
                <asp:TextBox ID="txtauthorid" runat="server" disabled="true"></asp:TextBox>
            </div>--%>
             <div class="for_sigle_row_form">
              <label>Discription</label>
              <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" placeholder="Enter the Description"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
               <label> Status</label>
              <asp:CheckBox ID="chkstatus" runat="server" />
            </div>
           <div class="for_sigle_row_form">
            <asp:Button ID="btnsubmit" runat="server" Text="Save" CssClass="button_save" />
            <asp:Button ID="btncancel" runat="server" Text="Back" CssClass="button2 inputinstitute" />
            </div>
        </div>
       <div id="Authorlist" class="for_sigle_row_form">
           <div style="float: left; width: 100%;" id="searchdiv" class="for_sigle_row_form">
            <asp:TextBox ID="Txtauthorname" runat="server" onkeypress="return lettersOnly(event)" style="height:23px;width:200px;" placeholder="Enter Author Name"></asp:TextBox>
           <img src="../images/clearsearch.png" id="btnclearalld" style="cursor: pointer" width="25" title="Clear All Search" alt="No Image" />
        </div>
        <table id="Tableauthorlist" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 10px">S.No.</th>
                <th scope="col" style="width: 95px">Author Id</th>
                <th scope="col" style="width: 40px">Author Name</th>
                <th scope="col" style="width: 40px">Status</th>
                <th scope="col" style="width: 30px">Edit</th>
                <th scope="col" style="width: 20px">Delete</th>
             </tr>
        </table>
            <label id="msg" style="height:23px;width:200px;display:none;border: 2px #2CA8C2 solid;">Sorry Record Is Not Exist!</label>
          
          </div>
          <div id="divProgressBar" class="progress"></div>
        </div>
     <script type="text/javascript">
         var Authorname = "", Description = "", settingstatus = ""; Authorid = "";
         var authornamesearch="";
         //********************************************************progressbar*****************************************
         function call_progressbar(progtype) {

             if (progtype == "start") {
                 $("#divProgressBar").find("#loader").remove();
                 $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
                 $("#divProgressBar").addClass("progressAdd");
             }
             if (progtype == "end") {
                 $("#divProgressBar").find("#loader").remove();
                 $("#divProgressBar").removeClass("progressAdd");
             }
         }
       
         //*******************************************************submit Author button*****************************************
         $("#ctl00_ContentPlaceHolder1_btnsubmit").click(function () {
           
             if ($('#ctl00_ContentPlaceHolder1_txtname').val() == "") {
                 alertify.error('Enter The Author Name');
                 $('#ctl00_ContentPlaceHolder1_txtname').focus();
                 return false;
             }
            
             else {
                 if ($(this).val() != "Update") {
                    
                     insertdata();
                     return false;
                 }
                 else {
                    
                 updateauthordata();
                     return false;
               }
            
             }

         });
      
         //*********************************************Add Author*********************************************************
         function insertdata() {
             call_progressbar("start");
             Authorname = $('#ctl00_ContentPlaceHolder1_txtname').val();
             Description = $('#ctl00_ContentPlaceHolder1_txtDescription').val();
             settingstatus = $("#ctl00_ContentPlaceHolder1_chkstatus").is(":checked");
             if (settingstatus == true) {
                 settingstatus = 1
             }
             else {
                 settingstatus = 0
             }

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "AddAuthor.aspx/saveAuthordata",
                 data: "{'Authorname':'" + Authorname.split("'").join("~") + "','Description':'" + Description.split("'").join("~") + "','settingstatus':'" + settingstatus + "'}",
                 dataType: "json",
                 success: function (data) {
                     if (data.d == 1) {
                         alertify.success("Add Author Successfully")
                         $('#ctl00_ContentPlaceHolder1_txtname').val('');
                         $('#ctl00_ContentPlaceHolder1_txtDescription').val('');
                         $('#ctl00_ContentPlaceHolder1_btnsubmit').val("submit");
                         Bindauthorlist();
                         $('#Authorlist').show(500);
                         $('#divadd').hide(500);
                         return false;
                     }
                     else {
                         alertify.error("Author Name Already Exist");
                         $('#ctl00_ContentPlaceHolder1_txtname').val('');
                         $('#ctl00_ContentPlaceHolder1_txtDescription').val('');
                         $('#ctl00_ContentPlaceHolder1_btnsubmit').val("submit");
                      return false;
                     }
                     call_progressbar("end");
                 },
                 error: function (data) {
                     call_progressbar("end");
                 }
             });
             return false;
         }
     </script>
    <script type="text/javascript">
        $(document).ready(function () {
           Bindauthorlist();
            //****************************************************Clear All Feilds From here************************************************************
            $("#btnclearalld").click(function () {
                $('#ctl00_ContentPlaceHolder1_Txtauthorname').val('');
                authornamesearch = "";
                Bindauthorlist();
             return false;
            });
            return false;
         });
   //*****************************************searching****************************************************************************
        $("#ctl00_ContentPlaceHolder1_Txtauthorname").keyup(function () {
            authornamesearch = $('#ctl00_ContentPlaceHolder1_Txtauthorname').val();
            Bindauthorlist();
            return false;
        });
        //****************************************************Addauthor*********************************************************
        $("#ctl00_ContentPlaceHolder1_ButtonaddAuthor").click(function () {
            $('#divadd').show(500);
            $('#Authorlist').hide(500);
            return false;
        });
        //****************************************************Back to list*********************************************************
        $("#ctl00_ContentPlaceHolder1_btncancel").click(function () {
            $('#divadd').hide(500);
            $('#Authorlist').show(500);
            $('#ctl00_ContentPlaceHolder1_txtname').val('');
            $('#ctl00_ContentPlaceHolder1_ButtonaddAuthor').show(500);
            $('#ctl00_ContentPlaceHolder1_txtDescription').val('');
            $('#ctl00_ContentPlaceHolder1_btnsubmit').val("submit");
            $('#ctl00_ContentPlaceHolder1_chkstatus').prop("checked", false);
            return false;
        });

   
        function lettersOnly(evt) {
           evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
          ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
          (charCode < 97 || charCode > 122)) {
                alertify.error("Please Enter Character Only.");
                return false;
            }
            else
                return true;
        };
        //**********************************************Authorlist******************************************************************
        function Bindauthorlist() {
            call_progressbar('start')
            $('#Tableauthorlist tr:gt(0)').remove();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddAuthor.aspx/fillauthorlist",
                data: "{'authornamesearch':'" + authornamesearch.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                   
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                if (i % 2 != 0)
                                    cssclass = 'stm_light';
                                else
                                    cssclass = 'stm_dark';
                                trforappend = '<tr class=' + cssclass + '><td>' + (i + 1) + '</td>' +
                                           '<td>' + data.d[i].Authorid + '</td>' +
                                           '<td>' + data.d[i].AuthorName + '</td>' +
                                           '<td>' + data.d[i].Status + '</td>' +
                                           '<td><img class="Authoridforedit" disabled type="image" style="width:15px;" src="../images/edit.png" />' +
                                           '<input id="hfclassid" type="hidden" value="' + data.d[i].Authorid + '"></td>' +
                                           '<td><input class=deleteimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../images/ic.png /></td></tr>';
                                $('#Tableauthorlist').append(trforappend);
                            }
                        }
                    
                    else {
                       
                     alertify.error("Sorry Record Is Not Exist!");
                    }
                                     call_progressbar('end')
                                   },
                error: function (result) {
                    call_progressbar('end')
                }
            });
        }
      
        // *******************************************************for edit Author Detail******************************************************
        $('.Authoridforedit').live('click', function () {
            $('#divadd').show(500);
            $('#Authorlist').hide(500);
            $('#ctl00_ContentPlaceHolder1_ButtonaddAuthor').hide(500);
           Authorid = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
            Edit(Authorid);
            return false;

        })
        //****************************************************************edit the author detail***************************************
        function Edit(Authorid) {
        $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddAuthor.aspx/Editdetail",
                data: "{'Authorid':'" + Authorid + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $("#ctl00_ContentPlaceHolder1_txtname").val(data.d[i].AuthorName)
                            $("#ctl00_ContentPlaceHolder1_txtDescription").val(data.d[i].Description);
                            if (data.d[i].Status == 'Active')
                            { $('#ctl00_ContentPlaceHolder1_chkstatus').prop("checked", true); }
                            else { $('#ctl00_ContentPlaceHolder1_chkstatus').prop("checked", false); }
                            $('#ctl00_ContentPlaceHolder1_btnsubmit').val("Update");
                         
                        }
                    }

                },
                error: function (data) {

                }
            });
        }
        //*******************************************update the author detail**********************************
        function updateauthordata() {
            var authorname = $('#ctl00_ContentPlaceHolder1_txtname').val()
            var description = $('#ctl00_ContentPlaceHolder1_txtDescription').val()
            var status = $("#ctl00_ContentPlaceHolder1_chkstatus").is(":checked");
            isstatus = "";
            if (status == true) {
                isstatus = 1;
            }
            else {
                isstatus = 0;
            }
          $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddAuthor.aspx/updateauthor",
                data: "{'authorname':'" + authorname.split("'").join("~") + "','description':'" + description.split("'").join("~") + "','isstatus':'" + isstatus + "','Authorid':'" + Authorid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    alertify.success('Author updated successfully');
                    Bindauthorlist();
                    $('#ctl00_ContentPlaceHolder1_txtname').val('');
                    $('#ctl00_ContentPlaceHolder1_txtDescription').val('');
                    $('#ctl00_ContentPlaceHolder1_btnsubmit').val("submit");
                    $('#Authorlist').show(500);
                    $('#divadd').hide(500);
                    return false;
                },
                error: function (data) {
                }
            });
            return false;
        };
        //**************************************************************delete book here*****************************************]

        $('.deleteimage').live("click", function () {
            if (confirm("Are you sure you want to delete this?")) {
                var Authoriddelete = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
                 $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "AddAuthor.aspx/deleteAuthor",
                    data: "{'Authorid':'" + Authoriddelete + "'}",
                    dataType: "json",
                    success: function (data) {
                        alertify.success("Author deleted successfully.");
                        Bindauthorlist();
                    },

                    error: function (result) {
                     
                    }
                });

            }
            return false;
        });
      
    </script>
</asp:Content>