require "rails_helper"

RSpec.describe "Friendships", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:another_user) }
  let!(:category) { FactoryBot.create(:category) }
  let!(:item) { FactoryBot.create(:item) }

  it "ユーザーをフォロー/フォロー解除する", js: true do
    visit root_path

    # user がログインする
    click_link "ログイン"
    expect(current_path).to eq "/users/sign_in"
    expect(page).to have_content "次回から自動でログインする"

    fill_in "user[email]", with: "test@example.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
    expect(current_path).to eq root_path

    # 友達検索のページへ移動する
    click_link "友達"
    expect(page).to have_content "Friends"
    fill_in "user", with: "@"
    click_button "button"
    sleep 5
    expect(page).to have_link "View Profile", href: "/users/#{another_user.id}"
    click_link "View Profile", href: "/users/#{another_user.id}"
    expect(current_path).to eq "/users/#{another_user.id}"

    # todo test追記必要
  end
end
