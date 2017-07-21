var ready;
ready = function() {
    // TODO: This assumes sSearch, if present, is the first search term
    var terms = window.location.search.replace('?', '').split('sSearch=');
    var q = terms.length == 2 ? decodeURIComponent(terms[1]) : null;
    //console.log('Loading search term: ' + q);

    var oTable = $('#document-datatable').dataTable({
        sPaginationType: 'full_numbers',
        search: {
            search: q
        },
        bJQueryUI: true,
        bProcessing: true,
        bServerSide: true,
        sAjaxSource: $('#document-datatable').data('source'),
        "columnDefs": [{
            "targets": -1,
            "className": 'details-control',
            "orderable": false,
            "searchable": false
        },
        {
            "targets": -3,
            "className": 'reviewed'
        }]
    });

    var search_box = $('#document-datatable_filter input');
    search_box.unbind();
    search_box.bind('keyup', function(e) {
        if (e.keyCode == 13) {
            oTable.fnFilter(this.value);
        }
    });

    $('.document-status-nav-link').bind('click', function(e) {
        e.preventDefault();
        var link = $(this).attr('href');
        var q = search_box.val();
        if (!!q) {
            link += '?sSearch=' + encodeURIComponent(q);
        }
        window.location.href = link;
    });
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
