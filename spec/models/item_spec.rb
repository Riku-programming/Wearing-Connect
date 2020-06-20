require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = @user.items.build(
        id: 1,
        item_name: "test_item",
        price: 100,
        image: 'test_image'
    )
  end

  it '有効なファクトリを持つこと' do
    expect(@item).to be_valid
  end

  describe 'validationの検証' do
    it 'アイテムの名前がない場合、無効であること' do
      @item.item_name = ''
      @item.valid?
      expect(@item).to_not be_valid
    end

    it 'ユーザーがない場合、無効であること' do
      @item.user = nil
      @item.valid?
      expect(@item).to_not be_valid
    end

    it '値段がない場合、無効であること' do
      @item.price = nil
      @item.valid?
      expect(@item).to_not be_valid
    end
  end

  describe 'lengthの検証' do
    it '値段が10桁未満の場合、有効であること' do
      @item.price = 1000000000
      expect(@item).to be_valid
    end

    it '値段が11桁以上の場合、無効であること' do
      @item.price = 10000000000
      expect(@item).to_not be_valid
    end

  end
end
