<%@ Page Title="Set Discount" EnableViewState="false" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="setdiscount.aspx.cs" Inherits="BranchPanel_setdiscount" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/setdiscount.js"></script>
    <script type="text/javascript">
        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
         ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
         (charCode < 97 || charCode > 122)) {
                return false;
            }
            else
                return true;
        };
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                 && (charCode <= 90))
                return false;
            return true;
        };
    </script>
    <style>
        .stm {
            border: 1px solid #dddddd;
        }

        th {
            background-color: #808080;
            color: white;
        }

        #ctl00_ContentPlaceHolder1_griddiscount tr th {
              background-color: #C7C7C7 !important;
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

        <style type="text/css" > .activeofferlist {
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

        .lblMessage {
            color: #FF5217;
            font-style: italic;
            font-size: 20px;
            font-family: sans-serif;
        }

        .t1 {
            height: 30px;
            padding-top: 5px;
            color: black;
            font-size: 14px !important;
            padding-left: 25px;
            text-align: left !important;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 13px !important;
            text-align: left !important;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 14px !important;
            padding-left: 10px;
            text-align: left !important;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 13px !important;
            text-align: left !important;
        }

        .tblHeading {
            border-bottom: 1px solid #ddd !important;
            width: 95%;
            color: #493f3f;
            font-weight: bold;
            font-size: 17px;
            vertical-align: top;
            text-align: left;
            height: 30px;
            padding-bottom: 2px;
            padding-left: 15px;
            padding-top: 4px;
        }

        .showpopup {
            opacity: 1;
            position: fixed;
            left: 10%;
            top: 2%;
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #41BFD9;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            min-height: 550px;
            height: auto!important;
            width: 85%;
            z-index: 99999999999;
            padding-bottom: 20px;
        }

            .showpopup td {
                vertical-align: top;
                color: #666666;
            }

        .showpopup2 {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 15px solid #CD3B09;
            border-radius: 25px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 40%;
            left: 32%;
            opacity: 1;
            position: fixed;
            top: 15%;
            width: 38%;
            z-index: 2147483647;
        }

        .texthover {
            border: solid 1px red !important;
        }

        #grdpay1 {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            width: 100%;
            border-collapse: collapse;
        }

            #grdpay1 td, #grdpay th {
                font-size: 1em;
                border: 1px solid #98bf21;
                padding: 3px 7px 2px 7px;
            }

            #grdpay1 th {
                font-size: 1.1em;
                text-align: left;
                padding-top: 5px;
                padding-bottom: 4px;
                background-color: #A7C942;
                color: #ffffff;
            }

            #grdpay1 tr.clsmaintr td {
                color: #000000;
                background-color: #EAF2D3;
            }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>

            <li style="background: none;"><a class="active" href="#">Set Discount</a></li>
        </ul>
    </div>
    <div class="clear"></div>

    <div class="content_pane_cont input_content" id="contentPane">
        <br />

        <div id="divstudentadno1" runat="server">
        </div>

        <div id="divMessage" class="showpopup" style="text-align: center; display: none">

            <div id="content">
                <div style="text-align: right;">
                    <a id="tdClosepopup" style="text-align: right; color: red; cursor: pointer; margin-right: 14px; margin-top: 10px !important;">Close</a>
                </div>
            </div>
        </div>
        <asp:Button ID="btndiscount" runat="server" CssClass="button_save" Text="Set Discount" />
        <asp:Button ID="btnback" runat="server" CssClass="button_save" Text="Back" Style="display: none; float: right" />
        <div id="setdiscount" runat="server" class="divsetdis">
            <div class="for_sigle_row_form">
                <label>
                    Registration No.(for reference)</label>
                <asp:TextBox ID="txtRegNo" runat="server" CssClass="checkreg"></asp:TextBox>
                <asp:HiddenField ID="hfrid" runat="server" Value='<%# Bind("rid") %>' />
                <asp:Label runat="server" ID="lblmsg" ForeColor="Chocolate" Width="150px" style="margin-left:30px !important;"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Select Financial Year<span style="color: Red">*</span></label>
                <asp:DropDownList ID="ddlfinancialyear" runat="server">
                </asp:DropDownList>
            </div>

            <div class="for_sigle_row_form">
                <label>
                    Name of Applicant<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtName" runat="server" CssClass="fname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            <asp:TextBox ID="txtmidname" runat="server" CssClass="mname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            <asp:TextBox ID="txtLName" runat="server" CssClass="lname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Father's Name<span style="color: Red">*</span></label>
                <asp:TextBox runat="server" ID="txtFname" CssClass="fname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            <asp:TextBox ID="txtmidname1" runat="server" CssClass="mname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            <asp:TextBox ID="txtlastname1" runat="server" CssClass="lname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Date of Birth<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtToDate" onkeypress="return false" runat="server"></asp:TextBox>
                <span id="lblAge"></span>
            </div>
            <div class="for_sigle_row_form" style="display: none;">
                <label>
                    Transportation:</label>
                <asp:RadioButtonList runat="server" ID="rtransportation" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                </asp:RadioButtonList>
                <asp:LinkButton ID="lnk1" runat="server" Text="Change" Style="display: none; margin-left: 436px; margin-top: -25px" CssClass="editlnk"> </asp:LinkButton>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Applying for Class<span style="color: Red">*</span></label>
                <asp:DropDownList ID="ddl_Course" runat="server">
                </asp:DropDownList>
                    <asp:Label runat="server" ID="lbclassname" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
                <asp:Label runat="server" ID="lbclmsg" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
                <asp:Label runat="server" ID="lbclssname" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
            </div>
            <div id="Container">
            </div>
            <span id="Span1" style="color: red; margin-left: 143px;"></span>
            <span id="totalfee" style="color: red; margin-left: 110px; padding-right: 40px;"></span>
            <span id="spandiscount" style="color: red; margin-left: 417px; padding-right: 190px;"></span>
            <span id="Span2" style="color: red; margin-right: -2000000px; margin-left: -57px;"></span>
            <div class="for_sigle_row_form">
                <label>
                    Discount Date<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtDate"  onkeypress="return false"  runat="server"></asp:TextBox>
                <span id="Span3"></span>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Address Line<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Mobile No.<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtmob" runat="server" MaxLength="12" onkeypress=" return noAlphabets(event)"></asp:TextBox>
                &nbsp;
            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="rqd" ControlToValidate="txtmob"
                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="Button2" runat="server" CssClass="button_save" Text="Set Discount" />
            </div>
        </div>
        <div id="discountreport" runat="server" style="display: none">
            <asp:GridView ID="griddiscount" runat="server" ShowHeader="true" AutoGenerateColumns="false"
                    GridLines="None" Width="100%" CssClass="stm" EmptyDataText="No record Found..">
                <Columns>
                    <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                        <ItemTemplate>
                            <asp:Label ID="lblsno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ref.No." ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                        <ItemTemplate>
                            <asp:Label ID="lbldiscount" runat="server" CssClass="studentid1" Text='<%# Bind("studentid") %>'>"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Discount Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="130px">
                        <ItemTemplate>
                            <asp:Label ID="lbldisdate" runat="server" Text='<%# Bind("discountdate") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                        <ItemTemplate>
                            <asp:Label ID="lblname" runat="server" Text='<%# Bind("name") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Father Name" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                        <ItemTemplate>
                            <asp:Label ID="lblfathername" runat="server" Text='<%#Bind("fathername")%>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Class" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
                        <ItemTemplate>
                            <asp:Label ID="lblapplyclass" runat="server" Text='<%#Bind("Classname") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="D.O.B" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="140px">
                        <ItemTemplate>
                            <asp:Label ID="lbldob" runat="server" Text='<%#Bind("dob")%>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actual Fee" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <asp:Label ID="lblactualfee" runat="server" Text='<%#Bind("actualfee")%>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                      <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbldis" CssClass="linkbut" runat="server" Text='<%#Bind("discountedfee")%>'>' </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Payable Fee" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                        <ItemTemplate>
                            <asp:Label ID="lblnetblnce" runat="server" Text='<%#Bind("netfee")%>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>   
                    <asp:TemplateField HeaderText="Admission" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                        <ItemTemplate>
                               <asp:ImageButton ID="lblstatus" CssClass="lnkadmisn" runat="server" Width="25px" ImageUrl='<%#Bind("statusimage")%>' AlternateText="No Image" />
							   <asp:Label ID="lblstatuslablel" CssClass="lnkadmisnlabel" runat="server" Text='<%#Bind("status")%>' style="display:none !important;"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>