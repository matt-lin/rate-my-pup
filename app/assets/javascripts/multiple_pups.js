$(document).ready(function() {
    $('#multiple_breeds').change(function(e) {
        $("#secondary-breed").toggle(this.checked);
    });
});