class StatusesController < ApplicationController
  def index
    @statuses = Status.all
  end

  def new
    @status = Status.new
  end

  def edit 
    @status = Status.find params[:id]
  end

  def create
    @status = Status.new params[:status]
    if @status.save
      redirect_to statuses_path, :notice => t("views.application.successfully_created")
    else
      render :action => "new"
    end
  end

  def update
    @status = Status.find params[:id]
    if @status.update_attributes params[:status]
      redirect_to statuses_path, :notice => t("views.application.successfully_updated")
    else
      render :action => "edit"
    end
  end

  def destroy
    @status = Status.find params[:id]
    @status.destroy
    redirect_to statuses_path
  end
end
