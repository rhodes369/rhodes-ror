class Admin::MaterialTypesController < ApplicationController
  def index
    @material_type = MaterialType.new
    @material_types = MaterialType.all
  end

  def new
    @material_type = MaterialType.new
    @material_types = MaterialType.all
  end

  def create
    @material_type = MaterialType.new(params[:material_type] )

    respond_to do |format|
      if @material_type.save
        format.html { redirect_to admin_material_types_path, :notice => 'MaterialType was Saved' }
        format.json { render json: @material_type, status: :created, location: @material_type }
      else
        format.html { redirect_to admin_material_types_path, :alert =>'Problem Saving Entity' }
        format.json { render json: @material_type.errors, status: :unprocessable_entity }
      end
    end
  end 
  

  def edit
    @material_type = MaterialType.find(params[:id])
    @material_types = MaterialType.all
  end

  def update
    @material_type = MaterialType.find(params[:id])
    return if @material_type.nil?
    
    respond_to do |format|
      if @material_type.update_attributes(params[:material_type])   
                  
        format.html { redirect_to admin_material_types_path, notice: 'MaterialType was Updated' }
        format.json { head :no_content, status: :success }
      else
        format.html { render action: "edit", error: 'Problem updating Material' }
        format.json { render json: @material_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end
end