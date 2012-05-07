class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_link
  before_filter :find_payment, :only => [:edit, :update, :destroy]

  def index
    @payments = Payment.includes(:seller, :payment_method).where(:link_id => params[:link_id])
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = @link.payments.build params[:payment]
    @payment.user_id = current_user.id
    if @payment.save
      Log.user_creates_payment @payment
      redirect_to link_payments_path(@link.id), :notice => t("views.application.successfully_created")
    else
      render "new", :link_id => @link.id
    end
  end

  def update
    if @payment.update_attributes params[:payment]
      redirect_to link_payments_path(@link.id), :notice => t("views.application.successfully_updated")
    else
      render "edit", :link_id => @link.id
    end
  end

  def destroy
    @payment.destroy
    redirect_to link_payments_path(@link.id)
  end

  private
  def find_link
    @link = Link.find params[:link_id]
  end

  def find_payment
    @payment = Payment.find params[:id]
  end
end
