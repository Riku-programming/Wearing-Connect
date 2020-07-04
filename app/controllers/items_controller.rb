class ItemsController < ApplicationController

  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :set_category, only: [:new, :create, :edit]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def index
    @items = Item.all.page(params[:page]).per(5)
  end

  def new
    @category = Category.where(ancestry: 1)
    @item = Item.new
  end

  def edit
  end


  def create
    @item = Item.create(item_params)
    @item.user = current_user
    if @item.save!
      flash[:success] = "アイテムを投稿しました"
      redirect_to items_path
    else
      render 'new'
    end
  end


  def save
    item = Item.create(user_id: current_user.id, item_name: params['item_name'], price: params['price'])
    item.image = params['image']
    if item.save
      flash[:success] = "アイテムを投稿しました"
      redirect_to items_path
    end
  end


  def update
    if @item.update(item_params)
      flash[:success] = "アイテムは正常に更新されました"
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def show
    # fixme current_userではなくUser.find([:params])かも
    # if @item.user_id == current_user.id
    #   @user = current_user
    # else
    #   @user = User.find(params[:id])
    # end

    @user = current_user
    # @user = User.find(params[:id])
    @items = @user.items.paginate(page: params[:page], per_page: 5)
  end

  # fixme flashメッセージがアプリケーションを通して表示されない
  def destroy
    @item.destroy
    flash[:danger] = "アイテムは正常に削除されました"
    redirect_to items_path
  end

  def my_items
  end

  def search
    if params[:keyword].present?
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      @item = Item.all.page(params[:page]).per(5)
      if @items.count >= 1
        respond_to do |format|
          format.js {render partial: 'item_result'}
        end
      elsif @items.count == 0
        respond_to do |format|
          flash.now[:alert] = "Couldn't find item"
          format.js {render partial: 'item_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a item name to search"
        format.js {render partial: 'item_result'}
      end
    end
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params[:item].permit(:item_name, :price, :image, :content, :brand, :category_id)
  end

  def require_same_user
    if current_user != @item.user
      flash[:danger] = "You can only edit delete your own items"
      redirect_to root_path
    end
  end

  def set_category
    @category = Category.where(ancestry: 1)
  end


end
