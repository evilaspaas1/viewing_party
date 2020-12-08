class DashboardController < ApplicationController
  before_action :require_user

  def index
    # require "pry"; binding.pry
    guests = @current_user.guests
    @parties = guests.map do |guest|
      Party.find_by(id: guest.party_id)
    end
    # require "pry"; binding.pry
  end

  private

  def require_user
    render file: "public/404" unless current_user
  end
end
