# Converted pascal method from:
# http://www.efg2.com/Lab/ScienceAndEngineering/Spectra.htm

do ->
	
	GAMMA = -> 0.8
	INTENSITY_MAX = -> 255
	
	# Convert wavelength to RGB
	exports.wavelengthToRGB = (wavelength) ->
		
		red = undefined
		green = undefined
		blue = undefined
		factor = undefined
		
		adjust = (color, factor) ->
			if color is 0
				0
			else
				Math.round INTENSITY_MAX() * Math.pow((color * factor), GAMMA())
		
		w = Math.round wavelength
		if w >= 380 and w <= 439
			red = -(w - 440) / (440 - 380)
			green = 0
			blue = 1
		else if w >= 440 and w <= 489
			red = 0
			green = (w - 440) / (490 - 440)
			blue = 1
		else if w >= 490 and w <= 509
			red = 0
			green = 1
			blue = -(w - 510) / (510 - 490)
		else if w >= 510 and w <= 579
			red = (w - 510) / (580 - 510)
			green = 1
			blue = 0
		else if w >= 580 and w <= 644
			red = 1
			green = -(w - 645) / (645 - 580)
			blue = 0
		else if w >= 645 and w <= 780
			red = 1
			green = 0
			blue = 0
		else
			red = 0
			green = 0
			blue = 0
		
		# Let the intensity fall off near the vision limits
		if w >= 380 and w <= 419
			factor = 0.3 + 0.7*(w - 380) / (420 - 380)
		else if w >= 420 and w <= 700
			factor = 1
		else if w >= 701 and w <= 780
			factor = 0.3 + 0.7*(780 - w) / (780 - 700)
		else
			factor = 0
		
		{r: adjust(red, factor), g: adjust(green, factor), b: adjust(blue, factor)}
