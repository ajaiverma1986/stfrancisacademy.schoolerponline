<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="add-topic.aspx.cs" Inherits="HO_add_topic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../js/alertify.js" type="text/javascript"></script>
    <style type="text/css">
        th {
            border-bottom: 1px solid #CDCDCD !important;
        }

        .stm1 td {
            text-align: center;
            border-top: 0px;
        }

        input[type="text"], select, input[type="Password"] {
        }

        .stm1 {
            border-right: 1px solid #ddd;
            padding-bottom: 0px !important;
        }

        .inputtopictime {
            margin-bottom: 10px;
        }

        .showpopuptopic, .showpopupshowtopic {
            position: fixed;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: rgb(0, 0, 0);
            font-family: sans-serif;
            left: 50%;
            opacity: 1;
            max-height: 500px;
            display: block;
            overflow: auto;
            padding-bottom: 8px !important;
            top: 15%;
            width: 500px !important;
            margin-left: -250px !important;
        }

        .showpopup2 span {
            float: right;
            padding-left: 0;
            height: 1px;
            width: 1px;
        }

        .t1 {
        }

        .t2 {
        }

            .t2 input {
                float: left;
                margin-top: 10px;
            }

            .t2 select {
                float: left;
                margin-top: 10px;
            }
    </style>

    <div class="content_pane_cont input_content  main-div-tbl" id="contentPane">
          <div class="cheadline1" style="width: 100%; margin-left: 0px">
            <span class="spanheading">Topic Master</span>
        </div>
        <br />
          <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <input id='txtclass' type='text' placeholder='Class Name' autocomplete='off' style="width: 120px;" />
            <input id='textsubject' type='text' placeholder='Subject Name' autocomplete='off' style="width: 105px;" />
            <asp:ImageButton ID="ImageButton1" CssClass="btnclear" Width="20px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />

            <div class="clear"></div>
        </div>
        <div class="content_pane_cont input_content" id="maindiv">
            <table class="stm" width="100%">
                <tr class="stm_head" align="center">
                    <th style="width: 4%;">S.No.</th>
                    <th>Class</th>
                    <th>Subject</th>
                    <th>View Topic</th>
                    <th>Add Topic</th>
                </tr>
            </table>
            <div class="clear"></div>
            <div class="divnorecordfound" style="margin-left: 200px; display: none">
                <label style="font-size: 15px; color: red">No class added.please add the class fist before add any thing.</label>
            </div>
        </div>
        <div class="content_pane_cont input_content" id="viewtopicdiv" style="display: none;">
            <div class="" style="margin: 10px;">
                <asp:Label ID="lblclassname" runat="server" Text="Hello"></asp:Label>

                <a style="cursor: pointer; float: right; margin-right: 7px; display: block;" class="btnback normal-btn-sty">(Back)</a>
            </div>
            <table class="stm1">
                <tr class="stm_head" align="center">
                    <th style="width: 4%;">Sno.</th>
                    <th>Topic Name</th>
                    <th>Completion Time(in Hours)</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </table>
        </div>
        <div id="divaddtopic" style="text-align: center; display: none;" class="">
            <div class="">

                <table class="showpopuptopic showpopup2" style="background-color: white; vertical-align: top">
                    <tr>
                        <td colspan="2" class="pop-headng-sty">Add Topic
                            <a id="BtnCancelTopic" title="Close this from here"
                                class="btnClose">
                                <img src="../images/popupcross.png"></a>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>Select Class:</label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="ddlclassforaddtopic" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>Select Subject:</label>
                        </td>
                        <td class="t2">

                            <asp:DropDownList ID="ddlsubjectforaddtopic" runat="server">
                                <asp:ListItem Value="0">--Select One--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Topic Name:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">

                            <asp:TextBox ID="txttopic" runat="server" placeholder="Name Please." CssClass="inputtopic"></asp:TextBox>
                            <asp:TextBox ID="txttopictime" runat="server" placeholder="Time(In Hour)"
                                onkeypress="return noAlphabets(event)" CssClass="inputtopictime"></asp:TextBox>
                            <img src="../images/add.png" style="width: 16px; margin-top: 17px; cursor: pointer;" alt="No Image" class="imgfroaddtopic" />
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="BtnSubmittopic" runat="server" Text="Submit" CssClass="button_save" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="divupdatetopic" style="text-align: center; display: none;">

            <table class="showpopupshowtopic showpopup2" style="background-color: white; vertical-align: top">
                <tr>
                    <td colspan="2" class="pop-headng-sty">Update Topic
                            <a id="btnupdateback" title="Close this from here" class="btnClose">
                                <img src="../images/popupcross.png"></a>
                    </td>
                </tr>
                <tr class="for_sigle_row_form">
                    <td class="t1">
                        <label>Topic Name:  <span style="color: red">*</span></label>
                    </td>
                    <td class="t2" style="width: 315px;">

                        <asp:TextBox ID="TextBox1" runat="server" placeholder="Name Please." CssClass="inputtopic"></asp:TextBox>
                    </td>
                </tr>

                <tr class="for_sigle_row_form">
                    <td class="t1">
                        <label>Topic Time:  <span style="color: red">*</span></label>
                    </td>
                    <td class="t2">

                        <asp:TextBox ID="TextBox2" runat="server" placeholder="Time(In Hour)" onkeypress="return noAlphabets(event)" CssClass="inputtopictime"></asp:TextBox>
                    </td>
                </tr>

                <tr class="for_sigle_row_form">
                    <td></td>
                    <td align="left">
                        <asp:Button ID="btnupdatetopic" runat="server" Text="Submit" CssClass="button_save" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;
            return true;
        };
        var TopicId = 0, TopicName = '', TopicMode = 0, TopicTime = "", subid = 0, Classname = "", Subjectname = "", classid = 0;
        $(document).ready(function () {
            BindGrid();

            //$('.inputtopictime').live('keydown', function (event) {
            //    // Allow only backspace and delete
            //    if (event.keyCode == 46 || event.keyCode == 8) {
            //        // let it happen, don't do anything
            //    }
            //    else {
            //        // Ensure that it is a number and stop the keypress
            //        if (event.keyCode < 48 || event.keyCode > 57) {
            //            event.preventDefault();
            //        }
            //    }
            //});

            $('.topicname').live('click', function () {
                subid = 0, Classname = "", Subjectname = "", classid = 0;
                if ($(this).html() == 'View Topic') {
                    subid = $(this).parent('td').parent('tr').find('td:eq(2)').find('input[type=hidden]').val();
                    classid = $(this).parent('td').parent('tr').find('td:eq(1)').find('input[type=hidden]').val();
                    Classname = $(this).parent('td').parent('tr').find('.classname').text();
                    Subjectname = $(this).parent('td').parent('tr').find('.subjectname').text();
                    BindGrid_Viewtopic(subid, classid);
                    $('#maindiv').hide(500)
                    $('#viewtopicdiv').show(500)
                    $("#ctl00_ContentPlaceHolder1_lblclassname").html("View Topic List of " + Classname + '-' + Subjectname + "");
                }
                else {

                }
            });

            $('.btnback').click(function () {
                $('#maindiv').show(500)
                $('#viewtopicdiv').hide(500)
                return false;
            });

            $('.addtopicname').live('click', function () {
                var classid = $(this).parent('td').parent('tr').find('td:eq(1)').find('input[type=hidden]').val();
                var subid = $(this).parent('td').parent('tr').find('td:eq(2)').find('input[type=hidden]').val();
                if (subid > 0) {
                    $("#ctl00_ContentPlaceHolder1_ddlclassforaddtopic").val(classid);
                    $("#ctl00_ContentPlaceHolder1_ddlsubjectforaddtopic").val(subid);
                    $("#ctl00_ContentPlaceHolder1_ddlclassforaddtopic").attr("disabled", true);
                    $("#ctl00_ContentPlaceHolder1_ddlsubjectforaddtopic").attr("disabled", true);
                    $('#divaddtopic').css('display', 'block');
                    $('#ctl00_ContentPlaceHolder1_txttopic').val('');
                    $('#ctl00_ContentPlaceHolder1_txttopictime').val('');
                }
                else {
                    alertify.error("Please First Add Subject.");
                    return false;
                }
            });
            $("#BtnCancelTopic").live('click', function () {
                var lasttroftable = $('.showpopuptopic').find('tbody').find('tr:last').prop('outerHTML');
                $('#divaddtopic').css('display', 'none');
                $('#divaddtopic').find('table tr:gt(3)').remove();
                $('#divaddtopic .showpopuptopic').append(lasttroftable);
                $('#divaddtopic').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                return false;
            });

            $('.imgfroaddtopic').click(function () {
                var lasttroftable = $('.showpopuptopic').find('tbody').find('tr:last').prop('outerHTML');
                $('.showpopuptopic').find('tbody').find('tr:last').remove();
                var trforadd = '<tr class="for_sigle_row_form"><td class="t1"><div><div style=""><label>Topic Name:</label></div></div></td><td class="t2"><div><div style="float: left; "><input  type="text" class="inputtopic"  placeholder="Name Please." ><input  type="text" onkeypress="return noAlphabets(event)" class="inputtopictime"  placeholder="Time(In Hour)"  ><img class="imageforsubtopic" alt="No Image" style="width: 16px; cursor: pointer; margin-left: 2px; margin-top:17px;" src="../images/minus.png"></div></div></td></tr>'
                $('#divaddtopic .showpopuptopic').append(trforadd);
                $('#divaddtopic .showpopuptopic').append(lasttroftable);
                return false;
            });
            $('.imageforsubtopic').live("click", function () {
                $(this).parent('div').parent('div').parent('td').parent('tr').remove();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_BtnSubmittopic').live('click', function () {
                if ($('.inputtopic').val() == "") {
                    alertify.error('Enter Topic Name Please.');
                    return false;
                }
                else if ($('.inputtopictime').val() == "") {
                    alertify.error('Enter Topic Time an hour Please.');
                    return false;
                }
                var alltopicname = "", alltopictime = "";
                $('.showpopuptopic').find('tr').find('td,.inputtopic').each(function () {
                    if ($(this).val() != "") {
                        alltopicname = alltopicname + '~' + $(this).val().replace("'", '@');
                       
                    }
                });
                $('.showpopuptopic').find('tr').find('td,.inputtopictime').each(function () {
                    if ($(this).val() != "") {
                        alltopictime = alltopictime + '~' + $(this).val();
                        //alert(alltopictime);
                    }
                });
                alltopicname = alltopicname.slice(1, alltopicname.length);
                alltopictime = alltopictime.slice(1, alltopictime.length);
                alltopicname = alltopicname.split("'").join("@")
               
                SaveTopic(alltopicname, alltopictime)
                return false;
            });
            $('.imgforedit').live("click", function () {
                TopicId = 0;
                TopicId = $(this).parent('td').parent('tr').find('td:eq(1)').find('input[type=hidden]').val();
                TopicName = $(this).parent('td').parent('tr').find('.labelalltopic').text();
                TopicTime = $(this).parent('td').parent('tr').find('.labelalltopictime').text();
                $("#ctl00_ContentPlaceHolder1_TextBox1").val(TopicName);
                $("#ctl00_ContentPlaceHolder1_TextBox2").val(TopicTime);
                $('#divupdatetopic').css('display', 'block');
                return false;
            });
            $("#btnupdateback").click(function () {
                $('#divupdatetopic').css('display', 'none');
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_btnupdatetopic").click(function () {
                if ($("#ctl00_ContentPlaceHolder1_TextBox1").val() == "") {
                    alertify.error("Please inter topicname.");
                    return false;
                }
                else if ($("#ctl00_ContentPlaceHolder1_TextBox2").val() == "") {
                    alertify.error("Please inter topicname time.");
                    return false;
                }
                TopicName = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                TopicName = TopicName.replace("'", '@');
                TopicTime = $("#ctl00_ContentPlaceHolder1_TextBox2").val();
                TopicMode = 1;
                UpDateTopic();
                return false;
            });
            $('.lbtncancel').live("click", function () {
                var confirmdeletestatus = confirm("Are you sure you want to delete the topic.?If you Delete once You Can't Recover It.");
                if (confirmdeletestatus == true) {
                    TopicId = $(this).parent('td').parent('tr').find('td:eq(1)').find('input[type=hidden]').val();
                    TopicName = $(this).parent('td').parent('tr').find('.labelalltopic').text();
                    TopicName = TopicName.replace("'", '@');
                    TopicTime = $(this).parent('td').parent('tr').find('.labelalltopictime').text();
                    TopicMode = 2;
                    UpDateTopic();
                }
                return false;
            });

            $('#txtclass,#textsubject').change(function () {
                BindGrid();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ImageButton1').click(function () {
                $('#txtclass').val('')
                $('#textsubject').val('')
                BindGrid();
                return false;
            });

        });

        function BindGrid() {
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-topic.aspx/BindGridByJs",
                data: "{'ClassName':'" + $('#txtclass').val().split("'").join("~") + "','SubjectName':'" + $('#textsubject').val().split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {

                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                    '<td style="width:28%;"><span class="classname">' + data.d[i].ClassName + '</span><input type="text" style="width:200px; display:none; height:20px;padding: 3px;" />' +
                                     '<img class="btncancel" title="Click here for cancel" src="../images/ic.png" style="display: none; float: right;cursor:pointer">' +
                                    '<img class="btnupdate" title="Click here for update" src="../images/update.png" style="display: none; margin-right:2px; float: right;cursor:pointer">' +
                                     '</label></div><input  type="hidden" value="' +
                                    data.d[i].ClassId + '" /></td>' +
                                    '<td style="width:28%;"><span class="subjectname">' +
                                    data.d[i].SubjectName + '</span><input type="text" style="width:200px; display:none; height:20px;padding: 3px;" />' +
                                     '<img class="sbtncancel" title="Click here for cancel" src="../images/ic.png" style="display: none; float: right;cursor:pointer">' +
                                    '<img class="sbtnupdate" title="Click here for update" src="../images/update.png" style="display: none; margin-right:2px; float: right;cursor:pointer">' +
                                     '</label></div><input  type="hidden" value="' +
                                    data.d[i].SubjectId + '" /></td>' +
                                    '<td><label class="labelalltopic" style="display:none">' +
                                    data.d[i].TopicName + '</label><label class="labelalltopictime" style="display:none">' +
                                    data.d[i].ToipcTime + '</label>' +
                                    '<a class="topicname">' + data.d[i].ShowTopicAnchor + '</a>' +
                                    '<input type="hidden" value="' + data.d[i].TopicId + '" /></td>' +
                                    '<td><a class="addtopicname" style="cursor:pointer">' + data.d[i].AddTopicAnchor + '</a></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                    '<td style="width:28%;"><span class="classname">' + data.d[i].ClassName + '</span><input type="text" style="width:200px; display:none; height:20px;padding: 3px;" />' +
                                     '<img class="btncancel" title="Click here for cancel" src="../images/ic.png" style="display: none; float: right;cursor:pointer">' +
                                    '<img class="btnupdate" title="Click here for update" src="../images/update.png" style="display: none; margin-right:2px; float: right;cursor:pointer">' +
                                     '</label></div><input  type="hidden" value="' +
                                    data.d[i].ClassId + '" /></td>' +
                                    '<td style="width:28%;"><span class="subjectname">' +
                                    data.d[i].SubjectName + '</span><input type="text" style="width:200px; display:none; height:20px;padding: 3px;" />' +
                                     '<img class="sbtncancel" title="Click here for cancel" src="../images/ic.png" style="display: none; float: right;cursor:pointer">' +
                                    '<img class="sbtnupdate" title="Click here for update" src="../images/update.png" style="display: none; margin-right:2px; float: right;cursor:pointer">' +
                                     '</label></div><input  type="hidden" value="' +
                                    data.d[i].SubjectId + '" /></td>' +
                                    '<td><label class="labelalltopic" style="display:none">' +
                                    data.d[i].TopicName + '</label><label class="labelalltopictime" style="display:none">' +
                                    data.d[i].ToipcTime + '</label>' +
                                    '<a class="topicname">' + data.d[i].ShowTopicAnchor + '</a>' +
                                    '<input type="hidden" value="' + data.d[i].TopicId + '" /></td>' +
                                    '<td><a class="addtopicname" style="cursor:pointer">' + data.d[i].AddTopicAnchor + '</a></td></tr>';
                            }

                            $('.stm').append(trforappend);

                            if (data.d[i].SubjectName == "Add Subject") {
                                $('.stm tr:eq(' + parseInt(i + 1) + ')').find('td:eq(2)').find('img').css('display', 'none')
                            }
                        }
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                    }
                    call_progressbar("end");

                    $("#maindiv").find("table tr").each(function () {
                        var topic = $(this).find("td:eq(3)").find('a').html()
                        if (topic == "No Topic Added") {
                            $(this).find("td:eq(3)").find('a').css("text-decoration", "none")
                            $(this).find("td:eq(3)").find('a').css("cursor", "default")
                        }
                        else {

                            $(this).find("td:eq(3)").find('a').css("cursor", "pointer")
                        }
                    })
                },
                error: function (response) {
                }
            });
        }

        //code for edit classname
        $('.imgforedit2').live("click", function () {
            $(this).hide(500)
            $(this).parents('tr').children('td:eq(1)').find('span').hide(500);
            $(this).parents('tr').children('td:eq(1)').find('.btnupdate').show(500);
            $(this).parents('tr').children('td:eq(1)').find('.btncancel').show(500);
            var data = $(this).parents('tr').children('td:eq(1)').find('span').html()
            $(this).parents('tr').children('td:eq(1)').find('input[type=text]').val(data).show(500);
        })
        $('.btnupdate').live("click", function () {
            var data = $(this).parents('tr').children('td:eq(1)').find('input[type=text]').val()
            var value = $(this).parents('tr').find('input[type=hidden]').val();
            if (data != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "add-topic.aspx/updateclass",
                    data: "{'id':'" + value + "','data':'" + data.split("'").join("~") + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            alertify.success('Class Name is Updated Successfully');
                            BindGrid()
                        }
                    },
                    error: function (result) {

                    }
                });
            }
            else {
                alertify.error('Please Enter class First');
                return false
            }
        })
        $('.btncancel').live("click", function () {
            $(this).parents('tr').children('td:eq(1)').find('span').show(500);
            $(this).parents('tr').children('td:eq(1)').find('.btnupdate').hide(500);
            $(this).parents('tr').children('td:eq(1)').find('.btncancel').hide(500);
            $(this).parents('tr').children('td:eq(1)').find('.imgforedit2').show(500);
            var data = $(this).parents('tr').children('td:eq(1)').find('span').html()
            $(this).parents('tr').find('input[type=text]').val('').hide(500);
        })
        //code for edit classname close from here

        //code for edit Subject name
        $('.imgforedit3').live("click", function () {
            $(this).hide(500)
            $(this).parents('tr').children('td:eq(2)').find('span').hide(500);
            $(this).parents('tr').children('td:eq(2)').find('.sbtnupdate').show(500);
            $(this).parents('tr').children('td:eq(2)').find('.sbtncancel').show(500);
            var data = $(this).parents('tr').children('td:eq(2)').find('span').html()
            $(this).parents('tr').children('td:eq(2)').find('input[type=text]').val(data).show(500);
        })
        $('.sbtnupdate').live("click", function () {
            var data = $(this).parents('tr').children('td:eq(2)').find('input[type=text]').val()
            var value = $(this).parents('tr').find('td:eq(2)').find('input[type=hidden]').val();
            if (data != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "add-topic.aspx/updatesubject",
                    data: "{'id':'" + value + "','data':'" + data.split("'").join("~") + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            alertify.success('Subject Name is Updated Successfully');
                            BindGrid()
                        }
                    },
                    error: function (result) {

                    }
                });
            }
            else {
                alertify.error('Please Enter subject First');
                return false
            }
        })
        $('.sbtncancel').live("click", function () {
            $(this).parents('tr').children('td:eq(2)').find('span').show(500);
            $(this).parents('tr').children('td:eq(2)').find('.sbtnupdate').hide(500);
            $(this).parents('tr').children('td:eq(2)').find('.sbtncancel').hide(500);
            $(this).parents('tr').children('td:eq(2)').find('.imgforedit3').show(500);
            var data = $(this).parents('tr').children('td:eq(2)').find('span').html()
            $(this).parents('tr').find('input[type=text]').val('').hide(500);
        })
        //code for edit Subject name  Close From Here

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

        function BindGrid_Viewtopic(subid, classid) {
            $('.stm1 tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-topic.aspx/BindGridViewTopic",
                data: "{'subid':'" + subid + "','classid':'" + classid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                    '<td><label class="labelalltopic" >' + data.d[i].TopicName + '</label><input type="hidden" value="' + data.d[i].TopicId + '" /></td>' +
                                    '<td><label class="labelalltopictime" >' + data.d[i].ToipcTime + '</label></td>' +
                                    '<td><input style="cursor: pointer" class="imgforedit" type="image"  src="../images/edit.png"></td>' +
                                    '<td><img class="lbtncancel" style="cursor: pointer !important; " src="../images/ic.png"  title="Click here for cancel"></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                    '<td><label class="labelalltopic">' + data.d[i].TopicName + '</label><input type="hidden" value="' + data.d[i].TopicId + '" /></td>' +
                                    '<td><label class="labelalltopictime">' + data.d[i].ToipcTime + '</label></td>' +
                                    '<td><input style="cursor: pointer" class="imgforedit" type="image"  src="../images/edit.png"></td>' +
                                    '<td><img class="lbtncancel" style="cursor: pointer !important; " src="../images/ic.png"  title="Click here for cancel"></td></tr>';
                            $('.stm1').append(trforappend);
                        }
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                }
            });
        }
        function SaveTopic(Alltopicname, alltopictime) {

            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-topic.aspx/AddTopic",
                data: "{'Classid':'" + $('#ctl00_ContentPlaceHolder1_ddlclassforaddtopic').val() + "','SubjectId':'" + $('#ctl00_ContentPlaceHolder1_ddlsubjectforaddtopic').val() + "','Topicname':'" + Alltopicname + "','Topictime':'" + alltopictime + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Topic Added Successfully.");
                        call_progressbar("end");
                        BindGrid();
                        var lasttroftable = $('.showpopuptopic').find('tbody').find('tr:last').prop('outerHTML');
                        $('#divaddtopic').css('display', 'none');
                        $('#divaddtopic').find('table tr:gt(3)').remove();
                        $('#divaddtopic .showpopuptopic').append(lasttroftable);
                        $('#divaddtopic').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                        $("#divaddtopic").hide();
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Topic Is Adding.");
                        call_progressbar("end");
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });

        }
        function UpDateTopic() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-topic.aspx/TopicManagement",
                data: "{'TopicId':'" + TopicId + "','TopicName':'" + TopicName.split("'").join("~") + "','TopicTime':'" + TopicTime.split("'").join("~") + "','TopicMode':'" + TopicMode + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Topic Updated Successfully.");
                        BindGrid_Viewtopic(subid, classid);
                        $('#divupdatetopic').hide();
                        call_progressbar("end");
                    }
                    else if (data.d == 2) {
                        alertify.error("Topic Deleted Successfully.");
                        BindGrid_Viewtopic(subid, classid)
                        call_progressbar("end");
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Issue While Topic Is Updating.");
                        call_progressbar("end");
                    }
                    TopicId = 0, TopicMode = 0, TopicName = "", TopicTime = "";
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });

        }
    </script>
</asp:Content>