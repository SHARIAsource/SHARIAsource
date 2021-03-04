// // From http://www.muslimphilosophy.com/ip/hijri.htm
// document.addEventListener("turbolinks:load", function () {

//     function setup_and_bind() {
//         setDateToToday();
//         $("#gregorian-month").on("change", function () {
//             chrToIsl(0);
//         });
//         $("#gregorian-day").on("change", function () {
//             chrToIsl(0);
//         });
//         $("#gregorian-year").on("change", function () {
//             chrToIsl(0);
//         });
//         $("#gregorian-year").on("keyup", function () {
//             chrToIsl(0);
//         });
//         $("#hijri-month").on("change", function () {
//             islToChr(0);
//         });
//         $("#hijri-day").on("change", function () {
//             islToChr(0);
//         });
//         $("#hijri-year").on("change", function () {
//             islToChr(0);
//         });
//         $("#hijri-year").on("keyup", function () {
//             islToChr(0);
//         });
//     }

//     // "gregorian" || "hijri", [yyyy, mm, dd]
//     function setter(d, system, index) {
//         if(system === undefined) system = "gregorian";
//         if(index === undefined) index = false;
//         $("#" + system + "-year").val(d[0]);
//         $("#" + system + "-day").val(d[2]);
//         if (index) {
//             $("#" + system + "-month").prop('selectedIndex', d[1]);
//         } else {
//             $("#" + system + "-month").val(d[1]);
//         }
//     }

//     function getter(system, part) {
//         var year = parseInt($("#" + system + "-year").val());
//         var month = parseInt($("#" + system + "-month").val());
//         var day = parseInt($("#" + system + "-day").val());

//         console.log(`GETTER ${system} ${[year, month, day]}`);
//         if (part == "day") {
//             return day;
//         } else if (part == "month") {
//             return month;
//         } else if (part == "year") {
//             return year;
//         } else {
//             return [year, month, day]
//         }
//     }

//     function getFromCalendar(){

//     }

//     function setDateToToday() {
//         var today = new Date();
//         var y = today.getYear();
//         if (y < 1000) {
//             y += 1900;
//         }

//         setter([y, today.getMonth(), today.getDate()], "gregorian", true);
//         chrToIsl(0);
//     }

//     //  LEAP_GREGORIAN  --  Is a given year in the Gregorian calendar a leap year ?
//     function leap_gregorian(year) {
//         return ((year % 4) == 0) &&
//             (!(((year % 100) == 0) && ((year % 400) != 0)));
//     }

//     //  GREGORIAN_TO_JD  --  Determine Julian day number from Gregorian calendar date
//     function gregorian_to_jd(year, month, day) {

//         var GREGORIAN_EPOCH = 1721425.5;
//         return (GREGORIAN_EPOCH - 1) +
//             (365 * (year - 1)) +
//             Math.floor((year - 1) / 4) +
//             (-Math.floor((year - 1) / 100)) +
//             Math.floor((year - 1) / 400) +
//             Math.floor((((367 * month) - 362) / 12) +
//                 ((month <= 2) ? 0 :
//                     (leap_gregorian(year) ? -1 : -2)
//                 ) +
//                 day);
//     }

//     function mod(a, b) {
//         return a - (b * Math.floor(a / b));
//     }

//     function jd_to_gregorian(jd) {
//         var wjd, depoch, quadricent, dqc, cent, dcent, quad, dquad,
//             yindex, dyindex, year, yearday, leapadj;

//         var GREGORIAN_EPOCH = 1721425.5;
//         wjd = Math.floor(jd - 0.5) + 0.5;
//         depoch = wjd - GREGORIAN_EPOCH;
//         quadricent = Math.floor(depoch / 146097);
//         dqc = mod(depoch, 146097);
//         cent = Math.floor(dqc / 36524);
//         dcent = mod(dqc, 36524);
//         quad = Math.floor(dcent / 1461);
//         dquad = mod(dcent, 1461);
//         yindex = Math.floor(dquad / 365);
//         year = (quadricent * 400) + (cent * 100) + (quad * 4) + yindex;
//         if (!((cent == 4) || (yindex == 4))) {
//             year++;
//         }
//         yearday = wjd - gregorian_to_jd(year, 1, 1);
//         leapadj = ((wjd < gregorian_to_jd(year, 3, 1)) ? 0 :
//             (leap_gregorian(year) ? 1 : 2)
//         );
//         month = Math.floor((((yearday + leapadj) * 12) + 373) / 367);
//         day = (wjd - gregorian_to_jd(year, month, 1)) + 1;

//         setter([year, month, day], "gregorian", false)
//     }

//     function intPart(floatNum) {
//         if (floatNum < -0.0000001) {
//             return Math.ceil(floatNum - 0.0000001)
//         }
//         return Math.floor(floatNum + 0.0000001)
//     }

//     function weekDay(wdn) {
//         if (wdn == 0) {
//             return "Monday"
//         }
//         if (wdn == 1) {
//             return "Tuesday"
//         }
//         if (wdn == 2) {
//             return "Wednesday"
//         }
//         if (wdn == 3) {
//             return "Thursday"
//         }
//         if (wdn == 4) {
//             return "Friday"
//         }
//         if (wdn == 5) {
//             return "Saturday"
//         }
//         if (wdn == 6) {
//             return "Sunday"
//         }
//         return ""

