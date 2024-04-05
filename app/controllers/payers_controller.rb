class PayersController < ApplicationController
  before_action :set_payer, only: %i[ show edit update destroy ]

  # GET /payers or /payers.json
  def index
    @payers = Payer.all
  end

  # GET /payers/1 or /payers/1.json
  def show
  end

  # GET /payers/new
  def new
    @payer = Payer.new
  end

  # GET /payers/1/edit
  def edit
  end

  # POST /payers or /payers.json
  def create
    @payer = Payer.new(payer_params)

    respond_to do |format|
      if @payer.save
        format.html { redirect_to payer_url(@payer), notice: "Payer was successfully created." }
        format.json { render :show, status: :created, location: @payer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payers/1 or /payers/1.json
  def update
    respond_to do |format|
      if @payer.update(payer_params)
        format.html { redirect_to payer_url(@payer), notice: "Payer was successfully updated." }
        format.json { render :show, status: :ok, location: @payer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payers/1 or /payers/1.json
  def destroy
    @payer.destroy

    respond_to do |format|
      format.html { redirect_to payers_url, notice: "Payer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payer
      @payer = Payer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payer_params
      params.require(:payer).permit(:dues_amount, :cope_amount, :name, :total_wages_earned_pp, :hourly_rate, :check_id)
    end
end
