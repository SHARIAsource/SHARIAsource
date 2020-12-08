document.addEventListener("turbolinks:load", function() {
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

    $('#search_filters_date_format').change(function () {
        let calendar_type_code = $(this).val();
        let calendar_type = convertShortcode(calendar_type_code);
        var calendar = $.calendars.instance(calendar_type);

        var convert = function (value) {
            return (!value || typeof value != 'object' ? value :
                calendar.fromJD(value.toJD()));
        };
        $('.is-calendarsPicker').each(function () {
            var current = $(this).calendarsPicker('option');

            $(this).calendarsPicker('option', {
                calendar: calendar,
                onSelect: null,
                onChangeMonthYear: null,
                defaultDate: convert(current.defaultDate),
                minDate: convert(current.minDate),
                maxDate: convert(current.maxDate)
            }).
            calendarsPicker('option', {
                onSelect: current.onSelect,
                onChangeMonthYear: current.onChangeMonthYear
            });
        });
    });

    // Onload
    $('.filter-date .filter-block .filter-content').show();
    var calendar = $.calendars.instance('gregorian');
    $("#search_filters_date_from").calendarsPicker({calender: calendar});
    $("#search_filters_date_to").calendarsPicker({calender: calendar});
});