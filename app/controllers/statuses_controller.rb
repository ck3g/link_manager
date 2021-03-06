class StatusesController < ApplicationController
  load_and_authorize_resource
  before_filter :find_status, :only => [:edit, :update, :destroy]

  def index
    @statuses = Status.all
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new params[:status]
    if @status.save
      redirect_to statuses_path, :notice => t("views.application.successfully_created")
    else
      render "new"
    end
  end

  def update
    if @status.update_attributes params[:status]
      redirect_to statuses_path, :notice => t("views.application.successfully_updated")
    else
      render "edit"
    end
  end

  def destroy
    @status.destroy
    redirect_to statuses_path
  end

  private
  def find_status
    @status = Status.find params[:id]
  end
end
