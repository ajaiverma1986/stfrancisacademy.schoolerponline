<%@ Page Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="EventByTeacher.aspx.cs" Inherits="Teacherpanel_EventByTeacher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" media="all" />

    <script src="js/jquery-ui.min.js"></script>

  <%--  <style type="text/css">
        .leaveactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .Highlighted a {
            background-color: #FFFF00 !important;
            pointer-events: none;
        }

            .Highlighted a:hover {
                color: #ff0000 !important;
                pointer-events: none;
            }

        .active6 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .important {
            color: white!important;
        }

            .important a {
                color: white!important;
            }

        td {
            border-bottom: 1px black !important;
            border-top: 1px black !important;
        }

        th {
            border-top: 1px black !important;
        }

        .ui-datepicker table {
            border-collapse: collapse;
            font-size: 0.7em;
            margin: 0 0 0.4em;
            width: 100%;
        }

        .ui-datepicker-multi-2 .ui-datepicker-group {
            width: 45%;
        }

        .col-md-9 select {
            border: 1px solid #ccc;
            border-radius: 0 !important;
            color: #676767;
            margin-bottom: 0;
            padding: 4px 5px;
            width: 293px;
        }

        .col-md-9 textarea {
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 64px;
            line-height: 20px;
            margin-bottom: 0;
            margin-top: 0;
            padding: 3px 6px;
            text-align: left;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
            width: 300px;
        }

        .col-md-9 label {
            color: #616161;
            float: left;
            font-size: 13px;
            margin-right: 20px;
            padding-top: 2px;
            text-align: right;
            width: 123px;
        }

        body {
            color: #333333;
            font-family: "Open Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 13px;
            line-height: 1.42857;
        }

        .stm_head th {
            font-size: 13px;
        }

        .texthover {
            border: 1px solid red !important;
        }

    </style>
    <script type="text/javascript">
       
    </script>--%>
    <style>
         .thsty {
            color:black !important;
        }
    </style>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                       <a id="lbLogOut" href="../teacher-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Events
                    </h1>
                </div>
                <div class="clearfix">
                </div>

                <div class="main-content">
              
                      <div style="width: 100%; " id="divdatewiseleave">

                               <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Events</h2>
            </div>
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        Events Information
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Class <span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlapplyingforclass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlapplyingforclass_SelectedIndexChanged">
                            <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="a" runat="server" ControlToValidate="ddlapplyingforclass" Display="Dynamic"
                            InitialValue="0" ErrorMessage="Select class" ForeColor="Red" Font-Size="Small">

                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Section <span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlsection" runat="server" OnSelectedIndexChanged="ddlsection_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="0">--Select  Section--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="a" runat="server" ControlToValidate="ddlsection" Display="Dynamic"
                            InitialValue="0" ErrorMessage="Select Section" ForeColor="Red" Font-Size="Small">

                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Date<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtdate" runat="server" placeholder="Select Date Please" onkeypress="return false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="a" runat="server" ControlToValidate="txtdate" Display="Dynamic" ErrorMessage="Event Date is Required" ForeColor="Red" Font-Size="Small">

                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Event<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtEvent" runat="server" TextMode="MultiLine" Height="60px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqEvent" runat="server" ValidationGroup="a" ControlToValidate="txtEvent" Display="Dynamic" ErrorMessage="Event is Required" ForeColor="Red" Font-Size="Small">

                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form" style="margin-bottom:10px" id="divforsubmit">
                        <label>
                        </label>
                        <asp:Button ID="btnforsubmit" runat="server" OnClick="btnforsubmit_Click" Text="SUBMIT" CssClass="button_save" ValidationGroup="a"/>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Events List
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <asp:GridView runat="server" ID="grdEvents" HeaderStyle-BackColor="cornflowerblue" HeaderStyle-ForeColor="Black" AutoGenerateColumns="false" 
                                                CssClass="table table-responsive" AllowPaging="true" PageSize="5" OnPageIndexChanging="grdEvents_PageIndexChanging" OnRowCommand="grdEvents_RowCommand">
                                                <Columns>
                                                   
                                                    <asp:TemplateField HeaderText="Date" HeaderStyle-CssClass="thsty">
                                                       <ItemTemplate>
                                                           <asp:Label ID="lblgrdDate" runat="server" Text='<%# Convert.ToDateTime(Eval("EventDate")).ToString("dd MMMM yyyy")%>'></asp:Label>
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Event" HeaderStyle-CssClass="thsty">
                                                       <ItemTemplate>
                                                           <asp:TextBox ID="txtgrdevent" TextMode="MultiLine" Height="50px" Width="100%"  runat="server" Text='<%#Eval("EventDetails").ToString()%>'></asp:TextBox>
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Edit" HeaderStyle-CssClass="thsty">
                                                       <ItemTemplate>
                                                           <asp:ImageButton runat="server" ID="btnUpdate" CommandName="upd" ImageUrl="~/images/update.png" CommandArgument='<%#Eval("Id")%>' />
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Delete" HeaderStyle-CssClass="thsty">
                                                       <ItemTemplate>
                                                           <asp:ImageButton runat="server" ID="btnDelete" CommandName="del" ImageUrl="~/images/delete3.png" Width="18px" Height="18px" CommandArgument='<%#Eval("Id")%>' />
                                                       </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>


                            </div>

                </div>
            </div>
        </div>
    </div>
      <script type="text/javascript">
          var year = 2015;
          var AdmissionNo = '', AttendanceStatus = '', SturegNo = '';
          $(document).ready(function () {
              $("#ctl00_head_txtdate").datepicker({
                  changeMonth: true,
                  changeYear: true,
                  dateFormat: 'dd MM yy',
                  minDate: new Date()
              }).datepicker("setDate", new Date());

              //$('#ctl00_head_ddlapplyingforclass').change(function () {
              //    $('#ctl00_head_ddlsection').html('');
              //    $.ajax({
              //        type: 'POST',
              //        contentType: "application/json; charset=utf-8",
              //        url: "StuAttendance.aspx/BindSectionDDL",
              //        data: "{'Classid':'" + $(this).val() + "'}",
              //        dataType: "json",
              //        success: function (data) {
              //            $('#ctl00_head_ddlsection').html('<option value="0">--Select Section--</option>');
              //            if (data.d.length > 0) {
              //                for (var i = 0; i < data.d.length; i++) {
              //                    $('#ctl00_head_ddlsection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
              //                }
              //            }
              //        }
              //    });
              //});
              //$('#ctl00_head_btnforsubmit').click(function () {
              //    $('.tblforattendance').find('tbody').find('tr:gt(0)').each(function () {
              //        debugger;
                      
              //            AdmissionNo = AdmissionNo + ',' + $(this).find('td:eq(1)').html();
              //            SturegNo = SturegNo + ',' + $(this).find('.reg').find('.hdn').val();
              //            if ($.trim($(this).find('.reg').find('.sreview').val()) == '') {
              //                AttendanceStatus = AttendanceStatus + ',' + 'No review';
              //            }
              //            else {
              //                AttendanceStatus = AttendanceStatus + ',' + $(this).find('.reg').find('.sreview').val();
              //            }
                     
                     
                      
                     
                     
              //    });
              //    AdmissionNo = AdmissionNo.slice(1, AdmissionNo.length);
              //    SturegNo = SturegNo.slice(1, SturegNo.length);
              //    AttendanceStatus = AttendanceStatus.slice(1, AttendanceStatus.length);
              //    if (AttendanceStatus != '')
              //    {
              //        $.ajax({
              //            type: 'POST',
              //            contentType: "application/json; charset=utf-8",
              //            url: "StudentReviewbyTeacher.aspx/TakeAttendance",
              //            data: "{'AdmissionNo':'" + AdmissionNo + "','SturegNo':'" + SturegNo + "','AttendanceStatus':'" + AttendanceStatus + "','Date':'" + $('#ctl00_head_txtdateforattendance').val() + "'}",
              //            dataType: "json",
              //            success: function (data) {
              //                if (data.d == '1') {
              //                    alertify.success('Review given Successfully.');
              //                }
              //                if (data.d == '0') {
              //                    alertify.success('Some Error While giving review.');
              //                }
              //                AdmissionNo = '', SturegNo = '', AttendanceStatus = '';
              //                return false;
              //            }
              //        });
              //    }
                 
              //    return false;
              //});
              //$('#ctl00_head_ddlsection,#ctl00_head_txtdateforattendance').change(function () {
              //    TakeAttendanceDefault();
              //});

              //$('.chkforabsent').live('change', function () {
              //    if ($(this).prop('checked') == true) {
              //        $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'red');
              //        $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', 'cursive');
              //    }
              //    else {
              //        $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'black');
              //        $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', '"Helvetica Neue",Helvetica,Arial,sans-serif');
              //    }
              //});

          });
          //function TakeAttendanceDefault() {
          //    if ($('#ctl00_head_ddlapplyingforclass').val() == '0') {
          //        alertify.error('Select Class Please.');
          //    }
          //    else if ($('#ctl00_head_ddlsection').val() == '0') {
          //        alertify.error('Select Section Please.');
          //    }
          //    else if ($('#ctl00_head_txtdateforattendance').val() == '') {
          //        alertify.error('Select Date Please.');
          //    }
          //    else {
          //        BindAttendanceGrid();
          //    }
          //    return false;
          //}
          //function BindAttendanceGrid() {
          //    $('#divforsubmit').css("display", "none");
          //    var trforappend = '', trclass = '', tdclass = '';
          //    $.ajax({
          //        type: 'POST',
          //        contentType: "application/json; charset=utf-8",
          //        url: "StudentReviewbyTeacher.aspx/BindAttendanceGrid",
          //        data: "{'Classid':'" + $('#ctl00_head_ddlapplyingforclass').val() + "','SectionId':'" + $('#ctl00_head_ddlsection').val() + "','Date':'" + $('#ctl00_head_txtdateforattendance').val() + "'}",
          //        dataType: "json",
          //        success: function (data) {
          //            $('.tblforattendance').find('tbody').find('tr:gt(0)').remove();
          //            if (data.d.length > 0) {
          //                $('#divforsubmit').css("display", "block");
          //                for (var i = 0; i < data.d.length; i++) {
          //                    if (i % 2 == 0) {
          //                        trclass = 'stm_dark'
          //                    }
          //                    else {
          //                        trclass = 'stm_light'
          //                    }
                              
          //                    trforappend = trforappend + '<tr class="' + trclass + '">' +
          //                        '<td>' + data.d[i].ROWNUMBER + '</td>' +
          //                        '<td>' + data.d[i].ADMISSIONNO + '</td>' +
                                 
          //                        '<td ' + tdclass + '>' + data.d[i].NAME + '</td>' +
          //                        '<td class="reg"> <input type="hidden" name="hdn" class="hdn" value="' + data.d[i].STUREGNO + '"><textarea rows="3" cols="60" name="sreview" class="sreview">' + data.d[i].Review + '</textarea></td>' +
          //                        '</tr>'
          //                }
          //            }
          //            else {
          //                trforappend = '<tr>' +
          //                        '<td></td>' +                                 
          //                        '<td>No Student List Found.</td>' +
          //                        '<td</td>' +
          //                        '<td></td>' +
          //                        '</tr>'
          //            }
          //            $('.tblforattendance').append(trforappend);
          //            trforappend = '', trclass = '';
          //        }
          //    });
          //}
    </script>
    <asp:HiddenField runat="server" ID="hfempcode" />
    <label id="chkapplyedleave" style="display: none"></label>

</asp:Content>

