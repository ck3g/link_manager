class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find params[:id]
  end

  def create
    @category = Category.new params[:category]
    if @category.save
      redirect_to categories_path, :notice => t("views.application.successfully_created")
    else
      render :action => "new"
    end
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes params[:category]
      redirect_to categories_path, :notice => t("views.application.successfully_updated")
    else
      render :action => "edit"
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to categories_path
  end
end
