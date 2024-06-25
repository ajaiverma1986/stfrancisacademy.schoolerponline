var UserLoggedIn = false;
var MessagePollingInterval = 3000;  // Interval of polling for message
var OLUsersPollingInterval = 5000;  // Interval of polling for online users
var CurrentReciepent = "";
var CurrentUser;
var userID;
var userName;
var message;
var ddlCatagory;
var department;
var password;
var senderid;
var receiverid;
var senderName;
var receiverName;
var reqid;
var MessagePollingTimer, OLUsersPollingTimer, Time, loggedIn;
var pageIndex, pageSize;
var EncryptionKey = 3;  //Encryption Key: 0 to disable encryption
var TotalPages = 0;
var prcode = "";
var ProductList = "";
var waitTime = 50;
var URL = "StudentPanel/student-feed-back.aspx";

function initializependingServicesRepliesAdmin(from, GerServucesOrProducts) {
    $('.pendingServicesRepliesAdmin').click(function () {
        //alert(from);
        //   alert("Df");
        //   alert( $(this).parents('tr').find('input[type=hidden][id*=hfpridReplies]').val());
        $("#hfprid").val($(this).parents('tr').find('input[type=hidden][id*=hfpridReplies]').val());
        var getprid = $("#hfprid").val();

        var result = GetReplymessager(getprid, from, GerServucesOrProducts);

        var xmlDoc = $.parseXML(result);
        var xml = $(xmlDoc);
        var a = 0;
        MainGetMessage = document.getElementById("divReplies");
        GetSeachMessageTable = document.getElementById("divReplies_popup-content");
        GetSeachMessageTable.innerHTML = "";
        $('#divmodelBack').addClass('modelBack');
        $("#divReplies").show(500);
        var SearchResults = xml.find("GetallData");
        SearchResults.each(function () {
            var Result = $(this);
            MessageLine1 = document.createElement("tr");
            MessageIdTD = document.createElement("td");
            MessageContent = document.createElement("td");
            MessageIdTD.innerHTML = "<div class='dealsearchproductName'></div>";
            MessageContent.innerHTML = "<div class='dealsearchproductName' style='vertical-align:top'>" + "<b>" + Result.find("fromto").text() + "</b>" + "</div><div>" +
                "<span class='cssdisc'>" + Result.find("message").text() + "</span>" + "</div><div>"
                    + "<span class='css-time'>" + Result.find("date").text() + "</span>" + "</div>";
            MessageLine1.appendChild(MessageIdTD);
            MessageLine1.appendChild(MessageContent);
            GetSeachMessageTable.appendChild(MessageLine1);
            //  MainGetMessage.appendChild(GetSeachMessageTable);
            a = (parseFloat(a)) + 1;
        });

        //$("#divReplies_popup-content").addClass('visible');
        return false;
    });

    $(".popup-exit_divReplies").click(function () {
        $("#divReplies").hide(500);
        $('#divmodelBack').removeClass('modelBack');
    })
}

//===============Start For Review and Comment=============================//

