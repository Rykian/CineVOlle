# Movie entity
class Movie < ActiveRecord::Base
  has_many :sessions
  validates_uniqueness_of :aid

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
      'sessions.date' => current_theater_week
    ).distinct
  end

  def self.next_week
    joins(:sessions).where(
      'sessions.date' => next_theater_week
    ).distinct
  end
end
