<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="set-marks.aspx.cs" Inherits="Teacherpanel_set_marks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
            margin-left: 100px!important;
        }

        .sth th {
            padding-left: 101px!important;
            text-align: left;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-1.11.1.min.js"></script>

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
    </script>

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
                        Set Marks
                    </h1>
                </div>
                <div class="main-content">
                    <div  id="contentPane">
        <div class="content_top">
      
        <div class="arrowt">
            <a href="ExamUtility.aspx">
                <img src="../../images/back-button.png" alt="school-logo" /></a>
        </div>
    </div>
        <br />

                <script type="text/javascript" lang="javascript">
                    Sys.Application.add_load(title);
                </script>
                <div id="divforsetmarks" style="display: block" runat="server">
                    <div class="for_sigle_row_form">
                        <label>
                            Select Exam<span style="color: #ff0066">*</span></label> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                        <asp:DropDownList ID="ddlexam" AutoPostBack="true" Width="26%"  CssClass="btn btn-secondry dropdown-toggle" runat="server" OnSelectedIndexChanged="ddlexam_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Select Class<span style="color: #ff0066">*</span></label> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                        <asp:DropDownList ID="ddlcourse" Enabled="false" Width="26%"  CssClass="btn btn-secondry dropdown-toggle" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlcourse_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="0" Text="Select Class"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Select Section<span style="color: #ff0066">*</span></label> &nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlsection" runat="server" Width="26%"  CssClass="btn btn-secondry dropdown-toggle" AutoPostBack="true" OnSelectedIndexChanged="ddlsection_SelectedIndexChanged" Enabled="false">
                            <asp:ListItem Selected="True" Value="0" Text="Select Section"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Select Subject<span style="color: #ff0066">*</span></label>  &nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlsubject" Enabled="false" Width="26%"  CssClass="btn btn-secondry dropdown-toggle" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlsubject_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="0" Text="Select Subject"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <br />
                    <asp:HiddenField ID="hfmaxmarks" runat="server" />
                    <div style="display: block" id="divforsetmarks2" runat="server">
                        <div id="divforstudentheading" runat="server" style="display: none; border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px; margin-top: 10px;"
                            class="containerHeadline">
                  <asp:Label runat="server" ID="lblheading" Text="Student Details"></asp:Label>
                        </div>
                        <br />
                        <div style=" margin-left: 2%;">

                        <asp:GridView ID="grdsetmarks"  runat="server" AutoGenerateColumns="false" GridLines="None" Width="100%" BorderWidth="0" CssClass="containerHeadline" OnRowDataBound="grdsetmarks_RowDataBound" >
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
                                        <asp:Label ID="lblname" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                                        <asp:Label ID="lblregno" runat="server" Style="display: none" Text='<%#Eval("sturegno") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Marks" HeaderStyle-Width="150">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtmarks" class="checkmaxmarks" Style="float: left; width: 200px;" runat="server" Text='<%#Eval("marks") %>'></asp:TextBox>
                                        <%--<asp:RegularExpressionValidator ID="revDigits" Style="font-weight: bold; font-size: 12pt; float: left" ControlToValidate="txtmarks" runat="server"
                                            ErrorMessage="*" Display="Dynamic" ValidationExpression="[0-9]*\.?[0-9]*"></asp:RegularExpressionValidator>--%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Mark Absent" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="IsAbsent" runat="server" Value='<%#Eval("IsAbsent") %>'/>
                                        <asp:CheckBox ID="chkstatus" Style="margin-left: 100px!important; padding: 10px!important" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head sth" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                        </asp:GridView>
                            </div>
                        <asp:Button ID="btnsubmit" Style="display: none; margin: 10px 0px 0px 10px" runat="server" Text="Submit" CssClass="button_save" OnClick="btnsubmit_Click" />
                    </div>
                </div>

                <br />
                <div id="divfortotal" style="display: none" runat="server">

                    <div id="divforexamname" runat="server" class="for_sigle_row_form">
                        <label>
                            Select Exam<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlforexamname" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlforexamname_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div id="divforclassname" runat="server" class="for_sigle_row_form">
                        <label>
                            Select Class<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlforclassame" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlforclassame_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="0" Text="Select Class"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div style="display:none; border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                        class="containerHeadline">
                        <asp:Label runat="server" ID="Label2" Text="Marks Details for Selected Class"></asp:Label>
                    </div>
                    <br />
                    <asp:GridView ID="gridforshowmarks" runat="server" Visible="false" GridLines="None" AutoGenerateColumns="false" Width="100%" BorderWidth="0" CssClass="containerHeadline" OnRowDataBound="OnRowDataBound" OnRowCommand="gridforshowmarks_RowCommand2" >
                        <Columns>
                            <asp:TemplateField HeaderText="S.No" HeaderStyle-Width="70px">
                                <ItemTemplate>
                                    <asp:Label ID="lblsno" runat="server" Text='<%# Container.DataItemIndex + 1 %>'>></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="View Result" HeaderStyle-Width="125px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btncancel" runat="server" Style="" CommandName="View" CommandArgument='<%# Eval("sturegno") %>' Text="View" />
                                    <%--<asp:Label ID="lblsno" runat="server" Text='<%# Container.DataItemIndex + 1 %>'>></asp:Label>--%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <%--<asp:GridView ID="gridforshowmarks" runat="server" GridLines="None" AutoGenerateColumns="false" Width="100%" BorderWidth="0" CssClass="containerHeadline" OnRowCommand="gridforshowmarks_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No" HeaderStyle-Width="70px">
                                <ItemTemplate>
                                    <asp:Label ID="lblsno" runat="server" Text='<%#Eval("rownumber") %>'>></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Roll No." HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblstudroll" runat="server" Text='<%#Eval("sturegno") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Name" HeaderStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:Label ID="lblsname" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Hindi" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblhindi" runat="server" Text='<%#Eval("Hindi") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="English" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblEnglish" runat="server" Text='<%#Eval("English") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Math" HeaderStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Label ID="lblmath" runat="server" Text='<%#Eval("Maths") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Science">
                                <ItemTemplate>
                                    <asp:Label ID="lblScience" runat="server" Text='<%#Eval("Science") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="G.K." HeaderStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Label ID="lblgk" runat="server" Text='<%#Eval("G_K") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Social Science" HeaderStyle-Width="180px">
                                <ItemTemplate>
                                    <asp:Label ID="lblSocialScience" runat="server" Text='<%#Eval("SocialScience") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Chem" HeaderStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Label ID="lblchemistry" runat="server" Text='<%#Eval("chemistry") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Phy" HeaderStyle-Width="60px">
                                <ItemTemplate>
                                    <asp:Label ID="lblPhysics" runat="server" Text='<%#Eval("Physics") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="History" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblHistory" runat="server" Text='<%#Eval("History") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Total" HeaderStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Label ID="lbltotal" runat="server" Text='<%#Eval("Total") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblexmstatus" runat="server" Text='<%#Eval("Examstatus") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="" HeaderStyle-Width="">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnshow" runat="server" Text="Show" CommandArgument='<%#Eval("sturegno") %>' CommandName="Show"></asp:LinkButton>
                                    <asp:Label ID="lbleid" runat="server" Style="display: none" Text='<%#Eval("examid") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>--%>
                    <asp:Button ID="btncancel" runat="server" CssClass="button2" Style="margin: 10px 0px 10px 10px" Text="Cancel" />
                </div>


    </div>
                </div>
                
                </div>
            </div>
         </div>
</asp:Content>