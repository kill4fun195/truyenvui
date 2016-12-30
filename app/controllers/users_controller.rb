class UsersController < ApplicationController
  layout "frontend"
  def index

  end

  def show
    @user = User.friendly.find(params[:id])
    @start_date = @user.created_at.strftime("%d-%m-%Y")
    @posts = @user.posts.anh_che.publish.paginate(page: params[:page], per_page: 10).order(publish: :desc)
    @total_anh_che = @user.posts.anh_che.size
    @total_view = @user.posts.sum(:view)
    @total_comment = @user.posts.sum(:comment)
    @rank = User.order(like_total: :desc).index(@user) + 1
  end

  def truyen
    @user = User.friendly.find(params[:id])
    @start_date = @user.created_at.strftime("%d-%m-%Y")
    @posts = @user.posts.truyen_cuoi.publish.paginate(page: params[:page], per_page: 10).order(publish: :desc)
    @total_truyen_cuoi = @user.posts.truyen_cuoi.size
    @total_view = @user.posts.sum(:view)
    @total_comment = @user.posts.sum(:comment)
    @rank = User.order(like_total: :desc).index(@user) + 1
  end

  def info
    @user = current_user
  end

  def top_user_week
    @users = User.order(like_week: :desc)
  end

  def top_user_month
    @users = User.order(like_month: :desc)
  end

  def top_user_total
    @users = User.order(like_total: :desc)
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
