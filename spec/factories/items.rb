FactoryBot.define do
  factory :item do
    id {1}
    item_name {'test_item'}
    price {'100'}
    brand {'Test'}
    image{'https://www.test.image.com'}
    user_id {1}
    likes_count {0}
    category_id {104}
  end

  factory :another_item, class: Item do
    id {2}
    item_name {'another_item'}
    price {'1000'}
    brand {'Fake'}
    image{'https://www.another.image.com'}
    user_id {2}
    likes_count {5}
    category_id {104}
  end
end
