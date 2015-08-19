# Movie entity
class Movie < ActiveRecord::Base
  has_many :sessions
  validates_uniqueness_of :aid
  has_attached_file :poster, styles: {
    small: '200x200>'
  }
  validates_attachment_content_type :poster, content_type: %r{\Aimage\/.*\Z}

  # Return sessions grouped by date
  # @return [Hash<Date,DateTime>]
  def sessions_by_date_for(interval)
    dates = {}
    sessions.where(date: interval).pluck(:date).each do |datetime|
      dates[datetime.to_date] ||= []
      dates[datetime.to_date] << datetime
    end
    dates
  end

  def self.current_week
    joins(:sessions).where(
      'sessions.date' => ApplicationController.helpers.current_theater_week
    ).distinct
  end

  def self.next_week
    joins(:sessions).where(
      'sessions.date' => ApplicationController.helpers.next_theater_week
    ).distinct
  end

  def allocine_link
    "http://www.allocine.fr/film/fichefilm_gen_cfilm=#{aid}.html"
  end
end
