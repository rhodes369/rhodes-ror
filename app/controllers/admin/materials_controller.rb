class Admin::MaterialsController < ApplicationController
  
  layout 'admin/layouts/application'
  
  def index
    @materials = Material.all 
    @material = Material.new

    respond_to do |format|
      format.html 
      format.json { render json: @materials }
    end

  end  
    
  def create
    @material = Material.new(params[:material] )
    @image = Image.create( params[:image] )
    
    #params[:material][:slug] = @material.generate_slug!
    
    respond_to do |format|
      if @material.save
        params[:material][:slug] = @material.generate_slug # for sluggable gem
        format.html { redirect_to edit_admin_material_path(@material), notice: 'Material Saved' }
        format.json { render json: @material, status: :created, location: @material }
      else
        format.html { redirect_to edit_admin_material_path(@material), alert: 'Problem Saving Material' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end
   
  
  def update
    @material = Material.find_using_slug(params[:id])
    redirect_to admin_material_url if @material.nil?
    
    params[:material][:slug] = @material.generate_slug # for sluggable gem
    
    respond_to do |format|
      if @material.update_attributes(params[:material])              
        format.html { redirect_to edit_admin_material_path(@material), notice: 'Material Updated' }
        format.json { head :no_content, status: :success }
      else
        format.html { redirect_to edit_admin_material_path(@material), alert: 'Problem Updating Material' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  
  def update_default_image
    material_id = params[:material_id].to_i
    default_image_id = params[:default_image_id].to_i
    
    return unless material_id.is_a?(Numeric) and default_image_id.is_a?(Numeric)
    
    @material = Material.find(material_id)  
    return if @material.nil? 
   
    respond_to do |format|      
       if @material.set_default_image(default_image_id)
        format.json { render json: { type: 'ok', status: :success } }
      else
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end       
  end


  def edit
    @material = Material.find_using_slug(params[:id])
    @materials = Material.all
    @material_sorted_images = self.sort_images(@material) 
    @image = Image.new
    @all_material_types = MaterialType.all
    @all_finishes = Finish.order(:title)
    @all_applications = Application.order(:title)
  end
  

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    #flash[:notice] = 'Material Removed'

    respond_to do |format|
      format.html { redirect_to admin_materials_path, notice: 'Material Removed' }
      format.json { render json: @material, status: :deleted }
    end
  end  

  def sort_images(mat)
    mat.images.sort { |a,b| b.created_at <=> a.created_at }
    unless mat.images.count == 0
      default_image = Image.find mat.default_image_id 
      mat.images[0] = default_image
      mat.save!
    else
      mat.images
    end
  end
   
end
