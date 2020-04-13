require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new(title: "GI", content: "GI is great")
  end

  test "title should be present" do
    @article.title = ""
    assert_not @article.valid?
  end

  test "content should be unique" do
    @article.save
    article2 = Article.new(content: "GI is great")
    assert_not article2.valid?
  end

  test "title should not be too short" do
    @article.title = "gi"
    assert_not @article.valid?
  end
end