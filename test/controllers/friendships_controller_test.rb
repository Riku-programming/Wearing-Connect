require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers


  setup do
    get '/users/sign_in'
    sign_in users(:riku)
    post user_session_url
    follow_redirect!
    assert_response :success
  end

  test "should get create" do
    get friendships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get friendships_destroy_url
    assert_response :success
  end

end
