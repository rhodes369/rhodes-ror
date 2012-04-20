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
    
    # for tracking when to show the results: # text on /materials page on a users first search
    session[:not_first_mat_search] = 1       
  end
      
    
  def show
    @material = Material.find_using_slug(params[:id])   
    
    unless @material.nil?
      @materials = Material.all
      @material_sorted_images = @material.sort_thumb_images
      @image = Image.new # for new image form
      @all_material_types = MaterialType.all
      @all_finishes = Finish.order(:title)
      @all_applications = Application.order(:title)

      # left sidebar
      @materials_antique_in_title = Material.antique_in_title
      @materials_alpha = Material.alphabetical # for sidebar edit links    
      @materials_newly_crafted_sidebar = Material.newly_crafted_without_antiques # all mats excluding antiques     
    else
      redirect_to materials_path, notice: 'No material found' if @material.nil?
    end 
  end
  
  
  # TODO: move as much of this logic into model as possible
  # materials index search filters (ajax)
  def search  
    filters = params[:filters] ||= {}
    results = {}
    results['newly_crafted'] = {}
    results['antiques'] = {}
    
    logger.debug "params search(filters): #{filters.inspect}"
    
    antiques_in_title = Material.antique_in_title_results(filters)
    newly_crafted = Material.newly_crafted(filters)
    
    results['newly_crafted']['count'] = newly_crafted.count
    results['newly_crafted']['html'] = render_to_string( 
      partial: 'materials/search/newly_crafted/header', locals: { results: results}) 
    
    results['antiques']['count'] = antiques_in_title.count
    results['antiques']['html'] = render_to_string( 
      partial: 'materials/search/antiques/header', locals: { results: results})     
    
    # filter newly crafted
    if results['newly_crafted']['count'] > 0   
      newly_crafted.each do |mat|     
        default_image = nil # reset
        
        unless mat.default_image_id.nil?
          default_image = Image.find(mat.default_image_id).image.url(:thumb)
        end
        
        results['newly_crafted']['html'] += render_to_string(
          partial: 'materials/search/newly_crafted/item', 
            locals: { mat: mat, default_image: default_image })
      end 
    end
    
    # filter antiques
    if results['antiques']['count'] > 0   
      antiques_in_title.each do |mat|     
        default_image = nil # reset
        
        if Image.exists?(mat.default_image_id)
          default_image = Image.find(mat.default_image_id).image.url(:thumb)
        end
        
        results['antiques']['html'] += render_to_string(
          partial: 'materials/search/antiques/item', 
            locals: { mat: mat, default_image: default_image })
      end 
    end    
      
    respond_to do |format|      
      format.json { render json: { type: 'ok', status: :success, results: results }}
    end 
  end   
end