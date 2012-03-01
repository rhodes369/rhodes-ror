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
        format.html { redirect_to admin_materials_path, notice: 'Material was successfully created.' }
        format.json { render json: @material, status: :created, location: @material }
      else
        format.html { render action: "admin/index" }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @material = Material.find(params[:id])
    @all_finishes = Finish.order('title ASC')
  end  
  
  def update
    @material = Material.find(params[:id])
    return if @material.nil?
      
    #render text: params[:material_finishes][:finish_ids] 
    
    @material.reset_finishes()
    @material.populate_finishes params[:material][:finish_ids]
    
    #params[:material_finishes].delete
    
    respond_to do |format|
      if @material.update_attributes(params[:material])
        
        format.html { redirect_to admin_materials_path, :notice => 'Material was successfully updated.' }
        #format.json { head :no_content }
      else
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

    respond_to do |format|
      format.html { redirect_to admin_materials_path }
      format.json { render json: @material, status: :deleted }
    end
  end 
end
