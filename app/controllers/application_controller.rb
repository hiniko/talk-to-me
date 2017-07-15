class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action do |controller|
    # Check to see if a tracking cookie exists 
    if cookies.signed[:id].blank?
      id = SecureRandom.hex 24
      cookies.signed[:id] = id
      @current_user = id
    end
      
  end

end
