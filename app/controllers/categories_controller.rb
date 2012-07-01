class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_filter :find_category, :only => [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new params[:category]
    if @category.save
      redirect_to categories_path, :notice => t("views.application.successfully_created")
    else
      render "new"
    end
  end

  def update
    if @category.update_attributes params[:category]
      redirect_to categories_path, :notice => t("views.application.successfully_updated")
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private
  def find_category
    @category = Category.find params[:id]
  end
end
