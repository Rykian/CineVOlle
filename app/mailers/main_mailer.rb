# Main mailer class
class MainMailer < ApplicationMailer
  include TheaterWeekHelper
  helper TheaterWeekHelper

  # Send summary of next theater session
  # @param [User] user
  def weekly(user)
    current_week = current_theater_week
    @current_week = Movie.joins(:sessions).where(
      'sessions.date' => current_week
    ).distinct

    subject = default_i18n_subject(begin: l(current_week.begin, format: :long),
                                   end: l(current_week.end, format: :long))

    mail(to: user.email,
         subject: subject)
  end
end
