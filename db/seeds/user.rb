Faker.Config.locale = :ja


#　管理ユーザー
User.create!(name: 'riku',
             email: 'riku@example.com',
             password: 'password',
             password_confirmation: 'password',
             created_at: Time.zone.now,
             avatar: open("#{Rails.root}/app/assets/images/admin.jpeg"),
             introduction: "よろしくお願いします")


# デモユーザー
1.upto(6) do |n|
  name = Faker::Name.name
  email = "sample-#{n}@example.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               created_at: Time.zone.now)
end

users = User.order(:id).take(10)
users.each_with_index do |user, n|
  user.avatar = open("#{Rails.root}/db/fixtures/avatar/avatar-#{n + 1}.jpg")
  user.save
end

# お気に入りアイテム作成
users = User.order(:id).take(6)
items = Item.order(:id).take(15)
users.each do |user|
  items.each do |item|
    user.likes(item) unless user.id == item.user_id
  end
end