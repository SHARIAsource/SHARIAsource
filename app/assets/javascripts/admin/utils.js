(function() {
    'use strict'

    $(document).on('click', '#document_use_content_password', function() {
        // Note that we set the single hidden var value from either one of two
        // checkboxes that exist in the page (based on document scan type.)
        var div = $('div.end.content_password')
        var hidden_input = $('#document_content_password')
        if ($(this).prop('checked')) {
            div.show()
            hidden_input.val( hidden_input.data('password') )
        } else {
            div.hide()
            hidden_input.val('')
        }
    })


    function hcWatcher(event) {
        console.log('HC.event:...')
        console.log(event)
    }
    window.addEventListener("hashchange", hcWatcher, false);
    console.log('loaded utils')
}())
