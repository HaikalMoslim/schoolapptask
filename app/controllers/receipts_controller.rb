class ReceiptsController < ApplicationController
  before_action :set_receipt, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:paymentredirect]

  def index
    if current_user.role == "admin"
      @receipts = Receipt.all
    elsif
      current_user.role == "teacher"
      @receipts = Receipt.all
    else
      @receipts = Receipt.where(user_id: current_user.id)
    end
    
  end

  def show
  end

  def new
    @receipt = Receipt.new
  end

  def edit
  end

  def create
    @receipt = Receipt.new(receipt_params)
    
    if @receipt.save
      user_id = current_user.id
      session[:user_id] = user_id
      params_api = {
            buyer_email: @receipt.email, 
            order_number: @receipt.id,
            buyer_name: @receipt.name,
            buyer_phone: @receipt.phone,
            transaction_amount: @receipt.total,
            product_description: @receipt.name,
            callback_url: "",
            redirect_url: "http://localhost:3000/receipts/#{@receipt.id}/paymentredirect",
            uid: '7732d8b9-369f-41d1-be65-e5b1a94f6a4b',
            token: 'Rr_xrPdppxrMfwxDDKW7',
            checksum: @receipt.generate_checksum,
            redirect_post: "true"
          }
          
          redirect_post('https://sandbox.securepay.my/api/v1/payments', params: params_api)    
        else
          respond_to do |format|
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @receipt.errors, status: :unprocessable_entity }
          end
    end
  end

  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to receipt_url(@receipt), notice: "Receipt was successfully updated." }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @receipt.destroy!

    respond_to do |format|
      format.html { redirect_to receipts_url, notice: "Receipt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def paymentredirect
    user_id = session[:user_id]
    if user_id.present?
      user = User.find_by(id: params[:user_id])
      sign_in(user) if user.present?
    end
    payment_status = params[:payment_status]
    if payment_status == "true"
        receipt_id = params[:order_number]
        params_payment = {
        receipt_id: receipt_id,
        payment_id: params[:payment_id],
        order_number: params[:order_number],
        payment_method: params[:payment_method],
        payment_status: params[:payment_status],
        receipt_url: params[:receipt_url],
        status_url: params[:status_url],
        retry_url: params[:retry_url],
        buyer_email: params[:buyer_email],
        buyer_name: params[:buyer_name],
        buyer_phone: params[:buyer_phone],
        transaction_amount: params[:transaction_amount]
      }
      @payment = Payment.new(params_payment)
      @payment.save
      redirect_to receipt_path(params[:id])
    else
        receipt_id = params[:order_number]
        params_payment = {
        receipt_id: receipt_id,
        payment_id: params[:payment_id],
        order_number: params[:order_number],
        payment_method: params[:payment_method],
        payment_status: params[:payment_status],
        receipt_url: params[:receipt_url],
        status_url: params[:status_url],
        retry_url: params[:retry_url],
        buyer_email: params[:buyer_email],
        buyer_name: params[:buyer_name],
        buyer_phone: params[:buyer_phone],
        transaction_amount: params[:transaction_amount]
      }
      @payment = Payment.new(params_payment)
      @payment.save
      redirect_to payment_path(params[:id])
    end
  end

  private
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    def receipt_params
      params.require(:receipt).permit(:name, :email, :phone, :total, :user_id, :teacher_id, :student_id)
    end

    def params_payment
      params.require(:payment).permit(:order_number, :payment_status, :buyer_name, :buyer_email, :buyer_phone, :transaction_amount, :payment_id, :status_url, :retry_url, :receipt_url)
    end
end
