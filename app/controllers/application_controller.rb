class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :initial_sidebar

  private


    def initial_sidebar
      @top_user_tuan = User.includes(:avatar).limit(8).order(like_week: :desc)
      @top_user_thang = User.includes(:avatar).limit(8).order(like_month: :desc)
      @top_user_tatca = User.includes(:avatar).limit(8).order(like_total: :desc)
      @categories = Category.all
    end 
end
