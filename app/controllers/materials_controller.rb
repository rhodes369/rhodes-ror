class MaterialsController < ApplicationController
  layout 'application'
  
  def index
    @material = Material.new
    @materials = Material.alphabetical
    @materials_newly_crafted = Material.newly_crafted.limit(5)
    
    # filter pulldown values
    @all_finishes = Finish.order('title ASC')
    @all_material_types = Finish.order('title ASC')     
  end
      
    
  def show
    @material = Material.find(params[:id])
  end
  
end
