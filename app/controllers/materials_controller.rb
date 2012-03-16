class MaterialsController < ApplicationController
  layout 'application'
  
  def index
    @material = Material.new
    @materials = Material.all
    @materials_newly_crafted = Material.newly_crafted
  end  
    
  def show
    @material = Material.find(params[:id])
  end
  
end
