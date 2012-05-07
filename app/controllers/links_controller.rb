class LinksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_link, :only => [:show, :edit, :update, :destroy]

  has_scope :url
  has_scope :page_rank
  has_scope :link_name
  has_scope :keyword

  def index
    @links = apply_scopes(Link).order('created_at DESC')
    @links = @links.where(:inactive => false) unless params[:inactive].present?
    @links = @links.where(:id => Link.by_seller(params[:seller])) if params[:seller].present?
    @links = @links.where(:placement_id => params[:placement]) if params[:placement].present?
    @links = @links.where(:id => Link.by_payment_method(params[:pm])) if params[:pm].present?
    @links = @links.sort_by(&:days_left).sort_by(&:seller_name)

    set_meta_tags :title => I18n.t(:links_title)
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.build params[:link]
    if @link.save
      Log.user_creates_link @link
      redirect_to new_link_payment_path(@link), :notice => t("views.application.successfully_created")
    else
      render "new"
    end
  end

  def update
    if @link.update_attributes params[:link]
      redirect_to link_path(@link), :notice => t("views.application.successfully_updated")
    else
      render "edit"
    end
  end

  def destroy
    @link.destroy
    redirect_to links_path
  end

  def check
    if params[:links].present?
      @links_to_check = params[:links].strip.split("\n").map(&:strip).compact.reject(&:blank?)
      @links = Link.all.select { |link| @links_to_check.include? link.url }.collect { |link| link.url }
    end
  end

  private
  def find_link
    @link = Link.find params[:id]
  end

end
