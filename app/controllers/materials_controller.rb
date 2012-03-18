class MaterialsController < ApplicationController
  layout 'application'
  
  def index
    @material = Material.new # for optionally creating a new material on the index
    @materials = Material.alphabetical # for sidebar edit links
    @materials_newly_crafted = Material.newly_crafted.limit(5) # array of newly created mats
    
    # populate filter pulldown values
    @all_mat_finishes = Finish.order(:title)
    @all_mat_types = MaterialType.order('title ASC')
    @all_mat_apps = Application.order(:title)     
  end
      
    
  def show
    # @all_mat_antiques = []
    # antique_finish = Finish.find_by_title('Antique') 
    @material = Material.find(params[:id]) 
    # #@all_mat_antiques = MaterialFinish.where(finish_id: antique_finish.id) 
    # mat_ids_with_antiques = MaterialFinish.where(finish_id: antique_finish.id).map(&:id)
    # mat_ids_with_antiques.each do |mat_id| 
    #   @all_mat_antiques <<  Material.find(mat_id)
    # end
  end
end