function initializeReview() {
    var pmid = " ";
    var reviewid = 0;
    var indexdiv = 0;
    var rate = 0;

    pmid = GetParameterValues("pmid");
    //if (pmid.indexOf('#') != -1) {
    //    pmid = scode.substring(0, scode.indexOf('#'));
    //}
    //if (pmid != "") {
    showReview();
    //}

    $(".clsinputrorc").val("");

    $(".clscomment").live("click", function () {
        $(".error_contactus").remove();
        rate = 0;
        $("#tblratingandclr tr:eq(0) td:eq(0)").find("span").html("★");
        $("#tblratingandclr tr:eq(0) td:eq(0)").find("span").attr("class", "clsstarsblank");
        $("#tblratingandclr tr:eq(0) td:eq(0) div").removeClass('rated');
        $("#tblratingandclr tr:eq(0) td:eq(0) div").addClass('rating');
        $(".divnowcomment").remove();
        $("#divpostreview").find(".clsinputname").val("");
        $("#divpostreview").find(".clsinputemail").val("");
        $("#divpostreview").find(".clsinputrorc").val("");
        var trcomclone = $("#divpostreview").clone();
        indexdiv = $(this).parents(".clsmaindiv").index();
        $(this).parents(".clsmaindiv").append('<div class="divnowcomment">' + trcomclone.html() + '</div>');
        $(".divnowcomment h2").html("Write Comment");
        $(".divnowcomment tr:eq(2)").remove();
        $(".divnowcomment tr:eq(2) td:eq(0)").html("Comment <cite>:</cite> ");
        $(".divnowcomment tr:eq(3) td:eq(1) input").val("Post Comment");
        $(".divnowcomment tr:eq(3) td:eq(1) input").removeClass("clspostnewrev");
        $(".divnowcomment tr:eq(3) td:eq(1) input").addClass("clspostnewcom");
        $(".divnowcomment tr:eq(3) td:eq(1)").append("<input type=\"button\" value=\"Cancel\" class=\"clscancelcomment btnpost\" >");
        reviewid = $(this).parents(".clsmaindiv").attr("id");
        $(".review-hide-style").show();
        $(".description-heading-div").hide();
        $(".divpostrv").hide();
        
        $(".clsinputrorc").val("");
        var offset = $(".clspostnewcom").offset();
        var top = offset.top;
        var WH = $(window).height();
        WH = parseFloat(WH) / 1.5;
        top = parseFloat(top) - parseFloat(WH);
        $('html, body').stop().animate({ scrollTop: top }, 500);
    });

    $(".clspostnewrev").click(function () {
        //  $("#divProgressBar").append('<img id="loader" alt="" src="images/progress.gif"  />');
        //   $("#divProgressBar").addClass("progressAdd");

        var scode2 = " ";
        var reviewid = 0;
        var indexdiv = 0;
        var name = $("#divpostreview").find(".clsinputname").val();

        name = name.split("—").join("-");
        name = name.split("’").join("'");
        var email = $("#divpostreview").find(".clsinputemail").val();

        email = email.split("—").join("-");
        email = email.split("’").join("'");
        var review = $("#divpostreview").find(".clsinputrorc").val();

        review = review.split("—").join("-");
        review = review.split("’").join("'");
        review = review.split('“').join('"');
        review = review.split('”').join('"');
        var type = "r";
        RemoveSpanById("divpostreview", "error_contactus");
        ResetTextBoxCssById("divpostreview", "texthover");
        if (name.trim() == "") {
            // $("#divProgressBar").removeClass("progressAdd");
            //  $("#divProgressBar").find("#loader").remove();
            $("#divpostreview").find(".clsinputname").focus();
            CustomFocusBYID("txtName");
            AddErrorSpan("txtName", "error_contactus", "Please Enter Name !");
            //ShowSuccessPopup("Error Message", "Please Enter Name !!! ");
            //alert("Please Enter Name !!!");
            return false;
        }

        if (email.trim() == "") {
            //  $("#divProgressBar").removeClass("progressAdd");
            //  $("#divProgressBar").find("#loader").remove();
            $("#divpostreview").find(".clsinputemail").focus();
            CustomFocusBYID("txtEmail");
            AddErrorSpan("txtEmail", "error_contactus", "Please Enter Email ID  !");
            //ShowSuccessPopup("Error Message", "Please Enter Email ID !!! ");
            //alert("Please Enter Email ID !!!");
            return false;
        }

        var re = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;
        if (!re.test(email.trim())) {
            //  $("#divProgressBar").removeClass("progressAdd");
            //  $("#divProgressBar").find("#loader").remove();
            $("#divpostreview").find(".clsinputemail").focus();
            CustomFocusBYID("txtEmail");
            AddErrorSpan("txtEmail", "error_contactus", "Please Enter Valid Email ID  !");
            //ShowSuccessPopup("Error Message", "Please Enter Valid Email ID ! ");
            // alert("Please Enter Valid Email ID !");
            return false;
        }

        if (review.trim() == "") {
            //  $("#divProgressBar").removeClass("progressAdd");
            //  $("#divProgressBar").find("#loader").remove();
            AddErrorSpan("Text1", "error_contactus", "Please Enter Review  !");
            CustomFocusBYID("Text1");
            $("#divpostreview").find(".clsinputrorc").focus();
            //ShowSuccessPopup("Error Message", "Please Enter Review !!! ");
            //alert("Please Enter Review !!!");
            return false;
        }

        var a = insreviewsandcomments(0, pmid, 0, name, email, rate, review, type);
        $("#divpostreview").find(".clsinputname").val("");
        $("#divpostreview").find(".clsinputemail").val("");
        $("#divpostreview").find(".clsinputrorc").val("");
        rate = 0;
        $("#tblratingandclr tr:eq(0) td:eq(0)").find("span").html("★");
        $("#tblratingandclr tr:eq(0) td:eq(0)").find("span").attr("class", "clsstarsblank");
        $("#tblratingandclr tr:eq(0) td:eq(0) div").removeClass('rated');
        $("#tblratingandclr tr:eq(0) td:eq(0) div").addClass('rating');
        $(".RateMsg").text("Rate It");
        //  $("#divProgressBar").removeClass("progressAdd");
        // $("#divProgressBar").find("#loader").remove();
    });

    $(".clspostnewcom").live("click", function () {
        $("#divProgressBar").append('<img id="loader" alt="" src="images/progress.gif"  />');
        $("#divProgressBar").addClass("progressAdd");

        var name = $(this).parents(".clsmaindiv").find(".clsinputname").val();
        name = name.split("—").join("-");
        name = name.split("’").join("'");
        var email = $(this).parents(".clsmaindiv").find(".clsinputemail").val();
        email = email.split("—").join("-");
        email = email.split("’").join("'");
        var rate = "0";
        var comment = $(this).parents(".clsmaindiv").find(".clsinputrorc").val();
        comment = comment.split("—").join("-");
        comment = comment.split("’").join("'");
        comment = comment.split('“').join('"');
        comment = comment.split('”').join('"');
        RemoveSpanById("divReview", "error_contactus");
        ResetTextBoxCssById("divReview", "texthover");
        var type = "c";
        if (name.trim() == "") {
            $("#divProgressBar").removeClass("progressAdd");
            $("#divProgressBar").find("#loader").remove();
            $(this).parents(".clsmaindiv").find(".clsinputname").focus();
            CustomFocusBYID("txtName");
            AddErrorSpan("txtName", "error_contactus", "Please Enter Name !");
            //ShowSuccessPopup("Error Message", "Please Enter Name !!! ");
            //alert("Please Enter Name !!!");
            return false;
        }
        if (email.trim() == "") {
            $("#divProgressBar").removeClass("progressAdd");
            $("#divProgressBar").find("#loader").remove();
            $(this).parents(".clsmaindiv").find(".clsinputemail").focus();
            CustomFocusBYID("txtEmail");
            AddErrorSpan("txtEmail", "error_contactus", "Please Enter Email ID !");
            //ShowSuccessPopup("Error Message", "Please Enter Email ID !!! ");
            //alert("Please Enter Email !!!");
            return false;
        }
        var re = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;
        if (!re.test(email.trim())) {
            $("#divProgressBar").removeClass("progressAdd");
            $("#divProgressBar").find("#loader").remove();
            $(this).parents(".clsmaindiv").find(".clsinputemail").focus();
            CustomFocusBYID("txtEmail");
            AddErrorSpan("txtEmail", "error_contactus", "Please Enter Valid Email ID !");
            //ShowSuccessPopup("Error Message", "Please Enter Valid Email ID ! ");
            //alert("Please Enter Valid Email ID !");
            return false;
        }
        if (comment.trim() == "") {
            $("#divProgressBar").removeClass("progressAdd");
            $("#divProgressBar").find("#loader").remove();
            $(this).parents(".clsmaindiv").find(".clsinputrorc").focus();
            CustomFocusBYID("Text1");
            AddErrorSpan("Text1", "error_contactus", "Please Enter Comment !");
            //ShowSuccessPopup("Error Message", "Please Enter Comment !!! ");
            //alert("Please Enter Comment !!!");
            return false;
        }
        var a = insreviewsandcomments(indexdiv, pmid, reviewid, name, email, 0, comment, type);
        $(".divnowcomment").remove();
        $(".review-hide-style").show();
        $(".description-heading-div").show();
        $(".divpostrv").show();

        $("#divProgressBar").removeClass("progressAdd");
        $("#divProgressBar").find("#loader").remove();

    });

    $(".clscancelcomment").live("click", function () {
        $(".error_contactus").remove();
        $(".divnowcomment").remove();
        $(".review-hide-style").show();

        $(".review-hide-style").show();
        $(".description-heading-div").show();
        $(".divpostrv").show();

        reviewid = 0;
    });

    //$(".clsscrolltoreviews").live("click", function () {
    //    $("body, html").animate({
    //        scrollTop: $("#ContentPlaceHolder1_read_reviews").position().top + 375
    //    }, 1100);
    //});

    $(".rating span").click(function () {
        rate = 0;

        $(this).parents("table").find("td:eq(0) div span").html("★");
        $(this).parents("table").find("td:eq(0) div span").attr("class", "clsstarsblank");
        $(this).parents("table").find("td:eq(0) div").removeClass('rated');
        $(this).parents("table").find("td:eq(0) div").removeClass('rating');
        $(this).parents("table").find("td:eq(0) div").addClass('rating');
        if (rate == 0) {
            rate = $(this).attr("id");
            rate = rate.toString().replace("Span","");
        }
        for (var i = 5 ; i >= (5 - parseInt(rate)) ; i--) {
            $(this).parent("div").find("span:eq(" + i + ")").html("★");
            $(this).parent("div").find("span:eq(" + i + ")").attr("class", "clsstarscolored");
            setTimeout(function () {
            if (rate == 0) {
                rate = $(this).attr("id");
                $(".RateMsg").text("Rate It");
            }
            if (rate == "1") {
                $(".RateMsg").text("Poor");
            }
            if (rate == "2") {
                $(".RateMsg").text("Average");
            }
            if (rate == "3") {
                $(".RateMsg").text("Good");
            }
            if (rate == "4") {
                $(".RateMsg").text("Very Good");
            }
            if (rate == "5") {
                $(".RateMsg").text("Excellent");
            }
         
            },0);
        }
        $(this).parent("div").removeClass('rating');
        $(this).parent("div").removeClass('rated');
        $(this).parent("div").addClass('rated');
    });

    //$(".clsclrstars").click(function () {
    //    alert('clear');
    //    rate = 0;
    //    $(this).parents("table").find("td:eq(0) div span").html("★");
    //    $(this).parents("table").find("td:eq(0) div span").attr("class", "clsstarsblank");
    //    $(this).parents("table").find("td:eq(0) div").removeClass('rated');
    //    $(this).parents("table").find("td:eq(0) div").removeClass('rating');
    //    $(this).parents("table").find("td:eq(0) div").addClass('rating');
    //});
}
//===============End For Review and Comment=============================//

