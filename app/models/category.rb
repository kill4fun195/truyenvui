class Category < ActiveRecord::Base

  has_many :posts, -> {where(post_type: 1)},dependent: :destroy

  #friendly_id
  extend FriendlyId
  friendly_id :name, use: :slugged
  
end
