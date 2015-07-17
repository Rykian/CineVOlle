# Main class for webapp
class WelcomeController < ApplicationController
  include TheaterWeekHelper

  def index
    @current_week = Movie.joins(:sessions).where(
      'sessions.date' => current_theater_week
    ).distinct

    @next_week = Movie.joins(:sessions).where(
      'sessions.date' => next_theater_week
    ).distinct
  end

  def register
    user = User.create(email: params[:email])
    result = user.valid? ? :success : :error

    respond_to do |format|
      format.html do
        flash[result] = t(result, scope: 'email.add')
        redirect_to :root
      end
      format.json { render json: { result => t(result, scope: 'email.add') } }
    end
  end
end
