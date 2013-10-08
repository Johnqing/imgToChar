window = this
character = document.body
# 获取灰度
# getImageData方法返回一个对象，每个像素点的rgba值都保存在其data属性下面，这是一个一位数组，
# 也就是说，rgba分别对应一个值，然后接着就是下一个像素点的rgba，
# 假设getImageData.data的值为[1,2,3,4,5,6,7,8]，
# 那么getImageData对象范围就包含了2个像素点，
# 第一个像素点的rgba值分别是1,2,3,4，第二个像素点的就是5,6,7,8。
# 因此，我们在取每个像素点的rgba值的时候其index应该在像素点的索引值上乘以4，
# 然后通过getGray()计算灰度。
getGray = (r, g, b) ->
	0.299 * r + 0.578 * g + 0.114 * b

# 将灰度转为字符
toCharacter = (grey) ->
	if grey <= 30 
		return '@'
	if grey > 30 and grey <= 60
		return '&'
	if grey > 60 and grey <= 120
		return '$'
	if grey > 120 and grey <= 150
		return '*'
	if grey > 150 and grey <= 180
		return 'o'
	if grey > 180 and grey <= 210
		return '!'
	if grey > 210 and grey <= 240
		return ';'
	return '&nbsp;'

# canvas相关
canvas = document.createElement 'canvas'

cv = canvas.getContext '2d'

# 图片相关
img = new Image()
# 加载完成后图片处理
img.onload = ->
	character.style.width = img.width + 'px'
	h = w = 0
	imgWidth = img.width
	imgHeight = img.height
	canvas.width = imgWidth
	canvas.height = imgHeight

	# 开始绘制
	cv.drawImage img, 0, 0

	imgData = cv.getImageData 0, 0, imgWidth, imgHeight
	imgDataArr = imgData.data
	imgDataWidth = imgData.width
	imgDataHeight = imgData.height

	characterStr = ''

	`for (; h < imgDataHeight; h += 12) {
		var p = '<p>';
		for (; w < imgDataWidth; w += 6) {
			var index = (w + imgDataWidth * h) * 4;
			var r = imgDataArr[index + 0];
			var g = imgDataArr[index + 1];
			var b = imgDataArr[index + 2];
			var gray = getGray(r, g, b);
			p += toCharacter(gray);
		}
		p += '</p>';
		characterStr += p;
	}`
	character.innerHTML = characterStr;
	return
# 获取图片
getImg = (file) ->
	reader = new FileReader()
	reader.readAsDataURL fileBtn.files[0]
	reader.onload = ->
		img.src = reader.result
		return
	return

window.imgToChar = (opts) ->
	character = opts.container or character
	
	opts.file.onchange = getImg
	return 
