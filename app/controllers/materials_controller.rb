class MaterialsController < ApplicationController
  layout 'application'
  
  def index
    @material = Material.new # for optionally creating a new material on the index
    @materials_newly_crafted = Material.newly_crafted_with_images # array of newly created mats
    
    # left sidebar
    @materials_antique_in_title = Material.antique_in_title
    @materials_alpha = Material.alphabetical # for sidebar edit links    
    @materials_newly_crafted_sidebar = Material.newly_crafted_without_antiques # all mats excluding antiques
    
    # populate filter pulldown values
    @all_mat_finishes = Finish.order(:title)
    @all_mat_types = MaterialType.order('title ASC')
    @all_mat_apps = Application.order(:title)     
  end
      
    
  def show
    @material = Material.find(params[:id]) 
    
    # left sidebar
    @materials_antique_in_title = Material.antique_in_title
    @materials_alpha = Material.alphabetical # for sidebar edit links    
    @materials_newly_crafted_sidebar = Material.newly_crafted_without_antiques    
  end
  
  # TODO: move most of logic into model
  # materials index search filters (ajax)
  def search
    filters = params[:filters] || {}
    antiques = Material.antique_in_title
    newly_crafted_with_images = Material.newly_crafted_with_images
    
    if newly_crafted_with_images.count > 0
      newly_crafted_html = render_to_string(partial: 'materials/search/newly_crafted_header', locals: { filters: filters })      
      newly_crafted_with_images.each do |mat| 
        newly_crafted_html += render_to_string(partial: 
        'materials/search/newly_crafted_item', locals: { 
        newly_crafted_with_images: newly_crafted_with_images 
        })
      end   
    end
       
    respond_to do |format|      
      format.json { render json: { type: 'ok', status: :success, newly_crafted_html: newly_crafted_html }}
    end 
  end   

end