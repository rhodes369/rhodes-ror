class Admin::FinishesController < ApplicationController
  
  layout 'admin/layouts/application'
  
  def index
    @finish = Finish.new 
    @finishes = Finish.all 
  end

  def new
    @finish = Finish.new
    @finishes = Finish.all
  end

  def create
    @finish = Finish.new(params[:finish] )

    respond_to do |format|
      if @finish.save
        format.html { redirect_to admin_finishes_path, :notice => 'Finish was Saved' }
        format.json { render json: @finish, status: :created, location: @finish }
      else
        format.html { redirect_to admin_finishes_path, :alert =>'Problem Saving Entity' }
        format.json { render json: @finish.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  def edit
    @finish = Finish.find(params[:id])
    @finishes = Finish.all
  end

  def update
    @finish = Finish.find(params[:id])
    return if @finish.nil?
    
    respond_to do |format|
      if @finish.update_attributes(params[:finish])   
                  
        format.html { redirect_to admin_finishes_path, notice: 'Finish was Updated' }
        format.json { head :no_content, status: :success }
      else
        format.html { render action: "edit", error: 'Problem updating Material' }
        format.json { render json: @finish.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @finish = Finish.find(params[:id])
    return if @finish.nil?
    
    title = @finish.title
    mat_finish_count = MaterialFinish.remove_mat_finishes(@finish.id)
    image_finish_count = Image.remove_image_finishes(@finish.id)
    
    @finish.destroy

    redirect_to admin_finishes_path, 
      notice: "Finish: #{title} was removed.
      #{mat_finish_count} material relations were reset.
      #{image_finish_count} material image relations were reset."    
  end
end
