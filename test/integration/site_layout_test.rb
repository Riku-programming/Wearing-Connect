require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:riku)
    login_as(@user, :scope => :user)
  end

  test 'homepage links' do
    get root_path
    assert_template 'home/index'
  end

  test 'showpage' do
    get show_path
    assert_template 'home/show'
  end

  test 'logout' do
    get destroy_user_session_path
    assert_template 'users/sign_out'
  end
end
