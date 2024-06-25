<%@ Page Title="School Management ERP- UnEnrolled Students" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"  AutoEventWireup="true" CodeFile="StudentWithoutFee.aspx.cs" Inherits="BranchPanel_Fee_Management_StudentWithoutFee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
    <style type="text/css">
        .conductedlecture234 {
            height: auto;
            margin-bottom: 3px;
        }
        #tblEmp_previous{
            cursor:pointer;
        }
         #tblEmp_next{
            cursor:pointer;
            border-width:0;
        }
    </style>
 
    <script src="../../js/jquery-3.3.1.js"></script>
    <script src="../../js/jquery.dataTables.min.js"></script>
    <script src="../../js/dataTables.buttons.min.js"></script>
    <script src="../../js/buttons.flash.min.js"></script>
    <script src="../../js/buttons.html5.min.js"></script>
      <script src="../../js/pdfmake.min.js"></script>
     <script src="../../js/JsZip.js"></script>
    <script src="../../js/buttons.print.min.js"></script>
    <script src="../../js/vfs_fonts.js"></script>   
   
  
    <link href="../../css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link href="../../css/dataTables.min.css" rel="stylesheet" />
    <script>   
       
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                BindClass();
                //FillField();
            });
            $('#ctl00_ContentPlaceHolder1_ddlclass').change(function () {
                BindSection();
                getData();
            });
            $('#ctl00_ContentPlaceHolder1_ddlSection').change(function () {
                getData();
                //FillField();
            });
            BindClass();
            getData();
        })

        function BindClass() {
            Fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overall-admissions.aspx/BindClassMethod",
                data: "{'fyid':'" + Fyid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
                    $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val('0').html('Select Class'));
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val(value.courseID).html(value.courseName));

                    });

                }
            });
        }
       
        
        function getData() {
            var classid = $("#ctl00_ContentPlaceHolder1_ddlclass").val();
            var sectionid = $("#ctl00_ContentPlaceHolder1_ddlSection").val();
        $('#tblEmp tbody').empty();
        $('#tblEmp').dataTable().fnClearTable();
        $('#tblEmp').dataTable().fnDestroy();
        $.ajax({
           type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "StudentWithoutFee.aspx/BindGrid",
                data: "{'ClassId':" + classid + ", 'sectionId':" + sectionid + "}",
                 dataType: "json",
                async: false,
                success: function (data) {
                    var sn = 1;
                    for (var i = 0; i < data.d.length; i++) {
                         var tr = '<tr><td>' + sn.toString() + '</td><td>' + data.d[i].Sturegno + '</td><td>' + data.d[i].classes + '</td><td>' + data.d[i].section + '</td><td>' + data.d[i].Name + '</td>';
                    tr = tr + '<td>' + data.d[i].Parent + '</td><td>' + data.d[i].Mobile + '</td></tr>';
                    sn = sn + 1;
                    $('#tblEmp').append(tr);
                    }
                //$(data).each(function () {
                //     var tr = '<tr><td>' + sn.toString() + '</td><td>' + this.Sturegno + '</td><td>' + this.Name + '</td><td>' + this.Amount + '</td>';
                //    tr = tr + '<td>' + this.Parent + '</td><td>' + this.Mobile + '</td></tr>';
                //    sn = sn + 1;
                //    $('#tblEmp').append(tr);

                   
                //})
                var dTable = $('#tblEmp').DataTable({
                    "pageLength": 15,
                    "pagingType": "simple",
                    dom: 'Bfrtip',
                        buttons: [                            
                           {
                                extend: 'excel',
                                messageTop: 'School Management ERP- UnEnrolled Students'
                            },
                            {
                                extend: 'pdf',
                                messageTop: 'School Management ERP- UnEnrolled Students'
                            },
                        ]

                });
            }

        });
         }

      
         function BindSection() {

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "overdue-fee.aspx/BindSectionMethod",
                 data: "{'ClassID':'" + $("#ctl00_ContentPlaceHolder1_ddlclass").val() + "'}",
                 dataType: "json",
                 async: false,
                 success: function (data) {
                     $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                     $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val('0').html('Select Section'));
                     $.each(data.d, function (key, value) {
                         $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.courseID).html(value.courseName));

                     });

                 }
             });
         }
    </script>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
              <div class="tbl-top-heading">
                <h2>UnEnrolled Students </h2>
                
            </div>                                                                       
            <div class="clear"></div>
            <div class="searchbar containerHeadline ">
                    <div class="clear"></div>
                   <asp:DropDownList ID="ddlfinancialyear" runat="server"  Style="height: 31px; width: 100px;">
                    </asp:DropDownList>
                     <asp:DropDownList ID="ddlclass" runat="server" Style="height: 31px; width: 140px;"></asp:DropDownList >
                    <asp:DropDownList ID="ddlSection" runat="server" Style="height: 31px; width: 140px;"></asp:DropDownList >
                  
                    <div class="clear"></div>
                </div>
               <div class="clear"></div>
            <div class="grid-data-resposive">
               <div class="divTableDataHolder m-l-sm m-r-sm">
                    <div class="divforbindgrid">
                        <table class="stm m-t-sm" style="width: 100%;" cellpadding="0" cellspacing="0" id="tblEmp">
                            <thead>
                                <tr class="stm_head" align="center">
                                <th align="center" scope="col">S.No.</th>
                                <th align="center" scope="col">Reg No</th>
                                    <th align="center" scope="col">Class</th>
                                    <th align="center" scope="col">Section</th>
                                <th align="center" scope="col">Name</th>
                               
                                <th align="center" scope="col">Parent</th>
                                <th align="center" scope="col">Mobile</th>                                
                                
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                          <table style="width: 100%">
                    
                </table>
                    </div>
                </div>
            </div>
            
        </div>
    </div>

    
</asp:Content>

