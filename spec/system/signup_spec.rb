require 'rails_helper'

RSpec.describe 'Signup', type: :system do
  let!(:user){FactoryBot.create(:user)}

  it '新規ユーザーを作成し、ログインする' do
    visit "/users/sign_up"
    click_link '新規登録'
    expect(current_path).to eq "users/sign_up"
    expect(page).to have_content '新規登録'

  # 失敗の場合

  # 成功の場合
  end
end