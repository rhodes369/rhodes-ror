class Admin::MaterialsController < ApplicationController
  def new
    @material = Material.new
    @materials = Material.all
  end
  
  def index
    @materials = Material.all #.order 'DESC'
    @material = Material.new
  end  
    
  def create
    @material = Material.new(params[:material])

    respond_to do |format|
      if @material.save
        format.html { redirect_to admin_material_path, notice: 'Entry was successfully created.' }
        format.json { render json: @material, status: :created, location: @material }
      else
        format.html { render action: "index" }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @material = Material.find(params[:id])
  end  
  
  def update
    @material = Material.find(params[:id])

    respond_to do |format|
      if @material.update_attributes(params[:material])
        format.html { redirect_to admin_materials_path, notice: 'Material was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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

    respond_to do |format|
      format.html { redirect_to admin_materials_path }
      format.json { render json: @material, status: :deleted }
    end
  end 
end
