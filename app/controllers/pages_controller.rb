class PagesController < ApplicationController

	def home
	end

	def about
	end

	def gallery
		@paintings = Painting.all.order(created_at: :desc)
	end
	
end
