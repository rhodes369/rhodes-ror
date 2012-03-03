class Admin::MaterialsController < ApplicationController
  
  layout 'admin/layouts/application'

  def index
    @materials = Material.all 
    @material = Material.new
    render :index
  end  
    
  def create
    @material = Material.new(params[:material])

    respond_to do |format|
      if @material.save
        flash[:notice] = 'Material Saved'
        format.html { redirect_to admin_materials_path }
        format.json { render json: @material, status: :created, location: @material }
      else
        flash[:error] = 'Problem Saving Material'
        format.html { redirect_to admin_materials_path }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @material = Material.find(params[:id])
    @all_finishes = Finish.order('title ASC')
    @all_applications = Application.order('title ASC')
  end  
  
  def update
    @material = Material.find(params[:id])
    return if @material.nil?
  

    respond_to do |format|
      if @material.update_attributes(params[:material])        
        flash[:notice] = 'Material Updated'       
        format.html { redirect_to admin_materials_path }
        #format.json { head :no_content, status: :success }
      else
        flash[:error] = 'Problem updating Material'
        format.html { render action: "edit" }
        #format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end

  end  
  
  
  def show
    @material = Material.find(params[:id])
  end
    

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    flash[:notice] = 'Material Removed'

    respond_to do |format|
      format.html { redirect_to admin_materials_path }
      format.json { render json: @material, status: :deleted }
    end
  end 
end
