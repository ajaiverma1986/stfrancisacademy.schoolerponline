//==== To show data when page initially loads.
$(document).ready(function () {
    bindData();
});

function bindData() {
    var brid = 0;

    brid = '<%= Session["BrBrid"] %>'

    $("#<%=TextBox1.ClientID %>").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: '<%=ResolveUrl("~/TimeTable.asmx/getstudentdashboard") %>',
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
        select: function (e, i) {
            $("#<%=HiddenField1.ClientID %>").val(i.item.val);
        },
        minLength: 1
    });
}