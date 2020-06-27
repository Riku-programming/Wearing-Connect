class CoordinatesController < ApplicationController

  def index
    @coordinates = Coordinate.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @coordinate = Coordinate.new
  end

  def create
    @coordinate = Coordinate.create(coordinate_params)
    @coordinate.user = current_user
    if @coordinate.save!
      flash[:success] = "コーディネートが作成されました"
      redirect_to root_path
    else
      render 'new'
    end
  end


  private

  def coordinate_params
    params[:coordinate].permit(:name)
  end
end
