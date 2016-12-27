ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column  :email
    column  :name
    column  :slug
    column  :provider
    column  "avatar" do |user|
      if user.avatar.present?
        image_tag(user.avatar.image.url)
      else
        image_tag(user.avatar)
      end
    end
    actions 
  end

  show do
    attributes_table_for user do
      row :email
      row :name
      row "avatar" do |user|
        if user.avatar.present?
          image_tag(user.avatar.image.url)
        else
          image_tag(user.avatar)
        end
      end
    end
  end

  form title: 'A custom user' do |f|
    inputs 'Details' do
      input  :email
      input  :name
      input  :avatar, :as => :file
    end
    actions
  end

  controller do
    def update
      @user = User.friendly.find(params[:id])
      if params[:user][:avatar].present?
        @user.create_avatar(image: params[:user][:avatar])
        redirect_to admin_users_path
      else
        render "edit"
      end
    end

    def find_resource
      begin
        scoped_collection.where(slug: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        scoped_collection.find(params[:id])
      end
    end
  end


end
