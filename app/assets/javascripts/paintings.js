Dropzone.autoDiscover = false;

$(function() {
	var colors;
	var activeColor = "#FFFFFF"; // default to white
	var colorTemplate = _.template($('#color-template').html());

	var canvas = new fabric.Canvas('canvas', { width: 500, height: 500, renderOnAddRemove: false });

	var myDropzone = new Dropzone("#fileUpload");

	// when the file is done being rendered to svg
	myDropzone.on("success", function(file, response) {
		// load the svg string from the response
		fabric.loadSVGFromString(response.svg, function(objects, options) {
			// reset canvas
			canvas.clear();
			// remove all color swatches
			$('#swatches').empty();
			// reset colors Set
			colors = new Set();
			// reset activeColor
			activeColor = "#FFFFFF";

			// for each path
			for(var i = 0; i < objects.length; i++) {

				var path = objects[i];
				// collect unique colors
				colors.add(path.getFill());
				// set color to white
				path.setFill('#FFFFFF');
				// draw the outline
				path.setStroke('rgb(0,0,0)');
				// remove user interactions, but still fire events
				path.selectable = false;
				// match clicks to exact path, not the bounding box
				path.perPixelTargetFind = true;
				canvas.add(path);
			}

			// add the paths to the canvas and render
			canvas.renderAll();
			$('#download').attr('href', canvas.toDataURL({ format: 'jpeg' }));

			// iterate through colors
			var index = 0;
			colors.forEach(function(color) {
				index++;
				var colorInfo = {
					index: index,
					color: color
				};
				// pass each color object through template and append to view
				var $swatch = $(colorTemplate(colorInfo));
				$('#swatches').append($swatch);
				addSwatchEventHandlers();
			});
		});
	});

	// choose color from key
	var addSwatchEventHandlers = function() {
		$('.color-picker').on('click', function(event) {
			$('.color-picker').removeClass('active');
			$(this).addClass('active');
			activeColor = $(this).attr('data-color');
			$('#eraser').removeClass('active');
		});
	};

	// erase tool
	$('#eraser').on('click', function(event) {
		event.preventDefault();
		$('#eraser').toggleClass('active');
		activeColor = '#ffffff';
	});

	// reset tool
	$('#reset').on('click', function(event) {
		event.preventDefault();
		var paths = canvas.getObjects();
		for(var i = 0; i < paths.length; i++) {
			paths[i].setFill('#FFFFFF');
		}
		canvas.renderAll();
		$('#download').attr('href', canvas.toDataURL({ format: 'jpeg' }));
	});

	canvas.on('mouse:move', function(options) {
		if($('#eraser').hasClass('active')) {
			canvas.setCursor('url(/img/eraser.png),default');
		} else {
			canvas.setCursor('url(/img/paint-cursor.png),default');
		}
	});

	canvas.on('mouse:down', function(options) {
		// find path at click
		var path = options.target;
		// set path fill color
		path.setFill(activeColor);
		// re-render the canvas
		canvas.renderAll();
		$('#download').attr('href', canvas.toDataURL({ format: 'jpeg' }));
		$('input#painting_url').attr('value', canvas.toDataURL({ format: 'jpeg' }));
	});
});