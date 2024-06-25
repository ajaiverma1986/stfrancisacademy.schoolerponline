<%@ Page Language="C#" Inherits="CuteEditor.EditorUtilityPage" %>

<script runat="server">
    string GetDialogQueryString;
    override protected void OnInit(EventArgs args)
    {
        if (Context.Request.QueryString["Dialog"] == "Standard")
        {
            if (Context.Request.QueryString["IsFrame"] == null)
            {
                string FrameSrc = "colorpicker_basic.aspx?IsFrame=1&" + Request.ServerVariables["QUERY_STRING"];
                CuteEditor.CEU.WriteDialogOuterFrame(Context, "[[MoreColors]]", FrameSrc);
                Context.Response.End();
            }
        }
        string s = "";
        if (Context.Request.QueryString["Dialog"] == "Standard")
            s = "&Dialog=Standard";

        GetDialogQueryString = "Theme=" + Context.Request.QueryString["Theme"] + s;
        base.OnInit(args);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Page-Enter" content="blendTrans(Duration=0.1)" />
    <meta http-equiv="Page-Exit" content="blendTrans(Duration=0.1)" />
    <script type="text/javascript" src="Load.ashx?type=dialogscript&verfix=1006&file=DialogHead.js"></script>
    <script type="text/javascript" src="Load.ashx?type=dialogscript&verfix=1006&file=Dialog_ColorPicker.js"></script>
    <link href='Load.ashx?type=themecss&file=dialog.css&theme=[[_Theme_]]' type="text/css"
        rel="stylesheet" />
    <style type="text/css">
        .colorcell {
            width: 16px;
            height: 17px;
            cursor: hand;
        }

        .colordiv, .customdiv {
            border: solid 1px #808080;
            width: 16px;
            height: 17px;
            font-size: 1px;
        }

        #ajaxdiv {
            padding: 10px;
            margin: 0;
            text-align: center;
            background: #eeeeee;
        }
    </style>
    <title>[[NamedColors]]</title>
    <script>

        var OxO6f87 = ["Green", "#008000", "Lime", "#00FF00", "Teal", "#008080", "Aqua", "#00FFFF", "Navy", "#000080", "Blue", "#0000FF", "Purple", "#800080", "Fuchsia", "#FF00FF", "Maroon", "#800000", "Red", "#FF0000", "Olive", "#808000", "Yellow", "#FFFF00", "White", "#FFFFFF", "Silver", "#C0C0C0", "Gray", "#808080", "Black", "#000000", "DarkOliveGreen", "#556B2F", "DarkGreen", "#006400", "DarkSlateGray", "#2F4F4F", "SlateGray", "#708090", "DarkBlue", "#00008B", "MidnightBlue", "#191970", "Indigo", "#4B0082", "DarkMagenta", "#8B008B", "Brown", "#A52A2A", "DarkRed", "#8B0000", "Sienna", "#A0522D", "SaddleBrown", "#8B4513", "DarkGoldenrod", "#B8860B", "Beige", "#F5F5DC", "HoneyDew", "#F0FFF0", "DimGray", "#696969", "OliveDrab", "#6B8E23", "ForestGreen", "#228B22", "DarkCyan", "#008B8B", "LightSlateGray", "#778899", "MediumBlue", "#0000CD", "DarkSlateBlue", "#483D8B", "DarkViolet", "#9400D3", "MediumVioletRed", "#C71585", "IndianRed", "#CD5C5C", "Firebrick", "#B22222", "Chocolate", "#D2691E", "Peru", "#CD853F", "Goldenrod", "#DAA520", "LightGoldenrodYellow", "#FAFAD2", "MintCream", "#F5FFFA", "DarkGray", "#A9A9A9", "YellowGreen", "#9ACD32", "SeaGreen", "#2E8B57", "CadetBlue", "#5F9EA0", "SteelBlue", "#4682B4", "RoyalBlue", "#4169E1", "BlueViolet", "#8A2BE2", "DarkOrchid", "#9932CC", "DeepPink", "#FF1493", "RosyBrown", "#BC8F8F", "Crimson", "#DC143C", "DarkOrange", "#FF8C00", "BurlyWood", "#DEB887", "DarkKhaki", "#BDB76B", "LightYellow", "#FFFFE0", "Azure", "#F0FFFF", "LightGray", "#D3D3D3", "LawnGreen", "#7CFC00", "MediumSeaGreen", "#3CB371", "LightSeaGreen", "#20B2AA", "DeepSkyBlue", "#00BFFF", "DodgerBlue", "#1E90FF", "SlateBlue", "#6A5ACD", "MediumOrchid", "#BA55D3", "PaleVioletRed", "#DB7093", "Salmon", "#FA8072", "OrangeRed", "#FF4500", "SandyBrown", "#F4A460", "Tan", "#D2B48C", "Gold", "#FFD700", "Ivory", "#FFFFF0", "GhostWhite", "#F8F8FF", "Gainsboro", "#DCDCDC", "Chartreuse", "#7FFF00", "LimeGreen", "#32CD32", "MediumAquamarine", "#66CDAA", "DarkTurquoise", "#00CED1", "CornflowerBlue", "#6495ED", "MediumSlateBlue", "#7B68EE", "Orchid", "#DA70D6", "HotPink", "#FF69B4", "LightCoral", "#F08080", "Tomato", "#FF6347", "Orange", "#FFA500", "Bisque", "#FFE4C4", "Khaki", "#F0E68C", "Cornsilk", "#FFF8DC", "Linen", "#FAF0E6", "WhiteSmoke", "#F5F5F5", "GreenYellow", "#ADFF2F", "DarkSeaGreen", "#8FBC8B", "Turquoise", "#40E0D0", "MediumTurquoise", "#48D1CC", "SkyBlue", "#87CEEB", "MediumPurple", "#9370DB", "Violet", "#EE82EE", "LightPink", "#FFB6C1", "DarkSalmon", "#E9967A", "Coral", "#FF7F50", "NavajoWhite", "#FFDEAD", "BlanchedAlmond", "#FFEBCD", "PaleGoldenrod", "#EEE8AA", "Oldlace", "#FDF5E6", "Seashell", "#FFF5EE", "PaleGreen", "#98FB98", "SpringGreen", "#00FF7F", "Aquamarine", "#7FFFD4", "PowderBlue", "#B0E0E6", "LightSkyBlue", "#87CEFA", "LightSteelBlue", "#B0C4DE", "Plum", "#DDA0DD", "Pink", "#FFC0CB", "LightSalmon", "#FFA07A", "Wheat", "#F5DEB3", "Moccasin", "#FFE4B5", "AntiqueWhite", "#FAEBD7", "LemonChiffon", "#FFFACD", "FloralWhite", "#FFFAF0", "Snow", "#FFFAFA", "AliceBlue", "#F0F8FF", "LightGreen", "#90EE90", "MediumSpringGreen", "#00FA9A", "PaleTurquoise", "#AFEEEE", "LightCyan", "#E0FFFF", "LightBlue", "#ADD8E6", "Lavender", "#E6E6FA", "Thistle", "#D8BFD8", "MistyRose", "#FFE4E1", "Peachpuff", "#FFDAB9", "PapayaWhip", "#FFEFD5"]; var colorlist = [{ n: OxO6f87[0], h: OxO6f87[1] }, { n: OxO6f87[2], h: OxO6f87[3] }, { n: OxO6f87[4], h: OxO6f87[5] }, { n: OxO6f87[6], h: OxO6f87[7] }, { n: OxO6f87[8], h: OxO6f87[9] }, { n: OxO6f87[10], h: OxO6f87[11] }, { n: OxO6f87[12], h: OxO6f87[13] }, { n: OxO6f87[14], h: OxO6f87[15] }, { n: OxO6f87[16], h: OxO6f87[17] }, { n: OxO6f87[18], h: OxO6f87[19] }, { n: OxO6f87[20], h: OxO6f87[21] }, { n: OxO6f87[22], h: OxO6f87[23] }, { n: OxO6f87[24], h: OxO6f87[25] }, { n: OxO6f87[26], h: OxO6f87[27] }, { n: OxO6f87[28], h: OxO6f87[29] }, { n: OxO6f87[30], h: OxO6f87[31] }]; var colormore = [{ n: OxO6f87[32], h: OxO6f87[33] }, { n: OxO6f87[34], h: OxO6f87[35] }, { n: OxO6f87[36], h: OxO6f87[37] }, { n: OxO6f87[38], h: OxO6f87[39] }, { n: OxO6f87[40], h: OxO6f87[41] }, { n: OxO6f87[42], h: OxO6f87[43] }, { n: OxO6f87[44], h: OxO6f87[45] }, { n: OxO6f87[46], h: OxO6f87[47] }, { n: OxO6f87[48], h: OxO6f87[49] }, { n: OxO6f87[50], h: OxO6f87[51] }, { n: OxO6f87[52], h: OxO6f87[53] }, { n: OxO6f87[54], h: OxO6f87[55] }, { n: OxO6f87[56], h: OxO6f87[57] }, { n: OxO6f87[58], h: OxO6f87[59] }, { n: OxO6f87[60], h: OxO6f87[61] }, { n: OxO6f87[62], h: OxO6f87[63] }, { n: OxO6f87[64], h: OxO6f87[65] }, { n: OxO6f87[66], h: OxO6f87[67] }, { n: OxO6f87[68], h: OxO6f87[69] }, { n: OxO6f87[70], h: OxO6f87[71] }, { n: OxO6f87[72], h: OxO6f87[73] }, { n: OxO6f87[74], h: OxO6f87[75] }, { n: OxO6f87[76], h: OxO6f87[77] }, { n: OxO6f87[78], h: OxO6f87[79] }, { n: OxO6f87[80], h: OxO6f87[81] }, { n: OxO6f87[82], h: OxO6f87[83] }, { n: OxO6f87[84], h: OxO6f87[85] }, { n: OxO6f87[86], h: OxO6f87[87] }, { n: OxO6f87[88], h: OxO6f87[89] }, { n: OxO6f87[90], h: OxO6f87[91] }, { n: OxO6f87[92], h: OxO6f87[93] }, { n: OxO6f87[94], h: OxO6f87[95] }, { n: OxO6f87[96], h: OxO6f87[97] }, { n: OxO6f87[98], h: OxO6f87[99] }, { n: OxO6f87[100], h: OxO6f87[101] }, { n: OxO6f87[102], h: OxO6f87[103] }, { n: OxO6f87[104], h: OxO6f87[105] }, { n: OxO6f87[106], h: OxO6f87[107] }, { n: OxO6f87[108], h: OxO6f87[109] }, { n: OxO6f87[110], h: OxO6f87[111] }, { n: OxO6f87[112], h: OxO6f87[113] }, { n: OxO6f87[114], h: OxO6f87[115] }, { n: OxO6f87[116], h: OxO6f87[117] }, { n: OxO6f87[118], h: OxO6f87[119] }, { n: OxO6f87[120], h: OxO6f87[121] }, { n: OxO6f87[122], h: OxO6f87[123] }, { n: OxO6f87[124], h: OxO6f87[125] }, { n: OxO6f87[126], h: OxO6f87[127] }, { n: OxO6f87[128], h: OxO6f87[129] }, { n: OxO6f87[130], h: OxO6f87[131] }, { n: OxO6f87[132], h: OxO6f87[133] }, { n: OxO6f87[134], h: OxO6f87[135] }, { n: OxO6f87[136], h: OxO6f87[137] }, { n: OxO6f87[138], h: OxO6f87[139] }, { n: OxO6f87[140], h: OxO6f87[141] }, { n: OxO6f87[142], h: OxO6f87[143] }, { n: OxO6f87[144], h: OxO6f87[145] }, { n: OxO6f87[146], h: OxO6f87[147] }, { n: OxO6f87[148], h: OxO6f87[149] }, { n: OxO6f87[150], h: OxO6f87[151] }, { n: OxO6f87[152], h: OxO6f87[153] }, { n: OxO6f87[154], h: OxO6f87[155] }, { n: OxO6f87[156], h: OxO6f87[157] }, { n: OxO6f87[158], h: OxO6f87[159] }, { n: OxO6f87[160], h: OxO6f87[161] }, { n: OxO6f87[162], h: OxO6f87[163] }, { n: OxO6f87[164], h: OxO6f87[165] }, { n: OxO6f87[166], h: OxO6f87[167] }, { n: OxO6f87[168], h: OxO6f87[169] }, { n: OxO6f87[170], h: OxO6f87[171] }, { n: OxO6f87[172], h: OxO6f87[173] }, { n: OxO6f87[174], h: OxO6f87[175] }, { n: OxO6f87[176], h: OxO6f87[177] }, { n: OxO6f87[178], h: OxO6f87[179] }, { n: OxO6f87[180], h: OxO6f87[181] }, { n: OxO6f87[182], h: OxO6f87[183] }, { n: OxO6f87[184], h: OxO6f87[185] }, { n: OxO6f87[186], h: OxO6f87[187] }, { n: OxO6f87[188], h: OxO6f87[189] }, { n: OxO6f87[190], h: OxO6f87[191] }, { n: OxO6f87[192], h: OxO6f87[193] }, { n: OxO6f87[194], h: OxO6f87[195] }, { n: OxO6f87[196], h: OxO6f87[197] }, { n: OxO6f87[198], h: OxO6f87[199] }, { n: OxO6f87[200], h: OxO6f87[201] }, { n: OxO6f87[202], h: OxO6f87[203] }, { n: OxO6f87[204], h: OxO6f87[205] }, { n: OxO6f87[206], h: OxO6f87[207] }, { n: OxO6f87[208], h: OxO6f87[209] }, { n: OxO6f87[210], h: OxO6f87[211] }, { n: OxO6f87[212], h: OxO6f87[213] }, { n: OxO6f87[214], h: OxO6f87[215] }, { n: OxO6f87[216], h: OxO6f87[217] }, { n: OxO6f87[218], h: OxO6f87[219] }, { n: OxO6f87[220], h: OxO6f87[221] }, { n: OxO6f87[156], h: OxO6f87[157] }, { n: OxO6f87[222], h: OxO6f87[223] }, { n: OxO6f87[224], h: OxO6f87[225] }, { n: OxO6f87[226], h: OxO6f87[227] }, { n: OxO6f87[228], h: OxO6f87[229] }, { n: OxO6f87[230], h: OxO6f87[231] }, { n: OxO6f87[232], h: OxO6f87[233] }, { n: OxO6f87[234], h: OxO6f87[235] }, { n: OxO6f87[236], h: OxO6f87[237] }, { n: OxO6f87[238], h: OxO6f87[239] }, { n: OxO6f87[240], h: OxO6f87[241] }, { n: OxO6f87[242], h: OxO6f87[243] }, { n: OxO6f87[244], h: OxO6f87[245] }, { n: OxO6f87[246], h: OxO6f87[247] }, { n: OxO6f87[248], h: OxO6f87[249] }, { n: OxO6f87[250], h: OxO6f87[251] }, { n: OxO6f87[252], h: OxO6f87[253] }, { n: OxO6f87[254], h: OxO6f87[255] }, { n: OxO6f87[256], h: OxO6f87[257] }, { n: OxO6f87[258], h: OxO6f87[259] }, { n: OxO6f87[260], h: OxO6f87[261] }, { n: OxO6f87[262], h: OxO6f87[263] }, { n: OxO6f87[264], h: OxO6f87[265] }, { n: OxO6f87[266], h: OxO6f87[267] }, { n: OxO6f87[268], h: OxO6f87[269] }, { n: OxO6f87[270], h: OxO6f87[271] }, { n: OxO6f87[272], h: OxO6f87[273] }];
    </script>
