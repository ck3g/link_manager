class StatisticsController < ApplicationController
  authorize_resource class: false

  def index
    raise CanCan::AccessDenied unless current_user.admin?
    @total_links = Link.count
    @by_page_ranks = Link.group(:page_rank).count
    @by_domains = Link.count_by_domains
  end
end
