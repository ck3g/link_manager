class OurSitesController < ApplicationController
  load_and_authorize_resource
  before_filter :find_our_site, :only => [:edit, :update]

  def index
    @our_sites = if current_user.admin?
                   OurSite.order(:name)
                 else
                   OurSite.visible_for(current_user.id)
                 end
  end

  def new
    @our_site = OurSite.new
  end

  def edit
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
    if @our_site.update_attributes params[:our_site]
      redirect_to our_sites_path, :notice => t("views.application.successfully_updated")
    else
      render "edit"
    end
  end

  private
  def find_our_site
    @our_site = if current_user.admin?
                  OurSite.find params[:id]
                else
                  OurSite.visible_for(current_user.id).find params[:id]
                end
  end
end
