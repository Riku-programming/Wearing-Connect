User.create!(name: 'riku',
             email: 'riku@example.com',
             password: 'password',
             password_confirmation: 'password',
             created_at: Time.zone.now,
             avatar: open("#{Rails.root}/app/assets/images/my_avatar.jpg"),
             introduction: "よろしくお願いします")


