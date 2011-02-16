class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_courier, :current_user
  
  private
  
  def current_courier_session
    return @current_courier_session if defined?(@current_courier_session)
    @current_courier_session = CourierSession.find
  end
  
  def current_courier
    return @current_courier if defined?(@current_courier)
    @current_courier = current_courier_session && current_courier_session.record
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end