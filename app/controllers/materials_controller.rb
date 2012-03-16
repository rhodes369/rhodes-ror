class MaterialsController < ApplicationController
  layout 'application'
  
  def index
    @material = Material.new
    @materials = Material.alphabetical
    @materials_newly_crafted = Material.newly_crafted.limit(5)
  end  
    
  def show
    @material = Material.find(params[:id])
  end
  
end
