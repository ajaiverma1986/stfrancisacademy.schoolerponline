<%@ Page Title="Add Classroom" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="roomsetting.aspx.cs" Inherits="BranchPanel_roomsetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../js/jquery-1.8.3.min.js"></script>
    <style>
        .stm {
            border: 1px solid #dddddd;
        }

        th {
            background-color: #808080;
            color: white;
        }

        .txdiscount {
            Height: 25px;
            Width: 100px;
        }

        .csspayfee3 {
            Height: 30px;
            Width: 300px;
            color: red;
        }

        .clsdivcheckboxes {
            height: 100px;
            overflow-x: hidden;
            overflow-y: scroll;
            width: 214px;
            display: none;
        }

            .clsdivcheckboxes td {
                line-height: 23px;
            }

        #grdpay {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            width: 100%;
            border-collapse: collapse;
        }

            #grdpay td, #grdpay th {
                font-size: 1em;
                border: 1px solid #98bf21;
                padding: 3px 7px 2px 7px;
            }

            #grdpay th {
                font-size: 1.1em;
                text-align: left;
                padding-top: 5px;
                padding-bottom: 4px;
                background-color: #A7C942;
                color: #ffffff;
            }

            #grdpay tr.clsmaintr td {
                color: #000000;
                background-color: #EAF2D3;
            }

        #grdpay3 {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            width: 100%;
            border-collapse: collapse;
        }

            #grdpay td, #grdpay3 th {
                font-size: 1em;
                border: 1px solid #98bf21;
                padding: 3px 7px 2px 7px;
            }

            #grdpay3 th {
                font-size: 1.1em;
                text-align: left;
                padding-top: 5px;
                padding-bottom: 4px;
                background-color: #A7C942;
                color: #ffffff;
            }

            #grdpay3 tr.clsmaintr td {
                color: #000000;
                background-color: #EAF2D3;
            }

        .one {
            border-style: solid;
            border-width: 5px;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Master Settings</a></li>
            <li><a>Classroom Settings</a></li>
            <li style="background: none;"><a class="active">Add Classroom with capacity </a>
            </li>
            <div class="arrowt">
                <a href="../Branchpanel/Addarea.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
        </ul>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {

            $('#ctl00_ContentPlaceHolder1_btnAdd').css("display", "none");
            $('#ctl00_ContentPlaceHolder1_Button1').css("display", "none");
            $("#ctl00_ContentPlaceHolder1_TextBox1").blur(function () {

                var txt = $("#ctl00_ContentPlaceHolder1_TextBox1").val();

                if (txt == "") {
                    alert("Please Enter any value in textbox!!");

                    return false;

                }

                $("#ctl00_ContentPlaceHolder1_divty").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_mydiv2").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_Button2").css("display", "none");
                var i = 0;
                var a = jQuery("#ctl00_ContentPlaceHolder1_TextBox1").val();
                var table = '<table id="grdpay"  cellpadding="0" cellspacing="0" border="0" align="center" style="margin-right:180px;margin-top:-2px;" width="100%" class="stm"><thead class="stm_head"><tr><th>Room Name</th><th>Type</th><th>Capacity</th><th>Description</th><th>Floor</th></thead><tbody>';
                for (var i = 0; i < a; i++) {

                    var row = '<tr class="clsmaintr">'
                    row += '<td><input style="height:27px" class="cssroomnamegrid" type=text></td>';
                    row += '<td><select id="ddltype" style="width:125px;height:27px"><option value="0">Select</option><option value="1">Class</option><option value="2">Adminstration</option></select></td>';
                    row += '<td><input style="height:27px"  class="csscapacitygrid" type=text></td>';
                    row += '<td><input style="height:27px" class="cssstatusgrid" type=text></td>';
                    row += '<td><input style="height:27px"  class="cssfloorgrid" type=text></td>';
                    row += '</tr>';
                    table += row;
                }
                table += '</tbody></table>';
                $('#ty').html(table);
                $('#ctl00_ContentPlaceHolder1_btnAdd').css("display", "block");
                $('#ctl00_ContentPlaceHolder1_Button1').css("display", "block");
            });

        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_Button2").click(function () {

                $("#ctl00_ContentPlaceHolder1_divgrid23").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_mydiv2").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_Button2").css("display", "none");
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_mydiv2").css("display", "none");
            $.ajax({
                type: "POST",
                url: "roomsetting.aspx/BindDatatable",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var table = '<table id="grdpay3" style="margin-right:180px; margin-top=43px" width="110%" class="stm"><thead class="stm_head" ><tr><th>Room Name</th><th> capacity</th><th>Room Type</th><th>Floor</th><th>Status</th><th>Edit Here</th><th style="display:none">roomid</th></thead><tbody>';

                    for (var i = 0; i < data.d.length; i++) {
                        var row = '<tr">';

                        row += '<td><span class="cssroomname" href="#">' + data.d[i].roomname1 + '</span></td>';
                        row += '<td><span class="csscapacity">' + data.d[i].capacity1 + '</span></td>';
                        row += '<td><span class="csstype">' + data.d[i].typename1 + '</span></td>';
                        row += '<td><span class="cssfloor">' + data.d[i].floor12 + '</span></td>';

                        row += '<td><span class="cssst">' + data.d[i].status1 + '</span></td>';
                        row += '<td><a class="changerout" href="">' + "Edit Here" + '</a></td>';
                        row += '<td style="display:none"><span class="cssroomid">' + data.d[i].roomid + '</span></td>';

                        row += '</tr>';

                        table += row;
                    }

                    table += '</tbody></table>';

                    $('#Container').html(table);

                }
            });

        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            var roomname = "";
            var capacity = "";
            var description = "";
            var floor = "";
            var count1 = 0;
            var typecheck = "";
            var typename = "";

            $("#ctl00_ContentPlaceHolder1_btnAdd").click(function () {

                //$(".cssroomnamegrid").each(function () {
                //   // alert("hey");
                //    var x = $(this).closest('tr').find('td:eq(0) input:first-child').val();
                //    var y = $(this).closest('tr').find('td:eq(1) option:selected').text();
                //    var z = $(this).closest('tr').find('td:eq(2) input:first-child').val();
                //    var k = $(this).closest('tr').find('td:eq(3) input:first-child').val();
                //    var t = $(this).closest('tr').find('td:eq(4) input:first-child').val();

                //    if (x == "")
                //    {
                //        alert("Please Enter Room Name");
                //        return false;
                //    }
                //    if (y == "select") {
                //        alert("please select Room Type");
                //        return false;
                //    }
                //    if (z == "") {
                //        alert("Please Enter Capacity");
                //        return false;
                //    }
                //    if (k == "") {
                //        alert("Please enter Description");
                //        return false;
                //    }
                //    if (t == "") {
                //        alert("Please enter Floor name");
                //        return false;

                //    }

                //});

                $("#grdpay .clsmaintr:has(td)").each(function () {

                    count1 = parseInt(count1) + 1;

                    roomname = roomname + "," + $(this).closest('tr').find('td:eq(0) input:first-child').val();
                    typename = typename + "," + $(this).closest('tr').find('td:eq(1) option:selected').text();
                    capacity = capacity + "," + $(this).closest('tr').find('td:eq(2) input:first-child').val();
                    description = description + "," + $(this).closest('tr').find('td:eq(3) input:first-child').val();
                    floor = floor + "," + $(this).closest('tr').find('td:eq(4) input:first-child').val();

                });
                if (roomname.length > 0) {
                    roomname = roomname.substring(1, roomname.length);
                }
                if (typename.length > 0) {
                    typename = typename.substring(1, typename.length);
                }
                if (capacity.length > 0) {
                    capacity = capacity.substring(1, capacity.length);
                }
                if (description.length > 0) {
                    description = description.substring(1, description.length);
                }
                if (floor.length > 0) {
                    floor = floor.substring(1, floor.length);
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "roomsetting.aspx/insertdata",
                    data: "{'roomname':'" + roomname + "','typname':'" + typename + "','capacity':'" + capacity + "','description':'" + description + "','floor':'" + floor + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            $("#ctl00_ContentPlaceHolder1_mydiv2").css("display", "none");
                            alert("Record inserted sucessfully .!");
                            $("#ctl00_ContentPlaceHolder1_btnAdd").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_Button1").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_divgrid23").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_Button2").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_divty").css("display", "none");
                            $.ajax({
                                type: "POST",
                                url: "roomsetting.aspx/BindDatatable",
                                data: "{}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    var table = '<table id="grdpay3" style="margin-right:180px;margin-top=43px" width="110%" class="stm"><thead class="stm_head" ><tr><th>Room Name</th><th> capacity</th><th>Room Type</th><th>Floor</th><th>Status</th><th>Edit Here</th><th style="display:none">roomid</th></thead><tbody>';

                                    for (var i = 0; i < data.d.length; i++) {
                                        var row = '<tr">';

                                        row += '<td><span class="cssroomname" href="#">' + data.d[i].roomname1 + '</span></td>';
                                        row += '<td><span class="csscapacity">' + data.d[i].capacity1 + '</span></td>';
                                        row += '<td><span class="csstype">' + data.d[i].typename1 + '</span></td>';
                                        row += '<td><span class="cssfloor">' + data.d[i].floor12 + '</span></td>';
                                        row += '<td><span class="cssst">' + data.d[i].status1 + '</span></td>';
                                        row += '<td><a class="changerout" href="">' + "Edit Here" + '</a></td>';
                                        row += '<td style="display:none"><span class="cssroomid">' + data.d[i].roomid + '</span></td>';

                                        row += '</tr>';

                                        table += row;
                                    }

                                    table += '</tbody></table>';

                                    $('#Container').html(table);

                                }
                            });

                            return false;

                        }

                        else {
                            alert("Error.");
                            return false;
                        }
                    },
                });

                return false;
            });

            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {

                $("#ctl00_ContentPlaceHolder1_divgrid23").css("display", "block");

                $.ajax({
                    type: "POST",
                    url: "roomsetting.aspx/BindDatatable",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var table = '<table id="grdpay3" style="margin-right:180px; margin-top=43px" width="110%" class="stm"><thead class="stm_head" ><tr><th>Room Name</th><th> capacity</th><th>Room Type</th><th>Floor</th><th>Status</th><th>Edit Here</th><th style="display:none">roomid</th></thead><tbody>';

                        for (var i = 0; i < data.d.length; i++) {
                            var row = '<tr">';

                            row += '<td><span class="cssroomname" href="#">' + data.d[i].roomname1 + '</span></td>';
                            row += '<td><span class="csscapacity">' + data.d[i].capacity1 + '</span></td>';
                            row += '<td><span class="csstype">' + data.d[i].typename1 + '</span></td>';
                            row += '<td><span class="cssfloor">' + data.d[i].floor12 + '</span></td>';
                            // row += '<td><a class="changerout" href="">' + "Edit Here" + '</a></td>';
                            row += '<td><span class="cssst">' + data.d[i].status1 + '</span></td>';
                            row += '<td><a class="changerout" href="">' + "Edit Here" + '</a></td>';
                            row += '<td style="display:none"><span class="cssroomid">' + data.d[i].roomid + '</span></td>';
                            row += '</tr>';

                            table += row;
                        }

                        table += '</tbody></table>';

                        $('#Container').html(table);

                    }
                });

                $("#ctl00_ContentPlaceHolder1_Button2").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_divty").css("display", "none");
                $('#ctl00_ContentPlaceHolder1_btnAdd').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_Button1').css("display", "none");
                $('#ctl00_ContentPlaceHolder1_TextBox1').val('');
                return false;
            })

            $(".changerout").live('click', function () {
                var roomid12 = ($(this).closest('tr').find('td:eq(6) span:last-child').text());

                $("#divedit").fadeIn(200);
                $("#divedit").css("display", "block");

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "roomsetting.aspx/filldata",
                    data: "{'roomid':'" + roomid12 + "'}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data.d, function (key, value) {

                            $("#ctl00_ContentPlaceHolder1_txt1").val(value.roomname);
                            $("#ctl00_ContentPlaceHolder1_lblhidden").html(roomid12);
                            $('#ctl00_ContentPlaceHolder1_ddl1').val(value.roomtype);
                            $('#ctl00_ContentPlaceHolder1_TextBox2').val(value.roomcapacity);
                            $('#ctl00_ContentPlaceHolder1_TextBox3').val(value.roomfloor);

                        });
                    }
                });

                return false;

            });

            $('#ctl00_ContentPlaceHolder1_btnupdate').click(function () {

                var cap = $("#ctl00_ContentPlaceHolder1_TextBox2").val();
                var room_id1 = $("#ctl00_ContentPlaceHolder1_lblhidden").text();

                $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "roomsetting.aspx/updateroom",
                                        data: "{'capacity':'" + cap + "','roomid2':'" + room_id1 + "'}",
                                        dataType: "json",
                                        success: function (data) {
                                            $('#divedit').css('display', 'none')
                                            $.each(data.d, function (key, value) {

                                                $.ajax({
                                                    type: "POST",
                                                    url: "roomsetting.aspx/BindDatatable",
                                                    data: "{}",
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    success: function (data) {
                                                        var table = '<table id="grdpay3" style="margin-right:180px;margin-top=43px" width="110%" class="stm"><thead class="stm_head" ><tr><th>Room Name</th><th> capacity</th><th>Room Type</th><th>Floor</th><th>Status</th><th>Edit Here</th><th style="display:none">roomid</th></thead><tbody>';

                                                        for (var i = 0; i < data.d.length; i++) {
                                                            var row = '<tr">';

                                                            row += '<td><span class="cssroomname" href="#">' + data.d[i].roomname1 + '</span></td>';
                                                            row += '<td><span class="csscapacity">' + data.d[i].capacity1 + '</span></td>';
                                                            row += '<td><span class="csstype">' + data.d[i].typename1 + '</span></td>';
                                                            row += '<td><span class="cssfloor">' + data.d[i].floor12 + '</span></td>';

                                                            row += '<td><span class="cssst">' + data.d[i].status1 + '</span></td>';
                                                            row += '<td><a class="changerout" href="">' + "Edit Here" + '</a></td>';
                                                            row += '<td style="display:none"><span class="cssroomid">' + data.d[i].roomid + '</span></td>';

                                                            row += '</tr>';

                                                            table += row;
                                                        }

                                                        table += '</tbody></table>';

                                                        $('#Container').html(table);

                                                    }
                                                });

                                            });
                                        },
                                        error: function (result) {
                                            alert("Error");
                                        }
                                    });

                return false;
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_btncancel1").click(function () {
                $("#divedit").slideToggle();
                return false;

            });
        });
    </script>

    <div class="content_pane_cont input_content" id="contentPane">
        <div id="divtop" runat="server" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadlinenew">
        </div>
        <asp:Button runat="server" ID="Button2" CssClass="view-enquiry" Text="Add Classroom"
            ToolTip="Click here to Add class." Style="float: right; margin-top: 8.71px;" />
        <div id="mydiv2" runat="server">
            <div class="for_sigle_row_form">
                <label>
                    Enter Room Name<span style="color: Red;">* </span>
                </label>
                <asp:TextBox ID="TextBox1" runat="server">
                </asp:TextBox>&nbsp;
            </div>
        </div>

        <div id="divty" runat="server" style="margin-top: 62px">
            <div id="ty">
            </div>
        </div>
        <div id="divgrid23" runat="server">
            <div id="Container"></div>
        </div>
    </div>
    <div id="divedit" class="one" style="background-color: gray; width: 400px; height: 300px; margin-left: 258px; display: none; border-color: green; margin-top: -569px; z-index: 2001; -moz-opacity: 0.9; opacity: .99; filter: alpha(opacity=80);">
        <br />
        <div class="for_sigle_row_form">
            <label style="margin-left: -90px">Room Name</label>
            <asp:TextBox ID="txt1" runat="server" Style="float: right; margin-right: 118px; height: 25px; width: 103px;"></asp:TextBox>
            <asp:TextBox ID="lblhidden" runat="server" Style="float: right; margin-right: 148px; display: none"></asp:TextBox>
            <br />
            <br />
        </div>
        <br />

        <br />
        <div class="for_sigle_row_form">
            <label style="margin-left: -90px">Capacity</label>
            <asp:TextBox ID="TextBox2" runat="server" Style="float: right; margin-right: 118px; height: 25px; width: 103px;"></asp:TextBox>
            <br />
            <br />
        </div>
        <br />
        <br />

        <div class="for_sigle_row_form">
            <label style="margin-left: -90px;">Room Type</label>
            <asp:DropDownList ID="ddl1" runat="server" Style="float: right; margin-right: 118px; height: 36px; width: 117px">
                <asp:ListItem Value="0">Select</asp:ListItem>
                <asp:ListItem Value="1">class</asp:ListItem>
                <asp:ListItem Value="2">Administration</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
        </div>

        <br />
        <br />
        <div class="for_sigle_row_form">
            <label style="margin-left: -90px">Floor</label>
            <asp:TextBox ID="TextBox3" runat="server" Style="float: right; margin-right: 118px; height: 25px; width: 103px"></asp:TextBox>
            <br />

            <br />
        </div>
        <br />
        <br />
        <asp:Button ID="btnupdate" runat="server" CssClass="button_save" Text="Submit" Style="height: 32px; margin-left: 168px; margin-top: -53px; width: 77px;" />
        <asp:Button ID="btncancel1" runat="server" CssClass="button_cancel" Text="Cancel"
            Style="margin-left: 258px" />
    </div>
    <label>
    </label>
    <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save1" Style="margin-left: 396px"
        ValidationGroup="g1" />
    <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="button_cancel" Style="margin-left: 482px; margin-top: -29px;" />
</asp:Content>