<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="yearly-leave-calendar.aspx.cs" Inherits="branchpanel_employee_yearly_leave_calendar" %>

<%@ Register Src="~/BranchPanel/employee/set-holiday.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../../js/jquery-1.8.3.min.js"></script>
    <script src="../../Calender/sp-jquery-ui.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .Highlighted a {
            background-color: #FFFF00 !important;
        }

            .Highlighted a:hover {
                color: #ff0000 !important;
            }

        .activelistofholiday {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .ui-datepicker-header {
            background: none repeat scroll 0 0 #016fa7!important;
            padding: 0.2em 0!important;
            position: relative!important;
            width: 244px!important;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Hr Management</a></li>
            <li style="background: none;"><a class="active" href="#">Holiday List</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <a id="img" style="cursor: pointer">Open</a>
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div id="jan" style="height: 200px; width: 25%; float: left;"></div>
        <div id="fab" style="height: 200px; width: 25%; float: left;"></div>
        <div id="mar" style="height: 200px; width: 25%; float: left;"></div>
        <div id="apr" style="height: 200px; width: 25%; float: left;"></div>
        <div id="may" style="height: 200px; width: 25%; float: left;"></div>
        <div id="jun" style="height: 200px; width: 25%; float: left;"></div>
        <div id="jul" style="height: 200px; width: 25%; float: left;"></div>
        <div id="aug" style="height: 200px; width: 25%; float: left;"></div>
        <div id="sep" style="height: 200px; width: 25%; float: left;"></div>
        <div id="oct" style="height: 200px; width: 25%; float: left;"></div>
        <div id="nov" style="height: 200px; width: 25%; float: left;"></div>
        <div id="dec" style="height: 200px; width: 25%; float: left;"></div>

        <script type="text/javascript">

            $(document).ready(function () {

                var getleavedate = "", leavefrom = "", leaveto = "";
                var SelectedDates = {};
                leavefrom = "01 Apr 2014";
                leaveto = "31 Mar 2015";
                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "yearly-leave-calendar.aspx/getsandwichleave",
                    data: "{'fromdate':'" + leavefrom + "','todate':'" + leaveto + "'}",
                    datatype: "json",
                    success: function (data) {

                        for (i = 0; i < data.d.length; i++) {
                            getleavedate = data.d[i].holidaydate;
                            SelectedDates[new Date(getleavedate)] = new Date(getleavedate);
                        }
                    },
                    error: function (result) {
                        alert('aaaa');
                    }
                });

                $("#jan").datepicker({
                    defaultDate: new Date('01 Jan 2015'),
                    beforeShowDay: function (date) {

                        //alert(SelectedDates[date]);
                        var Highlight = SelectedDates[date];
                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });

                $("#fab").datepicker({
                    defaultDate: new Date('01 Feb 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#mar").datepicker({
                    defaultDate: new Date('01 Mar 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#apr").datepicker({
                    defaultDate: new Date('01 Apr 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#may").datepicker({
                    defaultDate: new Date('01 May 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#jun").datepicker({
                    defaultDate: new Date('01 Jun 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#jul").datepicker({
                    defaultDate: new Date('01 Jul 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#aug").datepicker({
                    defaultDate: new Date('01 Aug 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#sep").datepicker({
                    defaultDate: new Date('01 Sep 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#oct").datepicker({
                    defaultDate: new Date('01 Oct 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#nov").datepicker({
                    defaultDate: new Date('01 Nov 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
                $("#dec").datepicker({
                    defaultDate: new Date('01 Dec 2015'),
                    beforeShowDay: function (date) {
                        var Highlight = SelectedDates[date];

                        if (Highlight) {
                            return [true, "Highlighted", "Holiday"];
                        }
                        else {
                            return [true, '', ''];
                        }
                    }
                });
            });
        </script>
</asp:Content>