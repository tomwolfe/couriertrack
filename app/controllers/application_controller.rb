class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_courier
  
  private
  
  def current_courier_session
    return @current_courier_session if defined?(@current_courier_session)
    @current_courier_session = CourierSession.find
  end
  
  def current_courier
    return @current_courier if defined?(@current_courier)
    @current_courier = current_courier_session && current_courier_session.record
  end
end