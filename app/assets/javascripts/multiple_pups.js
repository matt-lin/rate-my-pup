$(document).ready(function() {
   $('input[type="radio"]').click(function() {
       if($(this).val() == 'Mixed Breed') {
            $('#secondary-breed').show();           
       }
       else {
            $('#secondary-breed').hide();
            $('#secondary-breed-selector').select("None"); 
       }
   });
});