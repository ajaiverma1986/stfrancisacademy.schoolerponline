<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="EnrolledStudents.aspx.cs" Inherits="BranchPanel_Fee_Management_EnrolledStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
    <style type="text/css">
        #loadingDiv {
            position: fixed;
            left: 700px;
            top: 300px;
            width: 17%;
            height: 35%;
            z-index: 9999;
            background: url('../images/loader.gif') no-repeat rgb(249,249,249);
             background-size: 100% 100%;
        }
    </style>
    
    <style type="text/css">
        .conductedlecture234 {
            height: auto;
            margin-bottom: 3px;
        }

        #tblEmp_previous {
            cursor: pointer;
        }
        #tblEmp_next {
            cursor: pointer;
            border-width: 0;
        }
    </style>
 
    <%--<script src="../../js/jquery-3.3.1.js"></script>--%>
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
    <script type="text/javascript">
        $(document).ready(function () {
            //$('#content').append('');
            $('#loadingDiv').hide();  
            var year = 2025;
            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                BindClass();
                //FillField();
            });
            $('#ctl00_ContentPlaceHolder1_ddlStatus').change(function () {
                BindSection();               
                getData();
            });
            $('#ctl00_ContentPlaceHolder1_ddlclass').change(function () {
                BindSection();
                getData();
            });
            $('#ctl00_ContentPlaceHolder1_ddlSection').change(function () {
                getData();
                //FillField();
            });
            $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                yearRange: '1970:' + year
            });
            $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste', function () {
                getData();
                
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
            $('#loadingDiv').show();
            setTimeout(function () {
                var status = $("#ctl00_ContentPlaceHolder1_ddlStatus").val();
                var Fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();
                var classid = $("#ctl00_ContentPlaceHolder1_ddlclass").val();
                var sectionid = $("#ctl00_ContentPlaceHolder1_ddlSection").val();
                fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
                todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();

                $('#tblEmp tbody').empty();
                $('#tblEmp').dataTable().fnClearTable();
                $('#tblEmp').dataTable().fnDestroy();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "EnrolledStudents.aspx/BindGrid",
                    data: "{'Fyid':'" + Fyid + "','ClassId':" + classid + ", 'sectionId':" + sectionid + ", 'fromDate':'" + fromdate + "', 'toDate':'" + todate + "','status':'" + status + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $('#loadingDiv').hide();

                        var sn = 1;
                        for (var i = 0; i < data.d.length; i++) {
                            var tr = '<tr>' +
                                '<td> ' + sn.toString() + '</td>' +
                                '<td>' + data.d[i].Sturegno + '</td>' +
                                '<td>' + data.d[i].ClassName + '</td>' +
                                '<td>' + data.d[i].section + '</td>' +
                                '<td>' + data.d[i].Name + '</td>' +
                                '<td>' + data.d[i].Parent + '</td>' +
                                '<td>' + data.d[i].Mobile + '</td>' +
                                '<td><input class="chk" type="checkbox" id="chk' + i + '"></td>' +
                                '</tr>';
                            sn = sn + 1;
                            $('#tblEmp').append(tr);
                        }
                        var dTable = $('#tblEmp').DataTable({
                            "bDestroy": true,
                            "pageLength": 250,
                            "pagingType": "simple",
                            dom: 'Bfrtip',
                            buttons: [
                                {
                                    extend: 'excel',
                                    messageTop: 'School Management ERP- Enrolled Students'
                                },
                                {
                                    extend: 'pdf',
                                    messageTop: 'School Management ERP- Enrolled Students'
                                },
                            ]

                        }, Error(function () {
                            $('#loadingDiv').hide();
                        }));
                    }
                });
            }, 1000);
        }
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
         function ViewCard()
         {
             var rollnums = "";
             $("#tblEmp tr").each(function () {
                 var chkbox = $(this).find(".chk");
                 if ($(this).find('td').find('input[type="checkbox"]').is(':checked'))
                 {
                     rollnums=rollnums+","+ $(this).find('td:eq(1)').text();
                 }
                     
             });
             if (rollnums != "")
             {
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "EnrolledStudents.aspx/ViewAdmitCard",
                     data: "{'rolls':'" + rollnums + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {                         
                         window.open('../Exams/AdmitCard.aspx', '_blank');
                     }
                 });
             }
             
         }
    </script>
    <div class="branch-div-tbl">
        <div style="" id="loadingDiv">.</div>
        
        <div class="content_pane_cont input_content" id="contentPane">
              <div class="tbl-top-heading">
                <h2>Enrolled Students </h2>
                
            </div>                                                                       
            <div class="clear"></div>
            <div class="searchbar containerHeadline ">
                    <div class="clear"></div>
                   <asp:DropDownList ID="ddlfinancialyear" runat="server">
                    </asp:DropDownList>
                     <asp:DropDownList ID="ddlclass" runat="server"></asp:DropDownList >
                    <asp:DropDownList ID="ddlSection" runat="server" Style="height: 28px; width: 140px;"></asp:DropDownList >
                  <asp:TextBox ID="txtfromdate" runat="server" Placeholder="From Date" Width="140px" Height="25px" onkeypress="return false"></asp:TextBox>
               <asp:TextBox ID="txttodate" runat="server" Placeholder="To Date" Width="140px" Height="25px"  onkeypress="return false"></asp:TextBox>
                 <asp:DropDownList ID="ddlStatus" runat="server"  Style="">
                     <asp:ListItem Value="0" Selected="True">All</asp:ListItem>
                     <asp:ListItem Value="2">Enrolled</asp:ListItem>
                     <asp:ListItem Value="1">Un-Enrolled</asp:ListItem>
                    </asp:DropDownList>
                <input type="button" id="btnadmit" value="Admit Card" class="btn btn-success" onclick="ViewCard()"/>
                    <div class="clear"></div>
                </div>
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
                                <th align="center" scope="col">Select</th>                                
                                
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

