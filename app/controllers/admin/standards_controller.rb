class Admin::StandardsController < ApplicationController
  def create
    @material = Material.find_using_slug(params[:id])
    redirect_to admin_material_path(@material)
  end
end