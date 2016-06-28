var ready;
ready = function() {
    $('#document-datatable').DataTable({
        sPaginationType: 'full_numbers',
        bJQueryUI: true,
        bProcessing: true,
        bServerSide: true,
        sAjaxSource: $('#document-datatable').data('source'),
        "columnDefs": [ {
          "targets": -1,
          "className": 'details-control',
          "orderable": false,
          "searchable":false
        } ]
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);
