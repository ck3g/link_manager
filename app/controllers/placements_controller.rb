class PlacementsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_placement, only: [:edit, :update, :destroy]

  def index
    @placements = Placement.all
  end

  def new
    @placement = Placement.new
  end

  def edit
  end

  def create
    @placement = Placement.new(params[:placement])
    if @placement.save
      redirect_to placements_path, notice: t("views.application.successfully_created")
    else
      render "new"
    end
  end

  def update
    if @placement.update_attributes params[:placement]
      redirect_to placements_path, notice: t("views.application.successfully_updated")
    else
      render "edit"
    end
  end

  def destroy
    @placement.destroy
    redirect_to placements_path
  end

  def find_placement
    @placement = Placement.find params[:id]
  end
end
