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
end
