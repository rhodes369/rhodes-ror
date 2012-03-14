class Admin::FinishesController < ApplicationController
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
  end
end
