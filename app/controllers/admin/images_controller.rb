class Admin::ImagesController < ApplicationController

  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end


  def show
    @image = Image.find(params[:id])
       
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end


  def new
    @image = Image.new

    respond_to do |format|
      format.html 
      format.json { render json: @image }
    end
  end


  def create
    @image = Image.new(params[:image])
    @material = Material.find(params[:image][:material_id])
 
    respond_to do |format|
      if @image.save
        format.html { redirect_to edit_admin_material_path(@material), 
                      notice: 'Image was successfully added.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { redirect_to edit_admin_material_path(@material), alert: 'Problem uploading Image' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    
    @image = Image.find(params[:id])
    @material = Material.find(@image.material_id)
    
    # set a new alternative default_image_id if the current one is getting axed
    if @material.default_image_id == @image.id
      if @material.images.count > 1
        @alt_images_ids = @material.images.map(&:id)
        unless @alt_image_ids == @image_id
          @material.default_image_id = @alt_image_ids.first
        else
          @material.default_image_id = @alt_image_ids.last
        end
    end    
          
        
    
    # detatch/delete all related paperclip images
    @image.image = nil
    @image.save 
    @image.destroy

    respond_to do |format|
      format.html { redirect_to edit_admin_material_path(@material), notice: 'Image was removed' }
      format.json { render json: { type: 'ok', status: :success } }
    end
  end
end
