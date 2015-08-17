namespace :cinevolle do
  desc 'Update screening dates'
  task update_screenings: :environment do
    result = Allocine::ShowtimeList.search_by(theaters: ['P1140'])
    sessions = result['feed']['theaterShowtimes'].first['movieShowtimes']

    # Select only sessions with original version which is not french
    original_versions = sessions.keep_if do |screening|
      version = screening['version']
      version['original'] == 'true' && version['code'] != 6001
    end

    AllocineConverter.update_sessions(original_versions)
  end

  desc 'Sending newsletter with OV sessions'
  task send_newsletter: :environment do
    next if Date.today.wday != 3
    movies = Movie.current_week

    User.all.each do |user|
      MainMailer.weekly(user).deliver_later
    end if movies.count > 0
  end
end
