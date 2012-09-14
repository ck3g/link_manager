class SellersController < ApplicationController
  load_and_authorize_resource
  before_filter :find_seller, :only => [:show, :edit, :update, :destroy]

  def index
    @sellers = Seller.all
  end

  def show
  end

  def new
    @seller = Seller.new
  end

  def create
    @seller = Seller.new params[:seller]
    if @seller.save
      redirect_to sellers_path, :notice => t("views.application.successfully_created")
    else
      render "new"
    end
  end

  def update
    if @seller.update_attributes params[:seller]
      redirect_to sellers_path, :notice => t("views.application.successfully_updated")
    else
      render "edit"
    end
  end

  def destroy
    @seller.destroy
    redirect_to sellers_path
  end

  private
  def find_seller
    @seller = Seller.find params[:id]
  end
end
