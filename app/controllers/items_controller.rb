class ItemsController < ApplicationController

  def my_items
  end


  def search
    if params[:keyword].present?
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
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
end
