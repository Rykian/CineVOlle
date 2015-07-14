# Movie entity
class Movie < ActiveRecord::Base
  has_many :sessions
  validates_uniqueness_of :aid
end
