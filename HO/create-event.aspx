<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="create-event.aspx.cs" Inherits="HO_create_event" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">School Events</span>
    </div>
     <div class="divforstm" style="min-height:350px">
            <table id="schoolevent" class="stm" style="width: 100%;">
                <tr class="stm_head" align="center">
                    <th align="center" scope="col" style="width:4%;">S.No.</th>
                     <th align="center" scope="col"  style="width:8%;">Events Date</th>
                     <th align="center" scope="col"> Events in School <a  class="addormodifyevents" style="cursor:pointer;">( Add Event)</a></th> 
                    <th align="center" scope="col"  style="width:5%;">Edit</th>
                    <th align="center" scope="col"  style="width:5%;">Delete</th>
                </tr>
            </table>
        </div>
                 <div class="schooleaddevent"  style="display:none">
            <table style="width: 100%;" class="maintablefordateeventadd">
                <tr>
                    <td>
                        <div class="for_sigle_row_form" style="margin-left:30px;">
                            <label>
                                Date<span style="color: #ff0066">*</span></label>
                            <input id="txttodate" class="inputdate" onkeydown="return false" type="text"placeholder="Enter Date Please...." onkeypress="return noAlphabets(event)" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form" style="margin-left:30px;">
                            <label>
                                Event Description<span style="color: #ff0066">*</span></label>
                             <textarea id="txtdescription" cols="20" rows="2" placeholder="Enter Event Description"></textarea>
                        </div>
                    </td>
                </tr>
                <tr style="margin-left:30px;">
                    <td colspan="3" style="padding-top: 10px!important">
                           <input type="button" class="button_save" id="submitevent" value="Submit" />
                           <input type="button"  class="button_cancel" id="cancelevent" value="Cancel" />
                   </td>
                </tr>
            </table>
        </div>
                      </div>   
                
      <script type="text/javascript">
          BindGrid();
          var Mode = 1, updateid = 0, eventdeleteid=0;
          $(document).ready(function () {
              //.................... start run time Edit  click event code..................
              $('.imgforedit').live('click', function () {
                  Mode = 3;
                  updateid = $(this).val();
                  $('.divforstm').css('display', 'none')
                  $('.schooleaddevent').css('display', 'block')
                  $('#txttodate').val($(this).parent('td').parent('tr').find('td:eq(1)').html());
                  $('#txtdescription').val($(this).parent('td').parent('tr').find('td:eq(2)').html());
                  return false;
              });
              //........................end  run time Edit  click event code..................

              //.................... start  run time Delete  click event code..................
              $('.imgfordelete').live('click', function () {
                   eventdeleteid = $(this).val();
                  var confirmdeletestatus = confirm('Are You Sure Yow Want To Delete This Event.?');
                  if (confirmdeletestatus == true) {
                      DeleteEvents();
                  }
                  return false;
              });
              //.................... End run time Delete click event code..................
            

              //....................Add click event code....................................
              $('.addormodifyevents').click(function () {
                  $('.schooleaddevent').css('display', 'block')
                  $('.divforstm').css('display','none')
                  $('.inputdate').val('')
                  $('#txtdescription').val('')
                  updateid = 0, Mode = 1, eventdeleteid = 0;
                  return false;
              });
              jQuery(function () {
                  var d = new Date();
                  var y = d.getFullYear();
                  jQuery("#txttodate").datepicker({
                      changeMonth: true,
                      changeYear: true,
                      yearRange: '2000:2050',
                      dateFormat: "dd MM yy",
                      defaultDate: new Date()
                  })
              });
               
              $('#cancelevent').click(function () {
                  $('.schooleaddevent').css('display', 'none')
                  $('.divforstm').css('display','block')
                  $('.inputdate').val('')
                  $('#txtdescription').val('')
                  Mode = 1, updateid = 0, eventdeleteid = 0;
                  return false;
              });
              //....................End add click event code......................

              //.................... start submit click event code..................
              $('#submitevent').click(function () {
                  if ($('#txttodate').val() == '') {
                      alertify.error('Select Date please.');
                      $('#txttodate').focus();
                      return false;
                  }
                  else if ($('#txtdescription').val() == '') {
                      alertify.error('Enter Description please.');
                      $('#txtdescription').focus();
                      return false;
                  }
                  else {
                      Savedescriptions()
                  }
                  return false();
              });
              //.............................End submit click event code..........................................

             //.............................start insert and update  event in this code.............................
              function Savedescriptions() {
                  var eventdate = $('#txttodate').val().trim();
                  var eventdescription = $('#txtdescription').val().trim();
                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "create-event.aspx/AddEvents",
                      data: "{'EventDate':'" + eventdate.split("'").join("`") + "','Mode':'" + Mode + "','EventDescription':'" + eventdescription.split("'").join("`") + "','updateid':'" + updateid + "'}",
                      dataType: "json",
                      success: function (data) {
                          if (data.d == 1) {
                              alertify.success("Event Submited Sucessfully");
                              $('.schooleaddevent').css('display', 'none')
                              $('.divforstm').css('display','block')
                              $('#txttodate').val('')
                              $('#txtdescription').val('')
                              BindGrid()
                          }
                          else if (data.d == 2) {
                              alertify.success("Event Update Sucessfully");
                              $('.schooleaddevent').css('display', 'none')
                              $('.divforstm').css('display', 'block')
                              BindGrid();
                          }
                          Mode = 1, updateid = 0;
                          return false;
                      },
                      error: function (result) {
                          alert("Some Network Problem");
                          return false;
                      }
                  });
              }

          });
          // ......................................End insert and update  event in this code....................................

          //.........................................start event grid in this code................................................
          function BindGrid() {
              var trforappend = "";
              $('#schoolevent tr:gt(0)').remove();
              call_progressbar('start')
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "create-event.aspx/BindGridByschool",
                  data: "{}",
                  dataType: "json",
                  async: false,
                  success: function (data) {
                      if (data.d.length > 0) {
                          for (var i = 0; i < data.d.length; i++) {
                              if (i % 2 != 0)
                                  trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td style="margin-left:400px;">' + data.d[i].eventdate + '</td><td>' + data.d[i].eventdescription + '</td><td><input class="imgforedit"  value="' + data.d[i].event_id + '" type="image" style="width:15px;" src="../images/edit.png"></td><td><input class="imgfordelete"  value="' + data.d[i].event_id + '" type="image" style="width:15px;" src="../images/delete3.png"/></td></tr>';
                              else
                                  trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td style="margin-left:400px;">' + data.d[i].eventdate + '</td><td>' + data.d[i].eventdescription + '</td><td><input class="imgforedit"  value="' + data.d[i].event_id + '" type="image" style="width:15px;" src="../images/edit.png"></td><td><input class="imgfordelete"  value="' + data.d[i].event_id + '" type="image" style="width:15px;" src="../images/delete3.png"/></td></tr>';
                              $('#schoolevent').append(trforappend);
                          }
                      }
                      call_progressbar("end");
                  },
                  error: function (result) {
                      call_progressbar("end");
                  }
              });
            
          }
          //.........................................End event grid in this code........................................................

          //......................................start Delete event in this code........................................................
          function DeleteEvents() {
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "create-event.aspx/DeleteStatusEvents",
                  data: "{'eventdeleteid':'" + eventdeleteid + "'}",
                  dataType: "json",
                  success: function (data) {
                      alertify.error("Event Deleted Sucessfully.");
                      BindGrid();
                  },
                  error: function (result) {
                      alertify.error("Some Network Problem");
                      return false;
                  }
              });
          }

          //.............................End Delete event in this code...............................................................................
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
    <div id="divProgressBar" class="progress"></div>
</asp:Content>

