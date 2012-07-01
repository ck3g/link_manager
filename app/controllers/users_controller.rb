class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :find_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      redirect_to users_path, :notice => t("views.application.successfully_created")
    else
      render "new"
    end
  end

  def edit

  end

  def update
    saved = if params[:user][:password].present?
               @user.update_attributes params[:user]
             else
               @user.update_without_password params[:user]
             end

    if saved
      redirect_to users_path, :notice => t("views.application.successfully_updated")
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
  def find_user
    @user = User.find(params[:id])
  end
end
