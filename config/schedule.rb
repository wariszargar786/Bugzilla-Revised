set :output, "#{path}/log/cron_log.log"
every 1.minute do
  puts "echo 'Send Daily Email to All Managers'"
  rake 'send_daily_email_to_manager'
end
