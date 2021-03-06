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
    amovie = Allocine::Movie.new(movie['code'])
    Movie.where(aid: amovie.id).first_or_create(
      aid: amovie.id,
      title: amovie.title,
      runtime: amovie.length,
      poster: URI.parse(amovie.poster),
      plot: ActionView::Base.full_sanitizer.sanitize(amovie.plot(false)),
      actors: amovie.actors_name,
      directors: amovie.directors_name
    )
  end
end
