require 'rails_helper'

RSpec.describe AllocineConverter do
  describe '.update_sessions' do
  end

  describe '.find_or_create_film' do
    # Reset movie
    Movie.where(aid: 215_097).destroy_all
    amovie = Allocine::Movie.find_by_id(215_097)

    it 'is not in database' do
      expect(Movie.where(aid: 215_097).first).to be_nil
    end

    it 'has just been created' do
      expect(Movie.where(aid: 215_097).count).to eq 0
      movie = AllocineConverter.find_or_create_movie(amovie)
      expect(movie.persisted?).to be true
    end

    it 'fetch already created object' do
      movie = AllocineConverter.find_or_create_movie(amovie)
      expect(movie.new_record?).to be false
    end
  end
end
