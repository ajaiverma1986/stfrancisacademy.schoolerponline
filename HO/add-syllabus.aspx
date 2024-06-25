<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="add-syllabus.aspx.cs" Inherits="HO_add_syllabus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../css/alertify.core.css" type="text/css" rel="Stylesheet" media="all" />
    <link href="../css/alertify.default.css" type="text/css" rel="Stylesheet" media="all" />
    <script src="../js/alertify.js" type="text/javascript"></script>
    <style type="text/css">
        .for_sigle_row_form label {
            width: 58px !important;
        }

        .stm td {
            border-left: 1px solid #dddddd !important;
        }

        .showpopup {
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #2CA8C2;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: auto;
            left: 29%;
            opacity: 1;
            padding-bottom: 20px;
            position: fixed;
            top: 5%;
            width: 43%;
            z-index: 100;
        }
    </style>
    <script type="text/javascript">

        var branchid = 0, classid = 0, subjectid = 0, txttopic = 2, topic = "", topicid, topiclesson = "", txtlesson = 2;
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_gvdetails").hide();
            $("#getclass").hide();//hide ddl on page load
            $("#gettopic").hide();//hide ddl on page load
            $("#getsubject").hide();//hide ddl on page load

            $("#ctl00_ContentPlaceHolder1_DDlBranch").change(function () {
                branchid = $(this).val();
                if (branchid == 0) {
                    $("#getclass").hide(500);
                    $("#getsubject").hide(500);
                    $("#gettopic").hide(500);
                }
                else {
                    getclass();
                }

            });  // Get class related the banch
            $("#addmore").click(function () {
                $("#addmorediv").append('<div class="for_sigle_row_form" id="txttopin' + txttopic + '"><label></label><input class="Chup" id="txttopic' + txttopic + '" type="text"><img class="remove"  style="width: 15px; height: 15px; cursor: pointer;" src="../images/minus.png"></div>');
                txttopic = txttopic + 1;
            });                                 //add more topic in subject

            $("#addmorelecture").click(function () {
                $("#addmorelesson").append('<div class="for_sigle_row_form removeaddedlesson"><label>Lesson  ' + txtlesson + '</label><input class="addremovelesson" id="txtlesson' + txtlesson + '" type="text"><img class="removelesson"  style="width: 15px; height: 15px; cursor: pointer;" src="../images/minus.png"></div>');
                txtlesson = txtlesson + 1;
            });  //Add more lesson in topin/unit

            $("#ctl00_ContentPlaceHolder1_ddlClass").change(function () {
                classid = $(this).val();
                if (classid == 0) {
                    $("#getsubject").hide(500);
                    $("#gettopic").hide(500);
                }
                else {
                    getsubject();
                }
            });        //Get subject according to class
            $("#ctl00_ContentPlaceHolder1_ddlsubject").change(function () {
                if ($(this).val() != 0) {
                    $("#gettopic").show(500);
                    subjectid = $(this).val();
                    getsyllabus();
                }
                else {
                    $("#gettopic").hide(500);
                    $("#ctl00_ContentPlaceHolder1_gvdetails").hide(500);
                }
            });     //get subject id and show submit buttons as well
            $("#ctl00_ContentPlaceHolder1_btnsubmit").click(function () {
                var isfilltopic = "";
                $('.Chup').each(function () {
                    isfilltopic = $(this).val();
                    if (isfilltopic == "") {
                        alertify.error("Please fill all Textbox of topic else remove Textbox");
                        return false;
                    }
                });
                if (branchid != 0 && classid != 0 && subjectid != 0 && isfilltopic != "") {
                    $('.Chup').each(function () {
                        topic = topic + ',' + $(this).val();
                    });
                    topic = topic.substring(1);
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "add-syllabus.aspx/addsyllabus",
                        data: "{ 'branchid':'" + branchid + "','classid':'" + classid + "','subjectid':'" + subjectid + "','topic':'" + topic + "'}",
                        dataType: "json",
                        success: function (data) {
                            alertify.success("Topic Added Successfully");
                            getsyllabus();
                            $('.Chup').each(function () {
                                $(this).val('');
                            });
                        },
                        error: function (result) {
                            alertify.error('error');
                        },
                    });
                }
                else {
                    alertify.error("Please enter correct details");
                }
                return false;
            });

            $("#newlessonclose").click(function () {
                $("#addnewlesson").hide(500);
                $('.addremovelesson').each(function () {
                    $(this).val('');
                });
                $(".removeaddedlesson").remove();
                txtlesson = 2;

            });                             //to close popup in page
            $("#ctl00_ContentPlaceHolder1_btnlectureupdate").click(function () {

                $('.addremovelesson').each(function () {
                    topiclesson = topiclesson + ',' + $(this).val();
                });
                topiclesson = topiclesson.substring(1);
                if (topiclesson != "") {
                    updatelesson();
                }
                else {
                    alertify.error("Plese Enter Lesson");
                    return false;
                }
                return false;

            }); // to update lecture in a page

        });

        function getclass() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-syllabus.aspx/getclassname",
                data: "{ 'branchid':'" + branchid + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlClass").html("");
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlClass").append($("<option></option>").val(value.id).html(value.classname));
                    });
                    $("#getclass").show(500);
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }   ///get class name retaed that centre
        function getsubject() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-syllabus.aspx/getsubject",
                data: "{ 'classid':'" + classid + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlsubject").html("");
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlsubject").append($("<option></option>").val(value.subid).html(value.subjectname));
                    });
                    $("#getsubject").show(500);
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }   //get subjcet name according to center
        function updatelesson() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-syllabus.aspx/updatesyllabus",
                data: "{ 'topicid':'" + topicid + "','topiclesson':'" + topiclesson + "'}",
                dataType: "json",
                success: function (data) {
                    getsyllabus();
                    $("#addnewlesson").hide(500);
                    alertify.success("Lesson updated Successfully");
                    $('.addremovelesson').each(function () {
                        $(this).val('');
                    });
                    $(".removeaddedlesson").remove();
                    txtlesson = 2;

                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        } //update lecture topic
        $(".addnewlesson").live("click", function () {
            $("#addnewlesson").show(500);
            topicid = $(this).parents("tr").children("td:eq(1)").find("input[type='hidden']").val();
            var name = $(this).parents("tr").children("td:eq(1)").find("span").text();

        }); //add new topic open popup and get topic id as well from here.
        $(".editlesson").live("click", function () {
            topicid = $(this).parents("tr").children("td:eq(1)").find("input[type='hidden']").val();
            updateaddedlesson();
        });//For Edit lesson which is alredy added

        function updateaddedlesson() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-syllabus.aspx/getlessonforupdate",
                data: "{ 'topicid':'" + topicid + "'}",
                dataType: "json",
                success: function (data) {
                    $("#addnewlesson").show(500);
                    var totaldata = data.d.length;
                    $.each(data.d, function (key, value) {
                        if (totaldata != 1) {
                            $("#addmorelesson").append('<div class="for_sigle_row_form removeaddedlesson"><label>Lesson ' + txtlesson + '</label><input                                                  class="addremovelesson" id="txtlesson' + txtlesson + '"type="text"><img class="removelesson"  style="width: 15px; height: 15px; cursor: pointer;"                            src="../images/minus.png"></div>');
                            $("#txtlesson" + txtlesson).val(value.classtopic);
                            txtlesson = txtlesson + 1;
                            totaldata = totaldata - 1;
                        }
                        else {
                            $("#txtlesson1").val(value.classtopic);
                        }
                    });

                },
                error: function (result) {
                    alertify.error('There is some Technical issue');
                },
            });
        }

        function getsyllabus() {
            var j = 1;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-syllabus.aspx/gettotalsyllabus",
                data: "{'subjectid':'" + subjectid + "','classid':'" + classid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_gvdetails").show(500);
                        $("[id*=gvdetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                            $("[id$=gvdetails]").append(row);
                            $(row).find('.sno').html(j);
                            $(row).find('.subtopic').html(data.d[i].sub_topic);
                            if (data.d[i].topic_lecture == "") {
                                $(row).find('.lecture').html('<a class="addnewlesson" style="cursor: pointer">Add New Lature</a>');
                            }
                            else {
                                $(row).find('.lecture').html(data.d[i].topic_lecture);
                            }
                            $(row).find("input[type=hidden][id*=hfslbid]").val(data.d[i].slbid);
                            j = j + 1;
                        }
                        $("[id*=gvdetails] tr").show();
                        $("[id*=gvdetails] tr:eq(1)").hide();
                    }
                    else {
                        //alertify.error("There not any record related this this keyword");
                        $("#ctl00_ContentPlaceHolder1_gvdetails").hide(500);
                    }
                },
                error: function (result) {
                    alert('error');
                },
            });
        }   //get alredy added syllabus in gridview in grddetails.
        $(".remove").live("click", function () {
            $(this).parent("div").remove();
        });//Remove unwnted Textbox
        $(".removelesson").live("click", function () {
            $(this).parent("div").remove();
            txtlesson = txtlesson - 1;
        }); // Remove unwanted textbox from popup
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Master settings</a></li>
            <li style="background: none;"><a class="active" href="#">Add Syllabus</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <div style="width: 50%; float: left">
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="containerHeadline">
                Add Syllabus
            </div>

            <br />
            <div class="for_sigle_row_form">
                <label>
                    Branch</label>
                <asp:DropDownList ID="DDlBranch" runat="server">
                    <asp:ListItem Value="0" Selected="True">-- Select Branch --</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" id="getclass">
                <label>Class</label>
                <asp:DropDownList ID="ddlClass" runat="server"></asp:DropDownList>
            </div>

            <div class="for_sigle_row_form" id="getsubject">
                <label>Subject</label>
                <asp:DropDownList ID="ddlsubject" runat="server"></asp:DropDownList>
            </div>
            <div id="gettopic">
                <div class="for_sigle_row_form">
                    <label>Unit/Topic</label>
                    <input id="txttopic1" type="text" class="Chup" />
                    <img src="../images/add.png" alt="" title="Add More" id="addmore" style="width: 15px; height: 15px; cursor: pointer;" />
                </div>
                <div id="addmorediv"></div>
                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="button1" />
                    <asp:Button ID="btnclear" runat="server" Text="Clear" CssClass="button2" />
                </div>
            </div>
        </div>
        <div style="width: 49%; float: right;">
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="containerHeadline">
                Added Syllabus
            </div>

            <asp:GridView runat="server" ID="gvdetails" EmptyDataText="There is not any Assigned Task."
                AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S.No." ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="sno" runat="server" CssClass="sno" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Topic">
                        <ItemTemplate>
                            <asp:Label ID="lblDate" runat="server" CssClass="subtopic" Text='<%# Eval("sub_topic") %>'></asp:Label>
                            <asp:HiddenField runat="server" ID="hfslbid" Value='<%#Eval("slbid") %>' />
                        </ItemTemplate>
                        <HeaderStyle Width="20%" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Lecture">
                        <ItemTemplate>
                            <asp:Label ID="lblprojname" runat="server" CssClass="lecture" Text='<%# Eval("topic_lecture") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="30%" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edit">
                        <ItemTemplate>
                            <img src="../images/edit-leave.png" class="editlesson" height="20" width="20" style="cursor: pointer" alt="" />
                        </ItemTemplate>
                        <HeaderStyle Width="10%" />
                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
            <br />
        </div>

        <div id="addnewlesson" class="showpopup" style="text-align: center; margin-left: -24px !important; display: none">
            <div style="text-align: right;">
                <a id="newlessonclose" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; font-size: 9px; margin-top: 10px !important;">Close</a>
            </div>
            <div id="addmorelesson">
                <div class="for_sigle_row_form">
                    <label>Lesson 1</label>
                    <input id="txtlesson1" type="text" class="addremovelesson" />
                    <img src="../images/add.png" alt="" title="Add More" id="addmorelecture" style="width: 15px; height: 15px; cursor: pointer;" />
                </div>
            </div>

            <div class="for_sigle_row_form">
                <label></label>
                <asp:Button ID="btnlectureupdate" runat="server" Text="Submit" CssClass="button1" />
                <asp:Button ID="btnlecturecancel" runat="server" Text="Clear" CssClass="button2" />
            </div>
        </div>
    </div>
</asp:Content>