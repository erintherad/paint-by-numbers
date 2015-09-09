class FavoritesController < ApplicationController

	def create
		painting = Painting.find_by_id(favorite_params[:painting_id])
		if current_user.favorite_paintings.include? painting
			render nothing: true
		else
			@favorite = current_user.favorites.new(favorite_params)
			if @favorite.save
				render json: @favorite
			else
				render json: { errors: @favorite.errors.full_messages }, status: :unprocessable_entity
			end
		end
	end

	private
		def favorite_params
			params.require(:favorite).permit(:painting_id)
		end


end
