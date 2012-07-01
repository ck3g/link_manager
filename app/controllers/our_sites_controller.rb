class OurSitesController < ApplicationController
  load_and_authorize_resource

  def index
    @our_sites = OurSite.all
  end

  def new
    @our_site = OurSite.new
  end

  def edit
    @our_site = OurSite.find params[:id]
  end

  def create
    @our_site = OurSite.new params[:our_site]
    if @our_site.save
      redirect_to our_sites_path, :notice => t("views.application.successfully_created")
    else
      render "new"
    end
  end

  def update
    @our_site = OurSite.find params[:id]
    if @our_site.update_attributes params[:our_site]
      redirect_to our_sites_path, :notice => t("views.application.successfully_updated")
    else
      render "edit"
    end
  end
end
