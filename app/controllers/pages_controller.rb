class PagesController < ApplicationController

	def home
	end

	def about
	end

	def gallery
		@paintings = Painting.all
	end
	
end
