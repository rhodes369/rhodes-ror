class MaterialsController < ApplicationController
  layout 'application'
  
  def index
    @material = Material.new # for optionally creating a new material on the index
    @materials_newly_crafted = Material.newly_crafted_with_images # array of newly created mats
    
    # left sidebar
    @materials_antique_in_title = Material.antique_in_title
    @materials_alpha = Material.alphabetical # for sidebar edit links    
    @materials_newly_crafted_sidebar = Material.newly_crafted_sidebar # all mats excluding antiques
    
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
    @materials_newly_crafted_sidebar = Material.newly_crafted_sidebar # all mats excluding antiques    
  end
  
  def search
    @filters = params[:filters] || {}
    
    
    newly_crafted_html = render :partial => "newly_crafted_search_results", :content_type => "text/html", 
                    :layout => false, :locals => { :test => 'test' }
    
    
     
    respond_to do |format|      
      if @material.set_default_image(default_image_id)
        format.js { render json: { type: 'ok', status: :success } }
        
      else
        format.js { render json: @material.errors, status: :unprocessable_entity }
      end
    end    

  end
  
end