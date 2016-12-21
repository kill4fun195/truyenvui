class CategoriesController < ApplicationController
  layout "frontend"

  def show
    @category = Category.friendly.find(params[:id])
    @posts = @category.posts
  end

end
