class LinksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @links = Link.order('created_at DESC')
  end

  def show
    @link = Link.find params[:id]
  end

  def new
    @link = Link.new
  end

  def edit
    @link = Link.find params[:id]
  end

  def create
    @link = Link.new params[:link]
    @link.user_id = current_user.id
    if @link.save
      Log.user_creates_link @link
      redirect_to new_link_payment_path(@link), :notice => t("views.application.successfully_created")
    else
      render :action => "new"
    end
  end

  def update
    @link = Link.find params[:id]
    if @link.update_attributes params[:link]
      redirect_to link_path(@link), :notice => t("views.application.successfully_updated")
    else
      render :action => "edit"
    end
  end

  def destroy
    @link = Link.find params[:id]
    @link.destroy
    redirect_to links_path
  end
end
