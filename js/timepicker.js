 var txttimefortextbox = "", txttimeclass = "";
            $('.imgplushourintime').live("click", function () {
                var getintimehour = 0;
                getintimehour = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val();
                if (parseInt(getintimehour) < 12) {
                    getintimehour = parseInt(getintimehour) + 1;
                }
                else if (parseInt(getintimehour) == 12) {
                    getintimehour = "1";
                }
                if (parseInt(getintimehour) <= 9)
                    getintimehour = '0' + getintimehour;
                $(this).parent('div').find('.chklistboxID ').find('.HOUR').val(getintimehour);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplusminutintime').live("click", function () {
                var getintimeminute = 0;
                getintimeminute = $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val();
                if (parseInt(getintimeminute) < 59) {
                    getintimeminute = parseInt(getintimeminute) + 1;
                }
                else if (parseInt(getintimeminute) == 59) {
                    getintimeminute = "0";
                }
                if (parseInt(getintimeminute) <= 9)
                    getintimeminute = '0' + getintimeminute;
                $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val(getintimeminute);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplusampmintime').live("click", function () {
                var getintimeampm = "";
                getintimeampm = $(this).parent('div').find('.chklistboxID ').find('.AMPM').val();
                if (getintimeampm == "PM") {
                    getintimeampm = "AM"
                }
                else if (getintimeampm == "AM") {
                    getintimeampm = "PM"
                }
                $(this).parent('div').find('.chklistboxID ').find('.AMPM').val(getintimeampm);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubhourintime').live("click", function () {
                var getintimehour = 0;
                getintimehour = $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.HOUR').val();
                if (parseInt(getintimehour) >= 2) {
                    getintimehour = parseInt(getintimehour) - 1;
                }
                else if (parseInt(getintimehour) == 1) {
                    getintimehour = "12";
                }
                if (parseInt(getintimehour) <= 9)
                    getintimehour = '0' + getintimehour;
                $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.HOUR').val(getintimehour);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubminutintime').live("click", function () {
                var getintimeminute = 0;
                getintimeminute = $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.MINUTE').val();
                if (parseInt(getintimeminute) > 0) {
                    getintimeminute = parseInt(getintimeminute) - 1;
                }
                else if (parseInt(getintimeminute) == 0) {
                    getintimeminute = "59";
                }
                if (parseInt(getintimeminute) <= 9)
                    getintimeminute = '0' + getintimeminute;
                $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.MINUTE').val(getintimeminute);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubampmintime').live("click", function () {
                var getintimeampm = "";
                getintimeampm = $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.AMPM').val();
                if (getintimeampm == "PM") {
                    getintimeampm = "AM"
                }
                else if (getintimeampm == "AM") {
                    getintimeampm = "PM"
                }
                $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.AMPM').val(getintimeampm);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplushourouttime').live("click", function () {
                var getintimehour = 0;
                getintimehour = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val();
                if (parseInt(getintimehour) < 12) {
                    getintimehour = parseInt(getintimehour) + 1;
                }
                else if (parseInt(getintimehour) == 12) {
                    getintimehour = "1";
                }
                if (parseInt(getintimehour) <= 9)
                    getintimehour = '0' + getintimehour;
                $(this).parent('div').find('.chklistboxID ').find('.HOUR').val(getintimehour);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplusminutouttime').live("click", function () {
                var getintimeminute = 0;
                getintimeminute = $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val();
                if (parseInt(getintimeminute) < 59) {
                    getintimeminute = parseInt(getintimeminute) + 1;
                }
                else if (parseInt(getintimeminute) == 59) {
                    getintimeminute = "0";
                }
                if (parseInt(getintimeminute) <= 9)
                    getintimeminute = '0' + getintimeminute;
                $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val(getintimeminute);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplusampmouttime').live("click", function () {
                var getintimeampm = "";
                getintimeampm = $(this).parent('div').find('.chklistboxID ').find('.AMPM').val();
                if (getintimeampm == "PM") {
                    getintimeampm = "AM"
                }
                else if (getintimeampm == "AM") {
                    getintimeampm = "PM"
                }
                $(this).parent('div').find('.chklistboxID ').find('.AMPM').val(getintimeampm);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubhourouttime').live("click", function () {
                var getintimehour = 0;
                getintimehour = $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.HOUR').val();
                if (parseInt(getintimehour) >= 2) {
                    getintimehour = parseInt(getintimehour) - 1;
                }
                else if (parseInt(getintimehour) == 1) {
                    getintimehour = "12";
                }
                if (parseInt(getintimehour) <= 9)
                    getintimehour = '0' + getintimehour;
                $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.HOUR').val(getintimehour);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubminutouttime').live("click", function () {
                var getintimeminute = 0;
                getintimeminute = $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.MINUTE').val();
                if (parseInt(getintimeminute) > 0) {
                    getintimeminute = parseInt(getintimeminute) - 1;
                }
                else if (parseInt(getintimeminute) == 0) {
                    getintimeminute = "59";
                }
                if (parseInt(getintimeminute) <= 9)
                    getintimeminute = '0' + getintimeminute;
                $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.MINUTE').val(getintimeminute);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubampmouttime').live("click", function () {
                var getintimeampm = "";
                getintimeampm = $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.AMPM').val();
                if (getintimeampm == "PM") {
                    getintimeampm = "AM"
                }
                else if (getintimeampm == "AM") {
                    getintimeampm = "PM"
                }
                $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.AMPM').val(getintimeampm);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.HOUR').live("change", function () {
                var temphour = "";
                if ($.isNumeric($(this).parent('div').find('.HOUR').val()) == false) {
                    $(this).parent('div').find('.HOUR').val('09');
                }
                if (parseInt($(this).parent('div').find('.HOUR').val()) > 12) {
                    $(this).parent('div').find('.HOUR').val('09');
                    return false;
                }
                if (parseInt($(this).parent('div').find('.HOUR').val()) < 10) {
                    temphour = '0' + $(this).parent('div').find('.HOUR').val();
                    $(this).parent('div').find('.HOUR').val(temphour);
                }
                if ($(this).parent('div').parent('div').attr('class') == "divforappendintime") {
                    txttimeclass = '.timepickerintime';
                }
                else {
                    txttimeclass = ".timepickerouttime";
                }
                txttimefortextbox = $(this).parent('div').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('div').parent('td').find(txttimeclass).val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.MINUTE').live("change", function () {
                var tempminute = "";
                if ($.isNumeric($(this).parent('div').find('.MINUTE').val()) == false) {
                    $(this).parent('div').find('.MINUTE').val('30');
                }
                if (parseInt($(this).parent('div').find('.MINUTE').val()) > 59) {
                    $(this).parent('div').find('.MINUTE').val('30');
                }
                if (parseInt($(this).parent('div').find('.MINUTE').val()) < 10) {
                    tempminute = '0' + $(this).parent('div').find('.MINUTE').val();
                    $(this).parent('div').find('.MINUTE').val(tempminute);
                }
                if ($(this).parent('div').parent('div').attr('class') == "divforappendintime") {
                    txttimeclass = '.timepickerintime';
                }
                else {
                    txttimeclass = ".timepickerouttime";
                }
                txttimefortextbox = $(this).parent('div').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('div').parent('td').find(txttimeclass).val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.AMPM').live("change", function () {
                if ($(this).parent('div').find('.AMPM').val() != "AM" || $(this).parent('div').find('.AMPM').val() != "PM") {
                    $(this).parent('div').find('.AMPM').val('AM');
                }
                if ($(this).parent('div').parent('div').attr('class') == "divforappendintime") {
                    txttimeclass = '.timepickerintime';
                }
                else {
                    txttimeclass = ".timepickerouttime";
                }
                txttimefortextbox = $(this).parent('div').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('div').parent('td').find(txttimeclass).val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgbuttonpresentabsent').live('click', function () {
                var confirmstatus;
                if ($(this).attr('src') == '../../images/no.png') {
                    confirmstatus = confirm("Are you sure you want to mark as present.?");
                    markasabsent = "0";
                }
                else if ($(this).attr('src') == '../../images/yes.png') {
                    confirmstatus = confirm("Are you sure you want to mark as absent.?");
                    markasabsent = "1";
                }
                if (confirmstatus == true) {
                    $('.drop-down-intime').css("display", "none");
                    $('.drop-down-outtime').css("display", "none");
                    if (markasabsent == "1") {
                        $(this).parent('td').parent('tr').css("background-color", "#9D0000");
                        $(this).parent('td').parent('tr').find('td').css("color", "white");
                    }
                    else if (markasabsent == "0") {
                        $(this).parent('td').parent('tr').css("background-color", "green");
                        $(this).parent('td').parent('tr').find('td').css("color", "white");
                    }
                    intime = $(this).parents("tr").find(".timepickerintime").val();
                    outtime = $(this).parents("tr").find(".timepickerouttime").val();
                    empno = $(this).parent("td").parent('tr').find('input[type=hidden][id*=hfemployeeid]').val();
                    UpdateAttendance();
                    if ($(this).attr('src') == '../../images/no.png') {
                        $(this).attr("src", "../../images/yes.png");
                    }
                    else if ($(this).attr('src') == '../../images/yes.png') {
                        $(this).attr("src", "../../images/no.png");
                    }
                }
                return false;
            });
            $('.lbtnedit').live('click', function () {
                if ($(this).parent('td').parent('tr').find('td:eq(4) img').attr('src') == '../../images/no.png') {
                    alertify.error("You Can't Edit The Time. At First Mark Him/Her As Present.");
                    return false;
                }
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                $('.lbtnedit').css("display", "block");
                $('.lbtnupdate').css("display", "none");
                $('.lbtncancel').css("display", "none");
                $(this).parent('td').find('.lbtnedit').css("display", "none");
                $(this).parent('td').find('.lbtnupdate').css("display", "block");
                $(this).parent('td').find('.lbtncancel').css("display", "block");
                return false;
            });
            $('.lbtnupdate').live('click', function () {
                if ($(this).parent('td').parent('tr').find('td:eq(5) .timepickerintime').val() == "00 : 00 : AM" || $(this).parent('td').parent('tr').find('td:eq(6) .timepickerouttime').val() == "00 : 00 : PM") {
                    alertify.error("Enter Valid Time Please.");
                    return false;
                }
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                markasabsent = "0", colorstatus = "";
                intime = $(this).parents("tr").find(".timepickerintime").val()
                outtime = $(this).parents("tr").find(".timepickerouttime").val()
                empno = $(this).parent("td").parent('tr').find('input[type=hidden][id*=hfemployeeid]').val();
                UpdateAttendance();
                if (colorstatus != "") {
                    $(this).parent('td').parent('tr').find('td:eq(5) div').css("display", "none");
                    $(this).parent('td').parent('tr').find('td:eq(6) div').css("display", "none");
                    if (colorstatus == "1") {
                        alertify.success("Your Intime And OutTime Updated Sucessfully.");
                        $(this).parent('td').parent('tr').css("background-color", "green");
                        $(this).parent('td').parent('tr').find('td').css("color", "white");
                        call_progressbar("end");
                    }
                    $(this).parent('td').parent('tr').find('td:eq(4)').find(".lbtnabsent").attr("src", "../../images/yes.png")
                    $(this).parent('td').parent('tr').find('td').css("color", "white");
                    return false;
                }
            });
            $('.lbtncancel').live('click', function () {
                $(this).parent('td').parent('tr').find('td:eq(5) div').css("display", "none");
                $(this).parent('td').parent('tr').find('td:eq(6) div').css("display", "none");
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                $('.lbtnedit').css("display", "block");
                $('.lbtnupdate').css("display", "none");
                $('.lbtncancel').css("display", "none");
                return false;
            });