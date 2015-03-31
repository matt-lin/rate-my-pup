$(document).ready(function() {
          $("#slider-breeder").slider({
              animate: true,
              value: 0,
              min: 0,
              max: 5,
              step: 1,
              slide: function(event, ui) {
                  update(1,ui.value); //changed
              }
          });
          

          $("#slider-health").slider({
              animate: true,
              value: 0,
              min: 0,
              max: 5,
              step: 1,
              slide: function(event, ui) {
                  update(2,ui.value); //changed
              }
          });
          $("#slider-train").slider({
              animate: true,
              value: 0,
              min: 0,
              max: 5,
              step: 1,
              slide: function(event, ui) {
                  update(3,ui.value); //changed
              }
          });
          $("#slider-social").slider({
              animate: true,
              value: 0,
              min: 0,
              max: 5,
              step: 1,
              slide: function(event, ui) {
                  update(4,ui.value); //changed
              }
          });
          $("#slider-energy").slider({
              animate: true,
              value: 0,
              min: 0,
              max: 5,
              step: 1,
              slide: function(event, ui) {
                  update(5,ui.value); //changed
              }
          });
          $("#slider-sympatico").slider({
              animate: true,
              value: 0,
              min: 0,
              max: 5,
              step: 1,
              slide: function(event, ui) {
                  update(6,ui.value); //changed
              }
          });

          //Added, set initial value.
          $("#health").val(0);
          $("#breeder").val(0);
          $("#train").val(0);
          $("#social").val(0);
          $("#energy").val(0);
          $("#sympatico").val(0);
          // $("#breeder-label").val(0);
          // $("#health-label").val(0);
          // $("#train-label").val(0);
          // $("#social-label").val(0);
          // $("#energy-label").val(0);
          // $("#sympatico-label").val(0);
          
          update();
      });

      //changed. now with parameter
      function update(slider,val) {
        //changed. Now, directly take value from ui.value. if not set (initial, will use current value.)
        var $breeder = slider == 1?val:$("#breeder").val();
        var $health = slider == 2?val:$("#health").val();
        var $train = slider == 3?val:$("#train").val();
        var $social = slider == 4?val:$("#social").val();
        var $energy = slider == 5?val:$("#energy").val();
        var $sympatico = slider == 6?val:$("#sympatico").val();
        /* commented
        $amount = $( "#slider" ).slider( "value" );
        $duration = $( "#slider2" ).slider( "value" );
         */

        // $("#breeder-label").val($breeder);
        // $("#health-label").val($health);
        // $("#train-label").val($train);
        // $("#social-label").val($social);
        // $("#energy-label").val($energy);
        // $("#sympatico").val($sympatico);
        $("#breeder-label").attr('value', $breeder);
        $("#health-label").attr('value', $health);
        $("#train-label").attr('value', $train);
        $("#social-label").attr('value', $social);
        $("#energy-label").attr('value', $energy);
        $("#sympatico").attr('value', $sympatico);
        // $total = "$" + ($amount * $duration);
        // $( "#amount" ).val($amount);
        // $( "#amount-label" ).text($amount);
        // $( "#duration" ).val($duration);
        
        // $( "#total" ).val($total);
        // $( "#total-label" ).text($total);

        $('#slider-breeder a').html('<label><span class="fa fa-paw"></span>');
        $('#slider-health a').html('<label><span class="fa fa-paw"></span>');
        $('#slider-train a').html('<label><span class="fa fa-paw"></span>');
        $('#slider-social a').html('<label><span class="fa fa-paw"></span>');
        $('#slider-energy a').html('<label><span class="fa fa-paw"></span>');
        $('#slider-sympatico a').html('<label><span class="fa fa-paw"></span>');
        // $('#slider-health a').html('<label><span class="glyphicon glyphicon-chevron-left"></span> '+$health+' <span class="glyphicon glyphicon-chevron-right"></span></label>');
        // $('#slider-train a').html('<label><span class="glyphicon glyphicon-chevron-left"></span> '+$train+' <span class="glyphicon glyphicon-chevron-right"></span></label>');
        // $('#slider-breeder a').html('<label><span class="fa fa-paw"></span>');
      }