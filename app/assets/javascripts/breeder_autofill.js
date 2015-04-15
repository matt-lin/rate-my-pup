/**
 * Created by mcgourtyalex on 3/29/15.
 */


var BreederAutofill = {

    // setup sets a callback for #breeder_find keyup
    setup: function() {
        $('#breeder_find').keyup( function() {
            BreederAutofill.breeder_ajax('find')
        });
        $('#breeder_form').keyup(function() {
            BreederAutofill.breeder_ajax('form')
        });
    }

    // ajax call to breeder/match/
    // GET call with params name and limit
    ,breeder_ajax: function (success_type) {

        // grab prefix from either find or form text
        var prefix = success_type == 'find' ? $("#breeder_find").val() : $('#breeder_form').val();
        $.ajax({
            type: 'GET',
            url: '/breeder/match',
            data: {
                "name": prefix,
                "limit": 10
            },
            timeout: 5000,
            // callback designated by selection of find or form
            success: success_type == 'find' ? BreederAutofill.breeders_add_find : BreederAutofill.breeders_add_form
        })
    }

    // callback for breeder_ajax creates links for max 10 relevant breeders
    // class .autofills wraps each autofill
    // id #breeder_find contains .autofills
    // class .autofill_link links to each breeder's average ratings page
    ,breeders_add_find: function (data, requestStatus, xhrObject) {

        $('#autofills').empty();
        for (num in data) {
            var id = data[num].id;
            var name = data[num].name;
            var html = '<li class="autofills list-group-item"><a class="autofill_link" href="breeder/search_name?&breeders%5Bbreeder_name=' + name + '">' + name + '</a></li>';
            var autofill = $(html);
            $('#autofills').append(autofill);

            // bind autofill on scroll over option
            autofill.mouseover(function() {
                var text = $(this).text();
                $('#breeder_find').val(text);
            });
        }

        var html = '<li class="autofills list-group-item"><a class="autofill_link" href="breeders/new">' + "Don't see it? Add a new breeder" + '</a></li>';
        var autofill = $(html);
        $('#autofills').append(autofill);
    }

    ,breeders_add_form: function (data, requestStatus, xhrObject) {
        console.log('twerkin');
        $('#autofills').empty();
        console.log('emptied');
        console.log(data)
        for (num in data) {
            var id = data[num].id;
            var name = data[num].name;
            var html = '<div class="autofills"><a class="autofill_link">' + name + '</a></div>';
            var autofill = $(html);
            console.log($('#autofills').html());
            $('#autofills').append(autofill);
            console.log($('#autofills').html());

            // bind autofill on scroll over option
            autofill.mouseover(function() {
                var text = $(this).text();
                $('#breeder_form').val(text);
            });

            // on click, fill form name value and form id value
            function autofill_return(id) {
                return function () {
                    var text = $(this).text();
                    $('#autofills').empty();
                    $('#breeder_form').val(text);
                    $('#invisible_id').val(id);
                }
            }

            autofill.click(autofill_return(id));
        }

        // if a new breeder is selected, let id be -1
        var html = '<div class="autofills"><a class="autofill_link">' + "Don't see it? Add a new breeder" + '</a></div>';
        var new_breeder = $(html);
        $('#autofills').append(new_breeder);

        new_breeder.click(function () {
            var text = $(this).text();
            $('#autofills').empty();
            $('#breeder_form').val(text);
            $('#invisible_id').val(-1);
        });

    }
};



$(document).ready(function () {
    $(BreederAutofill.setup);
});