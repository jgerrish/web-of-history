class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def admin
    @users = User.all
    @shapefiles = Shapefile.all
  end

end
