FactoryBot.define do
  factory :user do
    id {1}
    name {'Test'}
    # sequence(:email) {|n| "test#{n}@example.com"}
    email {"test@example.com"}
    password {"password"}
    # Add additional fields as required via your User model
  end

  factory :another_user, class: User  do
    id {2}
    name {'Another'}
    email{"another@example.com"}
    password {"another_password"}
  end
end

