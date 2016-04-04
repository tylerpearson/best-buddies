$(function() {

    var $body = $('body');

    if ($body.hasClass('analyzer-processing')) {
        NProgress.start({showSpinner: false});
    }

    setTimeout(function() {
        setInterval(function() {
            if ($body.hasClass('analyzer-processing')) {
                $.getJSON('/users/results_check/' + window.userId + '.json', function(data) {
                    if (data.hasResults === true) {
                        NProgress.done();

                        setTimeout(function() {
                            window.location = "/results/" + data.username;
                        }, 500);
                    }
                });
            }
        }, 1000);
    }, 12500); // set an initial delay on this because it'll take some time before any results come in anyway

});
