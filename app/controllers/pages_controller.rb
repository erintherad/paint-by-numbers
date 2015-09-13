class PagesController < ApplicationController

	def home
	end

	def about
	end

  # CJ: I would use the `paintings#index` action for the gallery since it shows all paintings
  # you can still have the custom route `/gallery` point to the `paintings#index` action
	def gallery
		@paintings = Painting.all.order(created_at: :desc).page(params[:page]).per(12)
	end
	
end
