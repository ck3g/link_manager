class LinksController < ApplicationController
  load_and_authorize_resource
  before_filter :find_link, :only => [:show, :edit, :update, :destroy]

  has_scope :url
  has_scope :page_rank
  has_scope :link_name
  has_scope :keyword

  def index
    @links = apply_scopes(Link.includes(:placement, :last_payment, :seller).with_unmoderated_count)
    @links = @links.inactive unless params[:inactive].present?
    @links = @links.where(:id => Link.by_seller(params[:seller])) if params[:seller].present?
    @links = @links.where(:placement_id => params[:placement]) if params[:placement].present?
    @links = @links.where(:id => Link.by_payment_method(params[:pm])) if params[:pm].present?
    @links = @links.sort_by { |link| [link.days_left, link.seller_name] }
    @links = Kaminari.paginate_array(@links.to_a).page(params[:page]).per(params[:per_page])

    set_meta_tags :title => I18n.t(:links_title)
  end

  def new
    @links = []
    15.times { @links << Link.new }
  end

  def mass_create
    @links = []

    params[:links].each do |link_params|
      link = current_user.links.new link_params
      if link.url.present?
        unless link.save
          @links << link
        end
      end
    end

    if @links.blank?
      redirect_to links_path, notice: t(:successfully_created)
    else
      render :new
    end
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
    @links = []
    if params[:links].present?
      links_to_check = params[:links].strip.split("\n").map(&:strip).compact.reject(&:blank?)
      links_to_check.each do |link_to_check|
        link = Link.where{url =~ "%#{link_to_check}"}.first
        css_class = if link.present?
                      link.inactive? ? "inactive" : "active"
                    else
                      "new"
                    end

        @links << { :url => link_to_check, :class => css_class }
      end
    end
  end

  private
  def find_link
    @link = Link.find params[:id]
  end

end
