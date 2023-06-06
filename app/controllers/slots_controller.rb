class SlotsController < ApplicationController
  before_action :authenticate_user
  before_action :set_slot, only: [:show, :update, :destroy]

  def index
    slots = Slot.all
    render json: slots
  end

  def show
    render json: @slot
  end

  def create
    slot = Slot.new(slot_params)
    if slot.save
      render json: slot, status: :created
    else
      render json: slot.errors, status: :unprocessable_entity
    end
  end

  def update
    if @slot.update(slot_params)
      render json: @slot
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @slot.destroy
    head :no_content
  end

  private

  def set_slot
    @slot = Slot.find(params[:id])
  end

  def slot_params
    params.require(:slot).permit(:start_time, :end_time, :car_type, :disabled_only, :has_shade, :price, :is_available)
  end
end

