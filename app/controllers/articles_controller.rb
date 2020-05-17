class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit,  :update, :show, :destroy]
  before_action :set_item, only: [:edit,  :update, :show, :destroy]
  before_action :require_same_item, only: [:edit, :update, :destroy]


  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
    @user = current_user
  end

  def edit
  end



  def create
    @article = Article.new(article_params)
    @article.user  = current_user
    @article.item = current_item
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to items_path
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
    @articles = @item.articles.paginate(page: params[:page], per_page: 5)
  end

  # fixme flashメッセージがアプリケーションを通して表示されない
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to item_article_path
  end



  private

  def set_article
    @article = Article.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def require_same_item
    if current_user != @article.user
      flash[:danger] = "You can only edit delete your own articles"
      redirect_to root_path
    end
  end

end
