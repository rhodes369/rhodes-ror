class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    redirect_to '/' # default to /public/index.html
  end
  
  # redirect to /public/index.html with alert, and log it
  def bad_route
    redirect_to '/', alert: "Sorry, the url: #{request.fullpath} was not found"
    logger.error "Bad route requested for #{request.fullpath}"
  end
end
