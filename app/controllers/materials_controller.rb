class MaterialsController < ApplicationController
  layout 'application'
  
  def index
    @material = Material.new # for optionally creating a new material on the index
    @materials_newly_crafted = Material.newly_crafted # array of newly created mats
    
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
  
  # TODO: move as much of this logic into model as possible
  # materials index search filters (ajax)
  def search  
    filters = params[:filters] ||= {}
    results = {}
    results['newly_crafted'] = {}
    
    logger.debug "params (search()): #{filters.inspect}"
    
    antiques = Material.antique_in_title
    newly_crafted = Material.newly_crafted(filters)
    
    results['newly_crafted']['count'] = newly_crafted.count # ||= 0
   
    # also move to model
    results['newly_crafted']['html'] = render_to_string( 
      partial: 'materials/search/newly_crafted_header', locals: { results: results})      
    
    if results['newly_crafted']['count'] > 0   
      newly_crafted.each do |mat|     
        default_image = nil # reset
        
        unless mat.default_image_id.nil?
          default_image = Image.find(mat.default_image_id).image.url(:thumb)
        end
        
        results['newly_crafted']['html'] += render_to_string(
          partial: 'materials/search/newly_crafted_item', 
            locals: { mat: mat, default_image: default_image })
      end 
    end 
    
    respond_to do |format|      
      format.json { render json: { type: 'ok', status: :success, results: results }}
    end 
  end   
end