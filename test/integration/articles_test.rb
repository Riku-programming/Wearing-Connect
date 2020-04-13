require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:riku)
  end

  test "create new article form " do
    login_as(@user, :scope => :user)
    get new_article_path
    assert_template 'articles/new'
  end


end