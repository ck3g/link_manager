class LogsController < ApplicationController
  load_and_authorize_resource
  has_scope :user_id
  has_scope :link_id

  def index
    @logs = apply_scopes(Log).includes(:user, :link).order('created_at DESC')
  end
end
