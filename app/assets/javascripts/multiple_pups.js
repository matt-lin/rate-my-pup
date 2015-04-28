$(document).ready(function() {
   $('input[type="radio"]').click(function() {
       if($(this).val() == 'Mixed Breed') {
            $('#secondary-breed').show();           
       }
       else {
            $('#secondary-breed').hide();
            $("#pup_breed_2").val("None");
       }
   });
});