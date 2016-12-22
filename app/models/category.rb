class Category < ActiveRecord::Base

  has_many :posts, -> {where(post_type: 1)},dependent: :destroy

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
  
end
