<%@ Control Inherits="CuteEditor.EditorUtilityCtrl" Language="c#" AutoEventWireup="false" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<fieldset>
    <legend>[[EditCell]]</legend>
    <table class="normal" cellpadding="2" cellspacing="1" width="98%">
        <tr>
            <td style="white-space: nowrap; width: 100px;">[[Width]] :</td>
            <td>
                <input type="text" id="inp_width" size="14" /></td>
            <td>&nbsp;</td>
            <td style="white-space: nowrap; width: 80;">[[Height]] :</td>
            <td>
                <input type="text" id="inp_height" size="14" /></td>
        </tr>
        <tr>
            <td>[[Alignment]]:</td>
            <td>
                <select id="sel_align" style="width: 90px">
                    <option value="">[[NotSet]]</option>
                    <option value="left">[[Left]]</option>
                    <option value="center">[[Center]]</option>
                    <option value="right">[[Right]]</option>
                </select>
            </td>
            <td></td>
            <td>[[vertical]] [[Alignment]]:</td>
            <td>
                <select id="sel_valign" style="width: 90px">
                    <option value="">[[NotSet]]</option>
                    <option value="top">[[Top]]</option>
                    <option value="middle">[[Middle]]</option>
                    <option value="baseline">[[Baseline]]</option>
                    <option value="bottom">[[Bottom]]</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="100">[[BackgroundColor]]:</td>
            <td>
                <input autocomplete="off" size="14" type="text" id="inp_bgColor" />
            </td>
            <td></td>
            <td>[[BorderColor]]:</td>
            <td>
                <input autocomplete="off" size="14" type="text" id="inp_borderColor" />
            </td>
        </tr>
        <tr>
            <td width="100">[[BorderColorLight]]:</td>
            <td>
                <input autocomplete="off" size="14" type="text" id="inp_borderColorLight" />
            </td>
            <td></td>
            <td>[[BorderColorDark]]:</td>
            <td>
                <input autocomplete="off" size="14" type="text" id="inp_borderColorDark" />
            </td>
        </tr>
        <tr>
            <td>[[CssClass]]:</td>
            <td>
                <input size="14" type="text" id="inp_class" /></td>
            <td></td>
            <td valign="middle" style="white-space: nowrap">[[ID]]:</td>
            <td>
                <input type="text" id="inp_id" size="14" /></td>
        </tr>
        <tr>
            <td>[[noWrap]]:</td>
            <td>
                <select id="sel_noWrap" style="width: 90px">
                    <option value="">[[Default]]</option>
                    <option value="noWrap">[[noWrap]]</option>
                </select>
            </td>
            <td></td>
            <td>[[CellScope]]:</td>
            <td>
                <select id="sel_CellScope" style="width: 90px">
                    <option value="">[[Default]]</option>
                    <option value="row">row</option>
                    <option value="col">col</option>
                    <option value="rowgroup">rowgroup</option>
                    <option value="colgroup">colgroup</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>[[Title]]:</td>
            <td colspan="4">
                <textarea id="inp_tooltip" rows="6" cols="53"></textarea></td>
        </tr>
    </table>
</fieldset>
<script type="text/javascript" src="Load.ashx?type=dialogscript&verfix=1006&file=Dialog_Tag_Td.js"></script>