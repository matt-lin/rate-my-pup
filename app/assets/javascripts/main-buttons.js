/**
 * Created by mcgourtyalex on 4/14/15.
 */

var MainButtons = {

    // setup sets a callback for #breeder_find keyup
    setup: function() {
        $('.button-a').click( function() {
            $('.box-a').toggleClass("hidden");
        }).hover( function() {
            $('#tagline-text').html("Keep breeders <strong>honest</strong> by rating your pup");
        });

        $('.button-b').click( function() {
            $('.box-b').toggleClass("hidden");
        }).hover( function() {
            $('#tagline-text').html("Find the <strong>right</strong> breed for you");
        });

        $('.button-c').click( function() {
            $('.box-c').toggleClass("hidden");
        }).hover( function() {
            $('#tagline-text').html("Find a pup from a <strong>reliable</strong> breeder");
        });
    }
};


$(document).ready(function () {
    $(MainButtons.setup);
});