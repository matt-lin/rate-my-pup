var RatingPaws = {
    pos: ["first", "second", "third", "fourth", "fifth"],
    categories: ["breeder-label", "simpatico-label", "health-label", "train-label", "social-label", "energy-label"],
    unselectedColor: "#bbb",
    selectedColor: "#3399FF",
    setupCategory: function(label) {
        for (var i = 0; i < RatingPaws.pos.length; i++) {
            $("#"+label).val(1);
            $("#"+label+"-"+RatingPaws.pos[i]).on(
                "mouseover", RatingPaws.changeColors(label, RatingPaws.pos[i])
            );
            $("#"+label+"-"+RatingPaws.pos[i]).on(
                "mouseout", RatingPaws.revertColors(label, RatingPaws.pos[i])
            );
            $("#"+label+"-"+RatingPaws.pos[i]).on(
                "click", RatingPaws.setValue(label, RatingPaws.pos[i])
            );
        }
    },
    setValue: function(label, loc) {
        return function() {
            var val = RatingPaws.pos.indexOf(loc) + 1;
            //console.log(val);
            $('#'+label).val(RatingPaws.pos.indexOf(loc) + 1);
            RatingPaws.changeColors(label, loc, RatingPaws.selectedColor, true)();
        }
    },
    changeColors: function(label, loc) {
        return function() {
            var current_val = Number.parseInt($("#" + label).val()) - 1;
            var loc_val = RatingPaws.pos.indexOf(loc);
            var start = loc_val <= current_val ? loc_val : current_val;
            for (var i = start; RatingPaws.pos.indexOf(loc) >= i; i++) {
                $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.selectedColor);
            }
            for (; i < RatingPaws.pos.length; i++) {
                $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.unselectedColor);
            }
        };
    },
    revertColors: function(label, loc) {
        return function() {
            var current_val = Number.parseInt($("#" + label).val()) - 1;
            for (var i = 0; current_val >= i; i++) {
                $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.selectedColor);
            }
            for (; i < RatingPaws.pos.length; i++) {
                $("#" + label + "-" + RatingPaws.pos[i]).css("color", RatingPaws.unselectedColor);
            }
        };
    },
    setup: function() {
        for (var i = 0; i < RatingPaws.categories.length; i++) {
            RatingPaws.setupCategory(RatingPaws.categories[i]);
        }
    }
}

$(document).ready(RatingPaws.setup);