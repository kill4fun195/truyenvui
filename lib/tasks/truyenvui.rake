task :create_data_truyenvui => :environment do
  require 'mechanize'
  agent = Mechanize.new 
  page = agent.get("http://www.truyencuoi.vn/")
  array_category = []
  page.search(".view-the-loai-truyen .views-field-name a").each {|x| array_category.push(x.text)}
  array_category.each do |name_category| 
    category = Category.create(name: name_category)
    category_id = category.id
    page_category = page.link_with(:text => name_category.to_s).click
    first_page = 0
    last_page = page_category.search(".pager-last a").attr("href").to_s.split("?page=")[1].to_i
    j = 1
    while first_page < last_page + 1
      current_page_of_category = agent.get(page_category.uri.to_s+"?page=#{first_page}")
      i = 0
      while i < current_page_of_category.search(".node-truyen-cuoi h2 a").size
        article = current_page_of_category.link_with(:text => current_page_of_category.search(".node-truyen-cuoi h2 a")[i].text).click
        Post.create(title: article.search("#tabs-wrapper h1").text, content: article.search(".content .field-item").to_s, user_id: rand(1..20), category_id: category_id,source: "truyencuoi",post_type: 1,status: 1, view: 1)
        puts "category #{name_category} article #{j}"
        i += 1
        j += 1
      end
      first_page += 1
    end
  end
end

task :create_data_truyen_haivn => :environment do
  require 'mechanize'
  agent = Mechanize.new 
  host = "http://haivn.com"
  page_number = 1
  while page_number < 80
    page = agent.get("http://haivn.com/truyen/page/#{page_number}")
    page_content =  Nokogiri::HTML page.body
    i = 0
    while i < 12
      sleep 1
      if  Post.truyen_cuoi.pluck(:title).include?(page_content.search(".detail-info .badge-item-title a")[i].text) 
        i += 1
        puts "adsadadadasdasd"
        next
      end
      article = agent.get(host+page_content.search(".detail-info .badge-item-title a")[i].attr("href"))
      article_content =  Nokogiri::HTML article.body
      article_content.search(".post-header .badge-item-title").text
      article_content.search(".badge-post-container .text-content").to_s
      Post.create(title: article_content.search(".post-header .badge-item-title").text, content: article_content.search(".badge-post-container .text-content").to_s, user_id: rand(1..20) , category_id: 1, source: "vuivonvuivon", post_type: 1,view: 1)
      puts "book #{i}"
      i += 1
    end
    page_number += 1
  end
end

task :create_data_anh_hai_haivn => :environment do

  require 'mechanize'
  agent = Mechanize.new
  page_number = 1
  while(page_number < 3500) 
  post_title = []
  post_img_url = []
  page = agent.get("http://haivn.com/photo/page/#{page_number}")
  page_content =  Nokogiri::HTML page.body
  page_content.search("#haivl-list-content .haivl-photo .image img").each{ |x| post_img_url.push(x.attr("src").split("//")[1])}
  page_content.search("#haivl-list-content .detail-info .badge-item-title a").each{ |x| post_title.push(x.text)}
  i = 0
  while(i < 12)
    post = Post.create(title: post_title[i], post_type: 0, user_id: rand(1..20), source: "vuivonvuivon",view: 1)
    img_url = "https://" + post_img_url[i]
    puts img_url
    anh_che = post.create_avatar(image: img_url)
    puts anh_che.image.url
    i += 1
  end
  puts "trang #{page_number}"
  page_number += 1
  end
end

