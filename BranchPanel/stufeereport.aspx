<%@ Page Title="Student Fee Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="stufeereport.aspx.cs" Inherits="BranchPanel_stufeereport" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/1.4-query.min.js" type="text/javascript"></script>
    <script src="../js/1.8-jquery-ui.min.js" type="text/javascript"></script>
    <link href="../js/1.8-themes-base-jquery-ui.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .active71 {
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
    </style>
    <style>
        .conductedlecture235 {
            font-size: 12px;
            color: #000;
            line-height: 30px;
            text-align: left;
            padding: 0px 15px;
            background: #eeefff;
            width: auto;
            margin-left: 100px;
            border-radius: 4px;
            float: left;
            border: 1px solid #b4b8ff;
        }

        .siblings td {
            border: 1px solid #DBDBDB;
            padding: 8px;
            text-align: center;
        }
    </style>
    <style>
        .conductedlecture236 {
            font-size: 12px;
            color: #000;
            line-height: 30px;
            text-align: left;
            padding: 0px 15px;
            background: #d4feff;
            width: auto;
            margin-left: 100px;
            border-radius: 4px;
            float: left;
            border: 1px solid #41e1e6;
        }
    </style>
    <script type="text/javascript">
        var brid = 0;
        function pageLoad() {
            brid = '<%= Session["BrBrid"] %>'

            $("#<%=txtMemId.ClientID %>").autocomplete({

                source: function (request, response) {

                    $.ajax({
                        url: '<%=ResolveUrl("~/TimeTable.asmx/admissionsearch") %>',
                        data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.length > 0) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[0],
                                        val: item.split('-')[1],
                                        val1: item.split('-')[2]

                                    };
                                }))
                            }
                            else {
                                response([{ label: 'No results found.', val: -1 }]);
                            }

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },

                minLength: 1
            });

        };
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Fee Management</a></li>
            <li><a>Fee Collection</a></li>
            <li style="background: none;"><a class="active">Student Fee Report
                <asp:Label ID="lblHeading" runat="server"> </asp:Label></a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <%--<div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
           </div> --%>

        <asp:UpdatePanel ID="updat111" runat="server">
            <ContentTemplate>

                <div id="upperdiv" runat="server">

                    <div id="divsearchtext" runat="server">
                        <div class="for_sigle_row_form">

                            <span style="color: Red"></span>
                            <asp:TextBox ID="txtMemId" runat="server" placeholder="Enter student ID" Style="float: left; margin-top: 10px; margin-left: -65px"></asp:TextBox>

                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button_save" OnClick="btnSubmit_Click" Style="margin-bottom: -98px; margin-left: 7px; margin-top: 10px"></asp:Button>
                        </div>
                        <br />
                        <div class="clear"></div>
                        <asp:LinkButton runat="server" ID="lnk" OnClick="lnk_Click">Click here for advance search</asp:LinkButton>

                        <div class="for_sigle_row_form" visible="false" id="stutype" runat="server" style="width: 548px; float: right; margin-top: -41px;">
                            <asp:TextBox ID="txtbookid" runat="server" placeholder="Enter student name,class,father name"></asp:TextBox>
                            &nbsp;
              <asp:Button ID="btnserach" runat="server" CssClass="button_save" Text="GO" OnClick="btnserach_Click" />
                            <asp:Button ID="Button1" runat="server" CssClass="button_cancel" Text="Cancel" OnClick="btnserach_Click1" CausesValidation="false" />
                            <asp:Label ID="dlmsg" runat="server" Style="display: none;" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                    <div>
                    </div>
                    <asp:Button ID="goforsearch" runat="server" CssClass="button_save" Text="GO back for search" OnClick="goforsearch_Click" Style="float: right; margin-top: -16px" />
                    <asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red"></asp:Label>
                    <div class="clear"></div>
                    <asp:DataList ID="dataliststudent" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" Style="float: left" OnItemDataBound="dataliststudent_ItemDataBound">
                        <ItemTemplate>
                            <div class="carda" style="padding: 8px; width: 137%;">
                                <br>
                                <div style="float: left; margin-left: 8%;">
                                    <div class="student_img" style="width: 85px; margin: 0px auto; margin-bottom: 5px; padding: 2px; border: 1px solid #ccc;">
                                        <%-- <asp:HyperLink ID="HyperLink1" runat="server"  NavigateUrl='<%#Eval("id","bookinformation.aspx?id={0}")  %>' >--%>
                                        <asp:Image runat="server" ID="imgsource" Width="85" Height="90" ImageUrl='<%# Eval("photo") %>' CssClass="imgphoto" />
                                        <%--</asp:HyperLink>--%>
                                        <br />
                                    </div>
                                </div>

                                <div style="float: left;">
                                    <div class="id_student " style="text-align: left; padding-left: 20%; padding-top: 6%; line-height: 21px;">
                                        <b>Name : </b>
                                        <%-- <asp:LinkButton ID="Label1" runat="server" Text='<%# Eval("title") %>'></asp:LinkButton>--%>
                                        <asp:Label ID="linkscatname" Text='<%# Eval("name") %>' runat="server" CssClass="stuname"></asp:Label>
                                        <asp:Label ID="lblbt2" runat="server" Text='<%# Bind("ADNO") %>' CssClass="admo" Style="display: none;"></asp:Label>
                                        <br />
                                        <b>Class :</b>
                                        <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("applyclass") %>' CssClass="apclass"></asp:Label>
                                        <br />

                                        <b>Roll No. :</b>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("ADNO") %>' CssClass="admo"></asp:Label>
                                        <br />
                                        <b>Next Due Date :</b>
                                        <asp:Label ID="lblnextmonth" runat="server"></asp:Label>

                                        <div style="display: none">
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>

                    <table cellpadding="2" id="Table4" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">
                        <tr>
                            <td align="left" style="margin-left: 10px;">
                                <br />
                                <div id="divde" runat="server">
                                    <table id="tbllde" style="width: 800px">
                                        <tr>
                                            <td valign="top" align="left">
                                                <div class="conductedlecture234 secbox" style="margin-left: 10px;">
                                                    <asp:Label runat="server" ID="lbl1" Text="Total" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="Label9" runat="server" Text="₹" Font-Bold="true" ForeColor="#B136A4"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblTotal" runat="server" Text="0" ForeColor="#B136A4" Font-Bold="true"></asp:Label>
                                                </div>
                                            </td>
                                            <td valign="top" align="left">
                                                <div class="conductedlecture235 thirdbox" style="margin-left: -161px;">
                                                    <asp:Label runat="server" ID="Label6" Text="Received" Font-Bold="true" ForeColor="#824a9e"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="Label8" runat="server" Text="₹" Font-Bold="true" ForeColor="#824a9e"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblReceived" runat="server" Text="0" ForeColor="#824a9e" Font-Bold="true"></asp:Label>
                                                </div>
                                            </td>
                                            <td valign="top" align="left">
                                                <div class="conductedlecture236 fourthbox" style="margin-left: 5px;">
                                                    <asp:Label runat="server" ID="Label2" Text="Balance" Font-Bold="true" ForeColor="#14879e"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="Label3" runat="server" Text="₹" Font-Bold="true" ForeColor="#14879e"></asp:Label>&nbsp;&nbsp;
                                        <asp:Label ID="lblremain" runat="server" Text="0" Font-Bold="true" ForeColor="#14879e"></asp:Label>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div class="clear"></div>

                    <table runat="server" visible="false" cellpadding="1" cellspacing="0" border="0" style="width: 101%; margin-top: 9px; float: left; background: #F7F7F7; border-radius: 0px; margin-left: 0px; position: relative; padding-top: 20px;" id="Table2">
                        <tr>
                            <td>

                                <asp:GridView Style="float: left; margin-left: 0px;" runat="server" ID="gridreport" ShowHeader="true" AllowPaging="false"
                                    PageSize="20" AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="stm" OnRowDataBound="gridreport_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S No.">
                                            <ItemTemplate>
                                                <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Month">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldateyy" runat="server" Text='<%# Bind("MonthName") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fee Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldatetr" runat="server" Text='<%# Bind("transtype") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Payment Mode">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldateee" runat="server" Text='<%# Bind("paymentype") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Paid Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblclasstt5" runat="server" Text='<%# Bind("payfee","{0:0.00}") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Paid Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblstudentname4" runat="server" Text='<%# Bind("trdate") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Receipt No">
                                            <ItemTemplate>
                                                <asp:Label ID="lblstudentname5" runat="server" Text='<%# Bind("receiptno") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_dark" />
                                    <AlternatingRowStyle CssClass="stm_light" />
                                    <HeaderStyle CssClass="stm_head" />
                                </asp:GridView>
                                &nbsp;
                        &nbsp;
                        <asp:Label ID="lbltotalamn" ForeColor="Red" Font-Bold="true" runat="server" Style="margin-left: 530px"></asp:Label>
                                <br />
                                <br />
                                <br />
                                <br />
                            </td>
                        </tr>
                    </table>

                    <div id="datalistdiv" runat="server">
                        <div style="border: 1px solid #ddd; width: 100%; height: 379px; margin-top: 4.5%; background: #FCFCFC; overflow: scroll; overflow-x: hidden;" class="shadow1">

                            <%-- <asp:Panel ID="Panel1" runat="server">--%>

                            <asp:DataList ID="DataList2" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" OnItemCommand="DataList2_ItemCommand">
                                <ItemTemplate>
                                    <div class="carda" style="padding: 8px; width: 137%;">
                                        <br>
                                        <div style="float: left; margin-left: 8%;">
                                            <div class="student_img" style="width: 85px; margin: 0px auto; margin-bottom: 5px; padding: 2px; border: 1px solid #ccc;">
                                                <%-- <asp:HyperLink ID="HyperLink1" runat="server"  NavigateUrl='<%#Eval("id","bookinformation.aspx?id={0}")  %>' >--%>
                                                <asp:Image runat="server" ID="imgsource" Width="85" Height="90" ImageUrl='<%# Eval("photo") %>' CssClass="imgphoto" />
                                                <%--</asp:HyperLink>--%>
                                                <br />
                                            </div>
                                        </div>

                                        <div style="float: left;">
                                            <div class="id_student " style="text-align: left; padding-left: 20%; padding-top: 6%; line-height: 21px;">
                                                <b>Name : </b>
                                                <%-- <asp:LinkButton ID="Label1" runat="server" Text='<%# Eval("title") %>'></asp:LinkButton>--%>
                                                <asp:LinkButton ID="linkscatname" CommandName="edito" Text='<%# Eval("name") %>' CommandArgument='<%# Eval("ADNO")%>' runat="server" CssClass="stuname"></asp:LinkButton>
                                                <asp:Label ID="lblbt2" runat="server" Text='<%# Bind("ADNO") %>' CssClass="admo" Style="display: none;"></asp:Label>
                                                <br />
                                                <b>Class :</b>
                                                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("applyclass") %>' CssClass="apclass"></asp:Label>
                                                <br />
                                                <b>Father Name :</b>
                                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("FatherName") %>' CssClass="fname"></asp:Label>
                                                <br />
                                                <b>Roll No. :</b>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("ADNO") %>' CssClass="admo"></asp:Label>
                                                <br />

                                                <div style="display: none">
                                                </div>
                                            </div>
                                            <div class="clear"></div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>

                            <%--  </asp:Panel>--%>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>