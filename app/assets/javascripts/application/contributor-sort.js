// Adopted from https://www.w3schools.com/howto/howto_js_sort_table.asp

$(document).ready(function () {
    function sortTable(id) {
        var sortColumns = document.querySelectorAll(".sortable");
        for (i = 0; i < sortColumns.length; i++) {
            if (id == sortColumns[i].id) {
                var n = i;
            }
        }

        var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
        table = document.getElementById("contributors-table");
        switching = true;
        // Set the sorting direction to ascending
        dir = "asc";
        // Make a loop that will continue until no switching has been done
        while (switching) {
            switching = false;
            rows = table.rows;
            // Loop through all table rows except the first, which contains table headers
            for (i = 1; i < (rows.length - 1); i++) {
                // Start by saying there should be no switching:
                shouldSwitch = false;
                row = rows[i];
                nextRow = rows[i + 1];
                //Get the elements you to compare, one from current row and one from the next
                if (n == 0) {
                    x = rows[i].getElementsByTagName("th")[n];
                    y = rows[i + 1].getElementsByTagName("th")[n];
                } else {
                    x = rows[i].getElementsByTagName("td")[n - 1];
                    y = rows[i + 1].getElementsByTagName("td")[n - 1];
                }
                x = (typeof x.dataset.sort === 'undefined') ? "" : x.dataset.sort;
                y = (typeof y.dataset.sort === 'undefined') ? "" : y.dataset.sort;
                // Check if the two rows should switch place, based on the direction, asc or desc
                if (dir == "asc") {
                    if (x > y) {
                        // If so, mark as a switch and break the loop:
                        shouldSwitch = true;
                        break;
                    }
                } else if (dir == "desc") {
                    if (x < y) {
                        // If so, mark as a switch and break the loop:
                        shouldSwitch = true;
                        break;
                    }
                }
            }
            if (shouldSwitch) {
                // If a switch has been marked, make the switch and mark that a switch has been done
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                // Each time a switch is done, increase this count by 1:
                switchcount++;
            } else {
                // If no switching has been done AND the direction is "asc", set the direction to "desc" and run the while loop again. */
                if (switchcount == 0 && dir == "asc") {
                    dir = "desc";
                    switching = true;
                }
            }
        }
        // Remove asc/desc classes and add to the correct el
        [].forEach.call(document.querySelectorAll('.sortable'), function (el) {
            el.classList.remove('asc');
            el.classList.remove('desc');
        });
        el = document.querySelector(`#${id}`);
        if (dir == "asc") {
            document.querySelector(`#${id}`).classList.add('asc');
        } else {
            document.querySelector(`#${id}`).classList.add('desc');
        }
    }

    document.querySelectorAll(".sortable").forEach(col => {
        col.addEventListener("click", event => {
            sortTable(event.target.id);
        })
    })

    // set the default sort
    $('#table-name').click();

});