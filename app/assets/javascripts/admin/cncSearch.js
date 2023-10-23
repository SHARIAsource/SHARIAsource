$(document).on('turbolinks:load', function() {

    $('#cncSearch').select2({
        ajax: {
            url: 'https://staging.digitalseem.org/api/people',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    search: params.term, // search query
                    page: params.page || 1 // for pagination
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;

                return {
                    results: data.people.map(function (item) {
                        return {
                            id: item.id,
                            text: item.searchable_name
                        };
                    }),
                    pagination: {
                        more: (params.page * 10) < data.list.count // assuming 10 items per page
                    }
                };
            },
            cache: true
        },
        minimumInputLength: 1,
        placeholder: 'Search Courts and Canons Metadata People',
    });

    $('#cncSearch').on('change', function (e) {
        var data = $('#cncSearch').select2('data')[0]; // Get the first selected item
    
        // If there is data, get the id
        if(data && data.id){
            var id = data.id;
    
            // Get the full data
            var person_url = `https://staging.digitalseem.org/api/people/${id}`;
            // Fetch the detailed data from the API
            $.get(person_url, function(response) {
                // Convert the data to a string format suitable for storage, e.g., JSON string
                var jsonData = JSON.stringify(response);
    
                // Store in the hidden field
                $('#author_cnc_metadata_jsonb').val(jsonData);
            });
        } else {
            // There is no data; clear the hidden field too
            $('#author_cnc_metadata_jsonb').val('');
        }
    });
    
});