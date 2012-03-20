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

    respond_to do |format|
      if @material.save
        format.html { redirect_to edit_admin_material_path(@material), notice: 'Material Saved' }
        format.json { render json: @material, status: :created, location: @material }
      else
        format.html { redirect_to edit_admin_material_path(@material), alert: 'Problem Saving Material' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end
   
  
  def update
    @material = Material.find(params[:id])
    redirect_to admin_material_url if @material.nil?
    
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
  
  def update_default_image_id
    default_image_id = params[:default_image_id]
    return unless default_image_id.numeric?
  
    self.default_image = default_image_id
    self.save!

    render :json => {type: 'ok'} if request.xhr?         
  end

  def edit
    @material = Material.find(params[:id])
    @materials = Material.all
    @image = Image.new
    @all_finishes = Finish.order(:title)
    @all_applications = Application.order(:title)
  end
  
  def show
    @material = Material.find(params[:id])
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
end
