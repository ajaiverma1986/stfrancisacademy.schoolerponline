<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddPublisher.aspx.cs" Inherits="HO_AddPublisher" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_pane_cont input_content branch-div-tbl" id="Div1" style="border-bottom: medium none; border-top: medium none;">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
            <h2>Publisher list</h2>
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="containerHeadlinenew">
                <asp:Button runat="server" ID="ButtonaddPublisher" Text="Add Publisher" CssClass="button_save" Style="float: right; height: 25px; margin-right: 12px; margin-top: 3px; padding: 0 5px 1px;" ToolTip="Click here to Add Publisher." />
            </div>
        </div>
        <div class="clear" ></div>
        <div id="divadd" style="display: none">
            <div class="for_sigle_row_form" style="display: none">
                <label>Pub ID<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtFiName" runat="server" Enabled="false"></asp:TextBox>&nbsp
            </div>

            <div class="for_sigle_row_form">
                <label>Name<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtname" runat="server" placeholder="Enter The Publisher Name" onkeypress="return lettersOnly(event)" MaxLength="35"></asp:TextBox>&nbsp;
            </div>

            <div class="for_sigle_row_form">
                <label>Company&nbsp; Name<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtCname" runat="server" placeholder="Enter The Company Name"></asp:TextBox>&nbsp
            </div>
            <div class="for_sigle_row_form">
                <label>Address<span style="color: #ff0066"></span></label>
                <asp:TextBox ID="txtMFname" runat="server" TextMode="MultiLine" Height="36px" placeholder="Enter The Address"></asp:TextBox>&nbsp
            </div>

            <div class="for_sigle_row_form">
                <label>City<span style="color: Red"></span></label>
                <asp:TextBox ID="txtcity" runat="server" Placeholder="Enter The City"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>State<span style="color: Red"></span></label>
                <asp:TextBox ID="txtstate" runat="server" Placeholder="Enter The State"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>Pin/Zip Code<span style="color: Red"></span></label>
                <asp:TextBox ID="txtpostalcode" runat="server" onkeypress="return isNumberKey(event)" Placeholder="Enter The Pincode" MaxLength="6"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>Phone No<span style="color: Red"></span></label>
                <asp:TextBox ID="txtphone" runat="server" onkeypress="return isNumberKey(event)" Placeholder="Enter The Mobile No."></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>Email-Id<span style="color: Red"></span></label>
                <asp:TextBox ID="txtmail" runat="server" Placeholder="Enter The Email ID"></asp:TextBox>
            </div>
        <%--    <div class="for_sigle_row_form">
                <label>Date1<span style="color: Red"></span></label>
                <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
            </div>--%>
            <div class="for_sigle_row_form">
                <label>Comments<span style="color: Red"></span></label>
                <asp:TextBox ID="txtcomment" runat="server" Placeholder="Enter The Commments"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>Website<span style="color: Red"></span></label>
                <asp:TextBox ID="txtweb" runat="server" placeholder="Enter The Website"></asp:TextBox>&nbsp;
            </div>

            <div class="for_sigle_row_form">
                <label style="padding-top: 0px;">Active<span style="color: Red"></span></label>
                <asp:CheckBox ID="checkactive" runat="server" />
            </div>

            <div class="for_sigle_row_form">
                <label><span style="color: Red"></span></label>
                <asp:Button ID="btnsubmit" runat="server" Text="Save" CssClass="button_save" />
                <asp:Button ID="btncancel" runat="server" Text="Back" CssClass="button2 inputinstitute" />

            </div>
        </div>
        <div id="Publisherlist" class="for_sigle_row_form">
               <div style="float: left; width: 100%;" id="searchdiv" class="for_sigle_row_form">
            <asp:TextBox ID="Txtpublishername" runat="server" style="height:23px;width:200px;" placeholder="Enter Publisher Name"></asp:TextBox>
           <img src="../images/clearsearch.png" id="btnclearalld" style="cursor: pointer" width="25" title="Clear All Search" alt="No Image" />
        </div>
            <table id="Tablepublisherlist" class="stm" style="width: 100%;">
                <tr class="stm_head">
                    <th scope="col" style="width: 10px">S.No.</th>
                    <th scope="col" style="width: 95px">Publisher Id</th>
                    <th scope="col" style="width: 40px">Publisher Name</th>
                     <th scope="col" style="width: 40px">Company Name Name</th>
                     <th scope="col" style="width: 40px">Telephone No.</th>
                     <th scope="col" style="width: 40px">Email ID</th>
                    <th scope="col" style="width: 40px">Status</th>
                    <th scope="col" style="width: 30px">Edit</th>
                </tr>
            </table>
        </div>
          <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        var Publishername = "", Company = ""; Address = "", City = "", State = "", Postal = "", Telephone = "", Email = "", Comments = "", Website = "", Active = "", publisherid = "";
        var publishenamesearch = "";
        Bindpublisherlist();
        //********************************************************progressbar*****************************************
        function call_progressbar(progtype) {

            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
        //**********************************************noalphabet*********************************
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            else
                return true;
        }
        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
          ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
          (charCode < 97 || charCode > 122)) {
                alertify.error("Please Enter Character Only.");
                return false;
            }
            else
                return true;
        };
        $("#ctl00_ContentPlaceHolder1_txtmail").blur(function () {
            var emailid = $(this).val();
            if (emailid != '') {
                var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
                if (!reg.test(emailid)) {
                    alertify.error('Please Enter Valid Email-Id ( ie: abcd@gmail.com).');
                     return false;
                    }
                }
              });
        //*******************************************************submit publisher button*****************************************

        $("#ctl00_ContentPlaceHolder1_btnsubmit").click(function () {

            if ($('#ctl00_ContentPlaceHolder1_txtname').val() == "") {
                alertify.error('Enter The Publisher Name');
                $('#ctl00_ContentPlaceHolder1_txtname').focus();
                return false;
            }
            if ($('#ctl00_ContentPlaceHolder1_txtCname').val() == "") {
                alertify.error('Enter The Company Name');
                $('#ctl00_ContentPlaceHolder1_txtCname').focus();
                return false;
            }
            else {
                if ($(this).val() != "Update") {

                    insertdata();
                    return false;
                }
                else {

                    updatedata();
                    return false;
                }

            }

        });

        //****************************************************Back to list*********************************************************
     
        $("#ctl00_ContentPlaceHolder1_btncancel").click(function () {
            $('#divadd').hide(500);
            $('#Publisherlist').show(500);
            $('#ctl00_ContentPlaceHolder1_ButtonaddPublisher').show(500);
             $('#ctl00_ContentPlaceHolder1_txtname').val('');
                $('#ctl00_ContentPlaceHolder1_txtCname').val('');
                $('#ctl00_ContentPlaceHolder1_txtMFname').val('');
                $('#ctl00_ContentPlaceHolder1_txtcity').val('');
                $('#ctl00_ContentPlaceHolder1_txtstate').val('');
                $('#ctl00_ContentPlaceHolder1_txtpostalcode').val('');
                $('#ctl00_ContentPlaceHolder1_txtphone').val('');
                $('#ctl00_ContentPlaceHolder1_txtmail').val('');
                $('#ctl00_ContentPlaceHolder1_txtcomment').val('');
                $('#ctl00_ContentPlaceHolder1_txtweb').val('');
                $('#ctl00_ContentPlaceHolder1_btnsubmit').val("Save");
                $('#ctl00_ContentPlaceHolder1_checkactive').prop("checked", false);
            return false;
        });

        //****************************************************Addpublisher*********************************************************
        $("#ctl00_ContentPlaceHolder1_ButtonaddPublisher").click(function () {
           $('#divadd').show(500);
            $('#Publisherlist').hide(500);           
            return false;
         });
        //*****************************************searching****************************************************************************
        $("#ctl00_ContentPlaceHolder1_Txtpublishername").keyup(function () {
            publishenamesearch = $('#ctl00_ContentPlaceHolder1_Txtpublishername').val();
            Bindpublisherlist();
            return false;
        });
        $("#btnclearalld").click(function () {
            $('#ctl00_ContentPlaceHolder1_Txtpublishername').val('');
            publishenamesearch = "";
            Bindpublisherlist();
            return false;
        });
        //*********************************************Add Publisher*********************************************************
        function insertdata() {
            call_progressbar("start");
            Publishername = $('#ctl00_ContentPlaceHolder1_txtname').val();
            Company = $('#ctl00_ContentPlaceHolder1_txtCname').val();
            Address = $('#ctl00_ContentPlaceHolder1_txtMFname').val();
            City = $('#ctl00_ContentPlaceHolder1_txtcity').val();
            State = $('#ctl00_ContentPlaceHolder1_txtstate').val();
            Postal = $('#ctl00_ContentPlaceHolder1_txtpostalcode').val();
            Telephone = $('#ctl00_ContentPlaceHolder1_txtphone').val();
            Email = $('#ctl00_ContentPlaceHolder1_txtmail').val();
           Comments = $('#ctl00_ContentPlaceHolder1_txtcomment').val();
            Website = $('#ctl00_ContentPlaceHolder1_txtweb').val();
            Active = $("#ctl00_ContentPlaceHolder1_checkactive").is(":checked");
            if (Active == true) {
                Active = 1
            }
            else {
                Active = 0
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddPublisher.aspx/savePublisherdata",
                data: "{'Publishername':'" + Publishername.split("'").join("~") + "','Company':'" + Company.split("'").join("~") + "','Address':'" + Address.split("'").join("~") + "','City':'" + City.split("'").join("~") + "','State':'" + State.split("'").join("~") + "','Postal':'" + Postal.split("'").join("~") + "','Telephone':'" + Telephone.split("'").join("~") + "','Email':'" + Email.split("'").join("~") + "','Comments':'" + Comments.split("'").join("~") + "','Website':'" + Website.split("'").join("~") + "','Active':'" + Active + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Add Publisher Successfully")
                       $('#ctl00_ContentPlaceHolder1_btnsubmit').val("Save");
                        Bindpublisherlist();
                        $('#Publisherlist').show(500);
                        $('#divadd').hide(500);
                      
                    }
                    else {
                        alertify.error("Publisher Name Already Exist");
                    }
                    $('#ctl00_ContentPlaceHolder1_txtname').val('');
                    $('#ctl00_ContentPlaceHolder1_txtCname').val('');
                    $('#ctl00_ContentPlaceHolder1_txtMFname').val('');
                    $('#ctl00_ContentPlaceHolder1_txtcity').val('');
                    $('#ctl00_ContentPlaceHolder1_txtstate').val('');
                    $('#ctl00_ContentPlaceHolder1_txtpostalcode').val('');
                    $('#ctl00_ContentPlaceHolder1_txtphone').val('');
                    $('#ctl00_ContentPlaceHolder1_txtmail').val('');
                    $('#ctl00_ContentPlaceHolder1_txtcomment').val('');
                    $('#ctl00_ContentPlaceHolder1_txtweb').val('');
                    call_progressbar("end");
                    return false;
                },
                error: function (data) {
                    call_progressbar("end");
                }
            });
            return false;
        }

        //**********************************************Publisherlist******************************************************************
        function Bindpublisherlist() {
            call_progressbar('start')
            $('#Tablepublisherlist tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddPublisher.aspx/fillpublisherlist",
                data: "{'publishenamesearch':'" + publishenamesearch.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                cssclass = 'stm_light';
                            else
                                cssclass = 'stm_dark';
                            trforappend = '<tr class='+ cssclass +'><td>' + (i + 1) + '</td>' +
                                       '<td>' + data.d[i].Publisherid + '</td>' +
                                       '<td>' + data.d[i].PublisherName + '</td>' +
                                       '<td>' + data.d[i].CompanyName + '</td>' +
                                       '<td>' + data.d[i].Telephone + '</td>' +
                                       '<td>' + data.d[i].Email + '</td>' +
                                       '<td>' + data.d[i].Status + '</td>' +
                                       '<td><img class="Publisheridedit" disabled type="image" style="width:15px;" src="../images/edit.png" />' +
                                       '<input id="hfclassid" type="hidden" value="' + data.d[i].Publisherid + '"></td></tr>'
                            $('#Tablepublisherlist').append(trforappend);
                        }
                    }
                    call_progressbar('end')
                },
                error: function (result) {
                    call_progressbar('end')
                }
            });
        }
        // *******************************************************for edit publisher Detail******************************************************
        $('.Publisheridedit').live('click', function () {
            $('#divadd').show(500);
            $('#Publisherlist').hide(500);
            $('#ctl00_ContentPlaceHolder1_ButtonaddPublisher').hide(500);
             publisherid = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
            Edit(publisherid);
            return false;

        })
        //****************************************************************edit the publisher detail***************************************
        function Edit(publisherid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddPublisher.aspx/Editdetail",
                data: "{'publisherid':'" + publisherid + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_txtname').val(data.d[i].PublisherName);
                            $('#ctl00_ContentPlaceHolder1_txtCname').val(data.d[i].CompanyName);
                            $('#ctl00_ContentPlaceHolder1_txtMFname').val(data.d[i].Address);
                            $('#ctl00_ContentPlaceHolder1_txtcity').val(data.d[i].city);
                            $('#ctl00_ContentPlaceHolder1_txtstate').val(data.d[i].state);
                            $('#ctl00_ContentPlaceHolder1_txtpostalcode').val(data.d[i].pincode);
                            $('#ctl00_ContentPlaceHolder1_txtphone').val(data.d[i].phno);
                            $('#ctl00_ContentPlaceHolder1_txtmail').val(data.d[i].email);
                            $('#ctl00_ContentPlaceHolder1_txtcomment').val(data.d[i].comments);
                            $('#ctl00_ContentPlaceHolder1_txtweb').val(data.d[i].wesite);
                            $('#ctl00_ContentPlaceHolder1_btnsubmit').val("Save");
                            if (data.d[i].Status == 'Active')
                            { $('#ctl00_ContentPlaceHolder1_checkactive').prop("checked", true); }
                            else { $('#ctl00_ContentPlaceHolder1_checkactive').prop("checked", false); }
                            $('#ctl00_ContentPlaceHolder1_btnsubmit').val("Update");

                        }
                    }

                },
                error: function (data) {

                }
            });
        }
        //*******************************************update the author detail**********************************
        function updatedata() {
         var ePublishername = $('#ctl00_ContentPlaceHolder1_txtname').val();
           var eCompany = $('#ctl00_ContentPlaceHolder1_txtCname').val();
           var eAddress = $('#ctl00_ContentPlaceHolder1_txtMFname').val();
           var eCity = $('#ctl00_ContentPlaceHolder1_txtcity').val();
           var eState = $('#ctl00_ContentPlaceHolder1_txtstate').val();
           var ePostal = $('#ctl00_ContentPlaceHolder1_txtpostalcode').val();
            var eTelephone = $('#ctl00_ContentPlaceHolder1_txtphone').val();
           var eEmail = $('#ctl00_ContentPlaceHolder1_txtmail').val();
          var eComments = $('#ctl00_ContentPlaceHolder1_txtcomment').val();
           var eWebsite = $('#ctl00_ContentPlaceHolder1_txtweb').val();
            var eActive = $("#ctl00_ContentPlaceHolder1_checkactive").is(":checked");
            if (eActive == true) {
                eActive = 1
            }
            else {
                eActive = 0
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddPublisher.aspx/updatePublisher",
                data: "{'ePublishername':'" + ePublishername.split("'").join("~") + "','eCompany':'" + eCompany.split("'").join("~") + "','eAddress':'" + eAddress.split("'").join("~") + "','eCity':'" + eCity.split("'").join("~") + "','eState':'" + eState.split("'").join("~") + "','ePostal':'" + ePostal.split("'").join("~") + "','eTelephone':'" + eTelephone.split("'").join("~") + "','eEmail':'" + eEmail.split("'").join("~") + "','eComments':'" + eComments.split("'").join("~") + "','eWebsite':'" + eWebsite.split("'").join("~") + "','eActive':'" + eActive + "','publisherid':'" + publisherid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    alertify.success('Publisher updated successfully');
                    Bindpublisherlist()
                    $('#ctl00_ContentPlaceHolder1_txtname').val('');
                    $('#ctl00_ContentPlaceHolder1_txtCname').val('');
                    $('#ctl00_ContentPlaceHolder1_txtMFname').val('');
                    $('#ctl00_ContentPlaceHolder1_txtcity').val('');
                    $('#ctl00_ContentPlaceHolder1_txtstate').val('');
                    $('#ctl00_ContentPlaceHolder1_txtpostalcode').val('');
                    $('#ctl00_ContentPlaceHolder1_txtphone').val('');
                    $('#ctl00_ContentPlaceHolder1_txtmail').val('');
                    $('#ctl00_ContentPlaceHolder1_txtcomment').val('');
                    $('#ctl00_ContentPlaceHolder1_txtweb').val('');
                    $('#ctl00_ContentPlaceHolder1_btnsubmit').val("Save");
                    $('#ctl00_ContentPlaceHolder1_ButtonaddPublisher').show(500);
                    $('#Publisherlist').show(500);
                    $('#divadd').hide(500);
                    return false;
                },
                error: function (data) {
                }
            });
            return false;
        };
    </script>
</asp:Content>
