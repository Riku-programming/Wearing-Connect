require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @article = Article.create(title: "apple")
  end

  test 'article'

end