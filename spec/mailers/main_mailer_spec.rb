require 'rails_helper'

RSpec.describe MainMailer, type: :mailer do
  describe '.weekly' do
    user = User.create(email: 'test@example.com')
    let(:email) { MainMailer.weekly(user) }

    it 'send a mail to the selected user' do
      expect(email).to deliver_to user.email
    end

    it 'sends with a reply-to to my email' do
      expect(email).to reply_to 'rykian@gmail.com'
    end

    it 'contains an unsubscribe link' do
      expect(email.body).to include unsubscribe_url(email: user.email)
    end

    it 'contains header List-Unsubscribe' do
      expect(email).to have_header('List-Unsubscribe',
                                   unsubscribe_url(email: user.email))
    end
  end
end
