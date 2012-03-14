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
        format.html { redirect_to admin_materials_path, notice: 'Material Saved' }
        format.json { render json: @material, status: :created, location: @material }
      else
        format.html { redirect_to admin_materials_path, alert: 'Problem Saving Material' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @material = Material.find(params[:id])
    @materials = Material.all
    @image = Image.new
    @all_finishes = Finish.order('title ASC')
    @all_applications = Application.order('title ASC')
  end  
  
  def update
    @material = Material.find(params[:id])
    return if @material.nil?
    
    respond_to do |format|
      if @material.update_attributes(params[:material])              
        format.html { redirect_to admin_materials_path, :notice => 'Material Updated' }
        format.json { head :no_content, status: :success }
      else
        format.html { render action: "edit", :alert => 'Problem updating material' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
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
