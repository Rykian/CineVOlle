require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to allow_value('test@example.com').for(:email) }
  it { is_expected.not_to allow_value('Blabla bla').for(:email) }
end
