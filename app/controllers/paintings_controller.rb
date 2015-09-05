class PaintingsController < ApplicationController
  def index
  end

  def new
    render :new
  end

  def create
    @painting = current_user.paintings.new(painting_params)
    if @painting.save
      render json: @painting
    else
      flash[:error] = "Oops! Try saving your painting again."
      render json: { errors: @map.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @painting = Painting.find_by(params[:id])
    render json: @painting
  end

  def edit
    painting_id = params[:id]
    @paiting = Painting.find(painting_id)
  end

  def update
    painting_id = params[:id]
    painting = Painting.find(painting_id)
    update_params = params.require(:painting).permit(:title)
    if painting.update_attributes(update_params)
      redirect_to gallery_path
      flash[:success] = "Painting successfully updated!"
    else
      redirect_to gallery_path
      flash[:error] = "Oops! Try updating again!"
    end
  end

  def destroy
    Painting.find(params[:id]).destroy
    redirect_to gallery_path
  end

  private
    def painting_params
      params.require(:painting).permit(:user_id, :title, :url)
    end
end
