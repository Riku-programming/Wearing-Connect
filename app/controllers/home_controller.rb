class HomeController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(9)
  end

  def show
    @items = Item.all.page(params[:page]).per(5)
  end
end
