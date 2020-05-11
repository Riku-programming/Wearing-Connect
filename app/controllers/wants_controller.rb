class WantsController < ApplicationController
  def create
    want = current_user.wants.build(item_id: params[:item_id])
    want.save
    redirect_to items_path
  end

  def destroy
    want = Want.find_by(item_id: params[:item_id], user_id: current_user.id)
    want.destroy
    redirect_to items_path
  end

  def show
    @user = User.find(current_user.id)
    # @items = @user.items
    @want_items = @user.want_items
  end

end
