Dropzone.autoDiscover = false;

var canvas = new fabric.Canvas('canvas', {width: 500, height: 500});
var pathGroup = null;


$(function() {
	var myDropzone = new Dropzone("#fileUpload");

	// when the file is done being rendered to svg
	myDropzone.on("success", function(file, response) {
		// load the svg string from the response
		fabric.loadSVGFromString(response.svg, function(objects, options) {
			// create FabricJS paths from the svg
			// pathGroup = fabric.util.groupSVGElements(objects, options);

			// canvas.add(pathGroup);
			for(var i = 0; i < objects.length; i++) {
				var path = objects[i];
				path.setFill('#FFFFFF');
				path.setStroke('rgb(0,0,0)');
				path.selectable = false;
				path.perPixelTargetFind = true;
				// path.setStrokeWidth(0.5);
				canvas.add(path);
			}

			// add the paths to the canvas and render
			canvas.renderAll();
		});
	});

	canvas.on('mouse:down', function(options) {
		// find path at click
		var path = options.target;
		// set path fill color
		path.setFill('#ff0000');
		// re-render the canvas
		canvas.renderAll();
	});
});