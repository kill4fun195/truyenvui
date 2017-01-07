class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :initial_sidebar

   before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site_name   = "vuivon.com"
    title       = "Cộng đồng chế ảnh troll, truyen cuoi, hài hước, haivl"
    description = "Anh che haivl.com - Ảnh troll, chế ảnh vui hài hước meme, range comic haivl tại vuivon.com . Chia sẻ Video clip giải trí hay hot gây sốt giới trẻ . Tham gia NGAY để cười xả stress"
    image       = options[:image] || "your-default-image-url"
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: "Anh che haivl.com - Ảnh troll, chế ảnh vui hài hước meme, range comic haivl tại vuivon.com . Chia sẻ Video clip giải trí hay hot gây sốt giới trẻ .",
      keywords:    "Truyen cuoi , truyện cười, anh che, anh vui hai huoc , ảnh vui , ảnh chế , chế ảnh , ảnh troll, haivl, haivl.com",
      twitter: {
        site_name: site_name,
        site: 'vuivon.com',
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

  private


    def initial_sidebar
      @top_user_tuan = User.includes(:avatar).limit(8).order(like_week: :desc)
      @top_user_thang = User.includes(:avatar).limit(8).order(like_month: :desc)
      @top_user_tatca = User.includes(:avatar).limit(8).order(like_total: :desc)
      @categories = Category.all
    end 
end
