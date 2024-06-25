<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="dept-structure.aspx.cs" Inherits="employeepanel_geneology" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Hr Managment</a></li>
            <li style="background: none;"><a class="active" href="#">Department Structure</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="clear"></div>
    <div class="content_pane_cont input_content" id="contentPane" style="min-height: 710px">
        <asp:TreeView ID="trgeneology" runat="server" ShowLines="true" ShowExpandCollapse="true"
            NodeStyle-Width="25px" CollapseImageUrl="../images/plus.png" ExpandImageUrl="../images/plus.png"
            OnTreeNodeCollapsed="trgeneology_TreeNodeCollapsed" OnTreeNodePopulate="trgeneology_TreeNodePopulate">
            <SelectedNodeStyle></SelectedNodeStyle>
            <RootNodeStyle></RootNodeStyle>
            <LeafNodeStyle CssClass="treeNode"></LeafNodeStyle>
        </asp:TreeView>
    </div>
</asp:Content>