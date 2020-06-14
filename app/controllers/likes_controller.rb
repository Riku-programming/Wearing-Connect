class LikesController < ApplicationController
  before_action :set_item, only: [:create, :destroy]

  def create
    @like = Like.create(user_id: current_user.id, item_id: params[:item_id])
    @likes = Like.where(item_id: params[:_id])
    @item.reload
    redirect_to items_path
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    @like.destroy
    @likes = Like.where(item_id: params[:item_id])
    @item.reload
    redirect_to items_path
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
