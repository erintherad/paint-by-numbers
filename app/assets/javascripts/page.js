$(function() {

	setInterval(function() {
		var intro = $('.background1');

			if(intro.hasClass('background1')) {
				intro.removeClass('background1');
				intro.addClass('background2');
		}
	}, 750);

	setInterval(function() {
		var background = $('.background2');
		var buttonFadeIn = $('.show-button');
		if(background) {
			buttonFadeIn.css('visibility', 'visible');
		}

	}, 3000);

	$('.favorite').on('click', function() {
    // set variables
    var $favoriteIcon = $(this).find('.glyphicon');
    var $favoriteCount = $(this).next('.favorite-count');
    var count = parseInt($favoriteCount.text(), 10);

    // fill in star before ajax call for perceived speed
    $favoriteIcon.removeClass('glyphicon-star-empty').addClass('glyphicon-star');

    // ajax call to create new favorite in db
    $.post('/favorites', {
        favorite: { painting_id: $(this).attr('data-id') }
      },
      function(data) {
        console.log(data);
        // update favorite count
        $favoriteCount.text(count + 1);
      }
    );
  });

});