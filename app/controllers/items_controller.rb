class ItemsController < ApplicationController
  def search
    if params[:keyword].present?
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      if @items.present?
        respond_to do |format|
          format.js {render partial: 'item_result.js.erb'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find item"
          format.js {render partial: 'item_result.js.erb'}
        end
      end
      # fixme itemを入力しなかった時messageを出すようにしたい
    # else
    #   respond_to do |format|
    #     flash.now[:alert] = "Please enter a item name to search"
    #     format.js {render partial: 'item_result.js.erb'}
    #   end
    end
  end
end
