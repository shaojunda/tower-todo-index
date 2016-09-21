class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_days

  def current_days
    @current_days ||= find_day
  end

  private

  def find_day
    days = session[:days]

    if days.blank?
      days = []
    end

    session[:days] = days

    days
  end
end
