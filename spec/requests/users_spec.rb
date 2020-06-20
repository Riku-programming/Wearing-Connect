require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) {FactoryBot.create(:user)}
  let!(:another_user) {FactoryBot.create(:another_user)}

  describe '#show' do
    context 'ログインしていない状態の場合' do
      it 'ログインページにリダイレクトされること' do
        get user_path(user)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context 'ログインしている場合' do
      it 'マイページに移動すること' do
        sign_in user
        get user_path(user)
        expect(response).to have_http_status 200
      end
    end
  end
end