//================================================ Start Of Show Review ==============================================
function showReview() {
    var urlchange = URL;
    var str = window.location.toString();
    if (urlchange == null) { alert("Request URL is Empty"); }
    else {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: URL + "/showreview",
            data: "{}",
            dataType: "json",
            success: function (data) {
                bindReview(data);
            },
            error: function (result) {
            }
        });
    }
}

function bindReview(result) {
    var count = "0";
    $.each(result, function (key, value) {
        popupContent = document.getElementById("divReview");
        var maindiv = document.createElement("div");
        $(maindiv).addClass('clsmaindiv');
        MessageLine1 = document.createElement("div");
        divpostname = document.createElement("div");
        divrevcomdesc = document.createElement("div");
        divtimecomment = document.createElement("div");

        var rorc = value.rORc;
        if (rorc.trim() == "r") {
            $(maindiv).attr("id", value.rcid);
            //popupContent.appendChild(maindiv);
            $(MessageLine1).addClass('divReviews');
            var divrating = document.createElement("div");
            $(divrating).addClass('clsratingdiv');
            divrating.innerHTML = "<span id='1' class='clsstarsblank'>★</span><span id='2' class='clsstarsblank'>★</span><span id='3' class='clsstarsblank'>★</span><span id='4' class='clsstarsblank'>★</span><span id='5' class='clsstarsblank'>★</span>";
            var ratestar = value.rate;
            for (var i = 0; i < (parseInt(ratestar)) ; i++) {
                $(divrating).find("span:eq(" + i + ")").html("★");
                $(divrating).find("span:eq(" + i + ")").attr("class", "clsstarscolored");
            }
        }
        if (rorc.trim() == "c") {
            $(MessageLine1).addClass('divComments');
        }
        $(divpostname).addClass('divpostname');
        divpostname.innerHTML = "<span class='clsspannamesaid'>" + value.name + ", </span><span class='clsspandate'>" + value.date + "</span>";
        divrevcomdesc.innerHTML = value.rcdesc;
        $(divrevcomdesc).addClass('clsdivcomentdesc');
        $(divtimecomment).addClass('divtimecomment');
        divtimecomment.innerHTML = " <a class='clscomment'>Write Comment >></a>";
        //MessageLine1.appendChild(divpostname);
        //MessageLine1.appendChild(divrevcomdesc);
        //MessageLine1.appendChild(divtimecomment);
        var maintable = document.createElement("table");
        var maintr = document.createElement("tr");
        var maintddesc = document.createElement("td");
        if (rorc.trim() == "r") {
            var tblnameandrate = document.createElement("table");
            var trname = document.createElement("tr");
            var trrate = document.createElement("tr");
            var tdrate = document.createElement("td");
            var tdname = document.createElement("td");
            tdrate.appendChild(divrating);
            tdname.appendChild(divpostname);
            trrate.appendChild(tdrate);
            trname.appendChild(tdname);
            tblnameandrate.appendChild(trrate);
            tblnameandrate.appendChild(trname);
            $(tblnameandrate).addClass('clstblnameandrate');
            maintddesc.appendChild(tblnameandrate);
        }
        if (rorc.trim() == "c") {
            maintddesc.appendChild(divpostname);
        }
        maintddesc.appendChild(divrevcomdesc);
        maintddesc.appendChild(divtimecomment);
        maintr.appendChild(maintddesc);
        maintable.appendChild(maintr);
        $(maintable).addClass('clsmaintable');
        MessageLine1.appendChild(maintable);
        if (rorc.trim() == "r") {
            maindiv.appendChild(MessageLine1);
            popupContent.appendChild(maindiv);
        }
        if (rorc.trim() == "c") {
            var a = popupContent.lastChild;
            a.appendChild(MessageLine1);
        }

        //popupContent.appendChild(MessageLine1);
        $(".clslblreviewscount").html(value.totalreviews);
        for (var i = 0; i < (parseInt(value.avgRate)) ; i++) {
            $(".clsavgratingstar").find("span:eq(" + i + ")").html("★");
            $(".clsavgratingstar").find("span:eq(" + i + ")").attr("class", "clsstarscolored");
        }
        count = "1";
    });
    if (count == "1") {
        $("#read_reviews").show();
        $("#lireviews").show();
    }
    else {
        //$("#ContentPlaceHolder1_read_reviews").hide();
        $("#lireviews").hide();
    }
}
//================================================ End Of Show Review ==============================================
//================================================ Start Insert Review and Comment ==============================================
var staticrwid = 0;
var indexofdiv = 0;
function insreviewsandcomments(indexdiv, pmid, rwid, name, email, rate, review, type) {
    staticrwid = rwid;
    indexofdiv = indexdiv;
    var urlchange = URL;
    //alert(name);
    //alert(email);
    //alert(rate);
    //alert(review);
    var str = window.location.toString();
    if (str.indexOf("/business-details/") > -1) {
        urlchange = "../" + URL;
    }
    if (urlchange == null) { alert("Request URL is Empty"); }
    else {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: URL + "/insreviewsandcomments",
            data: "{'RWID': '" + rwid + "', 'NAME': '" + name + "', 'EMAIL': '" + email + "', 'RATE': '" + rate + "', 'TYPE': '" + type + "', 'REVIEW': '" + review + "'}",
            dataType: "json",
            success: function (data) {

                bindReviewandCommentafterinsert(data)
            },
            error: function (result) {
            }
        });
    }
}

