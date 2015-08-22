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

  def unsubscribe
    destroyed_users = User.destroy_all(email: params[:email])
    result = destroyed_users.count > 0 ? :success : :error
    flash[result] = t("email.remove.#{result}")
    redirect_to root_path
  end

  def contact
    @contact = Contact.new
  end

  def contact_send
    @contact = Contact.new(contact_params)
    result = :invalid
    result = send_email(@contact) if @contact.valid?

    if result == :success
      flash[:success] = t(".#{result}")
      redirect_to :root
    else
      flash[:error] = t(".#{result}")
      render :contact
    end
  end

  private

  # Relative to #contact_send, just send contact email
  # @param [Contact] contact
  # @return [Symbol] return status of the send : `:success` or `:error`
  def send_email(contact)
    result = :flood
    Rails.cache.fetch("contact.flood_control.#{session.id}",
                      expires_in: 1.hour) do
      MainMailer.contact(contact.name, contact.email,
                         contact.message).deliver_later
      result = :success
    end
    result
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
