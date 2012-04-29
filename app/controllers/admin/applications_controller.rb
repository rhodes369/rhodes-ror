class Admin::ApplicationsController < ApplicationController
  
  before_filter :require_login
  
  layout 'admin/layouts/application'
  
  def index
    @applications = Application.all
    @application = Application.new
  end
  
  def new
    @applications = Application.all
    @application = Application.new
  end

  def edit
    @applications = Application.all
    @application = Application.find(params[:id])
  end
  
  def create
    @application = Application.new(params[:application] )

    respond_to do |format|
      if @application.save
        format.html { redirect_to admin_applications_path, :notice => 'Application was Saved' }
        format.json { render json: @application, status: :created, location: @finish }
      else
        flash[:error] = 'Problem Saving Application'
        format.html { redirect_to admin_applications_path }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  def update
    @application = Application.find(params[:id])
    return if @application.nil?
    
    respond_to do |format|
      if @application.update_attributes(params[:application])   
                  
        format.html { redirect_to admin_applications_path, notice: 'Application Updated' }
        format.json { head :no_content, status: :success }
      else
        format.html { render action: "edit", error: 'Problem updating Application' }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end  

  def destroy
    @application = Application.find(params[:id])
    return if @application.nil?
    
    title = @application.title
    app_count = MaterialApplication.remove_mat_apps(@application.id)
    
    @application.destroy

    redirect_to admin_applications_path, 
      notice: "Application: #{title} was removed 
      and #{app_count} material relations were reset."    
  end 
end
