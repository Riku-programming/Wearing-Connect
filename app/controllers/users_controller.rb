class UsersController < ApplicationController
  def home
  end

  def index
    @users = User
  end
end
