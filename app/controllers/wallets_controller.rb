class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[show edit update destroy]
  before_action :generate_random_colors, only: %i[new edit create update]

  # GET /wallets or /wallets.json
  def index
    @pagy, @wallets = pagy current_user.wallets
  end

  # GET /wallets/1 or /wallets/1.json
  def show; end

  # GET /wallets/new
  def new
    @wallet = current_user.wallets.new(
      color: @random_colors[0],
      icon: WALLET_ICONS[0]
    )
  end

  # GET /wallets/1/edit
  def edit; end

  # POST /wallets or /wallets.json
  def create
    @wallet = current_user.wallets.new(wallet_params)

    respond_to do |format|
      if @wallet.save
        format.html { redirect_to wallet_url(@wallet), notice: 'Wallet was successfully created.' }
        format.json { render :show, status: :created, location: @wallet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallets/1 or /wallets/1.json
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to wallet_url(@wallet), notice: 'Wallet was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallets/1 or /wallets/1.json
  def destroy
    @wallet.destroy

    respond_to do |format|
      format.html { redirect_to wallets_url, notice: 'Wallet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wallet
    @wallet = current_user.wallets.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def wallet_params
    params.require(:wallet).permit(:name, :icon, :color, :balance, :deleted_at)
  end
end
