// This file contains the actual JavaScript logic

var demo = (function () {
    var host, table;
    var grid = {};

    var demo = {
        init: function (id) {
            host = $("#" + id);
            table = $("<table>");
            host.append(table);

            for (var row = 0; row < 3; row++) {
                grid[row] = {
                    $: $("<tr>"),
                    index: row,
                    cols: {}
                };
                table.append(grid[row].$);
                for (var col = 0; col < 3; col++) {
                    grid[row].cols[col] = {
                        $: $("<td>"),
                        index: col
                    };
                    grid[row].$.append(grid[row].cols[col].$);
                };
            };
        }
    };

    return demo;
})();