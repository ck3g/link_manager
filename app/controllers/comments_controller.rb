class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @commentable = find_commentable
    @commentable.comments.create(:comment => params[:comment][:comment], :user_id => current_user.id)
    redirect_to url_for(@commentable)
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end

    nil
  end
end
