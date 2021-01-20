desc 'Whenever rake task test'
task send_daily_email_to_manager: :environment do
	scheduale = SchedualesController.new
	scheduale.send_email
end
