class FeesController < ApplicationController
  before_action :set_fee, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:paymentredirect]
  # skip_before_action :authenticate_user!, only: [:paymentredirect]
  # GET /fees or /fees.json
  def index
    @fees = Fee.all
  end

  # GET /fees/1 or /fees/1.json
  # GET /fees/1 or /fees/1.json
def show
  user_id = current_user.id
  session[:user_id] = user_id
  @fee = Fee.find(params[:id])
  params_api = {
    buyer_email: @fee.email, 
    order_number: @fee.id,
    buyer_name: @fee.name,
    buyer_phone: @fee.phone,
    transaction_amount: @fee.total,
    product_description: @fee.name,
    callback_url: "",
    redirect_url: "http://localhost:3000/fees/#{@fee.id}/paymentredirect",
    uid: '7732d8b9-369f-41d1-be65-e5b1a94f6a4b',
    token: 'Rr_xrPdppxrMfwxDDKW7',
    checksum: @fee.generate_checksum,
    redirect_post: "true"
  }
          
  redirect_post('https://sandbox.securepay.my/api/v1/payments', params: params_api)   
end


  # GET /fees/new
  def new
    @fee = Fee.new
  end

  # GET /fees/1/edit
  def edit
  end

  # POST /fees or /fees.json
  def create
    @fee = Fee.new(fee_params)

    if @fee.save
      redirect_to fees_path, notice: 'Fee was successfully created.'
        else
          respond_to do |format|
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @fee.errors, status: :unprocessable_entity }
          end
    end
  end

  # PATCH/PUT /fees/1 or /fees/1.json
  def update
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to fee_url(@fee), notice: "Fee was successfully updated." }
        format.json { render :show, status: :ok, location: @fee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1 or /fees/1.json
  def destroy
    @fee.destroy!

    respond_to do |format|
      format.html { redirect_to fees_url, notice: "Fee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def paymentredirect
    user_id = session[:user_id]
    if user_id.present?
      user = User.find_by(id: user_id)
      sign_in(user) if user.present?
    end
  
    payment_status = params[:payment_status]
    fee_id = params[:order_number]
    @fee = Fee.find_by(id: fee_id)
  
    if payment_status == "true"
      params_payment = {
        fee_id: fee_id,
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
      @fee.update(payment_succeeded: true)
      redirect_to fees_path
    else
      params_payment = {
        fee_id: fee_id,
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
  
      redirect_to payments_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @fee = Fee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fee_params
      params.fetch(:fee).permit(:name, :email, :phone, :total, :user_id)
    end

    def params_payment
      params.require(:payment).permit(:order_number, :payment_status, :buyer_name, :buyer_email, :buyer_phone, :transaction_amount, :payment_id, :status_url, :retry_url, :receipt_url)
    end
end
