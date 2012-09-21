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
    
    if @material.nil? 
      redirect_to materials_path, notice: 'No material found'
    else

        
      unless @material.images.blank?
        @material_sorted_images = @material.sort_thumb_images
        unless @material.default_image_id.nil?
          @default_image = Image.find(@material.default_image_id)
        end
      end
      
      @all_material_types = MaterialType.all
      @all_finishes = Finish.order(:title)
      @all_applications = Application.order(:title)

      # left sidebar
      @materials_antique_in_title = Material.antique_in_title
      @materials_alpha = Material.alphabetical # for sidebar edit links    
      @materials_newly_crafted_sidebar = Material.newly_crafted_without_antiques    
  
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
   
    newly_crafted = Material.newly_crafted(filters)
    antique_in_title = Material.antique_in_title_results(filters)

    use_special_result_images = special_result_images(filters)
    
    results['newly_crafted']['count'] = newly_crafted.count
    results['newly_crafted']['html'] = render_to_string( 
      partial: 'materials/search/newly_crafted/header', 
      locals: { results: results}
    ) 
    
    results['antiques']['count'] = antique_in_title.count
    results['antiques']['html'] = render_to_string( 
      partial: 'materials/search/antiques/header', 
      locals: { results: results}
    )     


    # render newly crafted results
    if results['newly_crafted']['count'] > 0   
      newly_crafted.each do |mat|     
  
        thumb_image_url = self.get_thumb_image_url(mat,filters,use_special_result_images)
        
        results['newly_crafted']['html'] += render_to_string(
          partial: 'materials/search/newly_crafted/item', 
            locals: { mat: mat, thumb_image_url: thumb_image_url })
      end 
    end
    
    # render antiques results
    if results['antiques']['count'] > 0   
      antique_in_title.each do |mat|     

        thumb_image_url = self.get_thumb_image_url(mat,filters,use_special_result_images) 
        
        results['antiques']['html'] += render_to_string(
          partial: 'materials/search/antiques/item', 
            locals: { mat: mat, thumb_image_url: thumb_image_url })
      end 
    end    
      
    respond_to do |format|      
      format.json { render json: { type: 'ok', status: :success, results: results }}
    end 
  end 
  
  
protected

  # if finish filter set use first finish image thumb, 
  # otherwise search icon thumb including for unfiltered search index and fall back on default_image
  def get_thumb_image_url(mat,filters,use_special_result_images)
    # resets
    default_image = nil      
    search_icon_image = nil 
    thumb_image_url = nil
    mat_images_with_finish = [] 
    
    mat_images_with_finish = mat.images_with_finish(filters[:mat_finish_id].to_i)
    @mat_images_with_finish = mat.images_with_finish(mat.finishes)
    logger.debug "mat_images_with_finish: #{mat_images_with_finish.inspect}"
    
    unless mat_images_with_finish.empty?
      thumb_image = mat_images_with_finish.first
      thumb_image_url = thumb_image.image.url(:thumb)
    else
      unless mat.default_image_id.nil?
        default_image = Image.find(mat.default_image_id).image.url(:thumb)
      end

      unless mat.search_icon_image_id.nil?
        search_icon_image = Image.find(mat.search_icon_image_id).image.url(:thumb)
      end
      
      thumb_image_url = ( filters.empty? or !use_special_result_images.nil?) ? search_icon_image : default_image
    end
        
    return thumb_image_url 
  end

  def special_result_images(filters)
    return (filters.empty? or filters['mat_finish_id'].nil?) ? true : false
  end

end
