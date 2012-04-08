class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    render :root
  end
  
  # redirect to root route with alert, and log it
  def bad_route
    redirect_to :root, alert: "Sorry, the url: #{request.fullpath} was not found"
    logger.error "Bad route requested for #{request.fullpath}"
  end
end
