class PlacementsController < ApplicationController
  def index
    @placements = Placement.all
  end

  def new
    @placement = Placement.new
  end

  def edit
    @placement = Placement.find(params[:id])
  end

  def create
    @placement = Placement.new(params[:placement])
    if @placement.save
      redirect_to placements_path, :notice => t("views.application.successfully_created")
    else
      render :action => "new"
    end
  end

  def update
    @placement = Placement.find(params[:id])
    if @status.update_attributes params[:placement]
      redirect_to placements_path, :notice => t("views.application.successfully_updated")
    else
      render :action => "edit"
    end
  end

  def destroy
    @placement = Placement.find params[:id]
    @placement.destroy
    redirect_to placements_path
  end
end
