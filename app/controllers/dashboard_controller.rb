class DashboardController < ApplicationController
  before_action :require_user

  def index
    guests = @current_user.guests
    @parties = guests.map do |guest|
      Party.find_by(id: guest.party_id)
    end
  end

  private

  def require_user
    render file: 'public/404' unless current_user
  end
end
