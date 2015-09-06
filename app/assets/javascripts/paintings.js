Dropzone.autoDiscover = false;

$(function() {
	var colors = new Set();
	var activeColor = null;
	var colorTemplate = _.template($('#color-template').html());

	var canvas = new fabric.Canvas('canvas', {width: 500, height: 500});

	var myDropzone = new Dropzone("#fileUpload");

	// when the file is done being rendered to svg
	myDropzone.on("success", function(file, response) {
		// load the svg string from the response
		fabric.loadSVGFromString(response.svg, function(objects, options) {
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

			// add the paths to the canvas and render
			canvas.renderAll();
		});
	});

	var addSwatchEventHandlers = function() {
		$('.swatch').on('click', function(event) {
			activeColor = $(this).attr('data-color');
		});
	};

	
	canvas.on('mouse:down', function(options) {
		// find path at click
		var path = options.target;
		// set path fill color
		path.setFill(activeColor);
		// re-render the canvas
		canvas.renderAll();
	});
});