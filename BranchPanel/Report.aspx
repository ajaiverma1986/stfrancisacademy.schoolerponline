<%@ Page Title="Report" Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs"  MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_Report" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .TestStyle {
            color: White;
            background: #14AE18;
        }

        .TestStyle1 {
            color: #fff;
            background: #f88b1c;
        }

        .TestStyle2 {
            color: #9ca0a0;
            background: #c5cbce;
        }

        .TestStyle3 {
            color: White;
            background: #c10714;
        }

        .TestStyle4 {
            color: #FFF;
            background: #f93240;
        }

            .TestStyle4 a {
                color: White;
            }

        .TestStyle3 a {
            color: #FFF;
        }

        .TestStyle2 a {
            color: #FFF;
        }

        .TestStyle1 a {
            color: #FFF;
        }

        .TestStyle a {
            color: #FFF;
        }
    </style>
    <script type="text/javascript">

        function CheckDate() {
            if (document.getElementById("ctl00_ContentPlaceHolder1_txtDate").value != "") {
                if (document.getElementById("ctl00_ContentPlaceHolder1_txtToDate").value == "") {
                    alert("Please Select To Date !");
                    document.getElementById("ctl00_ContentPlaceHolder1_txtToDate").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_txtToDate").value != "") {
                if (document.getElementById("ctl00_ContentPlaceHolder1_txtDate").value == "") {
                    alert("Please Select From Date !");
                    document.getElementById("ctl00_ContentPlaceHolder1_txtDate").focus();
                    return false;
                }

            }

            return true;
        }
    </script>
      <script type="text/javascript">
          $(document).ready(function () {
              $('#ctl00_ContentPlaceHolder1_btnreset').click(function () {

                  $('#ctl00_ContentPlaceHolder1_ddlClass').find('option:first').attr('selected', 'selected');
                  $('#ctl00_ContentPlaceHolder1_ddlbus').find('option:first').attr('selected', 'selected');

                  return false;

              });
              $('#ctl00_ContentPlaceHolder1_Button2').click(function () {
                  var pageno = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                  var searchvalue1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
                  //var searchvalue2 = $('#ctl00_ContentPlaceHolder1_ddlbus').value;
                  var searchvalue2 = $('#ctl00_ContentPlaceHolder1_ddlbus :selected').text();
                  var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                  $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                  setTimeout(function () {
                      $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                      if (pagesize == "Page Size") {

                          pagesize = 10
                      }

                      if (searchvalue1 == "0" && searchvalue2 == "--Select Bus--") {

                          searchvalue2 = "";

                          if (parseInt(pagesize) > 0) {

                              $.ajax({
                                  type: "POST",
                                  contentType: "application/json; charset=utf-8",
                                  url: "Report.aspx/bingrid1",
                                  data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                                  dataType: "json",
                                  success: function (data) {

                                      $.each(data.d, function (key, value) {
                                          $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                      });
                                  },
                                  error: function (result) {
                                      alert("Error");
                                  }
                              });

                              $.ajax({
                                  type: "POST",
                                  contentType: "application/json; charset=utf-8",
                                  url: "Report.aspx/BindDatatable",
                                  data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                                  dataType: "json",
                                  success: function (data) {

                                      $("[id*=gvdetails] tr:gt(1)").remove();

                                      for (var i = 0; i < data.d.length; i++) {
                                          var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                          $("[id$=gvdetails]").append(row);

                                          $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                          $(row).find(".studentname").html(data.d[i].studentname);
                                          $(row).find(".routeno").html(data.d[i].routeno);

                                          $(row).find(".busno").html(data.d[i].busno);
                                          $(row).find(".Classname").html(data.d[i].Classname);
                                          $(row).find(".areaname").html(data.d[i].areaname);
                                          $(row).find(".areaid").html(data.d[i].areaid);
                                          $(row).find(".zoneid").html(data.d[i].zoneid);
                                          $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                          $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                          $("[id*=gvdetails] tr").show();
                                          $("[id*=gvdetails] tr:eq(1)").hide();
                                      }
                                      $("[id*=gvdetails] tr").show();
                                      $("[id*=gvdetails] tr:eq(1)").hide();
                                      $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                                  },
                                  error: function (result) {
                                      alert("Error");
                                  }
                              });
                          }
                          return false;
                      }
                      else if (searchvalue1 > 0 && searchvalue2 == "--Select Bus--") {

                          searchvalue2 = "";
                          if (parseInt(pagesize) > 0) {

                              if (parseInt(pagesize) > 0) {

                                  $.ajax({
                                      type: "POST",
                                      contentType: "application/json; charset=utf-8",
                                      url: "Report.aspx/bingrid1",
                                      data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                                      dataType: "json",
                                      success: function (data) {

                                          $.each(data.d, function (key, value) {
                                              $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                          });
                                      },
                                      error: function (result) {
                                          alert("Error");
                                      }
                                  });

                                  $.ajax({
                                      type: "POST",
                                      contentType: "application/json; charset=utf-8",
                                      url: "Report.aspx/BindDatatable",
                                      data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                                      dataType: "json",
                                      success: function (data) {

                                          $("[id*=gvdetails] tr:gt(1)").remove();

                                          for (var i = 0; i < data.d.length; i++) {
                                              var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                              $("[id$=gvdetails]").append(row);

                                              $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                              $(row).find(".studentname").html(data.d[i].studentname);
                                              $(row).find(".routeno").html(data.d[i].routeno);

                                              $(row).find(".busno").html(data.d[i].busno);
                                              $(row).find(".Classname").html(data.d[i].Classname);
                                              $(row).find(".areaname").html(data.d[i].areaname);
                                              $(row).find(".areaid").html(data.d[i].areaid);
                                              $(row).find(".zoneid").html(data.d[i].zoneid);
                                              $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                              $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                              $("[id*=gvdetails] tr").show();
                                              $("[id*=gvdetails] tr:eq(1)").hide();
                                          }
                                          $("[id*=gvdetails] tr").show();
                                          $("[id*=gvdetails] tr:eq(1)").hide();
                                          $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                                      },
                                      error: function (result) {
                                          alert("Error");
                                      }
                                  });
                              }

                              return false;

                          }
                      }
                      else if (searchvalue1 == "0" && searchvalue2 != "") {

                          if (parseInt(pagesize) > 0) {

                              if (parseInt(pagesize) > 0) {

                                  $.ajax({
                                      type: "POST",
                                      contentType: "application/json; charset=utf-8",
                                      url: "Report.aspx/bingrid1",
                                      data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                                      dataType: "json",
                                      success: function (data) {

                                          $.each(data.d, function (key, value) {
                                              $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                          });
                                      },
                                      error: function (result) {
                                          alert("Error");
                                      }
                                  });

                                  $.ajax({
                                      type: "POST",
                                      contentType: "application/json; charset=utf-8",
                                      url: "Report.aspx/BindDatatable",
                                      data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                                      dataType: "json",
                                      success: function (data) {
                                          $("[id*=gvdetails] tr:gt(1)").remove();

                                          for (var i = 0; i < data.d.length; i++) {
                                              var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                              $("[id$=gvdetails]").append(row);

                                              $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                              $(row).find(".studentname").html(data.d[i].studentname);
                                              $(row).find(".routeno").html(data.d[i].routeno);

                                              $(row).find(".busno").html(data.d[i].busno);
                                              $(row).find(".Classname").html(data.d[i].Classname);
                                              $(row).find(".areaname").html(data.d[i].areaname);
                                              $(row).find(".areaid").html(data.d[i].areaid);
                                              $(row).find(".zoneid").html(data.d[i].zoneid);
                                              $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                              $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                              $("[id*=gvdetails] tr").show();
                                              $("[id*=gvdetails] tr:eq(1)").hide();
                                          }
                                          $("[id*=gvdetails] tr").show();
                                          $("[id*=gvdetails] tr:eq(1)").hide();
                                          $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                                      },
                                      error: function (result) {
                                          alert("Error");
                                      }
                                  });
                              }

                              return false;

                          }
                      }
                      else if (searchvalue1 > 0 && searchvalue2 != "") {

                          if (parseInt(pagesize) > 0) {

                              if (parseInt(pagesize) > 0) {

                                  $.ajax({
                                      type: "POST",
                                      contentType: "application/json; charset=utf-8",
                                      url: "Report.aspx/bingrid1",
                                      data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                                      dataType: "json",
                                      success: function (data) {

                                          $.each(data.d, function (key, value) {
                                              $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                          });
                                      },
                                      error: function (result) {
                                          alert("Error");
                                      }
                                  });

                                  $.ajax({
                                      type: "POST",
                                      contentType: "application/json; charset=utf-8",
                                      url: "Report.aspx/BindDatatable",
                                      data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                                      dataType: "json",
                                      success: function (data) {

                                          $("[id*=gvdetails] tr:gt(1)").remove();

                                          for (var i = 0; i < data.d.length; i++) {
                                              var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                              $("[id$=gvdetails]").append(row);

                                              $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                              $(row).find(".studentname").html(data.d[i].studentname);
                                              $(row).find(".routeno").html(data.d[i].routeno);

                                              $(row).find(".busno").html(data.d[i].busno);
                                              $(row).find(".Classname").html(data.d[i].Classname);
                                              $(row).find(".areaname").html(data.d[i].areaname);
                                              $(row).find(".areaid").html(data.d[i].areaid);
                                              $(row).find(".zoneid").html(data.d[i].zoneid);
                                              $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                              $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                              $("[id*=gvdetails] tr").show();
                                              $("[id*=gvdetails] tr:eq(1)").hide();
                                          }
                                          $("[id*=gvdetails] tr").show();
                                          $("[id*=gvdetails] tr:eq(1)").hide();
                                          $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                                      },
                                      error: function (result) {
                                          alert("Error");
                                      }
                                  });
                              }

                              return false;

                          }

                      }
                  }, 1000);
                  return false;

              });

          });
      </script>

     <script type="text/javascript">   // go on first page
         $(document).ready(function () {

             $('.first-click').click(function () {

                 // var pageno = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                 var searchvalue1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
                 var searchvalue2 = $('#ctl00_ContentPlaceHolder1_ddlbus :selected').text();
                 var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();

                 //$("#ctl00_ContentPlaceHolder1_PageNo").html("");
                 if (searchvalue2 == "--Select Bus--") {
                     searchvalue2 = "";

                 }

                 $("#ctl00_ContentPlaceHolder1_PageNo").val();
                 if (pagesize = "Page Size") {

                     pagesize = 10;
                 }

                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "Report.aspx/BindDatatable",
                     data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                     dataType: "json",
                     success: function (data) {
                         $("[id*=gvdetails] tr:gt(1)").remove();
                         if (data.d.length > 0) {
                             for (var i = 0; i < data.d.length; i++) {
                                 var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                 $("[id$=gvdetails]").append(row);

                                 $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                 $(row).find(".studentname").html(data.d[i].studentname);
                                 $(row).find(".routeno").html(data.d[i].routeno);

                                 $(row).find(".busno").html(data.d[i].busno);
                                 $(row).find(".Classname").html(data.d[i].Classname);
                                 $(row).find(".areaname").html(data.d[i].areaname);
                                 $(row).find(".areaid").html(data.d[i].areaid);
                                 $(row).find(".zoneid").html(data.d[i].zoneid);
                                 $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                 $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                 $("[id*=gvdetails] tr").show();
                                 $("[id*=gvdetails] tr:eq(1)").hide();

                             }

                             $("[id*=gvdetails] tr").show();
                             $("[id*=gvdetails] tr:eq(1)").hide();

                         }
                         else {
                             $("[id*=gvdetails] tr").show();
                             $("[id*=gvdetails] tr:eq(1)").hide();
                             $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                         }

                     },

                     error: function (result) {
                         alert("Error");

                     }

                 });

                 return false;
             });

         });
    </script>

    <script type="text/javascript">    // go on previous page

        $(document).ready(function () {
            $('.previous-click').click(function () {
                var pageno = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var searchvalue1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
                var searchvalue2 = $('#ctl00_ContentPlaceHolder1_ddlbus :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                if (searchvalue2 == "--Select Bus--") {
                    searchvalue2 = "";

                }
                $("#ctl00_ContentPlaceHolder1_PageNo").html("");

                if (pagesize = "Page Size") {
                    pagesize = 10;
                }

                if (pageno == "Page No") {
                    pageno = 1;
                }
                else if (pageno == "1") {

                    pageno = 1;
                }
                else {
                    pageno = parseInt(pageno) - 1;
                }

                $("#ctl00_ContentPlaceHolder1_PageNo").val(parseInt(pageno));

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Report.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gvdetails] tr:gt(1)").remove();
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                $("[id$=gvdetails]").append(row);

                                $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                $(row).find(".studentname").html(data.d[i].studentname);
                                $(row).find(".routeno").html(data.d[i].routeno);

                                $(row).find(".busno").html(data.d[i].busno);
                                $(row).find(".Classname").html(data.d[i].Classname);
                                $(row).find(".areaname").html(data.d[i].areaname);
                                $(row).find(".areaid").html(data.d[i].areaid);
                                $(row).find(".zoneid").html(data.d[i].zoneid);
                                $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();
                            }
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                        }
                        else {
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                            $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                return false;

            });

        });
    </script>

    <script type="text/javascript">   // go on next page

        $(document).ready(function () {
            $('.next-click').click(function () {

                var pageno = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var searchvalue1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
                var searchvalue2 = $('#ctl00_ContentPlaceHolder1_ddlbus :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                if (searchvalue2 == "--Select Bus--") {
                    searchvalue2 = "";

                }
                $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                if (pagesize == "Page Size") {

                    pagesize = 10;

                }

                if (pageno == "Page No") {
                    pageno = 1;
                    if (max = "1") {
                        pageno = 1;

                    }
                    else {
                        pageno = 2;
                    }

                }

                else if (parseInt(pageno) < parseInt(max)) {
                    pageno = parseInt(pageno) + 1;

                }
                else {
                    pageno = parseInt(pageno);
                }

                $("#ctl00_ContentPlaceHolder1_PageNo").val(parseInt(pageno));

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Report.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gvdetails] tr:gt(1)").remove();
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                $("[id$=gvdetails]").append(row);

                                $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                $(row).find(".studentname").html(data.d[i].studentname);
                                $(row).find(".routeno").html(data.d[i].routeno);

                                $(row).find(".busno").html(data.d[i].busno);
                                $(row).find(".Classname").html(data.d[i].Classname);
                                $(row).find(".areaname").html(data.d[i].areaname);
                                $(row).find(".areaid").html(data.d[i].areaid);
                                $(row).find(".zoneid").html(data.d[i].zoneid);
                                $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();
                            }
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                        }
                        else {
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                            $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                return false;
            });

        });
    </script>

    <script type="text/javascript">   // go on last page

        $(document).ready(function () {
            $('.last-click').click(function () {
                var pageno = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
                var searchvalue1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
                var searchvalue2 = $('#ctl00_ContentPlaceHolder1_ddlbus :selected').text();
                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();
                if (searchvalue2 == "--Select Bus--") {
                    searchvalue2 = "";

                }
                $("#ctl00_ContentPlaceHolder1_PageNo").html("");

                // $("#ctl00_ContentPlaceHolder1_PageNo").val(currentpage);
                if (pagesize = "Page Size") {
                    pagesize = 10;
                }
                if (pageno = "Page No") {
                    pageno = "1";
                    $("#ctl00_ContentPlaceHolder1_PageNo").val(pageno);

                }
                else if (pageno = "") {
                    pageno = "1";

                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Report.aspx/BindDatatable",
                    data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=gvdetails] tr:gt(1)").remove();
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                $("[id$=gvdetails]").append(row);

                                $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                $(row).find(".studentname").html(data.d[i].studentname);
                                $(row).find(".routeno").html(data.d[i].routeno);

                                $(row).find(".busno").html(data.d[i].busno);
                                $(row).find(".Classname").html(data.d[i].Classname);
                                $(row).find(".areaname").html(data.d[i].areaname);
                                $(row).find(".areaid").html(data.d[i].areaid);
                                $(row).find(".zoneid").html(data.d[i].zoneid);
                                $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();
                            }
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                        }
                        else {
                            $("[id*=gvdetails] tr").show();
                            $("[id*=gvdetails] tr:eq(1)").hide();
                            $("[id*=gvdetails] tbody").append("<tr > <td align = 'center'colspan='7'>No records found.</td></tr>")
                        }

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                return false;
            });

        });
    </script>
    <script type="text/javascript">  // bind gridview according to PAge size
        $(document).ready(function () {
            debugger;
            $("#ctl00_ContentPlaceHolder1_ddlRecordperPage").live('change', function (e) {

                var pageno = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();

                var searchvalue1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;

                var searchvalue2 = $('#ctl00_ContentPlaceHolder1_ddlbus :selected').text();

                var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();

                if (searchvalue2 == "--Select Bus--") {
                    searchvalue2 = "";

                }

                if (pageno = "Page No") {
                    pageno == "";

                }

                $("#ctl00_ContentPlaceHolder1_PageNo").html("");
                if (pagesize == "Page Size") {

                    pagesize = 10

                }

                if (searchvalue1 == "0" && searchvalue2 == "--Select Bus--") {
                    searchvalue2 = "";

                    if (parseInt(pagesize) > 0) {
                        var c = 1;

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Report.aspx/bingrid1",
                            data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                            dataType: "json",
                            success: function (data) {

                                $.each(data.d, function (key, value) {
                                    $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                    c = parseInt(c) + 1;
                                });
                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Report.aspx/BindDatatable",
                            data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                            dataType: "json",
                            success: function (data) {

                                $("[id*=gvdetails] tr:gt(1)").remove();

                                for (var i = 0; i < data.d.length; i++) {
                                    var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                    $("[id$=gvdetails]").append(row);

                                    $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                    $(row).find(".studentname").html(data.d[i].studentname);
                                    $(row).find(".routeno").html(data.d[i].routeno);

                                    $(row).find(".busno").html(data.d[i].busno);
                                    $(row).find(".Classname").html(data.d[i].Classname);
                                    $(row).find(".areaname").html(data.d[i].areaname);
                                    $(row).find(".areaid").html(data.d[i].areaid);
                                    $(row).find(".zoneid").html(data.d[i].zoneid);
                                    $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                    $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();
                                }
                                $("[id*=gvdetails] tr").show();
                                $("[id*=gvdetails] tr:eq(1)").hide();

                            },
                            error: function (result) {
                                alert("Error");
                            }
                        });
                    }
                    return false;
                }
                else if (searchvalue1 > 0 && searchvalue2 == "--Select Bus--") {
                    searchvalue2 = "";

                    if (parseInt(pagesize) > 0) {

                        if (parseInt(pagesize) > 0) {
                            var c = 1;

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Report.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $.each(data.d, function (key, value) {
                                        $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                        c = parseInt(c) + 1;
                                    });
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Report.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();

                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                        $("[id$=gvdetails]").append(row);

                                        $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                        $(row).find(".studentname").html(data.d[i].studentname);
                                        $(row).find(".routeno").html(data.d[i].routeno);

                                        $(row).find(".busno").html(data.d[i].busno);
                                        $(row).find(".Classname").html(data.d[i].Classname);
                                        $(row).find(".areaname").html(data.d[i].areaname);
                                        $(row).find(".areaid").html(data.d[i].areaid);
                                        $(row).find(".zoneid").html(data.d[i].zoneid);
                                        $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                        $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                    }
                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();

                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });
                        }

                        return false;

                    }
                }
                else if (searchvalue1 == "0" && searchvalue2 != "") {

                    if (parseInt(pagesize) > 0) {

                        if (parseInt(pagesize) > 0) {
                            var c = 1;

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Report.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $.each(data.d, function (key, value) {
                                        $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                        c = parseInt(c) + 1;
                                    });
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Report.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                                dataType: "json",
                                success: function (data) {
                                    $("[id*=gvdetails] tr:gt(1)").remove();

                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                        $("[id$=gvdetails]").append(row);

                                        $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                        $(row).find(".studentname").html(data.d[i].studentname);
                                        $(row).find(".routeno").html(data.d[i].routeno);

                                        $(row).find(".busno").html(data.d[i].busno);
                                        $(row).find(".Classname").html(data.d[i].Classname);
                                        $(row).find(".areaname").html(data.d[i].areaname);
                                        $(row).find(".areaid").html(data.d[i].areaid);
                                        $(row).find(".zoneid").html(data.d[i].zoneid);
                                        $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                        $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                    }
                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();

                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });
                        }

                        return false;

                    }
                }
                else if (searchvalue1 > 0 && searchvalue2 != "") {

                    if (parseInt(pagesize) > 0) {

                        if (parseInt(pagesize) > 0) {
                            var c = 1;

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Report.aspx/bingrid1",
                                data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $.each(data.d, function (key, value) {
                                        $("#ctl00_ContentPlaceHolder1_PageNo").append($("<option></option>").html(value));
                                        c = parseInt(c) + 1;
                                    });
                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });

                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "Report.aspx/BindDatatable",
                                data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + 1 + "'}",
                                dataType: "json",
                                success: function (data) {

                                    $("[id*=gvdetails] tr:gt(1)").remove();

                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                        $("[id$=gvdetails]").append(row);

                                        $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                        $(row).find(".studentname").html(data.d[i].studentname);
                                        $(row).find(".routeno").html(data.d[i].routeno);

                                        $(row).find(".busno").html(data.d[i].busno);
                                        $(row).find(".Classname").html(data.d[i].Classname);
                                        $(row).find(".areaname").html(data.d[i].areaname);
                                        $(row).find(".areaid").html(data.d[i].areaid);
                                        $(row).find(".zoneid").html(data.d[i].zoneid);
                                        $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                        $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                        $("[id*=gvdetails] tr").show();
                                        $("[id*=gvdetails] tr:eq(1)").hide();
                                    }
                                    $("[id*=gvdetails] tr").show();
                                    $("[id*=gvdetails] tr:eq(1)").hide();

                                },
                                error: function (result) {
                                    alert("Error");
                                }
                            });
                        }

                        return false;

                    }
                }

            });

        });
            </script>
   <script type="text/javascript">
       $(document).ready(function () {
           $("#ctl00_ContentPlaceHolder1_PageNo").change(function () {

               var pageno = $('#ctl00_ContentPlaceHolder1_PageNo :selected').text();
               var searchvalue1 = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
               var searchvalue2 = $('#ctl00_ContentPlaceHolder1_ddlbus :selected').text();
               var pagesize = $('#ctl00_ContentPlaceHolder1_ddlRecordperPage :selected').text();

               if (pagesize == "Page Size") {

                   pagesize = 10
               }

               if (searchvalue1 == "0" && searchvalue2 == "--Select Bus--") {
                   searchvalue2 = "";

                   if (parseInt(pagesize) > 0) {
                       $.ajax({
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "Report.aspx/BindDatatable",
                           data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                           dataType: "json",
                           success: function (data) {

                               $("[id*=gvdetails] tr:gt(1)").remove();

                               for (var i = 0; i < data.d.length; i++) {
                                   var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                   $("[id$=gvdetails]").append(row);

                                   $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                   $(row).find(".studentname").html(data.d[i].studentname);
                                   $(row).find(".routeno").html(data.d[i].routeno);

                                   $(row).find(".busno").html(data.d[i].busno);
                                   $(row).find(".Classname").html(data.d[i].Classname);
                                   $(row).find(".areaname").html(data.d[i].areaname);
                                   $(row).find(".areaid").html(data.d[i].areaid);
                                   $(row).find(".zoneid").html(data.d[i].zoneid);
                                   $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                   $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                   $("[id*=gvdetails] tr").show();
                                   $("[id*=gvdetails] tr:eq(1)").hide();
                               }
                               $("[id*=gvdetails] tr").show();
                               $("[id*=gvdetails] tr:eq(1)").hide();

                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });
                   }
                   return false;
               }
               else if (searchvalue1 > 0 && searchvalue2 == "--Select Bus--") {
                   searchvalue2 = "";
                   if (parseInt(pagesize) > 0) {
                       $.ajax({
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "Report.aspx/BindDatatable",
                           data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                           dataType: "json",
                           success: function (data) {

                               $("[id*=gvdetails] tr:gt(1)").remove();

                               for (var i = 0; i < data.d.length; i++) {
                                   var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                   $("[id$=gvdetails]").append(row);

                                   $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                   $(row).find(".studentname").html(data.d[i].studentname);
                                   $(row).find(".routeno").html(data.d[i].routeno);

                                   $(row).find(".busno").html(data.d[i].busno);
                                   $(row).find(".Classname").html(data.d[i].Classname);
                                   $(row).find(".areaname").html(data.d[i].areaname);
                                   $(row).find(".areaid").html(data.d[i].areaid);
                                   $(row).find(".zoneid").html(data.d[i].zoneid);
                                   $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                   $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                   $("[id*=gvdetails] tr").show();
                                   $("[id*=gvdetails] tr:eq(1)").hide();
                               }
                               $("[id*=gvdetails] tr").show();
                               $("[id*=gvdetails] tr:eq(1)").hide();

                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });
                   }
                   return false;
               }
               else if (searchvalue1 == "0" && searchvalue2 != "") {

                   if (parseInt(pagesize) > 0) {
                       $.ajax({
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "Report.aspx/BindDatatable",
                           data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                           dataType: "json",
                           success: function (data) {

                               $("[id*=gvdetails] tr:gt(1)").remove();

                               for (var i = 0; i < data.d.length; i++) {
                                   var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                   $("[id$=gvdetails]").append(row);

                                   $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                   $(row).find(".studentname").html(data.d[i].studentname);
                                   $(row).find(".routeno").html(data.d[i].routeno);

                                   $(row).find(".busno").html(data.d[i].busno);
                                   $(row).find(".Classname").html(data.d[i].Classname);
                                   $(row).find(".areaname").html(data.d[i].areaname);
                                   $(row).find(".areaid").html(data.d[i].areaid);
                                   $(row).find(".zoneid").html(data.d[i].zoneid);
                                   $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                   $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                   $("[id*=gvdetails] tr").show();
                                   $("[id*=gvdetails] tr:eq(1)").hide();
                               }
                               $("[id*=gvdetails] tr").show();
                               $("[id*=gvdetails] tr:eq(1)").hide();

                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });
                   }
                   return false;
               }

               else if (searchvalue1 > 0 && searchvalue2 != "") {

                   if (parseInt(pagesize) > 0) {
                       $.ajax({
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "Report.aspx/BindDatatable",
                           data: "{'pagesize':'" + pagesize + "','searchvalue1':'" + searchvalue1 + "','searchvalue2':'" + searchvalue2 + "','pageno':'" + pageno + "'}",
                           dataType: "json",
                           success: function (data) {

                               $("[id*=gvdetails] tr:gt(1)").remove();

                               for (var i = 0; i < data.d.length; i++) {
                                   var row = $("[id*=gvdetails] tr:eq(1)").clone(true);

                                   $("[id$=gvdetails]").append(row);

                                   $(row).find(".studentAdmissionnNo").html(data.d[i].studentAdmissionnNo);
                                   $(row).find(".studentname").html(data.d[i].studentname);
                                   $(row).find(".routeno").html(data.d[i].routeno);

                                   $(row).find(".busno").html(data.d[i].busno);
                                   $(row).find(".Classname").html(data.d[i].Classname);
                                   $(row).find(".areaname").html(data.d[i].areaname);
                                   $(row).find(".areaid").html(data.d[i].areaid);
                                   $(row).find(".zoneid").html(data.d[i].zoneid);
                                   $(row).find(".ZoneName").html(data.d[i].ZoneName);

                                   $(row).find(".swet").html(data.d[i].studentAdmissionnNo);

                                   $("[id*=gvdetails] tr").show();
                                   $("[id*=gvdetails] tr:eq(1)").hide();
                               }
                               $("[id*=gvdetails] tr").show();
                               $("[id*=gvdetails] tr:eq(1)").hide();

                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });
                   }
                   return false;
               }

           });

       });
   </script>
    <div class="clear">
    </div>
<div class="content_top">
        <ul>
            <li><a href="Default.aspx" >Home</a></li>
            <li><a >Transport Management</a></li>

            <li style="background: none;"><a class="active">Report</a></li>
        </ul>
    </div>
    <div id="divstudentadno1" runat="server">
        </div>
           <div class="content_pane_cont input_content" id="contentPane">

            <tr>
                <td width="100%" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px;
                       " class="stm">
                        <tr>
                            <td colspan="10" class="containerHeadlinenew" style="border-top:none;">
                                <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px"
                        Font-Size="11px" style="margin-top:5.9px;">
                        <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text="10"></asp:ListItem>
                        <asp:ListItem Value="2" Text="20"></asp:ListItem>
                        <asp:ListItem Value="3" Text="50"></asp:ListItem>
                        <asp:ListItem Value="4" Text="100"></asp:ListItem>
                        <asp:ListItem Value="5" Text="200"></asp:ListItem>
                    </asp:DropDownList>

                                <div style="float: right; width:351px;margin-top: 5.9px;"">

                                    <asp:DropDownList ID="ddlClass" runat="server"  Width="120px"
                                    Font-Size="11px">
                                </asp:DropDownList>
                                 <asp:DropDownList ID="ddlbus" runat="server"  Width="120px"
                                    Font-Size="11px">
                                </asp:DropDownList>
                                 <asp:Button ID="Button2" runat="server" CssClass="view-enquiry" Text="GO" style="background-color:green;" ToolTip="Click here to search" />

                               <asp:Button ID="btnreset" runat="server" Text="Reset" ToolTip="Click here for reset"
                            CssClass="view-enquiry1"  Style="margin-top: 0px;" />
                                 <%--<a id="Button2" class="button_save"style="margin-top:-14px;">GO</a>--%>
                            </div>
                                </td>
                        </tr>
                        </table>
                    </td>
                </tr>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">

                                <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AllowPaging="true"
                                    PageSize="25" AutoGenerateColumns="false" GridLines="None" Width="100%"
                                    CssClass="stm">
                                    <Columns>
                                       <%-- <asp:TemplateField  HeaderText="S. No." ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="8%" />
                                        </asp:TemplateField> --%>
                                         <asp:TemplateField HeaderText="Admission No"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lbladmin" runat="server" CssClass="studentAdmissionnNo" Text='<%# Bind("studentAdmissionnNo") %>'  > </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="14%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Student Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblname" runat="server" CssClass="studentname" Text='<%# Bind("studentname") %>'  > </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="14%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField  HeaderText="Class"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                 <asp:Label ID="lblclass" runat="server"  CssClass="Classname"  Text='<%# Bind("classname") %>' ></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="14%" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Bus No."  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                               <asp:Label ID="lblbusno" runat="server"  CssClass="busno"  Text='<%# Bind("busno") %>' ></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="14%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Zone" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                               <asp:Label ID="lblroute1" runat="server"  CssClass="ZoneName"  Text='<%# Bind("ZoneName") %>' ></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="14%" />
                                        </asp:TemplateField>
                                 <asp:TemplateField  HeaderText="Area" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                               <asp:Label ID="lblarea" runat="server" CssClass="areaname" Text='<%# Bind("areaname") %>' ></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="14%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Route" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                               <asp:Label ID="lblroute" runat="server" CssClass="routeno"  Text='<%# Bind("Routeno") %>' ></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="14%" />
                                        </asp:TemplateField>
                                    </Columns>
                                     <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                <td colspan="10" class="containerHeadline pagingstrip" style="padding-left: 10px; padding-bottom: 5px;">
                    <asp:DropDownList ID="PageNo" runat="server" Width="88px">
                    </asp:DropDownList>
                    <div style=" float: right; width:143px;">

                        <asp:ImageButton ID="firstpage" runat="server" CssClass="first-click" ImageUrl="~/images/first.gif" Width="25px" />

                        <asp:ImageButton ID="previous" runat="server" CssClass="previous-click" ImageUrl="~/images/previous.gif" Width="25px" />
                        <asp:ImageButton ID="next" runat="server" CssClass="next-click" ImageUrl="~/images/next.gif" Width="25px" />
                        <asp:ImageButton ID="last" runat="server" CssClass="last-click" ImageUrl="~/images/last.gif" Width="25px" />
                    </div>
                </td>
            </tr>
                    </table>

    <script>
        $(function () {
            $('#li1').click();
            $('#li12').css("background-color", "#f0881e");

            $('#l1').css("border-right", "4px solid #f0881e");
            $('#li1').css("background-color", "#252728");

        });
    </script>
          </div>
</asp:Content>