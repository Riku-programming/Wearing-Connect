# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Faker::Config.locale = :ja
require "csv"
require "./db/seeds/category.rb"
# require '../db/seeds/coordinate.rb'

# 　管理ユーザー
User.create!(name: "riku",
             email: "riku@example.com",
             password: "password",
             password_confirmation: "password",
             created_at: Time.zone.now,
             avatar: open("#{Rails.root}/db/fixtures/avatar/admin.jpeg"),
             introduction: "よろしくお願いします",
             admin: true)

# ゲストユーザー
User.create!(name: "Guest User",
             email: "guest@example.com",
             password: "guest_password",
             password_confirmation: "guest_password",
             created_at: Time.zone.now,
             avatar: open("#{Rails.root}/db/fixtures/avatar/guest.jpg"),
             introduction: "このユーザーはゲストユーザーです",
             guest: true
             )

# デモユーザー
2.upto(7) do |n|
  name = Faker::Name.name
  email = "sample-#{n}@example.com"
  password = "password"
  User.create!(name: name,
               email: email,
               avatar: open("#{Rails.root}/db/fixtures/avatar/avatar-#{n}.jpg"),
               password: password,
               password_confirmation: password,
               created_at: Time.zone.now)
end





CSV_ID = 0
CSV_ITEM_NAME = 1
CSV_PRICE = 2
CSV_BRAND = 3
CSV_CONTENT = 4
CSV_USER_ID = 5
CSV_CATEGORY_ID = 6
CSV_IMAGE = 7


# CSVファイルを読み込み、DB（テーブル）へ保存
CSV.foreach("db/csv/item.csv") do |row|
  id = row[CSV_ID]
  item_name = row[CSV_ITEM_NAME]
  price = row[CSV_PRICE]
  brand = row[CSV_BRAND]
  content = row[CSV_CONTENT]
  user_id = User.find(row[CSV_USER_ID]).id
  category_id = Category.find(row[CSV_CATEGORY_ID]).id
  image = open("#{Rails.root}/db/fixtures/item_image/#{row[CSV_IMAGE]}")
  created_at = Time.zone.now

  Item.create!(id: id, item_name: item_name, price: price, brand: brand, content: content, user_id: user_id,  category_id: category_id, image: image, created_at: created_at)
end








# # お気に入りアイテム作成
# users = User.order(:id).take(6)
# items = Item.order(:id).take(15)
# users.each do |user|
#   items.each do |item|
#     user.likes(item) unless user.id == item.user_id
#   end
# end
