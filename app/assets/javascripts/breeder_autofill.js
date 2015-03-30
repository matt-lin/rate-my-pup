/**
 * Created by mcgourtyalex on 3/29/15.
 */

var BreederAutofill = {

    // setup adds #breeder_entry and #autofills
    // setup sets a callback for #breeder_entry keyup
    setup: function() {
        var fillzone = $('<br /><input id="breeder_entry" type="text"><div id="autofills"></div>');
        fillzone.insertAfter($('#breeders_breeder_name'));
        console.log("setup works");
        $('#breeder_entry').keyup( function() {
            BreederAutofill.breeder_ajax()
        });
    }
    // ajax call to breeder/match/
    // GET call with params name and limit
    ,breeder_ajax: function () {
        console.log("calling ajax");
        var prefix = $("#breeder_entry").val();
        console.log(prefix);
        $.ajax({
            type: 'GET',
            url: '/breeder/match',
            data: {
                "name": prefix,
                "limit": 10
            },
            timeout: 5000,
            success: BreederAutofill.breeders_add
        })
    }
    // callback for breeder_ajax creates links for max 10 relevant breeders
    // class .autofills wraps each autofill
    // id #breeder_entry contains .autofills
    ,breeders_add: function (data, requestStatus, xhrObject) {

        $('#autofills').empty();
        for (num in data) {
            var id = data[num].id;
            var name = data[num].name;
            console.log(name + " " + id);
            var html = '<div class="autofills"><a href="breeder/' + id + '">' + name + '</a></div>';
            console.log(html);
            var autofill = $(html);
            $('#autofills').append(autofill);
        }
    }


};



$(document).ready(function () {
    console.log("document works");
    $(BreederAutofill.setup);
});