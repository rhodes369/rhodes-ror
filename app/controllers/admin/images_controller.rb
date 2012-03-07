class Admin::ImagesController < ApplicationController
  # GET /images
  # GET /images.json
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])
       
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new

    respond_to do |format|
      format.html 
      format.json { render json: @image }
    end
  end


  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])
    @material = Material.find(params[:image][:material_id])
 
    respond_to do |format|
      if @image.save
        format.html { redirect_to edit_admin_material_path @material, notice: 'Image was successfully updated.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { redirect_to edit_admin_material_path @material, notice: 'Unable to add Image.' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    
    @image = Image.find(params[:id])
    @material = Material.find(@image.material_id)
    
    # detatch/delete all related paper clip images
    @image.image = nil
    @image.save 
    
    @image.destroy

    respond_to do |format|
      format.html { redirect_to edit_admin_material_path @material }
      format.json { head :no_content }
    end
  end
end
