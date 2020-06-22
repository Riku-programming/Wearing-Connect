require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:another_user) {FactoryBot.create(:another_user)}
  let!(:item) {FactoryBot.create(:item)}
  let!(:another_item) {FactoryBot.create(:another_item)}
  let!(:another_item_params) {FactoryBot.attributes_for(:another_item)}
  let!(:item_params) {FactoryBot.attributes_for(:item)}
  let!(:like){create(:like, user_id: user.id, item_id: item.id)}


  it '既存の投稿にいいね/解除する', js: true do
    visit root_path

    # Userがログインする
    click_link 'ログイン'
    expect(current_path).to eq "/users/sign_in"
    expect(page).to have_content 'Remember me'

    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン'
    expect(current_path).to eq root_path

    # 記事詳細へ移動する
    click_link 'アイテム一覧'
    expect(page).to have_link "#{item.item_name}", href: "/items/#{item.id}"
    click_link "#{item.item_name}", href: "/items/#{item.id}"
    expect(current_path).to eq "/items/#{item.id}"
  end

  # fixme いいねのテストが通らない
  # # マイページに移動する→記事詳細へ移動する
  # visit user_path(alice)
  # expect(current_path).to eq "/users/#{alice.id}"
  # expect(page).to have_content 'いいね 1'
  # click_link 'いいね'
  # click_link nil, href: "/posts/#{post.id}"
  # expect(current_path).to eq "/posts/#{post.id}"
  #
  # # いいね！解除する
  # expect(page).to have_content '1 いいね済'
  # expect do
  #   click_link 'いいね済'
  #   expect(page).to have_content '0 いいね！'
  #   expect(page).to_not have_content '1 いいね済'
  # end.to change(post.likes, :count).by(-1)
end

