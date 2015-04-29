/**
 * Created by mcgourtyalex on 4/29/15.
 */

var PupHashTags = {

    hashtags: [
        "#EasyToObedienceTrain",
        "#HardToObedienceTrain",
        "#EasyToHouseTrain",
        "#HardToHouseTrain",
        "#HighEnergy",
        "#CalmPersonality",
        "#BarksALot",
        "#VeryQuiet",
        "#OnePersonDog",
        "#FriendlyTowardEveryone",
        "#UnpredictableWithStrangers",
        "#UnpredictableWithChildren",
        "#Independent",
        "#ConstantCompanionAroundHome",
        "#GreatWithOtherDogs",
        "#UnpredictableWithOtherDogs",
        "#GreatWithCats&OtherSmallAnimals",
        "#UnpredictableWithCats&OtherSmallAnimals",
        "#LovesToPlayBall&Fetch",
        "#WellMannered&CanGoAnywhereWithMe",
        "#ShedsALot",
        "#CoatNeedsFrequentGrooming",
        "#EatsPoopOrOtherDisgustingThings"
    ]

    ,num: 0

    ,setup: function() {
        console.log('working');
        console.log(PupHashTags.selected);
        for (hashtag in PupHashTags.hashtags) {
            $('<a number="' + hashtag + '" class="hashtag">' + PupHashTags.hashtags[hashtag] + ' </a>').appendTo('#hashtags').click( function() {

                if ($(this).attr('class').indexOf("hashtag_selected") > -1) {
                    $(this).removeClass('hashtag_selected');
                    PupHashTags.num--;
                    if ($('#invisible_hashtag_1').val() == $(this).attr('number')) {
                        $('#invisible_hashtag_1').val("")
                    } else if ($('#invisible_hashtag_2').val() == $(this).attr('number')) {
                        $('#invisible_hashtag_2').val("")
                    } else {
                        $('#invisible_hashtag_3').val("")
                    }
                } else {
                    if (PupHashTags.num < 3) {
                        this_id = parseInt($(this).attr('number'))
                        console.log(this_id);
                        if ($('#invisible_hashtag_1').val() == "") {
                            $('#invisible_hashtag_1').val(this_id)
                        } else if ($('#invisible_hashtag_2').val() == "") {
                            $('#invisible_hashtag_2').val(this_id)
                        } else {
                            $('#invisible_hashtag_3').val(this_id)
                        }


                        $(this).addClass('hashtag_selected');
                        PupHashTags.num++;
                    }
                }
            });
        }
    }
};


$(document).ready(function () {
    $(PupHashTags.setup);
});