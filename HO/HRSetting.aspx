<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HRSetting.aspx.cs" Inherits="HO_HRSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .stm a, .showpopupshowtopic a {
            cursor: pointer !important;
        }

        th {
            border-bottom: 1px solid #CDCDCD !important;
        }

        .showpopupclass, .showpopupsubject, .showpopuptopic td {
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

        select {
            border: 1px solid #ccc;
            border-radius: 0 !important;
            color: #676767;
            margin-bottom: 0;
            padding: 4px 5px;
            width: 315px;
        }

        input[type=text] {
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 20px;
            line-height: 20px;
            padding: 3px 6px;
            text-align: left;
            text-transform: capitalize !important;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
            width: 300px;
        }

        #loader {
            position: relative;
            top: 10%;
        }

        .progress {
            display: none;
        }

        .progressAdd {
            display: block;
            position: fixed;
            background: -moz-linear-gradient(center top, #fff, #fff) repeat scroll 0 0 rgba(0, 0, 0, 0);
            z-index: 2147483647 !important;
            opacity: 0.8;
            overflow: hidden;
            text-align: center;
            top: 0;
            left: 0;
            height: 100%;
            vertical-align: middle;
            width: 100%;
            padding-top: 20%;
        }

        .imgforedit {
            float: right;
            margin-top: 7px;
        }

        .lbtnupdate {
            cursor: pointer !important;
            display: block;
            float: left;
            margin: 6px 0 0 7px;
            width: 16px;
        }

        .lbtncancel {
            cursor: pointer !important;
            display: block;
            margin: 6px 0 0 5px;
            width: 16px;
        }

        .stm {
            padding-bottom: 0px !important;
        }

        .showpopup2 span {
            float: right;
            padding-left: 0;
            height: 1px;
            width: 1px;
        }
    </style>

    <div class="clear"></div>
    <div class="content_pane_cont input_content  main-div-tbl" id="contentPane">
         <div class="cheadline1" style="width: 100%; margin-left: 0px">
            <span class="spanheading">Department Settings</span>
        </div>
        <table class="stm" width="100%">
            <tr class="stm_head" align="center">
                <th>S.No.</th>
                <th>Department<a style="cursor: pointer; margin-left: 7px !important;" class="addclass">(Add)</a></th>
                <th>Designation<a style="cursor: pointer; margin-left: 7px !important;" class="addsubject">(Add)</a></th>
                <th>Desig. Status<a style="cursor: pointer; margin-left: 7px !important;" class="status"></a></th>
                <th>Dept. Status<a style="cursor: pointer; margin-left: 7px !important;" class="dpstatus"></a></th>
            </tr>
        </table>
        <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 200px; display: none">
            <label style="font-size: 15px; color: red">No Department added.please add the Department first before add any thing.</label>
        </div>
        <div id="divaddclass" style="text-align: center; display: none;">
            <div style="width: 95%; margin: 10px;" class="pop-main-sty">
                <table class="showpopupclass showpopup2" style="background-color: white; vertical-align: top">
                    <tr>
                        <td class="pop-headng-sty" colspan="2">Add Department
                             <a id="BtnCancelclass" title="Close this from here"
                                 class="btnClose">
                                 <img src="../images/popupcross.png"></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="t1">

                            <label>Department Name:<span style="color: #ff0033">*</span></label>
                        </td>
                        <td class="t2">
                            <div>

                                <div style="float: left;">
                                    <asp:TextBox ID="txtclass" runat="server" placeholder="Enter Department Name Please." CssClass="inputclass"></asp:TextBox>
                                    <img src="../images/add.png" style="width: 16px; cursor: pointer;" alt="No Image" class="imageforaddclass" />
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="left">
                            <asp:Button ID="BtnSubmitclass" runat="server" Text="Submit" CssClass="button_save" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="divaddsubject" style="text-align: center; display: none;">
            <div style="width: 95%; margin: 10px;" class="pop-main-sty">
                <table class="showpopupsubject showpopup2" style="background-color: white; vertical-align: top">

                    <tr>
                        <td class="pop-headng-sty" colspan="2">Designation
                             <a id="BtnCancelSubject" title="Close this from here"
                                 class="btnClose">
                                 <img src="../images/popupcross.png"></a>
                        </td>
                    </tr>

                    <tr>
                        <td class="t1">
                            <div>

                                <div>
                                    <label>Select Department:<span style="color: #ff0033">*</span></label>
                                </div>
                            </div>
                        </td>
                        <td class="t2">
                            <div>

                                <div style="float: left;">
                                    <asp:DropDownList ID="ddlclassforaddsubject" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="t1">
                            <div>

                                <div>
                                    <label>Designation Name:<span style="color: #ff0033">*</span></label>
                                </div>
                            </div>
                        </td>
                        <td class="t2">
                            <div>

                                <div style="float: left;">
                                    <asp:TextBox ID="txtsubject" runat="server" placeholder="Enter Designation Name Please." CssClass="inputsubject"></asp:TextBox>
                                    <img src="../images/add.png" style="width: 16px; cursor: pointer;" alt="No Image" class="imageforaddsubject" />
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="left">
                            <asp:Button ID="BtnSubmitSubject" runat="server" Text="Submit" CssClass="button_save" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            BindGrid();
            $('.addclass').click(function () {
                $('#divaddclass').css('display', 'block');
                $('#divaddsubject').css('display', 'none');
                $('#ctl00_ContentPlaceHolder1_txtclass').val('');
            });

            $('.addsubject').click(function () {
                BindClass(1);
                $('#divaddsubject').css('display', 'block');
                $('#divaddclass').css('display', 'none');
                $('#ctl00_ContentPlaceHolder1_ddlclassforaddsubject').val('0');
                $('#ctl00_ContentPlaceHolder1_txtsubject').val('');
            });

            $('#BtnCancelclass').live('click', function () {
                var lasttroftable = $('.showpopupclass').find('tbody').find('tr:last').prop('outerHTML');
                $('#divaddclass').css('display', 'none');
                $('#divaddclass').find('table tr:gt(1)').remove();
                $('#divaddclass').find('table tr:eq(0)').find('td').find('input[type=text]').val('');
                $('#divaddclass .showpopupclass').append(lasttroftable);

                return false;
            });
            $('.imageforaddclass').click(function () {
                var lasttroftable = $('.showpopupclass').find('tbody').find('tr:last').prop('outerHTML');
                $('.showpopupclass').find('tbody').find('tr:last').remove();
                var trforadd = '<tr><td class="t1"><div><br><div ><label>Department Name:</label></div></div></td><td class="t2"><div><br><div ><input  type="text" class="inputclass" placeholder="Enter Department Name Please." ><img class="imageforsubclass" alt="No Image" style="width: 16px; cursor: pointer; margin-left: 2px" src="../images/minus.png"></div></div></td></tr>'
                $('#divaddclass .showpopupclass').append(trforadd);
                $('#divaddclass .showpopupclass').append(lasttroftable);
                return false;
            });
            $('.imageforsubclass').live("click", function () {
                $(this).parent('div').parent('div').parent('td').parent('tr').remove();
                return false;
            });
            $('.imageforaddsubject').click(function () {
                var lasttroftable = $('.showpopupsubject').find('tbody').find('tr:last').prop('outerHTML');
                $('.showpopupsubject').find('tbody').find('tr:last').remove();
                var trforadd = '<tr><td class="t1"><div><br><div ><label>Designation Name:</label></div></div></td><td class="t2"><div><br><div ><input  type="text" class="inputsubject" placeholder="Enter Designation Name Please." ><img class="imageforsubsubject" alt="No Image" style="width: 16px; cursor: pointer; margin-left: 2px" src="../images/minus.png"></div></div></td></tr>'
                $('#divaddsubject .showpopupsubject').append(trforadd);
                $('#divaddsubject .showpopupsubject').append(lasttroftable);
                return false;
            });
            $('.imageforsubsubject').live("click", function () {
                $(this).parent('div').parent('div').parent('td').parent('tr').remove();
                return false;
            });
            $('#BtnCancelSubject').live('click', function () {
                $("#ctl00_ContentPlaceHolder1_ddlclassforaddsubject").attr("disabled", false);
                var lasttroftable = $('.showpopupsubject').find('tbody').find('tr:last').prop('outerHTML');
                $('#divaddsubject').css('display', 'none');
                $('#divaddsubject').find('table tr:gt(2)').remove();
                $('#divaddsubject .showpopupsubject').append(lasttroftable);
                $('#divaddsubject').find('table tr:eq(0)').find('td').find('input[type=text]').val('');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_BtnSubmitclass').live('click', function () {
               
                if ($('.inputclass').val() == "") {
                    alertify.error('Please Enter The Department Name.');
                    return false;
                }
                var allclassname = "";
                $('.showpopupclass').find('tr').find('td').find('input[type=text]').each(function () {
                    if ($(this).val() != "") {
                        allclassname = allclassname + ',' + $(this).val();
                    }
                });
                allclassname = allclassname.slice(1, allclassname.length);
                SaveClass(allclassname)
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_BtnSubmitSubject').live('click', function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlclassforaddsubject').val() == "0") {
                    alertify.error('Please Select The Department First.');
                    return false;
                }
                else if ($('.inputsubject').val() == "") {
                    alertify.error('Please Enter The Designation Name.');
                    return false;
                }
                var allsubjectname = "";
                $('.showpopupsubject').find('tr').find('td').find('input[type=text]').each(function () {
                    if ($(this).val() != "") {
                        allsubjectname = allsubjectname + ',' + $(this).val();
                    }
                });
                allsubjectname = allsubjectname.slice(1, allsubjectname.length);

                SaveSubject(allsubjectname)
                return false;
            });

            $('.changestatus').live('click', function () {
                var desigID = $(this).parent('td').parent('tr').find('td:eq(2)').find('input[type=hidden]').val();
                var a = $(this).parent('td').parent('tr').find('.subjectname').text();
                var status = $(this).text();
                if (status != "N/A") {
                    if (a == "Add Designation") {
                        alert("You can't change the status.Please first add Designation");
                        return false;
                    }
                    else {
                        if (status == "Active")
                            status = 0;
                        else
                            status = 1;
                        updatestatus(desigID, status);
                    }
                }
                else {
                    alertify.error("No Designation Added Till Now.");
                    return false;
                }

            });

            $('.dpchangestatus').live('click', function () {
                var deptid = $(this).parent('td').parent('tr').find('td:eq(1)').find('input[type=hidden]').val();
                var status = $(this).text();
                if (status == "Active")
                    status = 0;
                else
                    status = 1;
                updatedepartmentstatus(deptid, status);
            });

            $('.imgforedit').live('click', function () {
                if ($(this).parents("td").find('a').html() != "Add Designation") {
                    if ($(this).parent('div').find('input[type=hidden][id*=iseditable]').val() == '0') {
                        alertify.error("You can not edit pre-defined Departments.");
                        return false;
                    }
                    $(this).parents("table").find("input[type=text], .lbtnupdate, .lbtncancel").css("display", "none");
                    $(this).parents("table").find('span,.classname,.subjectname').css("display", "inline");
                    $('.stm').find('span').css("display", "inline");
                    $(this).parent('div').find('span,.classname,.subjectname').css("display", "none");
                    $('.imgforedit').css("display", "block");
                    $(this).parent('div').find('input[type=image],img,input[type=text]').css("display", "block");
                    $(this).parent('div').find('input[type=text]').val($(this).parent('div').find('.classname,.subjectname').text());
                    $(this).css("display", "none");
                }
                else {
                    alertify.error('Please Add the Designation');
                    return false;
                }
                return false;
            });

            $('.lbtnupdate').live('click', function () {
                //This If For Update
                var col = $(this).parents('td').index();
                if (parseInt(col) == 1) {
                    var Categoryid = $(this).parent('div').find('input[type=hidden][id*=deptid]').val();
                    var CategoryName = $(this).parent('div').find('input[type=text]').val();
                    if (CategoryName != "")
                        updatedepartment(Categoryid, CategoryName);
                }
                else if (parseInt(col) == 2) {
                    var Categoryid = $(this).parent('div').find('input[type=hidden]').val();
                    var CategoryName = $(this).parent('div').find('input[type=text]').val();
                    if (CategoryName != "")
                        updatedesignation(Categoryid, CategoryName);
                }
                return false;
            });
            $('.lbtncancel').live('click', function () {
                $(this).parent('div').find('input[type=image],img,input[type=text]').css("display", "none");
                $(this).parent('div').find('.imgforedit,span,.classname,.subjectname').css("display", "inline");
                return false;
            });

        });

        function SaveClass(allclassname) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "HRSetting.aspx/AddClass",
                data: "{'ClassName':'" + allclassname + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Department Added Successfully.");
                        call_progressbar("end");
                        BindGrid();
                        $('#divaddclass').css('display', 'none');
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Adding Department .");
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

        function SaveSubject(Allsubjectname) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "HRSetting.aspx/AddSubject",
                data: "{'Classid':'" + $('#ctl00_ContentPlaceHolder1_ddlclassforaddsubject').val() + "','Allsubjectname':'" + Allsubjectname.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Designation Added Successfully.");
                        call_progressbar("end");
                        BindGrid();
                        $('#divaddsubject').css('display', 'none');
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Adding Designation .");
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

        function BindGrid() {
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "HRSetting.aspx/BindGridByJs",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td style="width:28%;"><div class="edit-div-sty"><span class="classname">' + data.d[i].deptname + '</span><input id="deptid" type="hidden" value="' + data.d[i].deptid + '" /><input id="iseditable"  type="hidden" value="' + data.d[i].IsEditable + '" /><input class="imgforedit" type="image"  src="../images/edit.png"><img class="lbtnupdate" style="cursor: pointer ! important; display: none; float: right;" src="../images/update.png"  title="Click here for update"><img class="lbtncancel" style="cursor: pointer !important; display: none; float: right" src="../images/ic.png"  title="Click here for cancel"><input type="text" style="display:none" /></div></td><td style="width:28%;"><div class="edit-div-sty"><span class="subjectname">' + data.d[i].desigName + '</span><input type="hidden" value="' + data.d[i].desigID + '" /><input class="imgforedit" type="image"  src="../images/edit.png"><img class="lbtnupdate" style="cursor: pointer ! important; display: none; float: right;" src="../images/update.png"  title="Click here for update"><img class="lbtncancel" style="cursor: pointer !important; display: none; float: right" src="../images/ic.png"  title="Click here for cancel"><input type="text" style="display:none" /></div></td><td><a class="changestatus">' + data.d[i].statusname + '</a></td><td><a class="dpchangestatus">' + data.d[i].dpstatusname + '</a></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td style="width:28%;"><div class="edit-div-sty"><span class="classname">' + data.d[i].deptname + '</span><input id="deptid" type="hidden" value="' + data.d[i].deptid + '" /><input id="iseditable" type="hidden" value="' + data.d[i].IsEditable + '" /><input class="imgforedit" type="image"  src="../images/edit.png"><img class="lbtnupdate" style="cursor: pointer ! important; display: none; float: right;" src="../images/update.png"  title="Click here for update"><img class="lbtncancel" style="cursor: pointer !important; display: none; float: right" src="../images/ic.png"  title="Click here for cancel"><input type="text" style="display:none" /></div></td><td style="width:28%;"><div class="edit-div-sty"><span class="subjectname">' + data.d[i].desigName + '</span><input type="hidden" value="' + data.d[i].desigID + '" /><input class="imgforedit" type="image"  src="../images/edit.png"><img class="lbtnupdate" style="cursor: pointer ! important; display: none; float: right;" src="../images/update.png"  title="Click here for update"><img class="lbtncancel" style="cursor: pointer !important; display: none; float: right" src="../images/ic.png"  title="Click here for cancel"><input type="text" style="display:none" /></div></td><td><a class="changestatus">' + data.d[i].statusname + '</a></td><td><a class="dpchangestatus">' + data.d[i].dpstatusname + '</a></td></tr>';

                            $('.stm').append(trforappend);
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

        function BindClass(Id) {
            $('#ctl00_ContentPlaceHolder1_txtsubject').val('');
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "HRSetting.aspx/BindClass",
                     data: "{}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         if (parseInt(Id) == 1) {
                             $("#ctl00_ContentPlaceHolder1_ddlclassforaddsubject").html("");
                             $("#ctl00_ContentPlaceHolder1_ddlclassforaddsubject").append($("<option></option>").val('0').html('Select One'));
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddlclassforaddsubject").append($("<option></option>").val(value.Id).html(value.Name));
                             });
                         }

                         call_progressbar("end");
                     },
                     error: function (result) {
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

        function updatestatus(desigID, status) {

            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "HRSetting.aspx/updatestatus",
                data: "{'desigID':'" + desigID + "','status':'" + status + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Designation status updated Successfully.");
                        call_progressbar("end");
                        BindGrid();

                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Updating Designation status .");
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

        function updatedepartment(deptid, deptName) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "HRSetting.aspx/updatedepartment",
                data: "{'deptid':'" + deptid + "','deptName':'" + deptName.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Department updated Successfully.");
                        call_progressbar("end");
                        BindGrid();

                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Updating Department .");
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

        function updatedesignation(desigID, desigName) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "HRSetting.aspx/updatedesignation",
                data: "{'desigID':'" + desigID + "','desigName':'" + desigName.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Designation updated Successfully.");
                        call_progressbar("end");
                        BindGrid();

                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Designation Is Updating.");
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

        function updatedepartmentstatus(deptid, status) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "HRSetting.aspx/updatedepartmentstatus",
                data: "{'deptid':'" + deptid + "','status':'" + status + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Department status updated Successfully.");
                        call_progressbar("end");
                        BindGrid();

                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While updating status .");
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
    </script>
</asp:Content>

