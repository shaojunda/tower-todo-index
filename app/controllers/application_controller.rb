class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_days
  helper_method :current_owners

  def current_days
    @current_days ||= find_day
  end

  def current_owners
    @current_owners ||= find_owner
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

  def find_owner
    owners = session[:owners]

    if owners.blank?
      owners = []
    end

    session[:owners] = owners

    owners
  end
end
