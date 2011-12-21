class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :init_link

  def index
    @payments = Payment.includes(:seller, :payment_method).where(:link_id => params[:link_id])
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new params[:payment]
    @payment.link_id = @link.id
    @payment.user_id = current_user.id
    if @payment.save
      redirect_to link_payments_path(@link_id), :notice => t("views.application.successfully_created")
    else
      render :action => "new", :link_id => @link.id
    end
  end

private
  def init_link
    @link = Link.find params[:link_id]
  end
end
