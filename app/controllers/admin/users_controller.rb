# frozen_string_literal: true

class Admin::UsersController < ActionController::Base
  layout 'application'
  def index
    @users = User.all
  end
end
