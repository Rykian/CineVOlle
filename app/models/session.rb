# Theaters sessions (linked to movies)
class Session < ActiveRecord::Base
  belongs_to :movie

  validates_uniqueness_of :movie_id, scope: :date
end
