require 'rails_helper'

RSpec.describe 'Signup', type: :system do
  let!(:user) {FactoryBot.create(:user)}

  it '新規ユーザーを作成し、ログインする' do
    visit "/users/sign_up"
    click_link '新規登録'
    expect(current_path).to eq "/users/sign_up"
    expect(page).to have_content '新規登録'

    # 失敗の場合
    fill_in 'ユーザー名', with: 'a' * 16
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード確認', with: 'error_password'

    expect do
      click_button '新規登録'
      expect(current_path).to eq "/users/sign_in"
      expect(page).to have_content 'エラーが発生したため ユーザ は保存されませんでした。'
      expect(page).to have_content 'ユーザー名は10文字以内で入力してください'
      expect(page).to have_content 'メールアドレスはすでに存在します'
      expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
    end
    sleep 2
    # 成功の場合
    fill_in 'ユーザー名', with: 'John'
    fill_in 'メールアドレス', with: 'john@example.com'
    fill_in 'パスワード', with: 'password_john'
    fill_in 'パスワード確認', with: 'password_john'
    expect do
      click_button '新規登録'
      expect(current_path).to eq root_path
      expect(page).to have_content 'Johnさん'
    end.to change(User, :count).by(1)

    aggregate_failures do
      john = User.find_by(name: 'John')
      expect(john.name).to eq 'John'
      expect(john.email).to eq 'john@example.com'
    end
  end
end