function bindReviewandCommentafterinsert(result) {
    var count = 1;
    $.each(result, function (key, value) {
        popupContent = document.getElementById("divReview");
        var maindiv = document.createElement("div");
        $(maindiv).addClass('clsmaindiv');
        MessageLine1 = document.createElement("div");
        divpostname = document.createElement("div");
        divrevcomdesc = document.createElement("div");
        $(divrevcomdesc).addClass('clsdivcomentdesc');
        divtimecomment = document.createElement("div");
        var rorc = value.rORc;
        if (rorc.trim() == "r") {
            $(maindiv).attr("id", value.rcid);
            popupContent.appendChild(maindiv);
            $(MessageLine1).addClass('divReviews');
            var divrating = document.createElement("div");
            $(divrating).addClass('clsratingdiv');
            divrating.innerHTML = "<span id='1' class='clsstarsblank'>★</span><span id='2' class='clsstarsblank'>★</span><span id='3' class='clsstarsblank'>★</span><span id='4' class='clsstarsblank'>★</span><span id='5' class='clsstarsblank'>★</span>";
            var ratestar = value.rate;
            for (var i = 0; i < (parseInt(ratestar)) ; i++) {
                $(divrating).find("span:eq(" + i + ")").html("★");
                $(divrating).find("span:eq(" + i + ")").attr("class", "clsstarscolored");
            }
        }
        if (rorc.trim() == "c") {
            $(MessageLine1).addClass('divComments');
        }
        $(divpostname).addClass('divpostname');
        divpostname.innerHTML = "<span class='clsspannamesaid'>" + value.name + ", </span><span class='clsspandate'>" + value.date + "</span>";
        divrevcomdesc.innerHTML = value.rcdesc;
        $(divtimecomment).addClass('divtimecomment');
        divtimecomment.innerHTML = " <a class='clscomment'>Write Comment >></a>";
        var maintable = document.createElement("table");
        var maintr = document.createElement("tr");
        var maintddesc = document.createElement("td");
        if (rorc.trim() == "r") {
            var tblnameandrate = document.createElement("table");
            var trname = document.createElement("tr");
            var trrate = document.createElement("tr");
            var tdrate = document.createElement("td");
            var tdname = document.createElement("td");
            tdrate.appendChild(divrating);
            tdname.appendChild(divpostname);
            trrate.appendChild(tdrate);
            trname.appendChild(tdname);
            tblnameandrate.appendChild(trrate);
            tblnameandrate.appendChild(trname);
            $(tblnameandrate).addClass('clstblnameandrate');
            maintddesc.appendChild(tblnameandrate);
        }
        if (rorc.trim() == "c") {
            maintddesc.appendChild(divpostname);
        }
        maintddesc.appendChild(divrevcomdesc);
        maintddesc.appendChild(divtimecomment);
        maintr.appendChild(maintddesc);
        maintable.appendChild(maintr);
        $(maintable).addClass('clsmaintable');
        MessageLine1.appendChild(maintable);
        if (rorc.trim() == "r") {
            maindiv.appendChild(MessageLine1);
            popupContent.appendChild(maindiv);
        }
        if (rorc.trim() == "c") {
            var a = popupContent.children[indexofdiv];
            a.appendChild(MessageLine1);
        }
        $(".clsavgratingstar").find("span").html("★");
        $(".clsavgratingstar").find("span").attr("class", "clsstarsblank");
        $(".clslblreviewscount").html(value.totalreviews);
        for (var i = 0; i < (parseInt(value.avgRate)) ; i++) {
            $(".clsavgratingstar").find("span:eq(" + i + ")").html("★");
            $(".clsavgratingstar").find("span:eq(" + i + ")").attr("class", "clsstarscolored");
        }
    });
    $("#read_reviews").show();
    $("#lireviews").show();
}

//========================End Insert Review and Comment=====================