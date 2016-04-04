var page   = require('webpage').create(),
    system = require('system'),
    fs = require('fs'),
    t, address;

if (system.args.length === 1) {
    console.log('Usage: screenshotter.js <some URL> <title>');
    phantom.exit();
}

address = system.args[1];
photoTitle = system.args[2];

console.log("checking address");

page.viewportSize = {
    width:  640,
    height: 640
};

page.settings.userAgent = "internal screenshotter";

page.customHeaders = {
    Referer: address
};



page.open(address, function(status) {
    if (status !== 'success') {
        console.log('failed to load address');
        try {
            fs.write("log/phantomjs_error.txt", "Something went wrong with url: " + address + " at " + photoTitle + ".jpg", 'w');
        } catch(e) {
            console.log(e);
        }
        phantom.exit();
    } else {
        page.evaluate(function() {
            var body = document.body;
            // body.style.backgroundColor = '#fff';
        });
        window.setTimeout(function () {
            console.log("rendering " + address + " to " + photoTitle + ".jpg");
            page.render('tmp/' + photoTitle + '.jpg', {format: 'jpeg', quality: 100});
            try {
                fs.write("log/phantomjs_check.txt", "url: " + address + " at " + photoTitle + ".jpg", 'w');
            } catch(e) {
                console.log(e);
            }
            phantom.exit();
        }, 200);
    }
});