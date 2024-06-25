<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="send-sms.aspx.cs" Inherits="BranchPanel_send_sms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.7.2.min.js" type="text/javascript"></script>

    <%--css and javascript for mulitple selection--%>
    <link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="../../js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../../js/bootstrap-multiselect.js" type="text/javascript"></script>
    <%--css and javascript for mulitple selection--%>

    <%--css and javascript for Date selection--%>
    <script src="../../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <%--css and javascript for Date selection--%>

    <script type="text/javascript" src="../../js/alertify.js"></script>
    <link href="../../css/alertify.core.css" type="text/css" media="all" rel="Stylesheet" />
    <link href="../../css/alertify.default.css" type="text/css" media="all" rel="Stylesheet" />
    <style type="text/css">
        .inline-rb input[type="radio"] {
            width: auto;
        }

        .inline-rb label {
            display: inline;
        }

        .selco {
            margin-left: 12%;
            margin-top: -16px;
            height: 79px;
            position: absolute;
            overflow-y: scroll;
            overflow-x: hidden;
            /*border-bottom: 1px solid #E6E6E6;*/
            border-radius: 15px;
        }

        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 4px 5px;
            width: 313px;
        }

        #ctl00_ContentPlaceHolder1_campaing_By {
            padding-left: 11px;
        }


        #ctl00_ContentPlaceHolder1_campaing_By_0 {
            margin-left: -72px;
            margin-top: 6px;
        }

        #ctl00_ContentPlaceHolder1_campaing_By_1 {
            margin-left: -67px;
            margin-top: 6px;
        }


        .student-photo_frame {
            background: none repeat scroll 0 0 #F4F1F1;
            border: 1px solid #CCCCCC;
            height: auto;
            margin-bottom: 30px;
            margin-top: 5px;
            width: 100%;
        }

        .for_sigle_row_form label {
            text-align: left !important;
        }

        .dropdown-menu {
            width: 100px !important;
            width: 150px !important;
        }

        .checkbox label {
            margin-left: 20px !important;
        }

        .checkbox input[type="checkbox"] {
            float: left;
        }

        #ctl00_ContentPlaceHolder1_chkstatuslist input {
            float: left !important;
            margin-right: 5px;
            margin-top: 10px;
        }

        #ctl00_ContentPlaceHolder1_chkstatuslist label {
            float: right !important;
            text-transform: uppercase !important;
        }

        #ctl00_ContentPlaceHolder1_campaing_By label {
            float: right !important;
            width: 50px;
        }

        #ctl00_ContentPlaceHolder1_campaing_By input {
            margin: 10px 8px 2px 2px !important;
        }

        .dropdown-menu li {
            margin-left: 8px;
        }

        .dropdown-menu a:hover {
            background: none!important;
        }

        .ui-datepicker .ui-datepicker-header {
            background: none repeat scroll 0 0 #016fa7;
            padding: 0.2em 0;
            position: relative;
            width: 245px;
        }

        .ui-datepicker th span {
            color: #2CA8C2;
            font-size: 15px;
        }

        .for_sigle_row_form b {
            box-shadow: none !important;
            color: #676767 !important;
            font-size: 14px !important;
            height: 8px !important;
            line-height: 20px !important;
            margin-bottom: 0 !important;
            padding: 0 !important;
            text-align: left !important;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s !important;
        }

        .active3 {
            -moz-border-bottom-colors: none;
            -moz-border-left-colors: none;
            -moz-border-right-colors: none;
            -moz-border-top-colors: none;
            background: none repeat scroll 0 0 #f7f7f7;
            border-color: #ccc #ccc -moz-use-text-color;
            border-image: none;
            border-radius: 3px 3px 0 0;
            border-style: solid solid none;
            border-width: 1px 1px medium;
            color: #2d9fdd;
            font-size: 12px;
            height: auto;
            margin-left: 10px;
            margin-top: 3px;
            padding: 5px 13px;
        }
    </style>
    <script type="text/javascript">
        var course = "", statusid = "", fromdate = "", todate = "", message = "", getcomid = 0;
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_txtfromdate").datepicker({

                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy"
            });
            $("#ctl00_ContentPlaceHolder1_txttodate").datepicker({

                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy"
            });

            // Add open class in multiple selection for open checkboxlist of classes
            $('#divcourse').on("click", function () {
                var tempclass = $(this).find('div').attr('class');
                $(this).find('div').addClass(tempclass + ' open');
            });
            //initialize Multiple selection of classes
            $('[id*=ddlcourse]').multiselect({
                includeSelectAllOption: true
            });
            //Call cancel button
            $('[id*=btncancel]').click(function () {
                reset();
                return false;
                
            });
            //Get from which resouse you want to send sms by Email/Sms
            $('[id*=campaing_By]').change(function () {
                getcomid = $(this).val();
                if (getcomid > 0) {
                    getTemplate(getcomid);
                    $("#divtemplate").show(500);
                }
            });
            //Get template Text behalf of Subject template
            $('[id*=ddltemplate]').change(function () {
                var tempid = $(this).val();
                gettemplatetext(tempid)
            });
            //Submit button click to send notification with Validation
            $('[id*=Button1]').click(function () {

                course = ""; statusid = "";
                //Get all seleted class from chosen class
                $('.multiselect-container li input').each(function () {
                    var chkstatus = $(this).is(":checked");
                    if (chkstatus == true) {
                        course = course + ',' + $(this).val();
                        if (parseInt(course.length) <= 2) {
                            course = course.substring(1, course.length);
                        }
                    }

                });
                if (course == "") {
                    alertify.error("Please select at least one course");
                    return false;
                }
                fromdate = $('[id*=txtfromdate]').val();
                if (fromdate == "") {
                    alertify.error("Please Select From Date");
                    return false;
                }
                todate = $('[id*=todate]').val();
                if (todate == "") {
                    alertify.error("Please Select To Date");
                    return false;
                }
                //Get cheked status from checkbox List of status
                $("#ctl00_ContentPlaceHolder1_chkstatuslist input").each(function () {
                    var chkstatus = $(this).is(":checked");
                    if (chkstatus == true) {
                        statusid = statusid + ',' + $(this).val();
                        if (parseInt(statusid.length) <= 2) {
                            statusid = statusid.substring(1, statusid.length);
                        }
                    }
                });
                if (statusid == "") {
                    alertify.error("Please select at least on status");
                    return false;
                }


                message = $('[id*=txtmsg]').val();
                if (message == "") {
                    alertify.error("Please Enter Message");
                    return false;
                }
                sendnotification();
                return false;
            });

        });

        //Funtion To reset all values
        function reset() {
            $('input[name="ctl00$ContentPlaceHolder1$campaing_By"]').prop('checked', false);
            $('[id*=txtfromdate]').val('');
            $('[id*=txttodate]').val('');
            $('input[type=checkbox]').attr('checked', false);
            $('[id*=divtemplate]').hide(500);
            $('[id*=txtmsg]').val('');
        }
        //Function to get template accounding sms/email
        function getTemplate(usedfor) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "send-sms.aspx/gettamplate",
                data: "{ 'usedfor':'" + usedfor + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddltemplate").html("");
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddltemplate").append($("<option></option>").val(value.tempid).html(value.temptext));
                    });

                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        //Function to get text accournig to template 
        function gettemplatetext(tempid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "send-sms.aspx/gettemplatetext",
                data: "{ 'tempid':'" + tempid + "'}",
                dataType: "json",
                success: function (data) {
                    $('[id*=txtmsg]').val(data.d);
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        //Final function to send notification after submission the form
        function sendnotification() {
            getcomid = $('input[name=ctl00$ContentPlaceHolder1$campaing_By]:checked').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "send-sms.aspx/getemailidandmobile",
                data: "{ 'course':'" + course + "','statusid':'" + statusid + "','fromdate':'" + fromdate + "','todate':'" + todate + "','message':'" + message + "','getcomid':'" + getcomid + "'}",
                dataType: "json",
                success: function (data) {
                    alertify.success('Message Sent Successfully');
                    reset();
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
    </script>
    <div class="student-photo_frame content_top1" style="height: 128px; margin-top: 4px;">
        <div class="clear">
        </div>
        <div class="student-photo_frame_img">

            <img id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_imgstu" src="../../images/camaing.png" style="border-width: 0px;">
        </div>
        <div style="float: left;">
            <div class="user-deatils">
                <dl>
                    <span id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_lblname">Campaing</span>
                </dl>
            </div>
            <div class="clear">
            </div>
            <div class="user-deatils">
                <dt></dt>
                <span></span>
            </div>
            <div class="clear">
            </div>
            <div class="user-deatils">
                <dt></dt>
                <span></span>
            </div>
        </div>
        <div class="clear">
        </div>
        <div style="margin-bottom: -3px; margin-top: 11px;">
            <a href="send-sms.aspx" class="active3">Send Sms </a>
            <a href="../Create-Campaing.aspx" class="sgpt1">Create template </a>

        </div>
    </div>


    <div class="clear">
    </div>

    <div class="content_pane_cont input_content" id="contentPane" style="border-top: none;">

        <div class="for_sigle_row_form">
            <label>Campaing By<span style="color: Red">*</span></label>
            <div>
                <asp:RadioButtonList ID="campaing_By" runat="server" RepeatDirection="Horizontal" Height="24px">
                    <asp:ListItem Text="SMS " Value="1"></asp:ListItem>
                    <asp:ListItem Text="E-Mail" Value="2"></asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </div>
        <div>
            <div class="for_sigle_row_form">
                <label>Select Class<span style="color: Red">*</span></label>
                <div id="divcourse">
                    <asp:ListBox ID="ddlcourse" runat="server" SelectionMode="Multiple"></asp:ListBox>
                </div>
            </div>
            <div class="for_sigle_row_form">
                <label>From Date<span style="color: Red"></span></label>
                <asp:TextBox runat="server" ID="txtfromdate" Placeholder="ie:20 Feb 2015"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>To Date<span style="color: Red"></span></label>
                <asp:TextBox runat="server" ID="txttodate" Placeholder="ie:28 Feb 2015"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>Select Status<span style="color: Red">*</span></label>
                <asp:CheckBoxList runat="server" CssClass="chklist" ID="chkstatuslist"></asp:CheckBoxList>
                <div style="margin-left: 205px; margin-top: 15px;">
                    <asp:Repeater ID="rptstatus" runat="server">
                        <ItemTemplate>
                            <table class="content smrt" id="tblContacts1" cellpadding="2" cellspacing="0" border="0"
                                style="margin-left: 35px;">
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkpage1" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblForm1" runat="server" Text='<%#Eval("statusname")%>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblpageid2" Visible="false" runat="server" Text='<%#Eval("esid")%>'></asp:Label>
                                        <asp:HiddenField ID="HD2" runat="server" Value='<%#Eval("esid")%>' />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>


            </div>

            <div class="for_sigle_row_form" id="divtemplate" style="display: none">
                <label>Select Template<span style="color: Red"></span></label>
                <asp:DropDownList ID="ddltemplate" runat="server"></asp:DropDownList>
            </div>

            <div class="for_sigle_row_form">
                <label>Enter Msg here<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtmsg" runat="server" TextMode="MultiLine" Height="155px"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form" id="div1" runat="server">
                <label>
                </label>
                <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="button_save" Style="margin-left: 24px; padding-top: 5px; padding-bottom: 5px;" />
                <asp:Button runat="server" class="button_save" ID="btncancel" Text="Cancel"></asp:Button>
            </div>
        </div>
</asp:Content>
