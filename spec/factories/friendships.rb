FactoryBot.define do
  factory :friendship do
    id { 1 }
    following_id { 1 }
    follower_id { 2 }
  end
end
