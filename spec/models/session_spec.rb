require 'rails_helper'

RSpec.describe Session, type: :model do
  it { is_expected.to belong_to :movie }
  it { is_expected.to validate_uniqueness_of(:movie_id).scoped_to(:date) }
end
