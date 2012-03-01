class MaterialsController < ApplicationController
  
  def index
    @materials = Material.all #.order 'DESC'
    @material = Material.new
  end  
    
  def show
    @material = Material.find(params[:id])
  end
end
