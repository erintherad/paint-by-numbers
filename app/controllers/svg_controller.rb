class SvgController < ApplicationController
	def create
		# accept image data from request
		image = Magick::Image.read(params[:file].tempfile.path).first
		# set output format
		image.format = 'pnm'
		# random temp file name
		file_name = "/tmp/#{SecureRandom.hex}"
		# resize and posterize using imagemagick
		image.resize_to_fill(500, 500).posterize(2).write(file_name)
		# use autotrace to generate svg
		svg = `autotrace --input-format pnm --output-format svg #{file_name}`

		# return svg string to the browser
		render json: {svg: svg}
	end
end
