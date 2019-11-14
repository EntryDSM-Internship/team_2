class TempsController < ApplicationController
  before_action :set_temp, only: [:show, :update, :destroy]

  # GET /temps
  def index
    @temps = Temp.all

    render json: @temps
  end

  # GET /temps/1
  def show
    render json: @temp
  end

  # POST /temps
  def create
    @temp = Temp.new(temp_params)

    if @temp.save
      render json: @temp, status: :created, location: @temp
    else
      render json: @temp.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /temps/1
  def update
    if @temp.update(temp_params)
      render json: @temp
    else
      render json: @temp.errors, status: :unprocessable_entity
    end
  end

  # DELETE /temps/1
  def destroy
    @temp.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp
      @temp = Temp.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def temp_params
      params.fetch(:temp, {})
    end
end
