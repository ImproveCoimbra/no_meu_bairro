var MAX_WIDTH = 200;
var MAX_HEIGHT = 300;

function addSmallerImagesToForm (done) {
	var $fileInputs, $newReport;

	$newReport = $("#new_report");
	$fileInputs = $("#new_report input[type=file]");

	$fileInputs.each(function (argument) {
		var $fileInput, files;

		$fileInput = $(this);
		
		files = $fileInput[0].files;

		if (files.length > 0 && files[0].type.match(/image.*/)) {
			addSmallerImage($fileInput, $newReport, files[0]);
		}
	});
}

var canvas = $("<canvas></canvas>")[0];
var ctx = canvas.getContext("2d");

//Based on https://hacks.mozilla.org/2011/01/how-to-develop-a-html5-image-uploader/
function addSmallerImage ($fileInput, $form, file) {
	var img = document.createElement("img");
	var reader = new FileReader();  
	
	reader.onload = function(e) {
		var index, dataurl, $hiddenInput;

		img.src = e.target.result;
		
		//Do the resizing
		var width = img.width;
		var height = img.height;
		if (width > height) {
		  if (width > MAX_WIDTH) {
		    height *= MAX_WIDTH / width;
		    width = MAX_WIDTH;
		  }
		} else {
		  if (height > MAX_HEIGHT) {
		    width *= MAX_HEIGHT / height;
		    height = MAX_HEIGHT;
		  }
		}
		canvas.width = width;
		canvas.height = height;
		ctx.drawImage(img, 0, 0, width, height);

		//Convert the resize image in the cavas to base 64
		dataurl = canvas.toDataURL("image/jpeg");

		//TODO: remove the leading stuff from the data url

		//Get the timestamp out of the name, which is like 'report[photos_attributes][1392484594913][attachment]'
		index = $fileInput.prop("name").split("[")[2].split("]")[0]

		//Adds the hidden input that contains the image as base64
		$hiddenInput = $('<input type="hidden" />');
		$hiddenInput.prop({
			value: dataurl,
			name: "report[photos_attributes_base64][" + index + "]"
		});
		$form.append($hiddenInput);

		//TODO: this may be necessary in FF
		//var file = canvas.mozGetAsFile("foo.png");
	}
	reader.readAsDataURL(file);
}