# frozen_string_literal: true

class Admin::StaticPagesController < ActionController::Base
  before_action :authenticate_user!
  layout 'application'
  def index; end
end
