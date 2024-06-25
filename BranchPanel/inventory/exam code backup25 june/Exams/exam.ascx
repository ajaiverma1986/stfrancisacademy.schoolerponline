<%@ Control Language="C#" AutoEventWireup="true" CodeFile="exam.ascx.cs" Inherits="BranchPanel_Exam_exam" %>
<div class="student-photo_frame">

    <div class="clear"></div>

    <%-- <div class="student-photo_frame_img">
    <asp:Image runat="server" ID="imgstu" />
    </div>--%>

    <div style="float: left; margin-top: 5px;">

        <div class="user-deatils">
            <dl>
                Who is Attending the Exam?
            </dl>
        </div>
        <div class="clear"></div>

        <div class="user-deatils1">
            </dt1>
       <span>
           <asp:Label ID="lblall1" runat="server"></asp:Label>
       </span>
        </div>
        <div class="clear"></div>

        <div>
            <dt1><b>
    Class:
     </b></dt1>
            <span>
                <asp:Label ID="lblall" runat="server"></asp:Label>
            </span>
        </div>
        <div class="clear"></div>
        <div>
            <dt1><b>
    Subject:
     </b></dt1>
            <span>
                <asp:Label ID="lblsub" runat="server"></asp:Label>
            </span>
        </div>
    </div>

    <div style="margin-left: 490px; float: left; margin-top: 5px;">

        <div>
            <b>Conducted on:</b>
            <asp:Label ID="lbldate" runat="server"></asp:Label>
        </div>
        <div class="clear"></div>
        <div>
            <dt1>
      <b>Min Marks:</b>
     </dt1>
            <span>
                <asp:Label ID="lblmin" runat="server"></asp:Label>
            </span>
            <br />
            <b>Max Marks:</b>
            <span>
                <asp:Label ID="lblmax" runat="server"></asp:Label>
            </span>
        </div>
    </div>

    <div class="clear"></div>

    <div style="margin-bottom: -3px; margin-top: 10px;">
        <asp:Button ID="btnbatch" runat="server" Text="Class" class="sgpt1 active2"
            OnClick="btnSchedules_Click" CausesValidation="false" />
        <%--<asp:Button ID="btnbatch" runat="server" Text="Batch"
            class="sgpt1 active2" ToolTip="Click here to add new Batch"
            CausesValidation="false" onclick="btnSchedules_Click" />--%>
        <asp:Button ID="btnmark" runat="server" Text="Mark Attendance" class="sgpt1 active0"
            ToolTip="Click here for mark attendance" CausesValidation="false"
            OnClick="btnStudents_Click" />

        <asp:Button ID="Marklist" runat="server" Text="Mark List" class="sgpt1 active1"
            ToolTip="Click here to view MarkList" CausesValidation="false"
            OnClick="btnTopics_Click" />
        <asp:Button ID="btnreport" runat="server" Text="Report" class="sgpt1 active3"
            ToolTip="Click here to view Report" CausesValidation="false"
            OnClick="btnTopics1_Click" />
    </div>
</div>