require 'test_helper'

class ArticlesControllerTest <  ActionController::TestCase
  # include Devise::TestHelpers
  include Devise::Test::ControllerHelpers


  def setup
    @article = Article.create(title: "apple", content: "apple is red")
    @user = users(:riku)
    sign_in(@user)
  end

  test 'should get new' do
    get new_article_path
    assert_response :success

  end

end