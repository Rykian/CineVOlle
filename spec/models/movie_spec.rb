require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { is_expected.to validate_uniqueness_of :aid }
  it { is_expected.to have_many :sessions }
end
