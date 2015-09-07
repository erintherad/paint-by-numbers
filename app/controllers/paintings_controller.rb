class PaintingsController < ApplicationController
  def index
  end

  def new
    render :new
  end

  def create
    @painting = current_user.paintings.new(painting_params)

    if @painting.save
      redirect_to gallery_path
    else
      flash[:error] = "Oops! Try saving your painting again."
      render json: { errors: @painting.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @painting = Painting.find(params[:id])
    render :show
  end

  def edit
    painting_id = params[:id]
    @painting = Painting.find(painting_id)
  end

  def update
    painting_id = params[:id]
    painting = Painting.find(painting_id)
    update_params = params.require(:painting).permit(:title)
    if painting.update_attributes(update_params)
      redirect_to profile_path
      flash[:success] = "Painting successfully updated!"
    else
      redirect_to profile_path
      flash[:error] = "Oops! Try updating again!"
    end
  end

  def destroy
    Painting.find(params[:id]).destroy
    redirect_to profile_path
  end

  private
    def painting_params
      params.require(:painting).permit(:user_id, :title, :url)
    end
end
