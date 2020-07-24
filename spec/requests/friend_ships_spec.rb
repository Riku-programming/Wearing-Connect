require "rails_helper"

RSpec.describe FriendshipsController, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:another_user) }
  let!(:friendship) { FactoryBot.create(:friendship) }


  describe "#create" do
    context "ログインしている状態の場合" do
      before do
        sign_in user
      end
      it "ユーザーをフォローすること" do
        expect { post user_friendships_path(friendship) }.to change { Friendship.count }.by(1)
      end
    end

    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        post user_friendships_path(user.id)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destory" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        delete user_friendships_path(friendship)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
