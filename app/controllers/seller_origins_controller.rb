class SellerOriginsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_seller_origin, :only => [:edit, :update, :destroy]

  def index
    @seller_origins = SellerOrigin.all
  end

  def new
    @seller_origin = SellerOrigin.new
  end

  def create
    @seller_origin = SellerOrigin.new params[:seller_origin]
    if @seller_origin.save
      redirect_to seller_origins_path, :notice => t("views.application.successfully_created")
    else
      render :action => "new"
    end
  end

  def update
    if @seller_origin.update_attributes params[:seller_origin]
      redirect_to seller_origins_path, :notice => t("views.application.successfully_updated")
    else
      render :action => "edit"
    end
  end

  def destroy
    @seller_origin.destroy
    redirect_to seller_origins_path
  end

  private
  def find_seller_origin
    @seller_origin = SellerOrigin.find params[:id]
  end
end
