FactoryBot.define do
  factory :item do
    id {1}
    item_name {'test_item'}
    price {'100'}
    url {'https://www.test.com'}
    image{'https://www.test.image.com'}
    user_id {1}
  end

  factory :another_item, class: Item do
    id {2}
    item_name {'another_item'}
    price {'1000'}
    url {'https://www.another.com'}
    image{'https://www.another.image.com'}
    user_id {2}
  end
end
