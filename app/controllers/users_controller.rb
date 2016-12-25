class UsersController < ApplicationController
  layout "frontend"
  def index

  end

  def show
    @user = User.friendly.find(params[:id])
    @start_date = @user.created_at.strftime("%d-%m-%Y")
    @posts = @user.posts.anh_che.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    @total_anh_che = @user.posts.anh_che.size
    @total_like = @user.posts.sum(:like)
    @total_view = @user.posts.sum(:view)
    @total_comment = @user.posts.sum(:comment)
    @rank = 99
  end

  def truyen
    @user = User.friendly.find(params[:id])
    @start_date = @user.created_at.strftime("%d-%m-%Y")
    @posts = @user.posts.truyen_cuoi.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    @total_truyen_cuoi = @user.posts.truyen_cuoi.size
    @total_like = @user.posts.sum(:like)
    @total_view = @user.posts.sum(:view)
    @total_comment = @user.posts.sum(:comment)
    @rank = 99
  end

  def info
    @user = current_user
  end

  def update
    @user = User.friendly.find(params[:id])
    @user.update(user_params)
    if params[:user][:avatar].present?
      @user.create_avatar(image: params[:user][:avatar])
    end
    flash[:error] = @user.errors.full_messages
    redirect_to info_users_path

  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
