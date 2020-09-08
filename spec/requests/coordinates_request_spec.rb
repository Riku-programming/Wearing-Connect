require "rails_helper"

RSpec.describe "Coordinates", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:another_user) }
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:category) { FactoryBot.create(:category) }
  let!(:item) { FactoryBot.create(:item) }
  let!(:coordinate) { FactoryBot.create(:coordinate) }
  let!(:another_item) { FactoryBot.create(:another_item) }
  let!(:item_params) { FactoryBot.attributes_for(:item) }
  let!(:coordinate_params) { FactoryBot.attributes_for(:coordinate) }


  describe "#index" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        get coordinates_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#new" do
    it "ログインページにリダイレクトされること" do
      get new_coordinate_path
      expect(response).to have_http_status 302
      expect(response).to redirect_to "/users/sign_in"
    end
    context "ログインしている状態の場合" do
      it "successステータスを返すこと" do
        sign_in user
        get new_coordinate_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#create" do
    context "ログインしている状態の場合" do
      before do
        sign_in user
      end
      it "コーディネートを作成すること" do
        expect { post coordinates_path(coordinate_params),
                     params: { coordinate: coordinate_params }}.to change { Coordinate.count }.by(1)
      end
    end

    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        post coordinates_path, params: { coordinate: coordinate_params }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end


  describe "#edit" do
    context "ログインしていない状態の時" do
      it "ログインページにリダイレクトされること" do
        get edit_coordinate_path(coordinate_params)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "コーディネートを作成していないユーザーの場合" do
      it "ルートページにリダイレクトされること" do
        sign_in another_user
        get edit_coordinate_path(coordinate_params)
        expect(response).to have_http_status 302
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#update" do
    context "ログインしていない状態の時" do
      it "ログインページにリダイレクトされること" do
        patch item_path(item)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  context  "コーディネートを作成していないユーザーの場合" do
    before do
      sign_in another_user
    end
    it "コーディネートを更新できず、ルートページにリダイレクトされること" do
      patch coordinate_path(coordinate_params), params: { coordinate: coordinate_params }
      expect(coordinate.reload.name).to eq "test_coordinate"
      expect(response).to redirect_to root_path
    end
  end


  context  "コーディネートを作成しているユーザーの場合" do
    before do
      sign_in user
    end
    it "コーディネートを更新して、showページにリダイレクトされること" do
      patch coordinate_path(coordinate_params), params: { coordinate: coordinate_params }
      expect(coordinate.reload.name).to eq "test_coordinate"
      expect(response).to redirect_to coordinate_path(coordinate)
    end
  end

  describe "#destroy" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        delete coordinate_path(coordinate_params)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "コーディネートを作成していないユーザの場合" do
      before do
        sign_in another_user
      end
      it "コーディネートを削除できずリダイレクトすること" do
        expect { delete coordinate_path(coordinate_params) }.to change { Coordinate.count }.by(0)
        expect(response).to redirect_to root_path
      end
    end
    context  "コーディネートを作成したユーザーの場合" do
      before do
        sign_in user
      end
      it "正常にコーディネートが削除されること" do
        expect { delete coordinate_path(coordinate_params) }.to change { Coordinate.count }.by(-1)
        expect(response).to redirect_to coordinates_path
      end
    end

    context "AdminUserの場合" do
      before do
        sign_in admin
      end
      it "正常にアイテムが削除されること" do
        expect { delete coordinate_path(coordinate_params) }.to change { Coordinate.count }.by(-1)
        expect(response).to redirect_to coordinates_path
      end
    end
  end
end
