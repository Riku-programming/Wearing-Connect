FactoryBot.define do
  factory :item do
    id {1}
    item_name {'test_item'}
    price {'100'}
    url {'https://www.test.com'}
    image{'https://www.test.image.com'}
  end
end
