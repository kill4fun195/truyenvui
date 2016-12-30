ActiveAdmin.register Category do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  controller do
    def find_resource
      begin
        scoped_collection.where(slug: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        scoped_collection.find(params[:id])
      end
    end

    def create
      @category = Category.create(category_params)
      redirect_to admin_category_path(@category)
    end

    def update 
      @category = Category.friendly.find(params[:id])
      @category.update(category_params)
      redirect_to admin_category_path(@category)
    end

    private

      def category_params
        params.require(:category).permit(:name, :slug)
      end

  end

end
