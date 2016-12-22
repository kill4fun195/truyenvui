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
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates 
    remove_vietnamese_character(self.name)
  end

  def remove_vietnamese_character(string)
  # break if string is empty
    return string if string.nil? || string.empty?
    return string.gsub(/[àáạảãâầấậẩẫăằắặẳẵ]/, "a")
      .gsub(/[èéẹẻẽêềếệểễ]/, "e")
      .gsub(/[ìíịỉĩ]/, "i")
      .gsub(/[òóọỏõôồốộổỗơờớợởỡ]/, "o")
      .gsub(/[ùúụủũưừứựửữ]/, "u")
      .gsub(/[ỳýỵỷỹ]/, "y")
      .gsub(/[đ]/, "d")
      .gsub(/[ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ]/, "A")
      .gsub(/[ÈÉẸẺẼÊỀẾỆỂỄ]/, "E")
      .gsub(/[ÌÍỊỈĨ]/, "I")
      .gsub(/[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]/, "O")
      .gsub(/[ÙÚỤỦŨƯỪỨỰỬỮ]/, "U")
      .gsub(/[ỲÝỴỶỸ]/, "Y")
      .gsub(/[Đ]/, "D")
      .gsub(/[\u0300]/,"")
      .gsub(/[\u0301]/,"")
      .gsub(/[\u0302]/,"")
      .gsub(/[\u0303]/,"")
      .gsub(/[\u0306]/,"")
      .gsub(/[\u0309]/,"")
      .gsub(/[\u0323]/,"")
      .gsub(/[\u031B]/,"")
  end  

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
