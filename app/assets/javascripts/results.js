$(document).ready(function() {

    if (window.userId) {

        $('.btn-share').on('click', function(e) {
            sendSharedInfo(function() {
                setTimeout(function() {
                    showTopResults();
                }, 1000);
            });
        });

        $('.signup-form input[type="submit"]').on('click', function(e) {
            showTopResults();
        });

        function sendSharedInfo(callback) {
            $.ajax({
                url: '/users/' + window.userId,
                type: "POST",
                data: {
                        _method: 'PUT',
                        user: {
                            shared: true
                        }
                    },
                dataType: 'json',
                success: callback.call()
              })
        }
    }

    function showTopResults() {
        $('.not-verified').removeClass('not-verified');
        $('.signup-cover').addClass('hidden');
    }

});
