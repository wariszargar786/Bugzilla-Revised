require "test_helper"

class SchedualMailerTest < ActionMailer::TestCase
  test "user_mail" do
    mail = SchedualMailer.user_mail
    assert_equal "User mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
