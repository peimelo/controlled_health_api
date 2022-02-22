class Api::V1::AccountsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :set_account, only: %i[show update destroy]

  serialization_scope :current_api_user

  # GET /accounts
  def index
    @accounts = current_api_user.accounts_list
                                .sorted(params[:sort], params[:dir])
                                .page(current_page)
                                .per(per_page)

    render json: @accounts,
           meta: meta_attributes(@accounts),
           adapter: :json,
           each_serializer: AccountsSerializer
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params.to_h.merge!({ owner: current_api_user }))

    if @account.save
      @account.users << current_api_user
      render json: @account, status: :created, location: api_account_url(@account)
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = current_api_user.accounts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:name)
  end
end
