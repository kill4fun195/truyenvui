class PostsController < ApplicationController
  layout "frontend"
  def create
    if post_params[:post_type] == "anh_che"
      create_anh_che
    elsif post_params[:post_type] == "truyen_cuoi"
      create_truyen_cuoi
    else
      
    end
  end

  def create_anh_che
    @post = current_user.posts.create(post_params)
    if params[:post][:avatar].present?
      @post.create_avatar(image: params[:post][:avatar])
    end
    flash[:error] = @post.errors.full_messages
    redirect_to post_path(@post)
  end

  def create_truyen_cuoi
    @post = current_user.posts.create(post_params)
    flash[:error] = @post.errors.full_messages
    redirect_to post_path(@post)
  end

  def truyencuoi
    @posts = Post.where(post_type: 1).order('created_at  DESC')
  end

  def anh_che
     @posts = Post.where(post_type: 0).order('created_at  DESC')
  end

  def show 
    @post = Post.friendly.find(params[:id])
    @check_source = source(@post)
    @post.update(view: @post.view + 1)
  end

  private 

  def source(post)
    if (1..20).include? post.user.id
      return true
    else 
      return false
    end
  end

  def post_params
    params.require(:post).permit( :title, :content, :source, :post_type, :user_id, :category_id)
  end
  
end
