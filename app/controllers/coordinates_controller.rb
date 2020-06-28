class CoordinatesController < ApplicationController

  before_action :set_coordinate, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]



  def index
    @coordinates = Coordinate.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @coordinate = Coordinate.new
    @items = Item.all
  end

  def create
    @items = Item.all
    @coordinate = Coordinate.create(coordinate_params)
    @coordinate.user = current_user
    if @coordinate.save!
      flash[:success] = "コーディネートが作成されました"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @coordinate.update(coordinate_params)
      flash[:success] = "コーディネートは正常に更新されました"
      redirect_to coordinate_path(@coordinate)
    else
      render 'edit'
    end
  end

  def destroy
    @coordinate.destroy
    flash[:danger] = "コーディネートは正常に削除されました"
    redirect_to coordinates_path
  end


  private

  def set_coordinate
    @coordinate = Coordinate.find(params[:id])
  end

  def coordinate_params
    params[:coordinate].permit(:name, :item_id)
  end

  def require_same_user
    if current_user != @coordinate.user
      flash[:danger] = "You can only edit delete your own items"
      redirect_to root_path
    end
  end
end
