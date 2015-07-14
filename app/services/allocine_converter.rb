# Convert Allocine data into ActiveRecord objects
class AllocineConverter
  # Update screening list
  # @param sessions [Hash] return from showtimelist Allocine API
  def self.update_sessions(sessions)
    sessions.each do |session|
      movie = AllocineConverter.find_or_create_movie(session['onShow']['movie'])

      session['scr'].each do |s|
        date = DateTime.strptime(
          s['d'] + ' ' + s['t'].first['$'],
          '%Y-%m-%d %H:%M'
        )
        Session.create(movie: movie, date: date)
      end
    end
  end

  # Convert Allocine movie data into [Movie]
  # @param movie [Hash] Allocine movie hash
  # @return [Movie] Old or newly created movie
  def self.find_or_create_movie(movie)
    Movie.where(aid: movie['code']).first_or_create(
      aid: movie['code'],
      title: movie['title'],
      runtime: movie['runtime']
    )
  end
end
