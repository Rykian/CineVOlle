# Adding a poster field to [Movie]
class AddMoreInformationsToMovie < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.attachment :poster
      t.text :plot
      t.string :actors, array: true, default: []
      t.string :directors, array: true, default: []
    end

    reversible do |dir|
      dir.up { post_up }
    end
  end

  def post_up
    say_with_time 'Updating existing Movies entity' do
      Movie.all.each do |movie|
        amovie = Allocine::Movie.new(movie.aid)
        movie.runtime = amovie.length # Upgrade to get runtime in minutes
        movie.poster = URI.parse(amovie.poster)
        movie.plot = amovie.plot(false)
        movie.actors = amovie.actors_name
        movie.directors = amovie.directors_name
        movie.save
      end
      Movie.count
    end
  end
end
