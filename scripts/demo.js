// This file contains the actual JavaScript logic

var demo = (function() {
    var host;

    var demo = {
        init: function(id) {
            host = $("#" + id);
            host.html("Control Loaded");
        }
    };

    return demo;
})();