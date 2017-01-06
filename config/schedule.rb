set :output, "log/cron_log.log"
set :environment, 'development' 
every 55.minutes do # 1.minute 1.day 1.week 1.month 1.year is also supported 
  rake "publish_truyen_cuoi"
end

every 6.minutes do # 1.minute 1.day 1.week 1.month 1.year is also supported 
  rake "publish_anh_che"
end

every 3.minutes do # 1.minute 1.day 1.week 1.month 1.year is also supported 
  rake "update_like_view"
end

every '59 23 21 * *' do
  runner "User.update_all('like_week = 0')"
end

every '59 23 * * 0' do
  runner "User.update_all('like_month = 0')"
end
