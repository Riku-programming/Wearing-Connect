require 'rails_helper'
#todo contextの部分を共通化してDRYにしたい
# fixme login機能の不具合の解決
RSpec.describe 'Items', type: :request do
  let(:user) {FactoryBot.create(:user)}
  let(:item) {user.items.build(
      id: 1,
      item_name: "test_item",
      price: 100,
      url: 'test',
      image: 'test_image'
  )}
  let(:item_params) {FactoryBot.attributes_for(:item)}

  describe '#index' do
    context 'ログインしていない状態の場合' do
      it 'ログインページにリダイレクトされること' do
        get items_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end

    end

  end

  describe '#new' do
    context 'ログインしていない状態の場合' do
      it 'ログインページにリダイレクトされること' do
        get new_item_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログインしている状態の場合' do
      it 'successステータスを返すこと' do
        sign_in user
        get new_item_path
        expect(response).to have_http_status(:success)
      end
    end
  end
# fixme itemを追加するテストがうまくいかない
  # describe '#create' do
  #   context 'ログインしている状態の場合' do
  #     before do
  #       sign_in user
  #     end
  #     subject do
  #       post '/items', params: item_params
  #     end
  #     it '記事を作成すること' do
  #       expect(subject).to change(user.items, :count).by(1)
  #     end
  #
  #   end
  # end
  #

  describe '#edit' do
    context  'ログインしていない状態の時' do
      it 'ログインページにリダイレクトされること' do
        get edit_item_path(item)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe  do

  end
end