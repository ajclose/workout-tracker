require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    @user = User.new(email: "test@example.com", password: "password", password_confirmation: "password")
    @user.save
  end

  test "account_activation" do
    user = @user
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end


end
