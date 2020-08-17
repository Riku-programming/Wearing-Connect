class CoordinatesController < ApplicationController
  before_action :set_coordinate, only: [:edit, :update, :show, :destroy]
  before_action :coordinate_params, only: [:create]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :set_all_item, only: [:new, :edit]


  def index
    @coordinates = Coordinate.all.page(params[:page]).per(5)
  end

  def show
    @user = current_user
    @coordinates = @user.coordinates.all.page(params[:page]).per(5)
  end

  def new
    @coordinate = Coordinate.new
    @coordinate.classifications.build
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    @coordinate.user = current_user
    if @coordinate.save!
      flash[:success] = "コーディネートが作成されました"
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @coordinate.items = []
    if @coordinate.update(coordinate_params)
      flash[:success] = "コーディネートは正常に更新されました"
      redirect_to coordinate_path(@coordinate)
    else
      render "edit"
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
    params[:coordinate].permit(:name,
                               classifications_attributes: [:item_id, :_destroy])
  end

  def item_params
    params[:item].permit(:item_name, :price, :image, :content, :brand, :category_id)
  end

  def set_all_item
    @items = Item.all
  end

  def require_same_user
    redirect_to(root_url) unless (@coordinate.user == current_user) || current_user.admin?
  end
end
