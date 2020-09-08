FactoryBot.define do
  factory :coordinate do
    id { 1 }
    name { "test_coordinate" }
    user_id { 1 }
    item_ids { 1 }
  end
end
