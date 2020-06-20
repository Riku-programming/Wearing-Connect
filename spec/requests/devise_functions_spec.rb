require 'rails_helper'


RSpec.describe "UserAuthentications", type: :request do
  let!(:user) {FactoryBot.create(:user)}
  let!(:another_user) {FactoryBot.create(:another_user )}

  describe 'new_user_session' do
    context 'ログインしていない状態の場合' do
      it 'ログインページにリダイレクトされること' do
        get user_path(user)
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ログインしている状態の場合' do
      it 'successステータスを返すこと' do
        sign_in user
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
