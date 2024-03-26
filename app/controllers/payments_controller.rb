class PaymentsController < ApplicationController
  # before_action :set_payment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment = Payment.find_by(id: params[:id])
    if @payment
      @payment.destroy!
      redirect_to payments_path, notice: "Payment deleted"
    else
      redirect_to payments_path, notice: "Payment with ID #{params[:id]} not found"
    end
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end
end
