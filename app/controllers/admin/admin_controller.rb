class Admin::AdminController < ApplicationController

  before_filter :require_login
  
  layout 'admin/layouts/application'
  
  def index
    render 'admin/index'
  end
end