</head>
<body>
    <div id="ajaxdiv">
        <div class="tab-pane-control tab-pane" id="tabPane1">
            <div class="tab-row">
                <h2 class="tab">
                    <a tabindex="-1" href='colorpicker.aspx?<%=GetDialogQueryString%>'>
                        <span style="white-space: nowrap;">[[WebPalette]]
                        </span>
                    </a>
                </h2>
                <h2 class="tab selected">
                    <a tabindex="-1" href='colorpicker_basic.aspx?<%=GetDialogQueryString%>'>
                        <span style="white-space: nowrap;">[[NamedColors]]
                        </span>
                    </a>
                </h2>
                <h2 class="tab">
                    <a tabindex="-1" href='colorpicker_more.aspx?<%=GetDialogQueryString%>'>
                        <span style="white-space: nowrap;">[[CustomColor]]
                        </span>
                    </a>
                </h2>
            </div>
            <div class="tab-page">
                <table class="colortable" align="center">
                    <tr>
                        <td colspan="16" height="16">
                            <p align="left">
                                Basic:
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <script>
                            var OxO2236 = ["length", "\x3Ctd class=\x27colorcell\x27\x3E\x3Cdiv class=\x27colordiv\x27 style=\x27background-color:", "\x27 title=\x27", " ", "\x27 cname=\x27", "\x27 cvalue=\x27", "\x27\x3E\x3C/div\x3E\x3C/td\x3E", ""]; var arr = []; for (var i = 0; i < colorlist[OxO2236[0]]; i++) { arr.push(OxO2236[1]); arr.push(colorlist[i].n); arr.push(OxO2236[2]); arr.push(colorlist[i].n); arr.push(OxO2236[3]); arr.push(colorlist[i].h); arr.push(OxO2236[4]); arr.push(colorlist[i].n); arr.push(OxO2236[5]); arr.push(colorlist[i].h); arr.push(OxO2236[6]); }; document.write(arr.join(OxO2236[7]));
                        </script>
                    </tr>
                    <tr>
                        <td colspan="16" height="12">
                            <p align="left"></p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="16">
                            <p align="left">
                                Additional:
                            </p>
                        </td>
                    </tr>
                    <script>
                        var OxO17fa = ["length", "\x3Ctr\x3E", "\x3Ctd class=\x27colorcell\x27\x3E\x3Cdiv class=\x27colordiv\x27 style=\x27background-color:", "\x27 title=\x27", " ", "\x27 cname=\x27", "\x27 cvalue=\x27", "\x27\x3E\x3C/div\x3E\x3C/td\x3E", "\x3C/tr\x3E", ""]; var arr = []; for (var i = 0; i < colormore[OxO17fa[0]]; i++) { if (i % 16 == 0) { arr.push(OxO17fa[1]); }; arr.push(OxO17fa[2]); arr.push(colormore[i].n); arr.push(OxO17fa[3]); arr.push(colormore[i].n); arr.push(OxO17fa[4]); arr.push(colormore[i].h); arr.push(OxO17fa[5]); arr.push(colormore[i].n); arr.push(OxO17fa[6]); arr.push(colormore[i].h); arr.push(OxO17fa[7]); if (i % 16 == 15) { arr.push(OxO17fa[8]); }; }; if (colormore % 16 > 0) { arr.push(OxO17fa[8]); }; document.write(arr.join(OxO17fa[9]));
                    </script>
                    <tr>
                        <td colspan="16" height="8"></td>
                    </tr>
                    <tr>
                        <td colspan="16" height="12">
                            <input checked id="CheckboxColorNames" style="width: 16px; height: 20px" type="checkbox">
                            <span style="width: 118px;">Use color names</span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="16" height="12"></td>
                    </tr>
                    <tr>
                        <td colspan="16" valign="middle" height="24">
                            <span style="height: 24px; width: 50px; vertical-align: middle;">Color : </span>&nbsp;
							<input type="text" id="divpreview" size="7" maxlength="7" style="width: 180px; height: 24px; border: #a0a0a0 1px solid; Padding: 4;" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="container-bottom">
            <input type="button" id="buttonok" value="[[OK]]" class="formbutton" style="width: 70px" onclick="do_insert();" />
            &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" id="buttoncancel" value="[[Cancel]]" class="formbutton" style="width: 70px" onclick="do_Close();" />
        </div>
    </div>
</body>
</html>