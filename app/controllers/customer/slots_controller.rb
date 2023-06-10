class Customer::SlotsController < ApplicationController
  before_action :authenticate_user
  before_action :set_slot, only: %I[show]

  def index
    slots = Slot.available_slots
    render json: slots
  end

  def show
    @slot = Slot.find(params[:id])
    render json: @slot
  end

  def filter_slots
    @slots = Slot.available_slots
    @slots = @slots.where(id: Reservation.where('start_time <= ? AND end_time >= ?', params[:end_time], params[:start_time]).select(:slot_id))
    @slots = @slots.where(id: Reservation.where(name: params[feature_name]))

    render json: @slots
  end
end