//     }

//     function hijri_month(month){
//         if (month = 1){ return "Muharram"; }
//         if (month = 2){ return "Safar"; }
//         if (month = 3){ return "Rabi I"; }
//         if (month = 4){ return "Rabi II"; }
//         if (month = 5){ return "Jumada I"; }
//         if (month = 6){ return "Jumada II"; }
//         if (month = 7){ return "Rajab"; }
//         if (month = 8){ return "Sha'ban";}
//         if (month = 9){ return "Ramadan"; }
//         if (month = 10){return "Shawwal";}
//         if (month = 11){return "Dhu'l Qa'dah"}
//         if (month = 12){return "Dhu'l Hijja"}
//         return "";
//     }

//     function chrToIsl(NumberofDays) {
//         var date = getter("gregorian"); 
//         y = date[0];
//         m = date[1];
//         d = date[2];

//         if ((y > 1582) || ((y == 1582) && (m > 10)) || ((y == 1582) && (m == 10) && (d > 14))) {
//             jd = intPart((1461 * (y + 4800 + intPart((m - 14) / 12))) / 4) + intPart((367 * (m - 2 - 12 * (intPart((m - 14) / 12)))) / 12) -
//                 intPart((3 * (intPart((y + 4900 + intPart((m - 14) / 12)) / 100))) / 4) + d - 32075
//         } else {
//             jd = 367 * y - intPart((7 * (y + 5001 + intPart((m - 9) / 7))) / 4) + intPart((275 * m) / 9) + d + 1729777
//         }

//         jd = jd + NumberofDays
//         $("#jd").html(jd)
//         $("#weekday").html(weekDay(jd % 7))
//         // setOtherDate("AH",from_date=date);

//         l = jd - 1948440 + 10632
//         n = intPart((l - 1) / 10631)
//         l = l - 10631 * n + 354
//         j = (intPart((10985 - l) / 5316)) * (intPart((50 * l) / 17719)) + (intPart(l / 5670)) * (intPart((43 * l) / 15238))
//         l = l - (intPart((30 - j) / 15)) * (intPart((17719 * j) / 50)) - (intPart(j / 16)) * (intPart((15238 * j) / 43)) + 29
//         m = intPart((24 * l) / 709)
//         d = l - intPart((709 * m) / 24)
//         y = 30 * n + j - 30


//         jd_to_gregorian(jd)
//         setter([y, m, d], "hijri")
//     }

//     function setOtherDate(format,from_date=null,to_date=null){
//         selected_format = $('#date_format').val();
//         if(selected_format == "AH"){
//             format = "CE";
//         }
//         if(selected_format = "CE"){
//             format = "AH";
//         }
//         if(from_date !== null){
//             from_year = from_date[0];
//             from_month = from_date[1];
//             from_day = from_date[2];
//         }
//         if(to_date !== null){
//             to_year = to_date[0];
//             to_month = to_date[1];
//             to_day = to_date[2];
//         }
//         if(format == "AH"){
//             if(from_date !== null){
//                 var hijri_from_month = hijri_month(from_month);
//                 var from_string = `${from_day} ${hijri_from_month}, ${from_year}`;
//             }
//             if(to_date !== null){
//                 var hijri_to_month = hijri_month(to_month);
//                 var to_string = `${to_day} ${hijri_to_month}, ${to_year}`
//             }
//         }
        
//         var val = `${format}: ${from_string} - ${to_string}`;
//         console.log(val);

//         $('#other-date-format').html(val)
//     }

//     function islToChr(NumberofDays) {
//         var date = getter("hijri");
//         y = date[0];
//         m = date[1];
//         d = date[2];

//         jd = intPart((11 * y + 3) / 30) + 354 * y + 30 * m - intPart((m - 1) / 2) + d + 1948440 - 385
//         jd = jd + NumberofDays
//         $("#jd").val(jd)
//         $("#weekday").val(weekDay(jd % 7))
//         // setOtherDate("CE",from_date=date);
        
//         if (jd > 2299160) {
//             l = jd + 68569
//             n = intPart((4 * l) / 146097)
//             l = l - intPart((146097 * n + 3) / 4)
//             i = intPart((4000 * (l + 1)) / 1461001)
//             l = l - intPart((1461 * i) / 4) + 31
//             j = intPart((80 * l) / 2447)
//             d = l - intPart((2447 * j) / 80)
//             l = intPart(j / 11)
//             m = j + 2 - 12 * l
//             y = 100 * (n - 49) + i + l
//         } else {
//             j = jd + 1402
//             k = intPart((j - 1) / 1461)
//             l = j - 1461 * k
//             n = intPart((l - 1) / 365) - intPart(l / 1461)
//             i = l - 365 * n + 30
//             j = intPart((80 * i) / 2447)
//             d = i - intPart((2447 * j) / 80)
//             i = intPart(j / 11)
//             m = j + 2 - 12 * i
//             y = 4 * k + n + i - 4716
//         }
//         setter([y, m, d], "gregorian")
//     }

//     setup_and_bind();
// })