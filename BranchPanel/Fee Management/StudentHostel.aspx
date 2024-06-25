<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="StudentHostel.aspx.cs" Inherits="BranchPanel_Fee_Management_StudentHostel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style type="text/css">
        .Admission_No {
            width:150px;
        }
         .Admission_Date {
            width:150px;
        }
    </style>
     <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
          <div class="content_pane_cont input_content branch-div-tbl" id="Div1">
        <div class="tbl-top-heading">
            <h2>All Student List for Hostel:</h2>
            <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
             <asp:Button ID="CustomExcel" runat="server" Text="Download Custom Excel file" Visible="true"
                CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float:right;" OnClick="CustomExcel_Click"
                ToolTip="Download" />
                </div>
        </div>
       <%--      <div class="for_sigle_row_form" style="margin-top:-12px !important;">
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" placeholder="From Date" Width="80px" CssClass="itemdisplaynone"  onkeypress="return false"></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" placeholder="To Date" Width="60px" CssClass="itemdisplaynone"  onkeypress="return false"></asp:TextBox>
            <asp:TextBox ID="txtname" runat="server" placeholder="Student Name" Width="60px" ></asp:TextBox>
            <asp:TextBox ID="txtAdmissionNo" runat="server" placeholder="New/Old Adm No" Width="110px"></asp:TextBox>
               <asp:TextBox ID="txtRegistrationNo" runat="server" placeholder="Registration No." Width="60px"></asp:TextBox>
            <asp:TextBox ID="txtfathername" runat="server" placeholder="Parent Name" Width="60px"  CssClass="itemdisplaynone"></asp:TextBox>
            <asp:TextBox ID="txtgaurdianmobileno" runat="server" placeholder="Parent Mobile No" CssClass="itemdisplaynone" Width="103px"></asp:TextBox>
               <asp:DropDownList ID="ddlclass" runat="server" Width="120px" Height="31px">     
            </asp:DropDownList>
             <asp:DropDownList ID="ddlSection" runat="server" Width="105px" Height="31px">     
            </asp:DropDownList>     
            <asp:DropDownList ID="ddlfyear" runat="server" Width="102px" Height="31px">     
            </asp:DropDownList>
            <asp:ImageButton ID="btnclear" style="height:25px;width:25px;margin-top:2px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
            <div class="clear"></div>
        </div>
                  </div>--%>
      <%--  <div id="studentslist" class="student-grid">
            <table style="width: 100%;border-collapse: collapse;" class="studentlistforBatche stm" cellspacing="0" cellpadding="4" border="0">
            
            </table>
             <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry Student list not found.</label>
        </div>
        </div>--%>
      
        </div>
             <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">Registration No</th>
                    <th align="center">Admission No</th>
                    <th align="center">Student Name</th>
                    <th align="center">Parent Name</th>
                    <th align="center">Hostel Name</th>
                    <th align="center">Class</th>
                    <th align="center">Section</th>
                   <%-- <th align="center">Total Amt</th>
                    <th align="center">Paid Amt</th>
                    <th align="center">Bal Amt</th>
                    <th align="center">Pay Status</th>
                    <th align="center">View Details</th>--%>
                </tr>
            </table>
         <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry No Record found.</label>
        </div>
    </div>
     <script type="text/javascript">        
         $(document).ready(function () {
             Bindstudentregistration();
         });
         function Bindstudentregistration() {           
            $('.stm tr:gt(0)').remove();
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "StudentHostel.aspx/BindGridByJs",
                data: "{'Mode':'7'}",
                dataType: "json",
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        pagecount = data.d[0].pagecount;
                        $('.lbltotalpage').html(data.d[0].pagecount);
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                        for (var i = 0; i < data.d.length; i++) {
                            trforappend = trforappend + "<tr class=" + trclass + ">" +
                                "<td><input type='hidden' value='" + data.d[i].StuRegNo + "' />" + (i + 1) + "</td>" +
                                "<td>" + data.d[i].Registration_No + " </td>" +
                                "<td>" + data.d[i].AdmissionNo + " </td>" +
                                "<td>" + data.d[i].studentFname + " " + data.d[i].studentMname + " " + data.d[i].studentLname + " </td>" +
                                "<td>" + data.d[i].fatherFname + " " + data.d[i].fatherMname + " " + data.d[i].fatherLname + " </td>" +
                                "<td>" + data.d[i].HostelName + " </td>" +
                                "<td>" + data.d[i].Classname + " </td>" +
                                "<td>" + data.d[i].Sectionname + " </td>" +
                                //"<td>" + data.d[i].TotalFee + " </td>" +
                                //"<td>" + data.d[i].PaidFee + " </td>" +
                                //"<td>" + data.d[i].BalFee + "</td>" +
                                //"<td class='name'>" + data.d[i].PayStatus + " </td>" +
                                //"<td><img src='../../images/viewquestion.png' style='border-width:0px;height:15px;width:15px;border-width:0px;' title='Click here to show detail.' class='showdiscount'></img></td>" +
                               
                                "</tr>"
                        }
                        $('.stm').append(trforappend);
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                    }
                },
                error: function (result) {
                    alertify.error("Error While Grid Is Binding");
                }
            });
        }
          </script>
      <div id="divProgressBar" class="progress"></div>
</asp:Content>

