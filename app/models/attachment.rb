class Attachment < ActiveRecord::Base
  
  belongs_to :attachable, polymorphic: true

  #paperclip
  has_attached_file :image, 
                  :processors => [:watermark], 
                  :url => "/system/:class/:attachment/:id_partition/:style/:filename",
                  :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename",
                  :styles => { 
                    :medium => { 
                            :processors => [:watermark],
                            :geometry => '',
                            :watermark_path => Rails.root.join('app/assets/images/watermark-domain.png'),
                            :position => 'North'
                        },
                  },
                  dependent: :allow_destroy
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
