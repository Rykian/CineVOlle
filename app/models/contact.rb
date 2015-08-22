# Class for contact object without persistence
class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :message

  validates :name, :email, :message, presence: true
  validates_format_of :email, with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i

  def initialize(attributes = {})
    attributes.each do |name, value|
      send "#{name}=", value
    end
  end
end
