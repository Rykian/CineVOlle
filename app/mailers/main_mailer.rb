# Main mailer class
class MainMailer < ApplicationMailer
  # Send summary of next theater session
  # @param [User] user
  def weekly(user)
    @user = user
    week = ApplicationController.helpers.current_theater_week
    @current_week = Movie.current_week

    subject = default_i18n_subject(begin: l(week.begin, format: :long),
                                   end: l(week.end, format: :long))

    headers['List-Unsubscribe'] = unsubscribe_url(email: user.email)
    mail(to: user.email,
         subject: subject)
  end

  # Send contact requests
  # @param [String] name
  # @param [String] email
  # @param [String] message
  def contact(name, email, message)
    @name = name
    @email = email
    @message = message

    mail(to: ENV['CONTACT_EMAIL'], reply_to: @email)
  end
end
