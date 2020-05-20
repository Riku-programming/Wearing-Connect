class FavoritesController < ApplicationController
  before_action :article_set, only: [:create, :destroy]
  def create
    favorite = current_user.favorites.build(article_id: params[:article_id])
    favorite.save
  end
  # fixme ajaxができない
  def destroy
    favorite = Favorite.find_by(article_id: params[:article_id], user_id: current_user.id)
    favorite.destroy
  end

  def show
    @user = User.find(current_user.id)
    @favorite_articles  = @user.favorite_articles
  end

  private

  def article_set
    @article = Article.find(params[:article_id])
  end
end
