class Admin::AdminController < ApplicationController
  def index
    @materials = Material.all #.order 'DESC'
    @material = Material.new
    render 'admin/index'
  end
end
