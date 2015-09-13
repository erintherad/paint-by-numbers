# CJ: nice job on this image-processing logic!
# any type of processing in the controller that's not directly
# part of request/response is a good candidate for a service class
# read more here: https://blog.engineyard.com/2014/keeping-your-rails-controllers-dry-with-services
class SvgController < ApplicationController
	def create
		# accept image data from request
		image = Magick::Image.read(params[:file].tempfile.path).first
		# set output format
		image.format = 'pnm'
		# random temp file name
		file_name = "/tmp/#{SecureRandom.hex}"
		# resize and posterize using imagemagick
		image.resize_to_fill(500, 500).posterize(3).write(file_name)
		# use autotrace to generate svg
		svg = `autotrace --input-format pnm --output-format svg #{file_name}`

		# return svg string to the browser
		render json: {svg: svg}
	end
end
