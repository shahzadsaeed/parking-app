class ReservationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_reservation, only: [:update, :destroy, :check_in, :check_out, :cancel]

  def index
    reservations = Reservation.all
    render json: reservations
  end

  def create
    reservation = Reservation.new(reservation_params)
    if reservation.save
      render json: reservation, status: :created
    else
      render json: reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    head :no_content
  end

  def check_in
    @reservation.update(checked_in: true)
    render json: @reservation
  end

  def check_out
    @reservation.update(checked_out: true)
    render json: @reservation
  end

  def cancel
    if @reservation.cancel_reservation
      render json: { message: 'Reservation cancelled successfully' }
    else
      render json: { error: 'Cancellation failed' }, status: :unprocessable_entity
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_time, :end_time, :checked_in, :checked_out, :slot_id, :customer_id)
  end
end
