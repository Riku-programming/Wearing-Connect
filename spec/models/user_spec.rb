require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  it '有効なファクトリを持つこと' do
    expect(build(:user)).to be_valid
  end

  it '名前、メール、パスワードがある場合、有効であること' do
    user = User.new(
                   name: 'Test',
                   email: 'test@example.com',
                   password: 'password'

    )
    expect(user).to be_valid
  end

end