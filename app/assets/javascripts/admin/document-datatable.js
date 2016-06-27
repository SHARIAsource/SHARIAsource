var ready;
ready = function() {
    $('#document-datatable').DataTable({
        paginationType: 'full_numbers'
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);
