# Preview all emails at http://localhost:3000/rails/mailers/schedual_mailer
class SchedualMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/schedual_mailer/user_mail
  def user_mail
    SchedualMailer.user_mail
  end

end
