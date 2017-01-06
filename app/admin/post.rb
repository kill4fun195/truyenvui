ActiveAdmin.register Post do
  config.batch_actions = false
  scope :all, :default => true
  scope("anh_che") { |scope| scope.where("post_type = ? ", 0) }
  scope("truyen_cuoi") { |scope| scope.where("post_type = ? ", 1) }
  scope("anh_che_haivn") { |scope| scope.where("post_type = ? AND user_id IN (?) ", 0, 1..20) }
  scope("truyen_cuoi_haivn") { |scope| scope.where("post_type = ? AND user_id IN (?) ", 1, 1..20) }
  scope("anh_che_user") { |scope| scope.where("post_type = ? AND user_id NOT IN (?) ", 0, 1..20) }
  scope("truyen_cuoi_user") { |scope| scope.where("post_type = ? AND user_id NOT IN (?) ", 1, 1..20) }
  scope("anh_che_haivn_pending") { |scope| scope.where("post_type = ? AND user_id IN (?) AND status = ? ", 0, 1..20, 2 ) }
  scope("truyen_cuoi_haivn_pending") { |scope| scope.where("post_type = ? AND user_id IN (?) AND status = ? ", 1, 1..20, 2 ) }
  scope("anh_che_user_pending") { |scope| scope.where("post_type = ? AND user_id NOT IN (?) AND status = ? ", 0, 1..20, 2 ) }
  scope("truyen_cuoi_user_pending") { |scope| scope.where("post_type = ? AND user_id NOT IN (?) AND status = ? ", 1, 1..20, 2 ) }
  scope("anh_che_accept") { |scope| scope.where("post_type = ? AND status = ? ", 0, 1 ) }
  scope("truyen_cuoi_accept") { |scope| scope.where("post_type = ? AND status = ? ", 1,1 ) }
  index do
    selectable_column
    column  :id
    column  :title
    column  "content" do |post|
        sanitize(post.content)
    end
    column  :status
    column  :source
    column  "avatar_url" do |post| 
      if post.avatar.present?
        image_tag(post.avatar.image.url)
      else
        post.avatar
      end
    end
    column  "avatar_medium" do |post| 
      if post.avatar.present?
        image_tag(post.avatar.image.url(:medium))
      else
        post.avatar
      end
    end
    column  "avatar_origin" do |post| 
      if post.avatar.present?
        image_tag(post.avatar.image.url(:origin))
      else
        post.avatar
      end
    end

    actions defaults: false do |post|
      item "View", admin_post_path(post)
      span "  "
      item "Edit", edit_admin_post_path(post)
      span "  "
      item "Delete", admin_post_path(post), method: :delete, "data-confirm"=> "Are you sure you want to delete this?"
      button "reject", class: "reject-post"
      button "accept", class: "accept-post"
      button "publish", class: "publish-post"
      span post.id, class: "post_id", style: "display:none"
    end 
  end

  collection_action :update_status, method: :post do
    @post = Post.find(params[:post_id])
    if params[:status] == "reject"
      @post.update(status: 0)
    elsif params[:status] == "accept"
      @post.update(status: 1)
    elsif params[:status] == "publish"
      @post.update(status: 3, publish: Time.zone.now)
    else

    end
    redirect_to update_comment_posts_path
  end

  controller do
    def find_resource
      begin
        scoped_collection.where(slug: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        scoped_collection.find(params[:id])
      end
    end
  end

end
