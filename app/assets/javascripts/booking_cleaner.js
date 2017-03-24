$(document).on('change', '#city_booking', function(){
  $.ajax({ url: '/bookings/edit',
    data: 'selectedCity=' + this.value,
    success: function(data) {
      $('#cleaners').html(data);
    }
  })
});

$(document).ready(function() {
	// get current URL path and assign 'active' class
    $('.navbar li').removeClass('active');
	var pathname = window.location.pathname;
	$('.nav > li > a[href="'+pathname+'"]').parent().addClass('active');
})
