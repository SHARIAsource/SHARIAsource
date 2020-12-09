document.addEventListener("turbolinks:load", function() {
    $('#contributors-table').DataTable({
        paging: false,
        searching: false,
        info: false
    });
});