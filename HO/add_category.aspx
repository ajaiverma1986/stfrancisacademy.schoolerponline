<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add_category.aspx.cs" Inherits="HO_add_category"  EnableEventValidation="false" MasterPageFile="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
   <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">
   <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Book Category Setting</h2>
   <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="containerHeadlinenew">
  </div>
  </div>
  
        <div id="divadd" style="display:none" class="for_sigle_row_form">
             <div id="multiple" class="for_sigle_row_form">
             <div class="for_sigle_row_form">
                <label> Category Name<span style="color: Red;">* </span></label>
                <asp:TextBox ID="txtname" runat="server" placeholder="Enter the Category Name" MaxLength="40" CssClass="inputforcategory"></asp:TextBox>
                <img src="../images/add.png" style="width: 16px; cursor: pointer;" alt="No Image" class="imageforadd" />
             </div>
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

         <div id="divaddsub" style="display:none" class="for_sigle_row_form">
              <div class="for_sigle_row_form">
                 <label>Select Category<span style="font-weight: bold; color: red">*</span></label>
                 <select id="ddlcategory"></select>
              </div>
             <div id="multipleSubcategory" class="for_sigle_row_form">
            <div class="for_sigle_row_form">
                <label>  Sub Category Name<span style="color: Red;">* </span></label>
                <asp:TextBox ID="TextBoxsubcategory" runat="server" placeholder="Enter Sub Category Name" MaxLength="40" CssClass="inputforsubcategory"></asp:TextBox>
                <img src="../images/add.png" style="width: 16px; cursor: pointer;" alt="No Image" class="imageforaddsubcategory" />
             </div>
        </div>
            <div class="for_sigle_row_form">
               <label> Status</label>
              <asp:CheckBox ID="Chkstatusofsub" runat="server" />

            </div>
           <div class="for_sigle_row_form">
            <asp:Button ID="Btnsavesubcategory" runat="server" Text="Save" CssClass="button_save" />
            <asp:Button ID="Btncanceltosubcategory" runat="server" Text="Back" CssClass="button2 inputinstitute" />
            </div>
        </div>
       <div id="Categorylist" class="for_sigle_row_form">
           <%-- <div style="float: left; width: 100%;" id="searchdiv">
            <asp:TextBox ID="Txtcategoryname" runat="server" style="height:23px;width:200px;" placeholder="Enter Book Category"></asp:TextBox>
           <img src="../images/clearsearch.png" id="btnclearalld" style="cursor: pointer" width="25" title="Clear All Search" alt="No Image" />
        </div>--%>
        <table id="Tablecategorylist" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 10px">S.No.</th>
                <th scope="col" style="width: 40px">Category Name<a class="addcategory" style="cursor:pointer;margin-left:10px;" title=" Click Here To Add Category">(Add)</a></th>
                <th scope="col" style="width: 40px">Sub Category Name<a class="addsubcategory" title=" Click Here To Add Sub Category" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
            </tr>
        </table>
          </div>
         <div id="displaysubcat" style="display:none" class="for_sigle_row_form">
             <input id="backtocategory" type="submit" class="button_save " value="Back" style="float:right;"/>  
             <div style="float: left; width: 100%;" id="searchsubcategorydiv" class="for_sigle_row_form">
            <asp:TextBox ID="Txtcategoryname" runat="server" style="height:23px;width:200px;" placeholder="Enter Book Sub Category"></asp:TextBox>
           <img src="../images/clearsearch.png" id="btnclearalld" style="cursor: pointer" width="25" title="Clear All Search" alt="No Image" />
        </div> 
             <table id="Tablesubcategory" class="stm" style="width: 100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width: 3%;">S.No.</th>
                        <th align="center" scope="col" style="width: 12%">Category Name</th>
                        <th align="center" scope="col" style="width: 12%">Sub Category Name</th>
                        <th align="center" scope="col" style="width: 8%;">Status</th>
                         <th align="center" scope="col" style="width: 5%">Edit</th>
                        
                    </tr>
                </table>
            </div>
         <div id="divProgressBar" class="progress"></div>
        </div>
        <script type="text/javascript">
            var categoryname = "", morecategory = "", settingstatus = ""; cat_id = "" ,categorydataid="";
            var subcategorynamesearch = "", categoryidforsub = "", settingstatusfoesubcat = "", subcategoryname = "", subcategoryid = "", categoryid = "";
            //*********************************************ready*********************************************
            $(document).ready(function () {
                categorylist();
                Bindsubcategory()//foradd sub category
                subcategorylist()//forsub category
                return false;
            });
        
            //*******************************************************Addcategory*********************************************

            $('.addcategory').click(function () {
                $('#divadd').show();
                $('#Categorylist').hide(500);
                categorylist();
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
            //****************************************************addclick***************************************************
            $('.imageforadd').live('click', function () {
                var trforadd = '<div class="for_sigle_row_form"><label> Category Name<span style="color: Red;">* </span></label><input type="text" placeholder="Enter the Category Name" class="inputforcategory"/><img class="imageforsub" alt="No Image" style="width: 16px; cursor: pointer;" src="../images/minus.png"></div>'
                $('#multiple').append(trforadd);
                return false;
            });
            $('.imageforsub').live("click", function () {
                $(this).parent('div').remove();
                return false;
            });
            //****************************************************savecategoryclick************************************
            $("#ctl00_ContentPlaceHolder1_btnsubmit").click(function () {
                var isvalidate = 0;
                $('#multiple').find('input[type="text"]').each(function () {
                    if ($(this).val() == '') {
                        alertify.error('Please Enter All The Textbox of Category name.');
                        $(this).focus();
                        isvalidate = 1;
                    }
                });
              if ($('.inputforcategory').val() == "") {
                    alertify.error('Enter The Category Name');
                    $('.inputforcategory').focus();
                    $('#ctl00_ContentPlaceHolder1_txtname').focus();
                    isvalidate = 1;
                }      
              if(isvalidate==0)
              {
                  insertdata();
              }
              return false;
            });
            //*********************************************Add Category*********************************************************
            function insertdata() {
                call_progressbar("start");
                categoryname = "";
                $('#multiple').find('.for_sigle_row_form').each(function () {
                    categoryname = categoryname + ',' + $(this).find('input[type="text"]').val();
                });
                categoryname = categoryname.slice(1, categoryname.length);
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
                    url: "add_category.aspx/savecategory",
                    data: "{'categoryname':'" + categoryname.split("'").join("~") + "','settingstatus':'" + settingstatus + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            alertify.success("Add Category Successfully")
                            $('#ctl00_ContentPlaceHolder1_txtname').val('');
                            $('.inputforcategory').val('');
                            $('#ctl00_ContentPlaceHolder1_btnsubmit').val("submit");
                            $('#multiple').find('div:gt(0)').remove();
                            categorylist();
                            $('#divadd').hide(500);
                            $('#Categorylist').show(500);
                            $('#ctl00_ContentPlaceHolder1_chkstatus').prop("checked", false);
                            return false;
                        }
                        else {
                            alertify.error("Category Name Already Exist")
                            $('#ctl00_ContentPlaceHolder1_txtname').val('');
                            $('#ctl00_ContentPlaceHolder1_txtname').focus();
                           
                          
                        }
                        call_progressbar("end");
                    },
                    error: function (data) {
                        call_progressbar("end");
                    }
                });
                return false;
            }
            //****************************************************Back to list*********************************************************
            $("#ctl00_ContentPlaceHolder1_btncancel").click(function () {
                $('#divadd').hide(500);
                $('#Categorylist').show(500);
                $('#ctl00_ContentPlaceHolder1_txtname').val('');
                $('#ctl00_ContentPlaceHolder1_btnsubmit').val("submit");
                $('#multiple').find('div:gt(0)').remove();
                $('.imageforadd').show(500);
                $('#ctl00_ContentPlaceHolder1_chkstatus').prop("checked", false);
                return false;
            });
            //********************************************addbutfor add category*****************************************************************
            $("#ctl00_ContentPlaceHolder1_ButtonaddCategory").click(function () {
                $('#Categorylist').hide(500);
                $('#divadd').show(500);
                $('#ctl00_ContentPlaceHolder1_txtname').val('');
                $('#ctl00_ContentPlaceHolder1_btnsubmit').val("submit");
                return false;
            });
            //**********************************************categorylist******************************************************************
            function categorylist() {
                call_progressbar('start')
                $('#Tablecategorylist tr:gt(0)').remove();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "add_category.aspx/fillcategorylist",
                    data: "{}",
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
                                   '<td><span class="categoryname">' + data.d[i].Categoryname + '</span><input value="' + data.d[i].Categoryname + '" class="txtcategoryupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../images/ic.png" title="Click here for cancel" class="sbtncancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../images/update.png" title="Click here for update" class="sbtnupdate"><img src="../images/edit.png" style="float:right;cursor:pointer" class="imgforeditcategory">' + '</td>' +
                                   '<td><input id="hfcatid" type="hidden" value="' + data.d[i].categoryid + '">' + data.d[i].SubCategoryname + '</td></tr>'
                                        
                                $('#Tablecategorylist').append(trforappend);
                            }
                        }
                        call_progressbar('end')
                    },
                    error: function (result) {
                        call_progressbar('end')
                    }
                });
            }
            // *******************************************************for edit category Detail******************************************************
            $('.imgforeditcategory').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').hide(500);
                $(this).parent('td').find('.sbtnupdate').show(500);
                $(this).parent('td').find('.sbtncancel').show(500);
                $(this).parent('td').find('input[type=text]').show(500);
                return false;
            })
            $('.sbtncancel').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').show(500);
                $(this).parent('td').find('.sbtnupdate').hide(500);
                $(this).parent('td').find('.sbtncancel').hide(500);
                $(this).parent('td').find('input[type=text]').hide(500);
                $(this).parent('td').find('.imgforeditcategory').show(500);
                return false;
            });
            //****************************************************************update category****************************************************************//
            $('.sbtnupdate').live("click", function () {
                var categorydata = $(this).parents('tr').children('td:eq(1)').find('input[type=text]').val()
                var valuectegoryid = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
                if (categorydata != '') {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "add_category.aspx/updatecategory",
                        data: "{'valuectegoryid':'" + valuectegoryid + "','categorydata':'" + categorydata.split("'").join("`") + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {

                            if (data.d > 0) {
                                alertify.success('Category Updated Successfully');
                                categorylist();
                                $(this).parent('td').find('.sbtnupdate').hide(500);
                                $(this).parent('td').find('.sbtncancel').hide(500);
                                $(this).parent('td').find('.imgforeditcategory').show(500);
                            }
                            call_progressbar("end");
                            valuectegoryid = 0, categorydata = '';
                        },

                        error: function (result) {
                            call_progressbar("end");
                        }

                    });
                }
                else {
                    alertify.error('Enter Category Name');
                    return false
                }
            })
            //*******************************************************Addsubcategory*********************************************

            $('.addsubcategory').live("click",function () {
               $("#ddlcategory").attr("disabled", false);
                $('#divaddsub').show();
                $('#divadd').hide();
                //subcategorylist();
                Bindsubcategory();
                subcategorylist();
                $('#Categorylist').hide(500);
                $('#ctl00_ContentPlaceHolder1_Chkstatusofsub').prop("checked", false);
            });
           
            // ***********************************************************bind category ddl for sub category*****************************************************
            function Bindsubcategory() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "add_category.aspx/bindcategory",
                    data: "",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#ddlcategory").html("");
                        $("#ddlcategory").append($("<option></option>").val('0').html('----Select Category----'));
                        $.each(data.d, function (key, value) {
                            $("#ddlcategory").append($("<option></option>").val(value.id).html(value.category));
                        });
                    },
                    error: function (result) {

                    },
                });
            }

            // ***********************************************************click event of submit button of sub category*****************************************************
            $("#ctl00_ContentPlaceHolder1_Btnsavesubcategory").click(function () {
                if ($('#ddlcategory').val() == "0") {
                    alertify.error('Select Category Name');
                    $('#ctl00_ContentPlaceHolder1_Btnsavesubcategory').focus();
                   return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_TextBoxsubcategory').val() == "") {
                    alertify.error('Enter Sub Category Name');
                    $('#ctl00_ContentPlaceHolder1_TextBoxsubcategory').focus();
                   return false;
                }
                else {
                    if ($(this).val() != "Update") {
                        insertdatatosubcategory();
                        return false;
                    }
                    else {
                        updatesubcategorydata();
                        return false;
                    }

                }
            
            });
            //****************************************************addclickto morecategory***************************************************
            $('.imageforaddsubcategory').live('click', function () {
                var trforaddsub = '<div class="for_sigle_row_form"><label> Sub Category Name<span style="color: Red;">* </span></label><input type="text" placeholder="Enter Sub Category Name" class="inputforsubcategory"/><img class="imageforremovesub" alt="No Image" style="width: 16px; cursor: pointer;" src="../images/minus.png"></div>'
                $('#multipleSubcategory').append(trforaddsub);
                return false;
            });
            $('.imageforremovesub').live("click", function () {
                $(this).parent('div').remove();
                return false;
            });
            //*********************************************Save Sub Category*********************************************************
            function insertdatatosubcategory() {
                call_progressbar("start");
                categoryidforsub = $('#ddlcategory').val();
                subcategoryname = "";
                $('#multipleSubcategory').find('.for_sigle_row_form').each(function () {
                    subcategoryname = subcategoryname + ',' + $(this).find('input[type="text"]').val();
                });
                subcategoryname = subcategoryname.slice(1, subcategoryname.length);
               settingstatusfoesubcat = $("#ctl00_ContentPlaceHolder1_Chkstatusofsub").is(":checked");
                if (settingstatusfoesubcat == true) {
                    settingstatusfoesubcat = 1
                }
                else {
                    settingstatusfoesubcat = 0
                }
              $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "add_category.aspx/savesubcategory",
                    data: "{'categoryidforsub':'" + categoryidforsub + "','subcategoryname':'" + subcategoryname.split("'").join("~") + "','settingstatusfoesubcat':'" + settingstatusfoesubcat + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            alertify.success("Add  Sub Category Successfully")
                            $('#ddlcategory').val('0');
                            $('#ctl00_ContentPlaceHolder1_TextBoxsubcategory').val('');
                            $('.inputforsubcategory').val('');
                            $('#ctl00_ContentPlaceHolder1_Btnsavesubcategory').val("submit");
                            $('#multipleSubcategory').find('div:gt(0)').remove();
                            categorylist();
                            subcategorylist();
                            $('#divaddsub').hide(500);
                            $('#Categorylist').show(500);
                            return false;
                        }
                        else {
                            alertify.error(" Sub Category Name Already Exist")
                            $('#ctl00_ContentPlaceHolder1_TextBoxsubcategory').val('');
                            $('#ctl00_ContentPlaceHolder1_TextBoxsubcategory').focus();
                        }
                        call_progressbar("end");
                    },
                    error: function (data) {
                        call_progressbar("end");
                    }
                });
                return false;
            }
               //**********************************************viewsubcategory***********************************************************************
               $('.viewsubcategory').live("click", function () {
                   $('#displaysubcat').show(500);
                   $('#Categorylist').hide(500);
                  categorydataid = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
                  subcategorylist();
                  return false;
               });
         
               //*****************************************searching****************************************************************************
               $("#ctl00_ContentPlaceHolder1_Txtcategoryname").on('change keyup paste', function () {
                   subcategorynamesearch = $('#ctl00_ContentPlaceHolder1_Txtcategoryname').val();
                   subcategorylist();
                   return false;
               });
               //****************************************************Clear All Feilds From here************************************************************
               $("#btnclearalld").click(function () {
                   $('#ctl00_ContentPlaceHolder1_Txtcategoryname').val('');
                   subcategorynamesearch = "";
                   subcategorylist();
                   return false;
               });
                //****************************************************bindSubcategorylist*****************************************************************
                 function subcategorylist() {
                call_progressbar('start')
                $('#Tablesubcategory tr:gt(0)').remove();
               $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "add_category.aspx/fillsubcategorylist",
                    data: "{'subcategorynamesearch':'" + subcategorynamesearch.split("'").join("~") + "','categorydataid':'" + categorydataid + "'}",
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
                                           '<td>' + data.d[i].Catname + '</td>' +
                                           '<td>' + data.d[i].SubCatname + '</td>' +
                                            '<td>' + data.d[i].SubStatus + '</td>'+
                                '<td><img class="foreditsubcategory" disabled type="image" style="width:15px;" src="../images/edit.png" title="click here to edit subcategory of book"/>' +
                                     '<input id="hfsubcatid" type="hidden" value="' + data.d[i].SubCateid + '"></td></tr>'

                                $('#Tablesubcategory').append(trforappend);
                            }
                        }
                        call_progressbar('end')
                    },
                    error: function (result) {
                        call_progressbar('end')
                    }
                });
            }

               //**********************************************************************edit subcategory*************************************************
                 $('.foreditsubcategory').live('click', function () {
                     $("#ddlcategory").attr("disabled", true);
                $('#divaddsub').show(500);
                $('#displaysubcat').hide(500);
                $('.imageforaddsubcategory').hide(500);
                subcategoryid = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
                Editsubcategory(subcategoryid);
                return false;
                 })
               //****************************************************************edit the sub category detail***************************************
               function Editsubcategory(subcategoryid) {
                   $.ajax({
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "add_category.aspx/Editdetailofsubcategory",
                       data: "{'subcategoryid':'" + subcategoryid + "'}",
                       dataType: "json",
                       success: function (data) {

                           if (data.d.length > 0) {
                               for (var i = 0; i < data.d.length; i++) {
                                   $("#ddlcategory").val(data.d[i].categoryidforsub)
                                   $("#ctl00_ContentPlaceHolder1_TextBoxsubcategory").val(data.d[i].Subcatenameforedit)
                                   if (data.d[i].Subcatstatus == 'Active')
                                   { $('#ctl00_ContentPlaceHolder1_Chkstatusofsub').prop("checked", true); }
                                   else { $('#ctl00_ContentPlaceHolder1_Chkstatusofsub').prop("checked", false); }
                                   $('#ctl00_ContentPlaceHolder1_Btnsavesubcategory').val("Update");

                               }
                           }

                       },
                       error: function (data) {

                       }
                   });
               }
               //*******************************************update the category detail**********************************
               function updatesubcategorydata() {
                   var ecatidforsucategory = $("#ddlcategory").val();
                   var esubcategoryname = $("#ctl00_ContentPlaceHolder1_TextBoxsubcategory").val();
                   var esubsettingstatus = $("#ctl00_ContentPlaceHolder1_Chkstatusofsub").is(":checked");
                   if (esubsettingstatus == true) {
                       esubsettingstatus = 1
                   }
                   else {
                       esubsettingstatus = 0
                   }

                   $.ajax({
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "add_category.aspx/updatesubcategory",
                       data: "{'ecatidforsucategory':'" + ecatidforsucategory + "','esubcategoryname':'" + esubcategoryname.split("'").join("~") + "','esubsettingstatus':'" + esubsettingstatus + "','subcategoryid':'" + subcategoryid + "'}",
                       dataType: "json",
                       async: false,
                       success: function (data) {
                           alertify.success('Sub Category updated successfully');
                           subcategorylist();
                           $('#ddlcategory').val('0');
                           $('#ctl00_ContentPlaceHolder1_TextBoxsubcategory').val('');
                           $('.inputforsubcategory').val('');
                           $('#ctl00_ContentPlaceHolder1_Btnsavesubcategory').val("submit");
                           $('#multipleSubcategory').find('div:gt(0)').remove();
                           $('#divaddsub').hide(500);
                           $('#displaysubcat').show(500);
                           return false;
                       },
                       error: function (data) {
                       }
                   });
                   return false;
               };
            //**************************************************back fromadd subcategory*************************************
               $("#ctl00_ContentPlaceHolder1_Btncanceltosubcategory").live("click",function () {
                   $('#ddlcategory').val('0');
                   $("#ddlcategory").attr("disabled", false);
                   subcategorylist();
                   $('#ctl00_ContentPlaceHolder1_TextBoxsubcategory').val('');
                   $('.inputforsubcategory').val('');
                   $('#ctl00_ContentPlaceHolder1_Btnsavesubcategory').val("submit");
                   $('#multipleSubcategory').find('div:gt(0)').remove();
                   $('.imageforaddsubcategory').show(500);
                   $('#divaddsub').hide(500);
                   $('#Categorylist').show(500);
                   return false;
               });
            //******************************************************addsubcategory***********************************************
               $('.Addsubcategory').live("click", function () {
                   $("#ddlcategory").attr("disabled", true);
                   $('#divaddsub').show(500);
                   $('#Categorylist').hide(500);
                   categoryid = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
                   Bindsubcategory()//foradd sub category
                  $("#ddlcategory").val(categoryid);
                  return false;
               });
            //*******************************************************back to category**************************************************
               $('#backtocategory').click(function () {
                   $('#displaysubcat').hide(500);
                   $('#Categorylist').show(500);
                   return false;
               });

        </script>
    </asp:Content>
