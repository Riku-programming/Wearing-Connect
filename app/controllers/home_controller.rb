class HomeController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(6)
  end

  def show
    @items = Item.all.page(params[:page]).per(5)
  end
end
