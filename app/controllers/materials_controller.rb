class MaterialsController < ApplicationController
  
  def index
    @material = Material.new
    @materials = Material.all
  end  
    
  def show
    @material = Material.find(params[:id])
  end
end
