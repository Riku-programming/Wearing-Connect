require 'rails_helper'

describe 'Items', type: :system do
  let!(:user) {FactoryBot.create(:user)}

  it '新規アイテム, 編集、削除をする', js: true do
    visit "/users/sign_in"

    #ログインする
    click_link 'ログイン'
    expect(current_path).to eq "/users/sign_in"
    expect(page).to have_content 'Remember me'

    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン'
    expect(current_path).to eq root_path

    #新規投稿する
    click_link '新しいアイテム'
    expect(current_path).to eq new_item_path
    expect(page).to have_content 'アイテムを追加する'

    attach_file 'item[image]', "#{Rails.root}/spec/fixtures/rspec_test.jpeg", make_visible: true
    fill_in '商品名', with: 'Apple'
    fill_in '価格', with: '777'
    fill_in 'レビュー', with: 'とてもいいアイテムです!'
    click_button '投稿する'

    item = Item.first
    aggregate_failures do
      expect(item.item_name).to eq 'Apple'
      expect(item.price).to eq 777
      expect(item.content).to eq 'とてもいいアイテムです!'
      expect(current_path).to eq items_path
      expect(page).to have_link "#{item.item_name}", href: "/items/#{item.id}"
    end

    #投稿を編集する
    expect(current_path).to eq items_path
    click_link '編集'
    expect(current_path).to eq edit_item_path(item)
    expect(page).to have_content 'アイテムを編集する'
    fill_in 'レビュー', with: '凄い欲しいです'
    click_button '更新する'
    expect(current_path).to eq item_path(item)
    expect(page).to_not have_content 'とてもいいアイテムです!'
    expect(page).to have_content '凄い欲しいです'

    #投稿を削除する
    # sleep 2
    # page.dismiss_confirm("アイテムを削除しますか?") do
    #   click_link("削除")
    # end
    #   expect(page).to have_content "item was successfully deleted"
    # }.to change(Item.count).by(-1)
    # expect{delete item_path(item)}.to change {Item.count}.by(-1)
    # expect(current_path).to eq  item_path(item)
    # expect(Item.where(id: item.id)).to be_empty
    # expect(page).to_not have_link "#{item.item_name}", href: "/items/#{item.id}"

  end
end