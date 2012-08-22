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
    thumb_image_url = nil
        
    results = {}
    results['newly_crafted'] = {}
    results['antiques'] = {}
   
    logger.debug "params search(filters): #{filters.inspect}"
    
    antique_in_title = Material.antique_in_title_results(filters)
    newly_crafted = Material.newly_crafted(filters)
    use_special_finish_filter_only_results = check_finish_filter_only(filters)
    
    results['newly_crafted']['count'] = newly_crafted.count
    results['newly_crafted']['html'] = render_to_string( 
      partial: 'materials/search/newly_crafted/header', locals: { results: results}) 
    
    results['antiques']['count'] = antique_in_title.count
    results['antiques']['html'] = render_to_string( 
      partial: 'materials/search/antiques/header', locals: { results: results})     


    # filter newly crafted
    if results['newly_crafted']['count'] > 0   
      newly_crafted.each do |mat|     
        # default_image = nil # reset        
        # search_icon_image = nil # reset
        # 
        # unless mat.default_image_id.nil?
        #   default_image = Image.find(mat.default_image_id).image.url(:thumb)
        # end
        # 
        # unless mat.search_icon_image_id.nil?
        #   search_icon_image = Image.find(mat.search_icon_image_id).image.url(:thumb)
        # end
        
        
        # # by default use icon thumb for search index + finish filters only, 
        # # otherwise use default/1st thumb
        # thumb_image_url = ( filters.empty? or !use_special_finish_filter_only_results) ? search_icon_image : default_image
        # 
        # # special case for finish only search filtering... (use first thumb assoc. with finish )
        # if use_special_finish_filter_only_results
        #   mat_images_with_finish = nil # reset
        #   mat_images_with_finish = mat.all_images_with_finish(filters[:mat_finish_id].to_i)
        # 
        #   if mat_images_with_finish.count > 0
        #     thumb_image = mat_images_with_finish.first
        #     thumb_image_url = thumb_image.image.url(:thumb)
        #   end
        # end
        
        thumb_image_url = self.get_thumb_image_url(mat,filters,use_special_finish_filter_only_results)
        
        results['newly_crafted']['html'] += render_to_string(
          partial: 'materials/search/newly_crafted/item', 
            locals: { mat: mat, thumb_image_url: thumb_image_url })
      end 
    end
    
    # filter antiques
    if results['antiques']['count'] > 0   
      antique_in_title.each do |mat|     
        # default_image = nil # reset
        # search_icon_image = nil # reset
        # 
        # unless mat.default_image_id.nil?
        #   default_image = Image.find(mat.default_image_id).image.url(:thumb)
        # end
        # 
        # unless mat.search_icon_image_id.nil?
        #   search_icon_image = Image.find(mat.search_icon_image_id).image.url(:thumb)
        # end
        # 
        # # use icon thumb for search index + finish filters only, otherwise use default/1st thumb
        # thumb_image_url = ( filters.empty? or !filters['mat_finish_id'].nil?) ? search_icon_image : default_image
        
        thumb_image_url = self.get_thumb_image_url(mat,filters,use_special_finish_filter_only_results) 
        
        results['antiques']['html'] += render_to_string(
          partial: 'materials/search/antiques/item', 
            locals: { mat: mat, thumb_image_url: thumb_image_url })
      end 
    end    
      
    respond_to do |format|      
      format.json { render json: { type: 'ok', status: :success, results: results }}
    end 
  end 
  

  def get_thumb_image_url(mat,filters,use_special_finish_filter_only_results)
    default_image = nil # reset        
    search_icon_image = nil # reset
    thumb_image_url = nil
    
    unless mat.default_image_id.nil?
      default_image = Image.find(mat.default_image_id).image.url(:thumb)
    end

    unless mat.search_icon_image_id.nil?
      search_icon_image = Image.find(mat.search_icon_image_id).image.url(:thumb)
    end
    

    # by default use icon thumb for search index + finish filters only, 
    # otherwise use default/1st thumb
    thumb_image_url = ( filters.empty? or !use_special_finish_filter_only_results) ? search_icon_image : default_image
  
    # special case for finish only search filtering... (use first thumb assoc. with finish )
    if use_special_finish_filter_only_results
      mat_images_with_finish = nil # reset
      mat_images_with_finish = mat.all_images_with_finish(filters[:mat_finish_id].to_i)
  
      if mat_images_with_finish.count > 0
        thumb_image = mat_images_with_finish.first
        thumb_image_url = thumb_image.image.url(:thumb)
      end
    end 
  
    return thumb_image_url 
  end
  
  def check_finish_filter_only(filters)
    if !filters['mat_finish_id'].nil? and filters[:mat_app_id].blank? and filters[:mat_type_id].blank?
      return true
    else
      return false
    end
  end

end