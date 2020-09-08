require "rails_helper"

RSpec.describe Coordinate, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @coordinate = @user.coordinates.build(
      id: 1,
      name: "test_coordinate",
      user_id: @user.id
    )
  end

  it "有効なファクトリを持つこと" do
    expect(@coordinate).to be_valid
  end

  describe "validationの検証" do
    it "コーディネートの名前がない場合、無効であること" do
      @coordinate.name = nil
      @coordinate.valid?
      expect(@coordinate).to_not be_valid
    end

    it "ユーザーがない場合、無効であること" do
      @coordinate.user = nil
      @coordinate.valid?
      expect(@coordinate).to_not be_valid
    end
  end
end
