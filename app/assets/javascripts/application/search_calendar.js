document.addEventListener("turbolinks:load", function() {
    // Global
    window.state = {
        "system": "ce",
        "from_jd": null,
        "to_jd": null,
        "today_jd": null,
        "calendar": $.calendars.instance("gregorian"),
        "formats": {
            'ce': 'mm/dd/yyyy',
            'ah': 'yyyy/mm/dd'
        }
    }

    function convertShortcode(code){
        switch(code){
            case 'ce':
                return 'gregorian';
                break;
            case 'ah':
                return 'islamic';
                break;
            default:
                return 'gregorian';
        }
    }

    function onSystemChange(){
        state.system = $(this).val();
        var calendar_type = convertShortcode(state.system);
        state.calendar = $.calendars.instance(calendar_type);
        $('.is-calendarsPicker').each(function(){
            var id = this.id;
            var context = id.replace("search_filters_date_", "");
            // console.log(this.id);
            // console.log($(this));
            // console.log(context);
            // let currentDate = $(this).calendarsPicker('getDate');
            // console.log(currentDate);

            // Swap calendar
            try{
                $(this).calendarsPicker('option', {
                    calendar: state.calendar,
                    onSelect: onDateChange
                });
            }
            catch(e){
                console.log(e);
            }

            // set new date
            if(state[context + "_date"] !== null){
                var date = state.calendar.fromJD(state[context + "_jd"]);
                state[context + "_date"] = date;
                $(this).calendarsPicker('setDate', date);
            } else {
                state[context + "_date"] = null;
            }

            // now swap it in the inputs
            var displayDate = state.calendar.formatDate(state.formats[state.system], state[context + "_date"]);
            $(`#${id}`).val(displayDate);

            $(this).attr("placeholder", state.formats[state.system]);
        })

    }
    $('#search_filters_date_format').change(onSystemChange);
    // $('.date-block.format').change(onSystemChange);

    /**
     * When the date changes
     */
    function onDateChange(){
        // if date is empty, needs to set it to null in calendar and in state
        console.log("onDateChange()");
        try {
            state.from_date = $("#search_filters_date_from").calendarsPicker('getDate')[0];
            state.from_jd = state.from_date.toJD();
        } catch(e){
            console.log("from_date null");
            console.log(e);
            state.from_date = null;
            state.from_jd = null;
        }

        try {
            state.to_date = $("#search_filters_date_to").calendarsPicker('getDate')[0];
            state.to_jd = state.to_date.toJD();
        } catch(e){
            console.log("to_date null");
            console.log(e);
            state.to_date = null;
            state.to_jd = null;
        }
        console.log(state);
        setOtherDate();
    }

    /**
     * Check to see if date is null
     * more aggressive than the callback in the calendar, as users may delete the date
     */
    function dateNull(){
        var id = this.id;
        var context = id.replace("search_filters_date_", "");

        if($(this).val() == ""){
            state[context + "_date"] = null;
            state[context + "_jd"] = null;
        }
    }
    $('#search_filters_date_from').change(dateNull);
    $('#search_filters_date_to').change(dateNull);

    function setOtherDate(){
        if(state.system == "ah"){
            var format = "ce";
        }
        if(state.system == "ce"){
            var format = "ah";
        }
        var calendar_type = convertShortcode(format);
        var otherCalendar = $.calendars.instance(calendar_type);

        var formatted_from = state.from_jd ? otherCalendar.formatDate(state.formats[format], otherCalendar.fromJD(state.from_jd)) : "";
        var formatted_to = state.to_jd ? otherCalendar.formatDate(state.formats[format], otherCalendar.fromJD(state.to_jd)) : "";
        var val = `Range in ${format.toUpperCase()}: ${formatted_from} - ${formatted_to}`
        $('#range-date').html(val)
    }

    function setDateToToday(){
        var today = state.calendar.today();
        state.today_jd = state.calendar.toJD(today);
    }

    // On the format change
    // $('#search_filters_date_format').change(function () {
    //     // Handle state change
    //     state.system = $(this).val();

    //     // Swap calendar
    //     var calendar_type = convertShortcode(state.system);
    //     var calendar = $.calendars.instance(calendar_type);

    //     console.log(calendar);

    //     var convert = function (value) {
    //         return (!value || typeof value != 'object' ? value :
    //             calendar.fromJD(value.toJD()));
    //     };
    //     $('.is-calendarsPicker').each(function () {
    //         var current = $(this).calendarsPicker('option');
    //         // console.log('current ', current);
    //         console.log($(this));
    //         console.log(current);

    //         $(this).calendarsPicker('option', {
    //             calendar: calendar,
    //             onSelect: null,
    //             onChangeMonthYear: null,
    //             defaultDate: convert(current.defaultDate),
    //             minDate: convert(current.minDate),
    //             maxDate: convert(current.maxDate)
    //         }).
    //         calendarsPicker('option', {
    //             onSelect: current.onSelect,
    //             onChangeMonthYear: current.onChangeMonthYear
    //         });
    //     });
    //     setOtherDate();

    //     // swap the dates in the range filter
    //     // var dates = getDatesFromState(state.system);
    //     // console.log("dates", dates);
    //     // setDate(dates.from, "from", state.system);
    //     // setDate(dates.to, "to", state.system);
    // });

    /**
     * When the date changes
     */
    // function onDateChange(){
    //     console.log("onDateChange()");
    //     console.log(state);
    //     var from_date = getDate("from");
    //     var to_date = getDate("to");
    //     console.log('post getDate()s')
    //     console.log(state);
    //     console.log(`TO DATE: ${to_date}`)

    //     console.log(`FROM ${from_date}`); /// This is wrong
    //     console.log(formatDate(from_date, state.system));
    //     // verify dates are valid

    //     console.log(`--here-- ${getDate("from", "string")}`);
    //     if(isValidDate)

    //     // convert to jd and store
    //     if(state.system == 'ce'){
    //         if(isValidDate(getDate("from", "string"))){
    //             state.from_jd = gregorian_to_jd(from_date[0], from_date[1], from_date[2]);
    //         }
    //         if(isValidDate(getDate("to", "string"))){
    //             state.to_jd = gregorian_to_jd(to_date[0], to_date[1], to_date[2]);
    //         }
    //     }
    //     if(state.system == 'ah'){
    //         // Hijri to Gregorian, then Gregorian to Julian
    //         console.log('hijri in onDateChange()');
    //         if(isValidDate(getDate("from", "string"))){
    //             var gregorian_from = islToChr(0, from_date);
    //             state.from_jd = gregorian_to_jd(gregorian_from[0], gregorian_from[1], gregorian_from[2]);
    //         }
    //         if(isValidDate(getDate("to", "string"))){
    //             var gregorian_to = islToChr(0, to_date);            
    //             state.to_jd = gregorian_to_jd(gregorian_to[0], gregorian_to[1], gregorian_to[2]);
    //         }
    //     }
    //     console.log('state ------ ');
    //     console.log(state);

    //     // Set the other date format 
    //     setOtherDate();
    // }

    /**
     * 
     * @param {string} target - "from" or "to"
     * @param {string} part - "day", "month", "year", "string" or empty
     */
    // function getDate(target, part) {
    //     // var system = $('#search_filters_date_format').val();
    //     var dateString = $(`#search_filters_date_${target}`).val();
    //     console.log("getDate() " + dateString);
    //     if(dateString == ""){
    //         return null;
    //     }
    //     var dateArr = dateString.split("/");
    //     if(state.system == "ah"){
    //         var year = parseInt(dateArr[0]);
    //         var month = parseInt(dateArr[1]);
    //         var day = parseInt(dateArr[2]);
    //     } else {
    //         var year = parseInt(dateArr[2]);
    //         var month = parseInt(dateArr[0]);
    //         var day = parseInt(dateArr[1]);
    //     }

    //     if (part == "day") {
    //         return day;
    //     } else if (part == "month") {
    //         return month;
    //     } else if (part == "year") {
    //         return year;
    //     } else if (part == "string"){
    //         return dateString;
    //     } else {
    //         return [year, month, day]
    //     }
    // }

    /**
     * Checks to see if a date is valid
     * @param {*} d - a string, Date, or timestamp int
     */
    function isValidDate(d) {
        if(d == null){
            return false;
        }
        let n = new Date(d);
        return n instanceof Date && !isNaN(n);
    }

    /**
     * Returns a 0 padded short date string or a long date string in the right date system format
     * @param {array} d - in [yyyy, mm, dd] format
     * @param {string} system - "CE" or "AH"
     */
    // function formatDate(d, system, format){
    //     if(format == null || format == "short"){
    //         if(system.toLowerCase() == "ce"){
    //             // mm/dd/yyyy eg 02/25/2021
    //             return ("000" + d[1]).substr(-2,2) + "/" + ("000" + d[2]).substr(-2,2) + "/" + d[0];
    //         }
    //         if(system.toLowerCase() == "ah"){
    //             // yyyy/mm/dd eg 2021/02/25
    //             return (d[0] + "/" + ("000" + d[1]).substr(-2,2) + "/" + ("000" + d[2]).substr(-2,2));
    //         }
    //         return false;
    //     }
    //     else if(format == "long"){
    //         if(system.toLowerCase() == "ce"){
    //             // dd Month, Year eg 25 February, 2021
    //             return (d[2] + " " + gregorian_month(d[1]) + ", " + d[0]);
    //         }
    //         if(system.toLowerCase() == "ah"){
    //             // dd Month, Year
    //             return (d[2] + " " + hijri_month(d[1]) + ", " + d[0]);
    //         }
    //         return false;
    //     }
    //     else {
    //         console.log("formatDate err");
    //         return false;
    //     }
    // }
  
    /**
     * 
     * @param {array} d - in [yyyy, mm, dd] format, or a preformatted string
     * @param {*} target - "to" or "from"
     * @param {*} system - "AH" or "CE"
     */
    // function setDate(d, target, system) {
    //     console.log("setDate()");
    //     if(Array.isArray(d)){
    //         dateString = formatDate(d, system, "short");
    //     } else {
    //         dateString = d;
    //     }
    //     if(!isValidDate(dateString)){
    //         return false;
    //     }
    //     $(`#search_filters_date_${target}`).val(dateString);
    //     return dateString;
    // }

    // function leap_gregorian(year) {
    //     return ((year % 4) == 0) &&
    //         (!(((year % 100) == 0) && ((year % 400) != 0)));
    // }

    /**
     * Converts a Gregorian calendar date to Julian day
     * 1 indexed?
     * TODO: update this to use array
     * @param {*} year 
     * @param {*} month 
     * @param {*} day 
     */
    function gregorian_to_jd(year, month, day) {

        var GREGORIAN_EPOCH = 1721425.5;
        return (GREGORIAN_EPOCH - 1) +
            (365 * (year - 1)) +
            Math.floor((year - 1) / 4) +
            (-Math.floor((year - 1) / 100)) +
            Math.floor((year - 1) / 400) +
            Math.floor((((367 * month) - 362) / 12) +
                ((month <= 2) ? 0 :
                    (leap_gregorian(year) ? -1 : -2)
                ) +
                day);
    }

    function mod(a, b) {
        return a - (b * Math.floor(a / b));
    }

    /**
     * Converts a Julian day number to Gregorian
     * @param {*} jd 
     */
    function jd_to_gregorian(jd) {
        var wjd, depoch, quadricent, dqc, cent, dcent, quad, dquad,
            yindex, dyindex, year, yearday, leapadj;

        var GREGORIAN_EPOCH = 1721425.5;
        wjd = Math.floor(jd - 0.5) + 0.5;
        depoch = wjd - GREGORIAN_EPOCH;
        quadricent = Math.floor(depoch / 146097);
        dqc = mod(depoch, 146097);
        cent = Math.floor(dqc / 36524);
        dcent = mod(dqc, 36524);
        quad = Math.floor(dcent / 1461);
        dquad = mod(dcent, 1461);
        yindex = Math.floor(dquad / 365);
        year = (quadricent * 400) + (cent * 100) + (quad * 4) + yindex;
        if (!((cent == 4) || (yindex == 4))) {
            year++;
        }
        yearday = wjd - gregorian_to_jd(year, 1, 1);
        leapadj = ((wjd < gregorian_to_jd(year, 3, 1)) ? 0 :
            (leap_gregorian(year) ? 1 : 2)
        );
        month = Math.floor((((yearday + leapadj) * 12) + 373) / 367);
        day = (wjd - gregorian_to_jd(year, month, 1)) + 1;

        return([year, month, day]);
        // setter([year, month, day], "gregorian", false)
    }

    function intPart(floatNum) {
        if (floatNum < -0.0000001) {
            return Math.ceil(floatNum - 0.0000001)
        }
        return Math.floor(floatNum + 0.0000001)
    }

    /**
     * Converts Gregorian to Hijri date
     * @param {*} NumberofDays - usually 0
     * @param {*} dateArr - in [yyyy, mm, dd] format, 1 indexed (eg 2 = Feb)
     */
    function chrToIsl(NumberofDays, dateArr) {
        // var date = getter("gregorian");
        // y = date[0];
        // m = date[1];
        // d = date[2];
        y = dateArr[0];
        m = dateArr[1];
        d = dateArr[2];
        console.log(`ChrtoIsl ${[y,m,d]}`)

        if ((y > 1582) || ((y == 1582) && (m > 10)) || ((y == 1582) && (m == 10) && (d > 14))) {
            jd = intPart((1461 * (y + 4800 + intPart((m - 14) / 12))) / 4) + intPart((367 * (m - 2 - 12 * (intPart((m - 14) / 12)))) / 12) -
                intPart((3 * (intPart((y + 4900 + intPart((m - 14) / 12)) / 100))) / 4) + d - 32075
        } else {
            jd = 367 * y - intPart((7 * (y + 5001 + intPart((m - 9) / 7))) / 4) + intPart((275 * m) / 9) + d + 1729777
        }

        jd = jd + NumberofDays
        // $("#jd").html(jd)
        // $("#weekday").html(weekDay(jd % 7))
        // setOtherDate("AH",from_date=date);

        l = jd - 1948440 + 10632
        n = intPart((l - 1) / 10631)
        l = l - 10631 * n + 354
        j = (intPart((10985 - l) / 5316)) * (intPart((50 * l) / 17719)) + (intPart(l / 5670)) * (intPart((43 * l) / 15238))
        l = l - (intPart((30 - j) / 15)) * (intPart((17719 * j) / 50)) - (intPart(j / 16)) * (intPart((15238 * j) / 43)) + 29
        m = intPart((24 * l) / 709)
        d = l - intPart((709 * m) / 24)
        y = 30 * n + j - 30


        // jd_to_gregorian(jd) // what does this do
        // setter([y, m, d], "hijri")
        return([y,m,d])
    }

    function islToChr(NumberofDays, dateArr) {
        // var date = getter("hijri"); // 1 indexed eg Feb = 2
        y = dateArr[0];
        m = dateArr[1];
        d = dateArr[2];

        jd = intPart((11 * y + 3) / 30) + 354 * y + 30 * m - intPart((m - 1) / 2) + d + 1948440 - 385
        jd = jd + NumberofDays
        // $("#jd").val(jd)
        // $("#weekday").val(weekDay(jd % 7))
        // setOtherDate("CE",from_date=date);
        
        if (jd > 2299160) {
            l = jd + 68569
            n = intPart((4 * l) / 146097)
            l = l - intPart((146097 * n + 3) / 4)
            i = intPart((4000 * (l + 1)) / 1461001)
            l = l - intPart((1461 * i) / 4) + 31
            j = intPart((80 * l) / 2447)
            d = l - intPart((2447 * j) / 80)
            l = intPart(j / 11)
            m = j + 2 - 12 * l
            y = 100 * (n - 49) + i + l
        } else {
            j = jd + 1402
            k = intPart((j - 1) / 1461)
            l = j - 1461 * k
            n = intPart((l - 1) / 365) - intPart(l / 1461)
            i = l - 365 * n + 30
            j = intPart((80 * i) / 2447)
            d = i - intPart((2447 * j) / 80)
            i = intPart(j / 11)
            m = j + 2 - 12 * i
            y = 4 * k + n + i - 4716
        }
        // setter([y, m, d], "gregorian")
        return( [y, m, d] );
    }

    /**
     * Returns the AH / Hijri month for an int, 1 indexed
     * @param {int} month 
     */
    function hijri_month(month){
        var months = ["Muharram", "Safar", "Rabi I", "Rabi II", "Jumada I", "Jumada II", "Rajab", "Sha'ban", "Ramadan", "Shawwal", "Dhu'l Qa'dah", "Dhu'l Hijja"]
        return months[month-1];
    }

    /**
     * Returns the Gregorian month, 1 indexed
     * @param {int} month 
     */
    function gregorian_month(month){
        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        return months[month-1];
    }

    /**
     * Sets the date to today
     */
    // function setDateToToday() {
    //     var today = new Date();
    //     var y = today.getYear();
    //     if (y < 1000) {
    //         y += 1900;
    //     }
    //     var jd = gregorian_to_jd(y, today.getMonth() + 1, today.getDate()); //gregorian_to_jd needs 1-indexed
    //     state.today_jd = jd;
    //     var dateArr = [y, today.getMonth() + 1, today.getDate()]
    //     var todayGregorian = formatDate(dateArr, "ce", "long");
    //     var todayHijriArr = chrToIsl(0, dateArr);
    //     var todayHijri = formatDate(todayHijriArr, "ah", "long");

    //     $('#today-date').html(`Today: ${todayGregorian} | ${todayHijri}`)
    // }

    function getDatesFromState(system){
        if(system == 'ce'){
            if(state.from_jd){
                var gregorian_from = jd_to_gregorian(state.from_jd);
            } else {
                var gregorian_from = null;
            }
            if(state.to_jd){
                var gregorian_to = jd_to_gregorian(state.to_jd);
            } else {
                var gregorian_to = null;
            }
            
            return {
                'from': gregorian_from,
                'to': gregorian_to
            }
        }
        if(system == 'ah'){
            if(state.from_jd){
                var gregorian_from = jd_to_gregorian(state.from_jd);
                var ah_from = chrToIsl(0, gregorian_from);
            } else {
                var gregorian_to = jd_to_gregorian(state.to_jd);
                var ah_to = chrToIsl(0, gregorian_to);
            }

            return {
                'from': ah_from,
                'to': ah_to
            }
        }
    }

    // function setOtherDate(){
    //     if(state.system == "ah"){
    //         var format = "ce";
    //     }
    //     if(state.system == "ce"){
    //         var format = "ah";
    //     }
    //     var dates = getDatesFromState(format);
    //     console.log(dates);
    //     var formatted_from = dates.from ? formatDate(dates.from, format, "long") : "";
    //     var formatted_to = dates.to ? formatDate(dates.to, format, "long") : "";
    //     var val = `Range in ${format.toUpperCase()}: ${formatted_from} - ${formatted_to}`

    //     $('#range-date').html(val)
    // }

    /**
     * binds initial things
     */
    function setup_and_bind(){
        $('.filter-date .filter-content').hide();
        $("#search_filters_date_from").calendarsPicker({
            calender: state.calendar, 
            onSelect: onDateChange
        });
        $("#search_filters_date_to").calendarsPicker({
            calender: state.calendar,
            onSelect: onDateChange
        });

        // $('#search_filters_date_from').change(onDateChange);
        // $('#search_filters_date_to').change(onDateChange);
        // $('#search_filters_date_from').on('input', onDateChange);
        // $('#search_filters_date_to').on('input', onDateChange);

        setDateToToday();
    }

    setup_and_bind();

    // function test(){
    //     console.log('TEST');
    //     state.from_jd = 2459272;
    //     console.log(state);a
    //     var gregorian_from = jd_to_gregorian(state.from_jd);
    //     console.log(gregorian_from);
    //     console.log(formatDate(gregorian_from, 'ce', "short"));
    //     var hijri_from = chrToIsl(0, gregorian_from);
    //     console.log(hijri_from);
    //     console.log(formatDate(hijri_from, 'ah'));
    //     console.log(formatDate(hijri_from, 'ah', 'long'));
    // }
    // test();
    
});