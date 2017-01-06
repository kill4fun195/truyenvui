task :update_like_view => :environment do
  Post.publish.order(publish: :desc).limit(10).each do |item|
    like_rand_anh_che = rand(2..4)
    view_rand_anh_che = rand(14..18)
    like_rand_truyen_cuoi = rand(3..5)
    view_rand_truyen_cuoi = rand(15..25)
    @user = User.find(item.user_id)
    if item.anh_che?
      @post = item.update(like: item.like + like_rand_anh_che, view: item.view + view_rand_anh_che)
      @user.update(like_week: @user.like_week + like_rand_anh_che, like_month: @user.like_month + like_rand_anh_che, like_total: @user.like_total + like_rand_anh_che)
    elsif item.truyen_cuoi?
      @post = item.update(like: item.like + like_rand_truyen_cuoi, view: item.view + view_rand_truyen_cuoi)
      @user.update(like_week: @user.like_week + view_rand_truyen_cuoi, like_month: @user.like_month + like_rand_truyen_cuoi, like_total: @user.like_total + like_rand_truyen_cuoi)
    end
  end
end

task :publish_anh_che => :environment do
  Post.anh_che.accept.order(updated_at: :asc).first.update(publish: Time.zone.now, status: 3)
end
task :publish_truyen_cuoi => :environment do
  Post.truyen_cuoi.accept.order(updated_at: :asc).first.update(publish: Time.zone.now, status: 3)
end
