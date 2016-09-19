var ready;
ready = function() {
    var oTable = $('#document-datatable').dataTable({
        sPaginationType: 'full_numbers',
        bJQueryUI: true,
        bProcessing: true,
        bServerSide: true,
        sAjaxSource: $('#document-datatable').data('source'),
        "columnDefs": [{
            "targets": -1,
            "className": 'details-control',
            "orderable": false,
            "searchable": false
        }]
    });
    $('#document-datatable_filter input').unbind();
    $('#document-datatable_filter input').bind('keyup', function(e) {
        if (e.keyCode == 13) {
            oTable.fnFilter(this.value);
        }
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);
