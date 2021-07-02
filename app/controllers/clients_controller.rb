class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show payments transactions ]

  # GET /clients/1 or /clients/1.json
  def show
  end

  def payments
    @payments_collected = @client.payments.where("payment_date < ?", Date.current)
    @payments_receivable = @client.payments.where("payment_date > ?", Date.current)
  end

  def transactions
    @payments = @client.payments.includes(:transactions)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find_by_client_id(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:client_id, :payment_date, :email, :first_name, :last_name, :job, :country, :address, :zip_code, :phone)
    end

end
