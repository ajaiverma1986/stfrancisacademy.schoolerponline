<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="SetTimeTable.aspx.cs" Inherits="BranchPanel_Exams_SetTimeTable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .bgd {
            text-align:center;
            color:red;
        }
        .active1 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #8CBF26;
            color: #333333;
            padding: 6px 15px 6px 15px;
            margin-right: 10px;
            height: auto;
        }Select Section

        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 20px;
            margin-top: 7px;
        }

        #content_pane {
            background: #fff;
        }

        .containerHeadline input {
            /*margin-left: 100px!important;*/
        }

        .sth th {
            /*padding-left: 101px!important;*/
            text-align: left;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">  
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
  <script>
      $(function () {
          $("#datepicker").datepicker({
              dateFormat: 'dd-mm-yy'
          });
          $('#timepicker1').timepicker({
              timeFormat: 'h:mm p',
              interval: 15,
              minTime: '7:00',
              maxTime: '6:00pm',              
              startTime: '7:00',
              dynamic: false,
              dropdown: true,
              scrollbar: true
          });
          $('#timepicker2').timepicker({
              timeFormat: 'h:mm p',
              interval: 15,
              minTime: '8',
              maxTime: '6:00pm',              
              startTime: '8:00',
              dynamic: false,
              dropdown: true,
              scrollbar: true
          });
      });
  </script>
    <script type="text/javascript">
        function title() {
            $(document).ready(function () {
                var currentmarks = 0;
                $("#ctl00_ContentPlaceHolder1_btncancel").click(function () {
                    $("#ctl00_ContentPlaceHolder1_divfortotal").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_divforsetmarks").css("display", "block");
                    $('.checkmaxmarks').val("");
                    return false;
                });

                $(".checkmaxmarks").on('keyup paste', function () {

                    var maxmarks = $('input[id$=hfmaxmarks]').val();
                    currentmarks = parseInt($.trim($(this).val()));
                    if (currentmarks > maxmarks) {
                        alert('You Can not insert the more than ' + maxmarks + ' marks.');
                        $('.checkmaxmarks').val("");
                    }

                });

            });
        }

        function getDayOfWeek()
        {
            $("#txtDay").val('');
            var dateString = $("#datepicker").val(); 
            if (dateString != '')
            {
                var dateParts = dateString.split("-");                
                var dateObject = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]);                
                $("#txtDay").val(convertToDay(dateObject.getDay()));
            }            
        }

        function convertToDay(day)
        {            
            if(day==1)
            {
                return 'Monday';
            }
            if (day == 2) {
                return 'Tuesday';
            }
            if (day == 3) {
                return 'Wednesday';
            }
            if (day == 4) {
                return 'Thursday';
            }
            if (day == 5) {
                return 'Friday';
            }
            if (day == 6) {
                return 'Saturday';
            }
            if (day == 7) {
                return 'Sunday';
            }
        }
    </script>

    

    <div class="content_pane_cont input_content" id="contentPane">
        <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>
            <li style="background: none;"><a class="active" href="#">Set Marks</a></li>
        </ul>
        <div class="arrowt">
            <a href="testlist.aspx">
                <img src="../../images/back-button.png" alt="school-logo" /></a>
        </div>
    </div>
        <br />
<%--        <asp:UpdatePanel ID="updatepanel1" runat="server" UpdateMode="Always">
            <ContentTemplate>--%>
                <script type="text/javascript" lang="javascript">
                    Sys.Application.add_load(title);
                </script>
                <div id="divforsetmarks" style="display: block" runat="server">
                    <div class="for_sigle_row_form">
                        <label>
                            Select Term<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlTerm" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlTerm_SelectedIndexChanged">
                            <asp:ListItem Value="0" Text="--Select Term--"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Term I"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Term II"></asp:ListItem>
                            
                        </asp:DropDownList>
                    </div>
                    <%--  <div class="for_sigle_row_form">
                        <label>
                            Select Exam<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlexam" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlexam_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>--%>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Class<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlcourse" Enabled="false" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlcourse_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="0" Text="Select Class"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Select Section<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlsection" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlsection_SelectedIndexChanged" Enabled="false">
                            <asp:ListItem Selected="True" Value="0" Text="Select Section"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Select Subject<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlsubject" Enabled="false" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlsubject_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="0" Text="Select Subject"></asp:ListItem>
                        </asp:DropDownList>&nbsp;
                        <asp:TextBox runat="server" Width="120px" ID="datepicker" onchange="getDayOfWeek()" ClientIDMode="Static" ReadOnly="true"></asp:TextBox>
                         <asp:TextBox runat="server" Width="120px" ID="txtDay" ClientIDMode="Static" ReadOnly="true"></asp:TextBox>
                        <asp:TextBox runat="server" Width="120px" ID="timepicker1" ClientIDMode="Static" ReadOnly="true"></asp:TextBox>
                        <asp:TextBox runat="server" Width="120px" ID="timepicker2" ClientIDMode="Static" ReadOnly="true"></asp:TextBox>
                        &nbsp;
                        <asp:Button runat="server" ID="btnSave" CssClass="btn-info" Text="Save" OnClick="btnSave_Click"/>
                    </div>
                      
                   
                    <br />
                    <asp:HiddenField ID="hfmaxmarks" runat="server" />
                    
                </div>

                <br />
                
        <%--<div style="width:98%">
            <asp:GridView ID="grdExam" runat="server" AutoGenerateColumns="false" GridLines="None" Width="100%" BorderWidth="0" CssClass="containerHeadline" >
                            <Columns>
                                <asp:TemplateField HeaderText="S. No" HeaderStyle-Width="50px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsno" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>                              

                                <asp:TemplateField HeaderText="Student Name" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                         <asp:Label ID="lblname" runat="server" Text='<%#Eval("ExamDate") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Student Name" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%#Eval("ExamDay") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Student Name" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%#Eval("FromTime") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Student Name" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%#Eval("ToTime") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                            </Columns>
                            <HeaderStyle CssClass="stm_head sth" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                        </asp:GridView>
        </div>--%>

    </div>
</asp:Content>

