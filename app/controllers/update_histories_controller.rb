class UpdateHistoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @link = Link.find(params[:link_id])
    @history = @link.update_histories.order("created_at DESC")
  end
end
