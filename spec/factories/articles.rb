FactoryBot.define do
  factory :article do
    id {1}
    title {'test_article'}
    content {'test article is great'}
    # user_id {1}
    item_id {1}
    favorites_count {1}
  end

  factory :another_item_article, class: Article do
    id {2}
    title {'another_item_article'}
    content {'another item article is better'}
    # user_id {1}
    item_id {2}
    favorites_count {1}
  end

  factory :another_user_article, class: Article do
    id {3}
    title {'another_user_article'}
    content {'another user article is bad'}
    # user_id {2}
    item_id {1}
    favorites_count {1}
  end

  factory :all_other_article, class: Article do
    id {4}
    title {'another_user_item_article'}
    content {'another_article is worse'}
    # user_id {2}
    item_id {2}
    favorites_count {1}

  end

end
