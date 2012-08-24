class Admin::MaterialsController < ApplicationController
  
  require 'htmlentities'
    
  before_filter :require_login
  
  layout 'admin/layouts/application'
  
  MIN_THICKNESS_OPTIONS = { 
    '.75"' => ".75&#34;", 
    '1"'   => "1&#34;", 
    '1.5"' => "1.5&#34;",
    '2"'   => "2&#34;",
    '3"'   => "3&#34;"
  }
  
  
  
  def index
    @materials = Material.all 
    @material = Material.new
  end  
 
    
  def create
    @material = Material.new(params[:material])
       
    respond_to do |format|
      if @material.save
        format.html { redirect_to edit_admin_material_path(@material), notice: 'Material Saved' }
        format.json { render json: @material, status: :created, location: @material }
      else
        format.html { redirect_to admin_materials_path, alert: @material.errors.full_messages.first }
        format.json { render json: @material.errors, status: :unprocessable_entity } 
      end
    end
  end
   
  
  def update
    @material = Material.find_using_slug(params[:id])
    redirect_to admin_material_url if @material.nil?
    
    params[:material][:finish_ids] = [] if params[:material][:finish_ids].blank?
    params[:material][:application_ids] = [] if params[:material][:application_ids].blank?

    respond_to do |format|
      if @material.update_attributes(params[:material])             
        format.html { redirect_to edit_admin_material_path(@material), notice: 'Material Updated' }
        format.json { head :no_content, status: :success }
      else
        format.html { redirect_to edit_admin_material_path(@material), alert: @material.errors.full_messages.first }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  # First = the first image in the list of thumbs (basically the default)
  def update_default_image
    @material_id = params[:material_id].to_i
    @default_image_id = params[:default_image_id].to_i
    
    return unless @material_id.is_a?(Numeric) and @default_image_id.is_a?(Numeric)
    
    @material = Material.find(@material_id)  
    return if @material.nil? 
   
    respond_to do |format|      
       if @material.set_default_image(@default_image_id)
        format.json { render json: { type: 'ok', status: :success } }
      else
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end       
  end


  # Search Icon = Icon = the image used to represent a material, 
  # shown as thumbs on the material index page by default (without filtering).
  def update_search_icon_image
    @material_id = params[:material_id].to_i
    @search_icon_image_id = params[:search_icon_image_id].to_i
    
    return unless @material_id.is_a?(Numeric) and @search_icon_image_id.is_a?(Numeric)
    
    @material = Material.find(@material_id)  
    return if @material.nil? 
   
    respond_to do |format|      
       if @material.set_search_icon_image(@search_icon_image_id)
        format.json { render json: { type: 'ok', status: :success } }
      else
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end       
  end

  def edit
    @material = Material.find_using_slug(params[:id])     
    
    unless @material.nil?  
      @materials = Material.all
      @material_sorted_images = @material.sort_thumb_images
      @image = Image.new
      @all_material_types = MaterialType.all
      @all_finishes = Finish.order(:title)
      @all_applications = Application.order(:title)
      @html_encoder = HTMLEntities.new
      @all_min_thicknesses = MIN_THICKNESS_OPTIONS
  
      # left sidebar
      @materials_antique_in_title = Material.antique_in_title
      @materials_alpha = Material.alphabetical # for sidebar edit links    
      @materials_newly_crafted_sidebar = Material.newly_crafted_without_antiques # all mats excluding antiques
    else
      redirect_to admin_materials_path, notice: 'Could not find material' if @material.nil?
    end
  end  


  def show
    redirect_to admin_materials_path, notice: 'No show path for admin materials'
  end
  

  def destroy
    @material = Material.find_using_slug(params[:id])
    return if @material.nil?
    
    num_mat_images = @material.images.count
    image_ids = @material.images.map &:id if num_mat_images > 0

    @material.destroy
       
     unless @material.errors.count > 0
      redirect_to admin_materials_path, notice: "Material: #{@material.title} removed"
    else
      redirect_to admin_materials_path, 
        alert: "Problem removing material: #{@material.errors.full_messages.first }"
    end
  end
  
  def default_image_ids
    logger.debug "running default_image_ids... params: #{params.inspect}"
    
    @material = Material.find(params[:material_id])
    return if @material.nil?
    
    logger.debug "running get_default_image_ids @material #{@material.id}"
    
    @default_image_ids = {}
    @default_image_ids[:default] = nil
    @default_image_ids[:search_icon] = nil
    
    @default_image_ids[:default] = @material.default_image_id
    @default_image_ids[:search_icon] = @material.search_icon_image_id

    respond_to do |format|      
      format.json { render json: {default_image_ids: @default_image_ids, type: 'ok', status: :success }}
    end
  end 
      
end
