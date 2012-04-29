class SellerOriginsController < ApplicationController
  def index
    @seller_origins = SellerOrigin.all
  end

  def new
    @seller_origin = SellerOrigin.new
  end

  def edit
    @seller_origin = SellerOrigin.find params[:id]
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
    @seller_origin = SellerOrigin.find params[:id]
    if @seller_origin.update_attributes params[:seller_origin]
      redirect_to seller_origins_path, :notice => t("views.application.successfully_updated")
    else
      render :action => "edit"
    end
  end

  def destroy
    @seller_origin = SellerOrigin.find params[:id]
    @seller_origin.destroy
    redirect_to seller_origins_path
  end
end
