require "rails_helper"

RSpec.describe "Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:another_user) }
  let!(:admin) { FactoryBot.create(:admin) }

  describe "#show" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        get user_path(user)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "ログインしている場合" do
      it "マイページに移動すること" do
        sign_in user
        get user_path(user)
        expect(response).to have_http_status 200
      end
    end
  end


  describe "#follows" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        get follows_user_path(user)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "ログインしている場合" do
      it "フォローページに移動すること" do
        sign_in user
        get follows_user_path(user)
        expect(response).to have_http_status 200
      end
    end
  end

  describe "#index" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        get users_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "admin Userではない時" do
      it "ルートページにリダイレクトされること" do
        sign_in user
        get users_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to root_path
      end
    end

    context "admin Userの場合" do
      it "indexページにリダイレクトされること" do
        sign_in admin
        get users_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe "#destroy" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        delete user_path(user)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "adminUserではない場合" do
      before do
        sign_in user
      end
      it "ユーザーを削除できずリダイレクトすること" do
        expect { delete user_path(user) }.to change { User.count }.by(0)
        expect(response).to redirect_to root_path
      end
    end
    context  "adminUserの場合" do
      before do
        sign_in admin
      end
      it "正常にユーザーが削除されること" do
        expect { delete user_path(user) }.to change { User.count }.by(-1)
        expect(response).to redirect_to users_path
      end
    end
  end
end
