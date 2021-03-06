// Generated by CoffeeScript 1.6.3
(function() {
  var canvas, character, cv, getGray, getImg, img, toCharacter, window;

  window = this;

  character = document.body;

  getGray = function(r, g, b) {
    return 0.299 * r + 0.578 * g + 0.114 * b;
  };

  toCharacter = function(grey) {
    if (grey <= 30) {
      return '@';
    }
    if (grey > 30 && grey <= 60) {
      return '&';
    }
    if (grey > 60 && grey <= 120) {
      return '$';
    }
    if (grey > 120 && grey <= 150) {
      return '*';
    }
    if (grey > 150 && grey <= 180) {
      return 'o';
    }
    if (grey > 180 && grey <= 210) {
      return '!';
    }
    if (grey > 210 && grey <= 240) {
      return ';';
    }
    return '&nbsp;';
  };

  canvas = document.createElement('canvas');

  cv = canvas.getContext('2d');

  img = new Image();

  img.onload = function() {
    var characterStr, h, imgData, imgDataArr, imgDataHeight, imgDataWidth, imgHeight, imgWidth, w;
    w = h = 0;
    character.style.width = img.width + 'px';
    imgWidth = img.width;
    imgHeight = img.height;
    canvas.width = imgWidth;
    canvas.height = imgHeight;
    cv.drawImage(img, 0, 0);
    imgData = cv.getImageData(0, 0, imgWidth, imgHeight);
    imgDataArr = imgData.data;
    imgDataWidth = imgData.width;
    imgDataHeight = imgData.height;
    characterStr = '';
    for (h = 0; h < imgDataHeight; h += 12) {
		var p = '<p>';
		for (w = 0; w < imgDataWidth; w += 6) {
			var index = (w + imgDataWidth * h) * 4;
			var r = imgDataArr[index + 0];
			var g = imgDataArr[index + 1];
			var b = imgDataArr[index + 2];
			var gray = getGray(r, g, b);
			p += toCharacter(gray);
		}
		p += '</p>';
		characterStr += p;
	};
    character.innerHTML = characterStr;
  };

  getImg = function(file) {
    var reader;
    reader = new FileReader();
    reader.readAsDataURL(fileBtn.files[0]);
    reader.onload = function() {
      img.src = reader.result;
    };
  };

  window.imgToChar = function(opts) {
    character = opts.container || character;
    opts.file.onchange = getImg;
  };

}).call(this);
