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

});