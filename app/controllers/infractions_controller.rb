class InfractionsController < ApplicationController
  before_action :set_infraction, only: %i[ show edit update destroy ]

  # GET /infractions or /infractions.json
  def index
    @infractions = Infraction.all
  end

  # GET /infractions/1 or /infractions/1.json
  def show
  end

  # GET /infractions/new
  def new
    @infraction = Infraction.new
  end

  # GET /infractions/1/edit
  def edit
  end

  # POST /infractions or /infractions.json
  def create
    @infraction = Infraction.new(infraction_params)

    respond_to do |format|
      if @infraction.save
        format.html { redirect_to infraction_url(@infraction), notice: "Infraction was successfully created." }
        format.json { render :show, status: :created, location: @infraction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @infraction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infractions/1 or /infractions/1.json
  def update
    respond_to do |format|
      if @infraction.update(infraction_params)
        format.html { redirect_to infraction_url(@infraction), notice: "Infraction was successfully updated." }
        format.json { render :show, status: :ok, location: @infraction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @infraction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infractions/1 or /infractions/1.json
  def destroy
    @infraction.destroy

    respond_to do |format|
      format.html { redirect_to infractions_url, notice: "Infraction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_infraction
      @infraction = Infraction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def infraction_params
      params.require(:infraction).permit(:member_id, :note, :passed)
    end
end
