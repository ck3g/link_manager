class PaymentsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_link
  before_filter :find_payment, only: [:edit, :update, :destroy, :moderate]

  def index
    @payments = Payment.includes(:seller, :payment_method).where(link_id: @link.id)
  end

  def new
    @payment = Payment.new
  end

  def create
    if params[:link_ids].present?
      @links = Link.find(params[:link_ids].split("-"))
    end

    if @links.present?
      @links.each do |link|
        @payment = link.payments.build params[:payment]
        @payment.user_id = current_user.id
        if @payment.save
          Log.user_creates_payment @payment
        else
          params[:link_ids] = params[:link_ids].split("-")
          render :new
          return
        end
      end
      redirect_to links_path, notice: t("views.application.successfully_created")
    else
      @payment = @link.payments.build params[:payment]
      @payment.user_id = current_user.id
      if @payment.save
        Log.user_creates_payment @payment
        redirect_to payments_path(link_id: @link.id), notice: t("views.application.successfully_created")
      else
        render "new", link_id: @link.id
      end
    end
  end

  def update
    if @payment.update_attributes params[:payment]
      redirect_to payments_path(link_id: @link.id), notice: t("views.application.successfully_updated")
    else
      render "edit", link_id: @link.id
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_path(link_id: @link.id)
  end

  def moderate
    @payment.update_attribute :moderated, true
    redirect_to payments_path(link_id: @link)
  end

  private
  def find_link
    @link = Link.find params[:link_id] if params[:link_id].present?
  end

  def find_payment
    @payment = Payment.find params[:id]
  end
end
