task :create_user => :environment do
  full_name = ["Đơ Như Nitơ","Kẹo Cực Đắng","Củ Chuối Vô Tình","Em Bị Ế","Cầy Con Lon Ton","Lò Thị Mẹt","Lần Thị Lượt","Thiên Sứ Già","Ngụy Khánh Kinh","Trần Anh","Phạm Bách","Cú Có Đeo","Nguyễn Công","Tòng Văn Tánh","Trần Đức","Trần Dương","Phạm Đạt","Phạm Chí","Trần Mỹ Tường","Nguyễn Lâm"]
  full_name.each_with_index do |name,index|
      User.create(name: name, email: "facebook"+"#{index*1234}"+"@vuivon.com", password: Devise.friendly_token[0,20], provider: "facebook")
  end
  puts "create users successfully"
end
