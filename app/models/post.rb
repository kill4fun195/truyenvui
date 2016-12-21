class Post < ActiveRecord::Base

  enum post_type: {anh_che: 0, truyen_cuoi: 1}
  enum status: {reject: 0, accept: 1, pending: 2 }

  has_one :avatar, as: :attachable, class_name: "Attachment",dependent: :destroy
  belongs_to :user
  belongs_to :category

  #friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged
  
end
