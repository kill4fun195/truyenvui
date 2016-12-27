ActiveAdmin.register Post do

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
    actions 
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
