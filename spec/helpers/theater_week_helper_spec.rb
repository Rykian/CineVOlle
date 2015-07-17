require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TheaterWeekHelperHelper. For example:
#
# describe TheaterWeekHelperHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TheaterWeekHelper, type: :helper do
  describe '.current_theater_week' do
    it 'include today' do
      expect(current_theater_week).to cover Date.today
    end

    it 'not include yesterday' do
      expect(current_theater_week).not_to cover Date.today - 1.day
    end

    it 'not include today + a week' do
      expect(current_theater_week).not_to cover Date.today + 1.week
    end

    it 'not include today - a week' do
      expect(current_theater_week).not_to cover Date.today - 1.week
    end
  end

  describe '.next_theater_week' do
    it 'not include today' do
      expect(next_theater_week).not_to cover Date.today
    end

    it 'include today + 1 week' do
      expect(next_theater_week).to cover Date.today + 1.week
    end

    it 'not include today + 2 week' do
      expect(next_theater_week).not_to cover Date.today + 2.weeks
    end
  end
end
