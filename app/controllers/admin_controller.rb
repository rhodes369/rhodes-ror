class AdminController < ApplicationController
  def index
    @materials = Material.all #.order 'DESC'
  end
end
