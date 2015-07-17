# Manage weeks for theater (from wednesday to tuesday)
module TheaterWeekHelper
  # Get current theater week interval (from next wednesday to next tuesday
  # included)
  def current_theater_week
    to = Date.today.next_week.next_day(2)
    to -= 1.week if Date.today.wday <= 2

    Date.today..to
  end

  # Get next theater week interval (from next wednesday to next tuesday
  # included)
  def next_theater_week
    from = Date.today.next_week.next_day(2)
    from -= 1.week if Date.today.wday <= 2

    from..(from + 1.week)
  end
end
