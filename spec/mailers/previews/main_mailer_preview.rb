# Preview all emails at http://localhost:3000/rails/mailers/main_mailer
class MainMailerPreview < ActionMailer::Preview
  def weekly
    MainMailer.weekly(User.first)
  end
end
