require "rails_helper"
# todo contextの部分を共通化してDRYにしたい
RSpec.describe "Items", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:another_user) }
  let!(:category) { FactoryBot.create(:category) }
  let!(:item) { FactoryBot.create(:item) }
  let!(:another_item) { FactoryBot.create(:another_item) }
  let!(:another_item_params) { FactoryBot.attributes_for(:another_item) }
  let!(:item_params) { FactoryBot.attributes_for(:item) }

  describe "#index" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        get items_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#new" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        get new_item_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
    context "ログインしている状態の場合" do
      it "successステータスを返すこと" do
        sign_in user
        get new_item_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#create" do
    context "ログインしている状態の場合" do
      before do
        sign_in user
      end
      it "アイテムを作成すること" do
        expect { post items_path(item),
                    params: { item: item_params }}.to change { Item.count }.by(1)
      end
    end

    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        post items_path, params: { item: item_params }
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end


  describe "#edit" do
    context "ログインしていない状態の時" do
      it "ログインページにリダイレクトされること" do
        get edit_item_path(item)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "アイテムを作成していないユーザーの場合" do
      it "ルートページにリダイレクトされること" do
        sign_in another_user
        get edit_item_path(item)
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

    context  "アイテムを作成していないユーザーの場合" do
      before do
        sign_in another_user
      end
      it "アイテムを更新できず、ルートページにリダイレクトされること" do
        patch item_path(item), params: { item: item_params }
        expect(item.reload.item_name).to eq "test_item"
        expect(response).to redirect_to root_path
      end
    end

    context  "アイテムを作成しているユーザーの場合" do
      before do
        sign_in user
      end
      it "アイテムを更新して、showページにリダイレクトされること" do
        patch item_path(item), params: { item: item_params }
        expect(item.reload.item_name).to eq "test_item"
        expect(response).to redirect_to item_path(item)
      end
    end
  end

  describe "#destroy" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        delete item_path(item)
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "アイテムを作成していないユーザの場合" do
      before do
        sign_in another_user
      end
      it "アイテムを削除できずリダイレクトすること" do
        expect { delete item_path(item) }.to change { Item.count }.by(0)
        expect(response).to redirect_to root_path
      end
    end
    context  "アイテムを作成したユーザーの場合" do
      before do
        sign_in user
      end
      it "正常にアイテムが削除されること" do
        expect { delete item_path(item) }.to change { Item.count }.by(-1)
        expect(response).to redirect_to items_path
      end
    end
  end

  describe "#my_items" do
    context "ログインしていない状態の場合" do
      it "ログインページにリダイレクトされること" do
        get my_items_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to "/users/sign_in"
      end
    end
    context "ログインしている状態の場合" do
      before do
        sign_in user
      end
      it "successステータスを返すこと" do
        get my_items_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
