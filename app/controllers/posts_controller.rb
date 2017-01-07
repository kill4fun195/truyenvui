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
    @posts = Post.truyen_cuoi.publish.paginate(page: params[:page], per_page: 10).order('publish  DESC')
  end

  def anh_che
     @posts = Post.publish.paginate(page: params[:page], per_page: 10).order('publish  DESC')
  end

  def show 
    @post = Post.friendly.find(params[:id])
    @check_source = source(@post)
    @post.update(view: @post.view + 1)
    @user = @post.user
    @like_total = @user.like_total

    if @post.source == "vuivonvuivon" && @post.anh_che?
      prepare_meta_tags(title:  @post.title + " | Ảnh hài" ,
                        description: @post.user.name + " - Ảnh chế " +@post.user.name + " . Cộng đồng ảnh chế troll, truyện cười. Tham gia NGAY VUIVON.COM",
                        keywords: @post.user.name + ", ảnh chế troll, truyện cười, vuivon.com",
                        image: @post.avatar.image.url(:medium),
                        twitter: {card: @post.avatar.image.url})
    end
    if @post.source != "vuivonvuivon" && @post.anh_che?
      prepare_meta_tags(title: @post.title + " | Ảnh hài | vuivon.com",
                        description: @post.user.name + " - Ảnh chế " +@post.user.name + " . Cộng đồng ảnh chế troll, truyện cười. Tham gia NGAY VUIVON.COM",
                        keywords: @post.user.name + ", ảnh chế troll, truyện cười, vuivon.com",
                        image: @post.avatar.image.url(:origin),
                        twitter: {card: @post.avatar.image.url})
    end
    if @post.truyen_cuoi?
      prepare_meta_tags(title: @post.title + " | truyện cười",
                        description: @post.user.name + " - Ảnh chế " +@post.user.name + " . Cộng đồng ảnh chế troll, truyện cười. Tham gia NGAY VUIVON.COM",
                        keywords: @post.user.name + ", ảnh chế troll, truyện cười, vuivon.com",
                        image: "/assets/truyencuoi-logo.jpg",
                        twitter: {card: "/assets/truyencuoi-logo.jpg"})
    end
  end

  def update_like
    @post = Post.find(params[:post_id])
    @user = @post.user
    if params[:check] == "asc"
      @post.update(like: @post.like + 1)
      @user.update(like_week: @user.like_week + 1, like_month: @user.like_month + 1, like_total: @user.like_total + 1)
    else
      @post.update(like: @post.like - 1)
      @user.update(like_week: @user.like_week - 1, like_month: @user.like_month - 1, like_total: @user.like_total - 1)
    end
  end

  def update_comment
    @post = Post.find(params[:post][:post_id])
    @post.update(comment: params[:post][:comment_count])
  end

  def hot
    @posts = Post.publish.paginate(page: params[:page], per_page: 10).order('publish  DESC')
  end
  
  def the_end
    
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
