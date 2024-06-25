<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="feedback-master.aspx.cs" Inherits="HO_feedback_master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .cheadline1 {
            float: right;
            padding: 0;
            width: 780px;
            font-size: 15px;
            font-weight: bolder;
            line-height: 27px;
        }

        select.myDropDownList {
            text-align: center;
        }
    </style>
    <div class="cheadline1" style="width: 100%; margin-left: 5px">
        <span class="spanheading" style="margin-left: 5px">Feedback Type List</span>
        <asp:Button ID="btnaddnewfeedback" runat="server" Text="Add New Feedback" Visible="true" CssClass="button_save"
            CausesValidation="false" Style="float: right; border: 1px solid #0A748A; color: #fff; background-color: #2ca8c2; margin-right: 30px;" />
        <div style="padding: 10px; width: 700px; float: right">
            <label style="font-weight: 700; color: green">Active Feedback</label>:
            <span id="spantotalafeedback" runat="server">0</span>
            <label id="lbl1" style="font-weight: 700"></label>
            <label style="font-weight: 700; color: red">Deactive</label>:
            <span id="spanactivatedfeddback" runat="server">0</span>
            <label id="lbl2" style="display: none"></label>
            <label style="margin-left: 20px; font-weight: 700; color: darkred">Deleted </label>
            :
            <span id="spantotaldeletedfeedback" runat="server">0</span>
            <label id="lbl3" style="font-weight: 700"></label>
            <%-- <label style="margin-left: 20px; font-weight: 700; color: blue">Submitted Feedback </label>
            :
            <span id="spansubmit" runat="server">0</span>--%>
        </div>

        <div class="AddNewFeedbacktype" style="display: none">
            <div class="MainTableForAddFeddback ">
                <div class="for_sigle_row_form">
                    <label style="width: 200px">
                        Feedback Type:<span style="color: red; font-weight: bold">*</span></label>

                    <asp:DropDownList ID="ddlsdudenttype" runat="server">
                        <asp:ListItem Value="0" Text="---Select Feedback Type---"></asp:ListItem>
                        <asp:ListItem Value="1" Text="General Feedback"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Faculty Feedback"></asp:ListItem>
                        <asp:ListItem Value="3" Text="Other Feedback"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label style="width: 200px">
                        Feedback Description:<span style="color: red; font-weight: bold">*</span></label>
                    <textarea cols="20" rows="2" placeholder="Enter Add New  Feedback Type Please" class="inputforfeedbacktype"></textarea>
                    <img src="../images/add.png" style="width: 16px; cursor: pointer;" alt="No Image" class="imageforadd" />
                </div>
            </div>
            <div class="for_sigle_row_form">
                <label style="width: 200px"></label>
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="button_save" />
                <asp:Button ID="btncancel" runat="server" Text="Cancel" CssClass="button_cancel" />
            </div>
        </div>
        <div class="DivForListFeedbackType">
            <table class="stm" style="width: 100%">
                <tr class="stm_head" align="center">
                    <td>S.No.</td>
                    <td>Feedback Types</td>
                    <td>Feedback Comment</td>
                    <td>Change Status</td>
                    <td>Edit</td>
                    <td>Delete</td>
                </tr>
            </table>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        var FeedbackTypeid = 0, FeedbackTypeName = '', ddlforfeedbacktype = '', ddlforfeedbacktypeid = 0, abc = 0, Status = 0;
        $(document).ready(function () {
            BindFeedbackTypeGrid();
            BindLabelData();
            $("#ctl00_head_txtdescription").val('');
            $('.inputforfeedbacktype').val('');
            $('.imageforadd').live('click', function () {
                var trforadd = '<div class="for_sigle_row_form"><label style="width:200px">Feedback Description:<span style="color:red;font-weight:bold">*</span></label><textarea  cols="20" rows="2" placeholder="Enter Add New Feedback Type Please" class="inputforfeedbacktype"></textarea><img class="imageforsub" alt="No Image" style="width: 16px; cursor: pointer;" src="../images/minus.png"></div>'
                $('.MainTableForAddFeddback').append(trforadd);
                return false;
            });
            $('.imageforsub').live("click", function () {
                $(this).parent('div').remove();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnaddnewfeedback').click(function () {
                $(this).hide(500);
                $('.spanheading').html('Add New Feedback')
                $('.DivForListFeedbackType').hide(500)
                $('.AddNewFeedbacktype').show(500);
                $('.MainTableForAddFeddback').find('div:gt(1)').remove();
                $('.imageforadd').css("display", "inline");
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btncancel').click(function () {
                $('#ctl00_ContentPlaceHolder1_btnaddnewfeedback').show(500);
                $('.spanheading').html('Feedback Type List')
                $('.DivForListFeedbackType').show(500);
                $('.AddNewFeedbacktype').hide(500);
                $('#ctl00_ContentPlaceHolder1_ddlsdudenttype').val('0');
                $('.inputforfeedbacktype').val('');
                $('.MainTableForAddFeddback').find('div:gt(1)').remove();
                $('#ctl00_ContentPlaceHolder1_btnsubmit').val('Submit');
                $('.imageforadd').css("display", "block");
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnsubmit').click(function () {

                if (Status == 3) {
                    if ($('#ctl00_ContentPlaceHolder1_ddlsdudenttype').val() == '0') {
                        alertify.error('Please select feedback type.');
                        return false;
                    }
                    else if ($('.inputforfeedbacktype').val() == '') {
                        alertify.error('Please enter feedback description.');
                        return false;
                    }
                    ddlforfeedbacktypeid = $('#ctl00_ContentPlaceHolder1_ddlsdudenttype option:selected').val();
                    ddlforfeedbacktype = $('#ctl00_ContentPlaceHolder1_ddlsdudenttype option:selected').text();
                    FeedbackTypeName = $('.inputforfeedbacktype').val();
                    $('.imageforadd').show(500);
                    alertify.confirm('Are You Sure You want To Activate This Feedback Type.?', function (e) {
                        if (e) {
                            EditOrChangeStatus();
                        }

                        else {
                            alertify.error("You've Clicked Cancel.");
                        }
                    });
                }
                else {
                    if ($('#ctl00_ContentPlaceHolder1_ddlsdudenttype').val() == '0') {
                        alertify.error('Please select feedback type.');
                        return false;
                    }
                    else if ($('.inputforfeedbacktype').val() == '') {
                        alertify.error('Please enter feedback description.');
                        return false;
                    }
                    else {
                        var AllFeedbackcomment = '', feedbacktypes = 0, feedbacktypesname = '';
                        $('.MainTableForAddFeddback textarea').each(function () {
                            if ($(this).val() == '') {
                                alertify.error('Please Fill All The Field.');
                                return false;
                            }
                            feedbacktypesname = $('#ctl00_ContentPlaceHolder1_ddlsdudenttype option:selected').text();
                            feedbacktypes = $('#ctl00_ContentPlaceHolder1_ddlsdudenttype option:selected').val();
                            AllFeedbackcomment = AllFeedbackcomment + '`' + $(this).val();

                        });
                        SubMitFeedbackType(AllFeedbackcomment, feedbacktypesname, feedbacktypes);
                        BindLabelData();
                    }
                }
                return false;
            });
            $('.ImgForChangeStatus').live('click', function () {
                if ($(this).attr('src') == '../images/ic.png')
                    Status = 1;
                else
                    Status = 0;
                FeedbackTypeid = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type=hidden]').val();
                if (Status == 1) {
                    alertify.confirm('Are You Sure To Activate This Feedback Type.?', function (e) {
                        if (e) {
                            EditOrChangeStatus();
                            BindLabelData();
                        }

                        else {
                            alertify.error("You've Clicked Cancel.");
                        }
                    });
                }
                else {
                    alertify.confirm('Are You Sure To Deactivate This Feedback Type.?', function (e) {
                        if (e) {
                            EditOrChangeStatus();
                            BindLabelData();
                        }
                        else {
                            alertify.error("You've Clicked Cancel.");
                        }

                    });
                }
                return false;
            });
            $('.imgedit').live('click', function () {
                Status = 3;
                FeedbackTypeid = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type=hidden]').val();
                $('#ctl00_ContentPlaceHolder1_btnsubmit').val('Update');
                $('.imageforadd').hide(500);
                abc = $(this).parent('td').parent('tr').find('td:eq(1)').find('input[type=hidden]').val();

                $("#ctl00_ContentPlaceHolder1_ddlsdudenttype").val(abc)
                $('.inputforfeedbacktype').val($(this).parent('td').parent('tr').find('td:eq(3)').html());
                $('.spanheading').html('Edit Feedback  Type')
                $('.DivForListFeedbackType').hide(500);
                $('.AddNewFeedbacktype').show(500);
                $('#ctl00_ContentPlaceHolder1_btnaddnewfeedback').css("display", "none");
                return false;
            });
            $('.imgdelete').live('click', function () {
                Status = 2;
                FeedbackTypeid = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type=hidden]').val();
                alertify.confirm('Are You Sure You want To Delete This Feedback Type.?', function (e) {
                    if (e) {
                        EditOrChangeStatus();
                        BindLabelData();
                    }
                    else {
                        alertify.error("You've Clicked Cancel.");
                    }
                });
                return false;
            });
            BindDiscountTypeGrid();
        });
        function SubMitFeedbackType(AllFeedbackcomment, feedbacktypesname, feedbacktypes) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "feedback-master.aspx/AddFeedbackType",
                data: "{'AllFeedbackcomment':'" + AllFeedbackcomment.split("'").join("~") + "','feedbacktypes':'" + feedbacktypes + "','feedbacktypesname':'" + feedbacktypesname.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Feedback Type Added Sucessfully.");
                        BindFeedbackTypeGrid();
                        call_progressbar("end");
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error Occur While Feedback Adding.");
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error Occured.");
                    return false;
                }
            });
        }
        function BindFeedbackTypeGrid() {
            $('#ctl00_ContentPlaceHolder1_btnaddnewfeedback').css("display", "block");
            $('.spanheading').html('Feedback Type List')
            $('.DivForListFeedbackType').show(500);
            $('.AddNewFeedbacktype').hide(500);
            $('#ctl00_ContentPlaceHolder1_ddlsdudenttype').val('0');
            $('.inputforfeedbacktype').val('');
            $('.MainTableForAddFeddback').find('div:gt(1)').remove();
            var trforappend = '', classfortr = '';
            $('.stm').find('tr:gt(0)').remove();
            call_progressbar('start');
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "feedback-master.aspx/BindGridByJs",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                classfortr = 'stm_dark'
                            else
                                classfortr = 'stm_light'

                            trforappend = '<tr class="' + classfortr + '"><td><input type="hidden" value="' + data.d[i].FeedbackTypeid + '" />' + (i + 1) + '</td>' +
                                              '<td style="display:none"><input type="hidden" value="' + data.d[i].feedbacktypes + '" /></td>' +
                                              '<td>' + data.d[i].feedbacktypesname + '</td>' +
                                              '<td>' + data.d[i].FeedbackTypeName + '</td>' +
                                              '<td><input type="image"class="ImgForChangeStatus" title=" Click here for Active and Deactive feedback" class="imgbuttonforedit" src="' + data.d[i].StatusImageName + '" />' + '</td>' +
                                              '<td><input type="image"class="imgedit" title=" Click here for Edit feedback"  class="imgbuttonforedit" src="../images/edit.png" />' + '</td>' +
                                              '<td><input type="image"class="imgdelete"  class="deleteimage" title=" Click here for Delete feedback" src="../images/ic.png"  />' + '</td></tr>';

                            $('.stm').append(trforappend);
                        }
                    }
                    else {
                        call_progressbar("end");
                        alertify.error('Sorry ! No Record Found.');
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                    alertify.error('Some Internel Error Occur Data Is Binding.')
                    call_progressbar("end");
                }
            });
        }
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
        function EditOrChangeStatus() {

            call_progressbar('start')
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "feedback-master.aspx/EditOrChangeStatusOfFeedbackType",
                data: "{'FeedbackTypeid':'" + FeedbackTypeid + "','FeedbackTypeName':'" + FeedbackTypeName.split("'").join("~") + "','Status':'" + Status + "','ddlforfeedbacktypeid':'" + ddlforfeedbacktypeid + "','ddlforfeedbacktype':'" + ddlforfeedbacktype + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 4)
                        alertify.error("Some Error Occur Here Sorry.");
                    else if (data.d == 0)
                        alertify.error("Feedback Type Deactivated Sucessfully.");
                    else if (data.d == 1)
                        alertify.success("Feedback Type Activated Sucessfully.");
                    else if (data.d == 2)
                        alertify.error("Feedback Type Deleted Sucessfully.");
                    else if (data.d == 3)
                        alertify.success("Feedback Type Name Updated Sucessfully.");

                    FeedbackTypeid = 0, FeedbackTypeName = '', Status = 0

                    BindFeedbackTypeGrid();
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error("Some Internal Error Occur.");
                    return false;
                }
            });
        }

        function BindLabelData() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "feedback-master.aspx/Feedbacklable",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_spantotalafeedback").html(data.d[0].TotalActivate);
                        $('#ctl00_ContentPlaceHolder1_spanactivatedfeddback').html(data.d[0].TotalDeactive);
                        $("#ctl00_ContentPlaceHolder1_spantotaldeletedfeedback").html(data.d[0].TotaDeletedFeedback);
                        //$('#ctl00_ContentPlaceHolder1_spansubmit').html(data.d[0].TotalSubmitFeedback);
                    }
                }
            });
        }
    </script>
</asp:Content>