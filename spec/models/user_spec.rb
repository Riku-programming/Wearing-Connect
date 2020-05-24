require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it '名前、メール、パスワードがある場合、有効であること' do
    user = User.new(
        name: 'TAS',
        email: 'tas@example.com',
        password: 'password'

    )
    expect(user).to be_valid
  end

  describe "存在の検証" do
    it '名前がない場合無効であること' do
      @user.name = ''
      @user.valid?
      expect(@user).to_not be_valid
    end

    it 'メールアドレスがない場合、無効であること' do
      @user.name = ''
      @user.valid?
      expect(@user).to_not be_valid
    end

    it 'パスワードがない場合、無効であること' do
      @user.password = ''
      @user.valid?
      expect(@user).to_not be_valid
    end
  end

  describe '文字列の検証' do
    it '名前が15文字以内の場合、有効であること' do
      @user.name = 'a' * 15
      expect(@user).to be_valid
    end

    it '名前が16文字以内の場合、有効であること' do
      @user.name = 'a' * 16
      expect(@user).to_not be_valid
    end

    it 'メールアドレスが255文字を超える場合、有効であること' do
      @user.email = 'a' * 243 + '@example.com'
      expect(@user).to be_valid
    end

    it 'メールアドレスが255文字を超える場合、無効であること' do
      @user.email = 'a' * 245 + '@example.com'
      @user.valid?
      expect(@user.errors).to be_added(:email, :too_long, count: 255)
    end

    it 'パスワードが8文字以上の場合、有効であること' do
      @user.password = @user.password_confirmation = 'a' * 7
      @user.valid?
      expect(@user.errors).to be_added(:password, :too_short, count: 8)
    end

    # fixme　このテストを通したい
    it 'パスワードが8文字未満の場合、無効であること' do
    @user.password = @user.password_confirmation = 'a' * 7
          @user.valid?
          expect(@user.errors).to be_added(:password, :too_short, count: 8)
    end
  end

  describe '一意性の検証' do
    it '重複したメールアドレスの場合、無効であること' do
      user1 = User.new(id: 1, name: 'john', email: 'john@example.com')
      user2 = User.new(id: 2, name: 'mary', email: user1.email)
      expect(user2).to_not be_valid
    end

    it 'メールアドレスは大文字小文字を区別せず扱うこと' do
      duplicate_user = User.new(email: 'TEST@EXAMPLE.COM')
      duplicate_user.valid?
      expect(duplicate_user.errors).to be_added(:email, :taken, value: 'test@example.com')
    end

  end
end