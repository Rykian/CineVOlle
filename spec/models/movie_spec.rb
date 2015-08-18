require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { is_expected.to validate_uniqueness_of :aid }
  it { is_expected.to have_many :sessions }
  it { is_expected.to have_attached_file :poster }
  it do
    is_expected.to validate_attachment_content_type(:poster)
      .allowing('image/png', 'image/gif', 'image/jpg')
      .rejecting('text/plain', 'text/xml')
  end
end
