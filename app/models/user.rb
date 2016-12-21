class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  #relative

  has_one  :avatar, as: :attachable, class_name: "Attachment",dependent: :destroy
  has_many :posts,dependent: :destroy      

  #friendly_id
  extend FriendlyId
  friendly_id :name, use: :slugged  

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
      if user
       return user
      else
        registered_user = User.where(:email => auth.info.email).first
        if registered_user
          return registered_user
        else
          if auth.info.email.present?
            user = User.create(
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            name:auth.info.name,
                            password:Devise.friendly_token[0,20],
                          )
            user.create_avatar(image: auth.info.image.gsub('http://','https://'))
            user
          else
            email = "facebook" + Devise.friendly_token[0,20] + "@vuivon.com"
            user = User.create(
                            provider:auth.provider,
                            uid:auth.uid,
                            email: email,
                            name:auth.info.name,
                            password:Devise.friendly_token[0,20],
                          )
            user.create_avatar(image: auth.info.image.gsub('http://','https://'))
            user
          end
        end    
     end
  end

end
