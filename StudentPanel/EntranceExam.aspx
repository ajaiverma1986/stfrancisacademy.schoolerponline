<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="EntranceExam.aspx.cs" Inherits="StudentPanel_EntranceExam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .main-content {
             min-height: 0px !important; 
        }
        .examactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }

         .examactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }
          .side-bar-wrapper .side-menu > li .examactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }
        .side-bar-wrapper .side-menu > li .examactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }

        .clsstarscolored {
            color: #e65124 !important;
        }

        *, *::before, *::after {
            box-sizing: border-box;
        }

        .rating > span:hover:before,
        .rating > span:hover ~ span:before {
            content: "☆" !important;
            position: absolute;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
            font-size: 11px !important;
            font-weight: normal !important;
        }

        .for_sigle_row_form label {
            width: 20%;
            text-align: right;
            font-size: 14px;
            font-weight: 500;
            font-family: Arial;
            margin-right: 20px;
        }

        .for_sigle_row_form textarea {
            width: 33%;
            height: 80px;
            border: 1px solid #ccc;
            color: #454545;
            font-family: Arial;
            padding: 5px;
            font-size: 12px;
        }

        .for_sigle_row_form select {
            background: #fff none repeat scroll 0 0;
            border: 1px solid #ccc;
            border-radius: 0;
            box-shadow: none;
            color: #676767;
            margin-bottom: 0;
            outline: medium none;
            padding: 6px 5px;
            width: 33%;
        }

        .btnClrStars {
            background-color: #49c0f0;
            background-image: linear-gradient(to bottom, #49c0f0, #2cafe3);
            border: 1px solid #15aeec;
            color: #ffffff;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 11px;
            font-weight: bold;
            padding: 3px 9px 4px;
            text-decoration: none;
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }
        .content-wrapper .content-inner {
            -webkit-box-shadow: 0px 2px 2px 2px rgba(0, 0, 0, 0.8);
            /* box-shadow: 0px 2px 40px 2px rgba(0, 0, 0, 0.8); */
            /* border-radius: 4px; */
        }
    </style>
     

    <div class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="clearfix">
                    </div>
                    <h1>
                        <i class="fa fa-edit"></i>
                        Entrance TEst Information
                    </h1>
                </div>
            </div>
            <div class="main-content" style="width: 100%;">
                 <div class="for_sigle_row_form" runat="server" visible="true">
                    <label>
                        Exam Date :</label>
                    <asp:Label runat="server" ID="lblExamDate">Not Assigned</asp:Label>
                </div>
                <div class="clear"></div>
                 <div class="for_sigle_row_form" runat="server" visible="true">
                    <label>
                        Total Max Makrs :</label>
                    <asp:Label runat="server" ID="lblMaxMarks">Not Assigned</asp:Label>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" runat="server" visible="true">
                    <label>
                        Total Obtained Makrs :</label>
                    <asp:Label runat="server" ID="lblObtainMarks">Not Assigned</asp:Label>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" runat="server" visible="true">
                    <label>
                        Result :</label>
                    <asp:Label runat="server" ID="lblResult">Not Assigned</asp:Label>
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
    <link href="../css/stylesheet.css" rel="stylesheet" />
    <link href="../css/product-listing.css" rel="stylesheet" />
</asp:Content>

