class Admin::AdminController < ApplicationController
  layout 'admin/layouts/application'
  
  def index
    render 'admin/index'
  end
end
