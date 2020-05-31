require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe "Articles", type: :request do
  let!('user') {FactoryBot.create(:user)}
  let!('another_user') {FactoryBot.create(:another_user)}
  let!('item') {FactoryBot.create(:item)}
  let!('another_item') {FactoryBot.create(:another_item)}
  # user_id 1 item_id 1
  let('article') {FactoryBot.create(:article)}
  let('article_params') {FactoryBot.attributes_for(:article)}
  # user_id 1 Item_id 2
  let('another_article') {FactoryBot.create(:another_item_article)}
  let('another_article_params') {FactoryBot.attributes_for(:another_item_article)}
  # user_id 2 item_id 1
  let('another_user_article') {FactoryBot.create(:another_user_article)}
  let('another_user_article_params') {FactoryBot.attributes_for(:another_user_article)}
  # user_id 2 item_id 2
  let('all_other_article') {FactoryBot.create(:all_other_article)}
  let('all_other_article_params') {FactoryBot.attributes_for(:all_other_article)}

  describe '#index' do
    context 'ログインしていない状態の場合' do
      it 'ログインページにリダイレクトされること' do
        get item_articles_path(item)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end

    end

  end


  describe '#new' do
    context 'ログインしていない状態の場合' do
      it 'ログインページにリダイレクトされること' do
        get new_item_article_path(item)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context 'ログインしている状態の場合' do
      it 'successステータスを返すこと' do
        get new_item_article_path(item)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end


  # fixme createのテストが書けない
  describe '#create' do
    context 'ログインしている状態の場合' do
      before do
        sign_in user
      end
      it '記事を作成すること' do
        expect{post item_articles_path(item),
                    params: {article: article_params}}.to change{Article.count}.by(1)
      end
    end

  end
end
